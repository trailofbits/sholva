yosys -import

hierarchy -check -top circuit
procs
memory
fsm
techmap
opt -purge
abc -fast -liberty zk.lib
rmports
opt
clean 
read_liberty -lib zk.lib
