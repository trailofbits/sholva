use std::fs::File;
use std::io::{Read, Seek, SeekFrom, Write};
use std::path::Path;

use anyhow::Result;
use nix::unistd::Pid;

const DUMP_MAGIC: &[u8] = b"SIEVDMP1";

fn packed_permissions(perms: &rsprocmaps::Permissions) -> u8 {
    let mut packed = 0_u8;

    packed |= (perms.readable as u8) << 4;
    packed |= (perms.writable as u8) << 3;
    packed |= (perms.executable as u8) << 2;
    packed |= (perms.shared as u8) << 1;
    packed |= perms.private as u8;

    packed
}

fn map_data(pid: Pid, map: &rsprocmaps::Map) -> Result<Vec<u8>> {
    let mut mem = File::open(format!("/proc/{pid}/mem"))?;
    let size = map.address_range.end - map.address_range.begin;
    let mut data = Vec::with_capacity(size.try_into()?);

    log::debug!(
        "attempting to read {size} bytes from {:x} ({:?})",
        map.address_range.begin,
        map.pathname
    );

    mem.seek(SeekFrom::Start(map.address_range.begin))?;
    mem.take(size).read_to_end(&mut data)?;

    Ok(data)
}

pub(crate) fn dump(pid: Pid, dest: impl AsRef<Path>) -> Result<()> {
    let dest = dest.as_ref();
    let maps = rsprocmaps::from_pid(pid.as_raw())?;

    // The SIEVE memory dump format is as follows:
    // * Magic (8 bytes): SIEVDMP1
    // * Map table (N bytes):
    //   - Address range (16 bytes): [begin (8), end(8))
    //   - Permissions (1 byte): 0b000rwxsp
    //   - Region size (8 bytes)
    //   - Raw region (variable per region size)
    //
    // All multi-byte fields are in little-endian order.

    let mut dump = File::create(dest)?;
    dump.write_all(DUMP_MAGIC)?;

    for map in maps {
        let map = map?;

        // Kernel bug(?): [vvar] can't be dumped via ptrace or `/proc/PID/mem`
        // despite being marked as readable.
        if matches!(map.pathname, rsprocmaps::Pathname::Vvar) {
            continue;
        }

        dump.write_all(&map.address_range.begin.to_le_bytes())?;
        dump.write_all(&map.address_range.end.to_le_bytes())?;
        dump.write_all(&[packed_permissions(&map.permissions)])?;

        // Don't support any sizes over u32, for now.
        let size: u32 = (map.address_range.end - map.address_range.begin).try_into()?;
        dump.write_all(&size.to_le_bytes())?;

        dump.write_all(&map_data(pid, &map)?)?;
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_packed_permissions() {
        let mut perms = rsprocmaps::Permissions::default();

        perms.readable = true;
        assert_eq!(packed_permissions(&perms), 0b00010000);

        perms.writable = true;
        assert_eq!(packed_permissions(&perms), 0b00011000);

        perms.executable = true;
        assert_eq!(packed_permissions(&perms), 0b00011100);

        perms.shared = true;
        assert_eq!(packed_permissions(&perms), 0b00011110);

        perms.private = true;
        assert_eq!(packed_permissions(&perms), 0b00011111);
    }
}
