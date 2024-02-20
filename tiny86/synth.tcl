yosys -import

hierarchy -check -top check
procs
memory
fsm
techmap
opt -purge
abc -liberty zk.lib
rmports
opt
flatten
clean 
read_liberty -lib zk.lib
write_blif -gates -impltf -buf BUF IN OUT tiny86.blif
