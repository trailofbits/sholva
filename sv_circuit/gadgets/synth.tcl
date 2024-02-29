yosys -import

hierarchy -check -top intra_bucket
procs
memory
fsm
techmap
opt -purge
abc -liberty zk.lib -fast
rmports
opt
flatten
clean 
read_liberty -lib zk.lib
write_blif -gates -impltf -buf BUF IN OUT intra_bucket.blif
