//! Filesystem model for mttn.
//!
//! These are only used in "linux32" syscall mode

use std::fs::File;
use std::io::Read;
use std::mem;
use std::os::unix::io::{AsRawFd, FromRawFd}; 
use std::str;
use anyhow::Result;

use crate::trace::{MemoryMask, Tracee};


pub trait FileSystemOp {
    // limits found https://github.com/torvalds/linux/blob/master/include/uapi/linux/limits.h
    const MAX_FILENAME_SIZE: usize = 255;
    const MAX_PATH_SIZE: usize = 4096;
    fn filesystem_open(&self, rbx : u64) -> Result<u32> ;
    fn filesystem_read(&self, ebx : u32, ecx : u32, edx : u32) -> Result<()> ;
    fn filesystem_write(&self);
    fn filesystem_close(&self, ebx : u32);
}


impl<'a> FileSystemOp for Tracee<'a> {
    fn filesystem_open(&self, rbx : u64) -> Result<u32> {
        // This should open and return a file descriptor

        let mut filepath = vec![0; Self::MAX_FILENAME_SIZE];

        let mut addr = rbx;
        let mut r = self.tracee_data(addr, MemoryMask::Byte)?;
        
        let mut len = 0;
        while r[0] != 0 && len < Self::MAX_FILENAME_SIZE {
            filepath[len] = r[0];
            addr += 1;
            len += 1;
            r = self.tracee_data(addr, MemoryMask::Byte)?;
        }
        filepath.truncate(len);

        let filepath = str::from_utf8(&filepath).unwrap();

        log::debug!("Filename: {:?}", filepath);

        let file = match File::open(&filepath) {
            // The `description` method of `io::Error` returns a string that
            // describes the error
            Err(why) => panic!("couldn't open {}: {:?}", filepath,
                                                       why),
            Ok(file) => file,
        };
        log::debug!("File Descriptor: {}",file.as_raw_fd());
        let fd = file.as_raw_fd() as u32;
        // This is so the FD won't be freed by Rust
        mem::forget(file);

        Ok(fd)

    }

    fn filesystem_read(&self, ebx : u32, _ecx : u32, edx : u32) -> Result<()> {
        log::debug!("Reading from {} bytes from FD {:?}", edx, ebx);
        let mut file = unsafe { File::from_raw_fd(ebx as i32) };
        // TODO: Change this to variable length
        let mut buffer = vec![0u8; edx as usize];
        let read_count = file.read(&mut buffer)?;

        //TODO: compare the contents to a commitment
        log::debug!("read_count {:?} contents {:?}", read_count, str::from_utf8(&buffer).unwrap());

        Ok(())
    }

    fn filesystem_write(&self) {

    }

    fn filesystem_close(&self, ebx : u32) {
        log::debug!("File Descriptor: {}", ebx);
        let file = unsafe { File::from_raw_fd(ebx as i32) };

        drop(file);
    }

}