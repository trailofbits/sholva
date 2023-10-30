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
clean 
read_liberty -lib zk.lib
write_verilog check.zk.v
