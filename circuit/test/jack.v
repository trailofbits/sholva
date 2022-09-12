module circuit(
input [2806:0] current,
input [2806:0] next,

output [0:0] result,
output [0:0] dummy
);
wire [2:0] Advice_1 = current[2: 0];
wire [2:0] Advice_2 = current[5: 3];
wire [2:0] Advice_3 = current[8: 6];
wire [63:0] Advice_4 = current[72: 9];
wire [63:0] Advice_5 = current[136: 73];
wire [3:0] Advice_6 = current[140: 137];
wire [3:0] Advice_7 = current[144: 141];
wire In_error_flag = current[145: 145];
wire In_register_AF = current[474: 474];
wire In_register_CF = current[475: 475];
wire [7:0] In_register_DF = current[483: 476];
wire In_register_OF = current[484: 484];
wire In_register_PF = current[485: 485];
wire [63:0] In_register_R10 = current[549: 486];
wire [63:0] In_register_R11 = current[613: 550];
wire [63:0] In_register_R12 = current[677: 614];
wire [63:0] In_register_R13 = current[741: 678];
wire [63:0] In_register_R14 = current[805: 742];
wire [63:0] In_register_R15 = current[869: 806];
wire [63:0] In_register_R8 = current[933: 870];
wire [63:0] In_register_R9 = current[997: 934];
wire [63:0] In_register_RAX = current[1061: 998];
wire [63:0] In_register_RBP = current[1125: 1062];
wire [63:0] In_register_RBX = current[1189: 1126];
wire [63:0] In_register_RCX = current[1253: 1190];
wire [63:0] In_register_RDI = current[1317: 1254];
wire [63:0] In_register_RDX = current[1381: 1318];
wire [63:0] In_register_RIP = current[1445: 1382];
wire [63:0] In_register_RSI = current[1509: 1446];
wire [63:0] In_register_RSP = current[1573: 1510];
wire In_register_SF = current[1574: 1574];
wire In_register_ZF = current[1575: 1575];
wire [63:0] In_timestamp = current[1639: 1576];
wire Out_error_flag = next[145: 145];
wire Out_register_AF = next[474: 474];
wire Out_register_CF = next[475: 475];
wire [7:0] Out_register_DF = next[483: 476];
wire Out_register_OF = next[484: 484];
wire Out_register_PF = next[485: 485];
wire [63:0] Out_register_R10 = next[549: 486];
wire [63:0] Out_register_R11 = next[613: 550];
wire [63:0] Out_register_R12 = next[677: 614];
wire [63:0] Out_register_R13 = next[741: 678];
wire [63:0] Out_register_R14 = next[805: 742];
wire [63:0] Out_register_R15 = next[869: 806];
wire [63:0] Out_register_R8 = next[933: 870];
wire [63:0] Out_register_R9 = next[997: 934];
wire [63:0] Out_register_RAX = next[1061: 998];
wire [63:0] Out_register_RBP = next[1125: 1062];
wire [63:0] Out_register_RBX = next[1189: 1126];
wire [63:0] Out_register_RCX = next[1253: 1190];
wire [63:0] Out_register_RDI = next[1317: 1254];
wire [63:0] Out_register_RDX = next[1381: 1318];
wire [63:0] Out_register_RIP = next[1445: 1382];
wire [63:0] Out_register_RSI = next[1509: 1446];
wire [63:0] Out_register_RSP = next[1573: 1510];
wire Out_register_SF = next[1574: 1574];
wire Out_register_ZF = next[1575: 1575];
wire [63:0] Out_timestamp = next[1639: 1576];
wire [119:0] instruction_bits = current[265: 146];
wire [207:0] memory_0 = current[473: 266];
wire v33 = 1'b0;
wire v35 = v33 == Out_error_flag;
wire v37 = In_error_flag == v33;
wire [3:0] v39 = 4'b0001;
wire v3b =  v39 == memory_0[15: 12] && In_register_RSP == memory_0[79: 16] && In_timestamp == memory_0[207: 144] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v3c = 1'b1;
wire v3d = In_error_flag ^ v3c;
wire v3e = v3d | Out_error_flag;
wire [4:0] v3f = 5'b11010;
wire [4:0] v40 = instruction_bits[7: 3];
wire v41 = v3f == v40;
wire [111:0] v42 = 112'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [111:0] v43 = instruction_bits[119: 8];
wire v44 = v42 == v43;
wire v45 = v3c;
wire v46 = v41 & v44 & v45;
wire [63:0] v47 = memory_0[143: 80];
wire [63:0] v48 = { v47 };
wire [63:0] v4a = ( Advice_1 == 3'd0) ? Out_register_RAX : 
	( Advice_1 == 3'd1) ? Out_register_RCX : 
	( Advice_1 == 3'd2) ? Out_register_RDX : 
	( Advice_1 == 3'd3) ? Out_register_RBX : 
	( Advice_1 == 3'd4) ? Out_register_RSP : 
	( Advice_1 == 3'd5) ? Out_register_RBP : 
	( Advice_1 == 3'd6) ? Out_register_RSI : Out_register_RDI;
wire v4b = v48 == v4a;
wire [2:0] v4c = 3'b000;
wire v4d = Advice_1 == v4c;
wire v4e = In_register_RAX == Out_register_RAX;
wire v4f = v4d | v4e;
wire [2:0] v50 = 3'b110;
wire v51 = Advice_1 == v50;
wire v52 = In_register_RBX == Out_register_RBX;
wire v53 = v51 | v52;
wire [2:0] v54 = 3'b100;
wire v55 = Advice_1 == v54;
wire v56 = In_register_RCX == Out_register_RCX;
wire v57 = v55 | v56;
wire [2:0] v58 = 3'b010;
wire v59 = Advice_1 == v58;
wire v5a = In_register_RDX == Out_register_RDX;
wire v5b = v59 | v5a;
wire [2:0] v5c = 3'b011;
wire v5d = Advice_1 == v5c;
wire v5e = In_register_RSI == Out_register_RSI;
wire v5f = v5d | v5e;
wire [2:0] v60 = 3'b111;
wire v61 = Advice_1 == v60;
wire v62 = In_register_RDI == Out_register_RDI;
wire v63 = v61 | v62;
wire [2:0] v64 = 3'b001;
wire v65 = Advice_1 == v64;
wire [63:0] v66 = 64'b0001000000000000000000000000000000000000000000000000000000000000;
wire [63:0] v67 = In_register_RSP + v66;
wire v68 = v67 == Out_register_RSP;
wire v69 = v65 | v68;
wire [2:0] v6a = 3'b101;
wire v6b = Advice_1 == v6a;
wire v6c = In_register_RBP == Out_register_RBP;
wire v6d = v6b | v6c;
wire [63:0] v6e = 64'b1000000000000000000000000000000000000000000000000000000000000000;
wire [63:0] v6f = In_register_RIP + v6e;
wire v70 = v6f == Out_register_RIP;
wire v71 = In_register_R8 == Out_register_R8;
wire v72 = In_register_R9 == Out_register_R9;
wire v73 = In_register_R10 == Out_register_R10;
wire v74 = In_register_R11 == Out_register_R11;
wire v75 = In_register_R12 == Out_register_R12;
wire v76 = In_register_R13 == Out_register_R13;
wire v77 = In_register_R14 == Out_register_R14;
wire v78 = In_register_R15 == Out_register_R15;
wire v79 = In_register_AF == Out_register_AF;
wire v7a = In_register_CF == Out_register_CF;
wire v7b = In_register_DF == Out_register_DF;
wire v7c = In_register_OF == Out_register_OF;
wire v7d = In_register_PF == Out_register_PF;
wire v7e = In_register_SF == Out_register_SF;
wire v7f = In_register_ZF == Out_register_ZF;
wire v80 = v4f & v53 & v57 & v5b & v5f & v63 & v69 & v6d & v70 & v71 & v72 & v73 & v74 & v75 & v76 & v77 & v78 & v79 & v7a & v7b & v7c & v7d & v7e & v7f;
wire v81 = v4b & v80;
wire [2:0] v82 = instruction_bits[2: 0];
wire [2:0] v83 = { v82 };
wire v85 = v83 == Advice_2;
wire [63:0] v86 = In_timestamp + v6e;
wire v88 = v86 == Out_timestamp;
wire v89 = Advice_2 == Advice_1;
wire v8a = v35 & v37 & v3b & v3e & v46 & v81 & v85 & v88 & v89;
wire rnx50x0 = 1'b0 || v8a;
wire onx50x0 = 1'b0 || ( 1'b0 && v8a);
wire [63:0] v8b = 64'b0001111111111111111111111111111111111111111111111111111111111111;
wire [63:0] v8c = In_register_RSP + v8b;
wire v8d = v8c == Out_register_RSP;
wire v8e = v4e & v52 & v56 & v5a & v5e & v62 & v8d & v6c & v70 & v71 & v72 & v73 & v74 & v75 & v76 & v77 & v78 & v79 & v7a & v7b & v7c & v7d & v7e & v7f;
wire [63:0] v90 = ( Advice_3 == 3'd0) ? In_register_RAX : 
	( Advice_3 == 3'd1) ? In_register_RCX : 
	( Advice_3 == 3'd2) ? In_register_RDX : 
	( Advice_3 == 3'd3) ? In_register_RBX : 
	( Advice_3 == 3'd4) ? In_register_RSP : 
	( Advice_3 == 3'd5) ? In_register_RBP : 
	( Advice_3 == 3'd6) ? In_register_RSI : In_register_RDI;
wire v92 = v90 == Advice_4;
wire v93 =  v39 == memory_0[15: 12] && v8c == memory_0[79: 16] && In_timestamp == memory_0[207: 144] && Advice_4 == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [4:0] v94 = 5'b01010;
wire v95 = v94 == v40;
wire v96 = v95 & v44 & v45;
wire v97 = Advice_2 == Advice_3;
wire v98 = v8e & v37 & v3e & v85 & v88 & v92 & v35 & v93 & v96 & v97;
wire rnx50x1 = rnx50x0 || v98;
wire onx50x1 = onx50x0 || ( rnx50x0 && v98);
wire [63:0] v9a = { Advice_5 };
wire [63:0] v9c = ( Advice_6 == 4'd0) ? Out_register_RAX : 
	( Advice_6 == 4'd1) ? Out_register_RCX : 
	( Advice_6 == 4'd2) ? Out_register_RDX : 
	( Advice_6 == 4'd3) ? Out_register_RBX : 
	( Advice_6 == 4'd4) ? Out_register_RSP : 
	( Advice_6 == 4'd5) ? Out_register_RBP : 
	( Advice_6 == 4'd6) ? Out_register_RSI : 
	( Advice_6 == 4'd7) ? Out_register_RDI : 
	( Advice_6 == 4'd8) ? Out_register_R8 : 
	( Advice_6 == 4'd9) ? Out_register_R9 : 
	( Advice_6 == 4'd10) ? Out_register_R10 : 
	( Advice_6 == 4'd11) ? Out_register_R11 : 
	( Advice_6 == 4'd12) ? Out_register_R12 : 
	( Advice_6 == 4'd13) ? Out_register_R13 : 
	( Advice_6 == 4'd14) ? Out_register_R14 : Out_register_R15;
wire v9d = v9a == v9c;
wire [3:0] v9e = 4'b0000;
wire v9f = Advice_6 == v9e;
wire va0 = v9f | v4e;
wire [3:0] va1 = 4'b1100;
wire va2 = Advice_6 == va1;
wire va3 = va2 | v52;
wire [3:0] va4 = 4'b1000;
wire va5 = Advice_6 == va4;
wire va6 = va5 | v56;
wire [3:0] va7 = 4'b0100;
wire va8 = Advice_6 == va7;
wire va9 = va8 | v5a;
wire [3:0] vaa = 4'b0110;
wire vab = Advice_6 == vaa;
wire vac = vab | v5e;
wire [3:0] vad = 4'b1110;
wire vae = Advice_6 == vad;
wire vaf = vae | v62;
wire [3:0] vb0 = 4'b0010;
wire vb1 = Advice_6 == vb0;
wire vb2 = In_register_RSP == Out_register_RSP;
wire vb3 = vb1 | vb2;
wire [3:0] vb4 = 4'b1010;
wire vb5 = Advice_6 == vb4;
wire vb6 = vb5 | v6c;
wire [63:0] vb7 = 64'b1110000000000000000000000000000000000000000000000000000000000000;
wire [63:0] vb8 = In_register_RIP + vb7;
wire vb9 = vb8 == Out_register_RIP;
wire vba = Advice_6 == v39;
wire vbb = vba | v71;
wire [3:0] vbc = 4'b1001;
wire vbd = Advice_6 == vbc;
wire vbe = vbd | v72;
wire [3:0] vbf = 4'b0101;
wire vc0 = Advice_6 == vbf;
wire vc1 = vc0 | v73;
wire [3:0] vc2 = 4'b1101;
wire vc3 = Advice_6 == vc2;
wire vc4 = vc3 | v74;
wire [3:0] vc5 = 4'b0011;
wire vc6 = Advice_6 == vc5;
wire vc7 = vc6 | v75;
wire [3:0] vc8 = 4'b1011;
wire vc9 = Advice_6 == vc8;
wire vca = vc9 | v76;
wire [3:0] vcb = 4'b0111;
wire vcc = Advice_6 == vcb;
wire vcd = vcc | v77;
wire [3:0] vce = 4'b1111;
wire vcf = Advice_6 == vce;
wire vd0 = vcf | v78;
wire vd1 = va0 & va3 & va6 & va9 & vac & vaf & vb3 & vb6 & vb9 & vbb & vbe & vc1 & vc4 & vc7 & vca & vcd & vd0 & v79 & v7a & v7b & v7c & v7d & v7e & v7f;
wire vd2 = v9d & vd1;
wire [31:0] vd3 = instruction_bits[55: 24];
wire [31:0] pad_212 = (vd3[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] vd4 = { pad_212, vd3 };
wire vd6 = vd4 == Advice_5;
wire vd8 = instruction_bits[0: 0];
wire [2:0] vd7 = instruction_bits[18: 16];
wire [3:0] vd9 = { vd8 , vd7 };
wire vdb = vd9 == Advice_7;
wire [14:0] vdc = 15'b001001011100011;
wire [14:0] vdd = instruction_bits[15: 1];
wire vde = vdc == vdd;
wire [4:0] vdf = 5'b00011;
wire [4:0] ve0 = instruction_bits[23: 19];
wire ve1 = vdf == ve0;
wire [63:0] ve2 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
wire [63:0] ve3 = instruction_bits[119: 56];
wire ve4 = ve2 == ve3;
wire ve5 = vde & ve1 & ve4 & v45;
wire ve6 = Advice_7 == Advice_6;
wire ve7 = vd2 & vd6 & v35 & v37 & vdb & ve5 & v88 & v3e & ve6;
wire rnx50x2 = rnx50x1 || ve7;
wire onx50x2 = onx50x1 || ( rnx50x1 && ve7);
wire [7:0] ve8 = 8'b00001001;
wire [7:0] ve9 = instruction_bits[7: 0];
wire vea = ve8 == ve9;
wire veb = vea & v44;
wire vec = v4e & v52 & v56 & v5a & v5e & v62 & vb2 & v6c & v70 & v71 & v72 & v73 & v74 & v75 & v76 & v77 & v78 & v79 & v7a & v7b & v7c & v7d & v7e & v7f;
wire ved = v3e & v35 & v37 & veb & vec & v88;
wire rnx50x3 = rnx50x2 || ved;
wire onx50x3 = onx50x2 || ( rnx50x2 && ved);
wire v32 = (!onx50x3) && rnx50x3;
assign result = v32;
assign dummy = 1'b0;
endmodule
