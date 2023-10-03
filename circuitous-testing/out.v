module circuit(
input [1525:0] current,
input [1525:0] next,

output [0:0] result,
output [0:0] dummy
);
wire In_error_flag = current[0: 0];
wire In_register_AF = current[409: 409];
wire In_register_CF = current[410: 410];
wire [31:0] In_register_CSBASE = current[442: 411];
wire [7:0] In_register_DF = current[450: 443];
wire [31:0] In_register_DSBASE = current[482: 451];
wire [31:0] In_register_EAX = current[514: 483];
wire [31:0] In_register_EBP = current[546: 515];
wire [31:0] In_register_EBX = current[578: 547];
wire [31:0] In_register_ECX = current[610: 579];
wire [31:0] In_register_EDI = current[642: 611];
wire [31:0] In_register_EDX = current[674: 643];
wire [31:0] In_register_EIP = current[706: 675];
wire [31:0] In_register_ESBASE = current[738: 707];
wire [31:0] In_register_ESI = current[770: 739];
wire [31:0] In_register_ESP = current[802: 771];
wire [31:0] In_register_FSBASE = current[834: 803];
wire [31:0] In_register_GSBASE = current[866: 835];
wire In_register_OF = current[867: 867];
wire In_register_PF = current[868: 868];
wire In_register_SF = current[869: 869];
wire [31:0] In_register_SSBASE = current[901: 870];
wire In_register_ZF = current[902: 902];
wire [63:0] In_timestamp = current[966: 903];
wire Out_error_flag = next[0: 0];
wire Out_register_AF = next[409: 409];
wire Out_register_CF = next[410: 410];
wire [31:0] Out_register_CSBASE = next[442: 411];
wire [7:0] Out_register_DF = next[450: 443];
wire [31:0] Out_register_DSBASE = next[482: 451];
wire [31:0] Out_register_EAX = next[514: 483];
wire [31:0] Out_register_EBP = next[546: 515];
wire [31:0] Out_register_EBX = next[578: 547];
wire [31:0] Out_register_ECX = next[610: 579];
wire [31:0] Out_register_EDI = next[642: 611];
wire [31:0] Out_register_EDX = next[674: 643];
wire [31:0] Out_register_EIP = next[706: 675];
wire [31:0] Out_register_ESBASE = next[738: 707];
wire [31:0] Out_register_ESI = next[770: 739];
wire [31:0] Out_register_ESP = next[802: 771];
wire [31:0] Out_register_FSBASE = next[834: 803];
wire [31:0] Out_register_GSBASE = next[866: 835];
wire Out_register_OF = next[867: 867];
wire Out_register_PF = next[868: 868];
wire Out_register_SF = next[869: 869];
wire [31:0] Out_register_SSBASE = next[901: 870];
wire Out_register_ZF = next[902: 902];
wire [63:0] Out_timestamp = next[966: 903];
wire [119:0] instruction_bits = current[120: 1];
wire [143:0] memory_0 = current[264: 121];
wire [143:0] memory_1 = current[408: 265];
wire [15:0] v2 = 16'b0110011010010001;
wire [15:0] v117 = instruction_bits[15: 0];
wire v118 = v2 == v117;
wire [1:0] v3 = 2'b11;
wire [1:0] v119 = instruction_bits[23: 22];
wire v11a = v3 == v119;
wire [95:0] v4 = 96'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [95:0] v11b = instruction_bits[119: 24];
wire v11c = v4 == v11b;
wire v11d = v118 & v11a & v11c;
wire v11e = v11d;
wire v11f = v11e;
wire v122 = In_register_SF;
wire v124 = v122 == Out_register_SF;
wire [7:0] v127 = In_register_DF;
wire v129 = v127 == Out_register_DF;
wire v8 = 1'b1;
wire [2:0] v13c = instruction_bits[18: 16];
wire [2:0] v13d = { v13c };
wire [2:0] v7 = 3'b000;
wire v13e = v13d == v7;
wire v13f = v13e;
wire v140 = v11d & v13f;
wire v141 = v140;
wire [31:0] v5 = 32'b00000000000000001111111111111111;
wire [31:0] v12b = In_register_EAX & v5;
wire [2:0] v12c = instruction_bits[21: 19];
wire [2:0] v12d = { v12c };
wire [31:0] v135 = ( v12d == 3'd0) ? In_register_EAX : 
	( v12d == 3'd1) ? In_register_ECX : 
	( v12d == 3'd2) ? In_register_EDX : 
	( v12d == 3'd3) ? In_register_EBX : 
	( v12d == 3'd4) ? In_register_ESP : 
	( v12d == 3'd5) ? In_register_EBP : 
	( v12d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6 = 32'b11111111111111110000000000000000;
wire [31:0] v136 = v135 & v6;
wire [31:0] v138 = v136;
wire [15:0] v139 = v138[15:0];
wire [31:0] v13a = { 16'b0000000000000000, v139 };
wire [31:0] v13b = v12b | v13a;
wire [31:0] v144 = ( v8 ) ? In_register_EAX : v13b;
wire [31:0] v146 = v144;
wire v148 = v146 == Out_register_EAX;
wire [2:0] v9 = 3'b111;
wire v14b = v13d == v9;
wire v14c = v14b;
wire v14d = v11d & v14c;
wire v14e = v14d;
wire [31:0] v149 = In_register_EDI & v5;
wire [31:0] v14a = v149 | v13a;
wire [31:0] v151 = ( v8 ) ? In_register_EDI : v14a;
wire [31:0] v153 = v151;
wire v155 = v153 == Out_register_EDI;
wire v158 = In_error_flag == Out_error_flag;
wire [63:0] va = 64'b1000000000000000000000000000000000000000000000000000000000000000;
wire [63:0] v15a = In_timestamp + va;
wire v15c = v15a == Out_timestamp;
wire [2:0] vb = 3'b001;
wire v15f = v13d == vb;
wire v160 = v15f;
wire v161 = v11d & v160;
wire v162 = v161;
wire [31:0] v15d = In_register_ESP & v5;
wire [31:0] v15e = v15d | v13a;
wire [31:0] v165 = ( v8 ) ? In_register_ESP : v15e;
wire [31:0] v167 = v165;
wire v169 = v167 == Out_register_ESP;
wire v16c = In_register_OF;
wire v16e = v16c == Out_register_OF;
wire [2:0] vc = 3'b100;
wire v171 = v13d == vc;
wire v172 = v171;
wire v173 = v11d & v172;
wire v174 = v173;
wire [31:0] v16f = In_register_ECX & v5;
wire [31:0] v170 = v16f | v13a;
wire [31:0] v177 = ( v8 ) ? In_register_ECX : v170;
wire [31:0] v179 = v177;
wire v17b = v179 == Out_register_ECX;
wire [2:0] vd = 3'b110;
wire v17e = v13d == vd;
wire v17f = v17e;
wire v180 = v11d & v17f;
wire v181 = v180;
wire [31:0] v17c = In_register_EBX & v5;
wire [31:0] v17d = v17c | v13a;
wire [31:0] v184 = ( v8 ) ? In_register_EBX : v17d;
wire [31:0] v186 = v184;
wire v188 = v186 == Out_register_EBX;
wire [2:0] ve = 3'b010;
wire v18b = v13d == ve;
wire v18c = v18b;
wire v18d = v11d & v18c;
wire v18e = v18d;
wire [31:0] v189 = In_register_EDX & v5;
wire [31:0] v18a = v189 | v13a;
wire [31:0] v191 = ( v8 ) ? In_register_EDX : v18a;
wire [31:0] v193 = v191;
wire v195 = v193 == Out_register_EDX;
wire [2:0] vf = 3'b101;
wire v198 = v13d == vf;
wire v199 = v198;
wire v19a = v11d & v199;
wire v19b = v19a;
wire [31:0] v196 = In_register_EBP & v5;
wire [31:0] v197 = v196 | v13a;
wire [31:0] v19e = ( v8 ) ? In_register_EBP : v197;
wire [31:0] v1a0 = v19e;
wire v1a2 = v1a0 == Out_register_EBP;
wire [31:0] v1a5 = In_register_SSBASE;
wire v1a7 = v1a5 == Out_register_SSBASE;
wire v1aa = In_register_CF;
wire v1ac = v1aa == Out_register_CF;
wire [31:0] v10 = 32'b11000000000000000000000000000000;
wire [31:0] v1af = v10;
wire [31:0] v1b0 = In_register_EIP + v1af;
wire [31:0] v1b2 = v1b0;
wire v1b4 = v1b2 == Out_register_EIP;
wire [31:0] v1b7 = In_register_ESBASE;
wire v1b9 = v1b7 == Out_register_ESBASE;
wire [31:0] v1bc = In_register_FSBASE;
wire v1be = v1bc == Out_register_FSBASE;
wire [31:0] v1c1 = In_register_CSBASE;
wire v1c3 = v1c1 == Out_register_CSBASE;
wire [31:0] v1c6 = In_register_GSBASE;
wire v1c8 = v1c6 == Out_register_GSBASE;
wire [31:0] v1cb = In_register_DSBASE;
wire v1cd = v1cb == Out_register_DSBASE;
wire v1d0 = In_register_AF;
wire v1d2 = v1d0 == Out_register_AF;
wire v1d5 = In_register_PF;
wire v1d7 = v1d5 == Out_register_PF;
wire [2:0] v11 = 3'b011;
wire v1da = v13d == v11;
wire v1db = v1da;
wire v1dc = v11d & v1db;
wire v1dd = v1dc;
wire [31:0] v1d8 = In_register_ESI & v5;
wire [31:0] v1d9 = v1d8 | v13a;
wire [31:0] v1e0 = ( v8 ) ? In_register_ESI : v1d9;
wire [31:0] v1e2 = v1e0;
wire v1e4 = v1e2 == Out_register_ESI;
wire v1e7 = In_register_ZF;
wire v1e9 = v1e7 == Out_register_ZF;
wire v1ea = v11f & v124 & v129 & v148 & v155 & v158 & v15c & v169 & v16e & v17b & v188 & v195 & v1a2 & v1a7 & v1ac & v1b4 & v1b9 & v1be & v1c3 & v1c8 & v1cd & v1d2 & v1d7 & v1e4 & v1e9;
wire [7:0] v12 = 8'b10000001;
wire [7:0] v1eb = instruction_bits[7: 0];
wire v1ec = v12 == v1eb;
wire [4:0] v13 = 5'b00111;
wire [4:0] v1ed = instruction_bits[15: 11];
wire v1ee = v13 == v1ed;
wire [71:0] v14 = 72'b000000000000000000000000000000000000000000000000000000000000000000000000;
wire [71:0] v1ef = instruction_bits[119: 48];
wire v1f0 = v14 == v1ef;
wire v1f1 = v1ec & v1ee & v1f0;
wire v1f2 = v1f1;
wire v1f3 = v1f2;
wire [31:0] v1f5 = In_register_SSBASE;
wire v1f6 = v1f5 == Out_register_SSBASE;
wire [2:0] v1fa = instruction_bits[10: 8];
wire [2:0] v200 = { v1fa };
wire v201 = v200 == v7;
wire v202 = v201;
wire v203 = v1f1 & v202;
wire v204 = v203;
wire [31:0] v1f7 = instruction_bits[47: 16];
wire [31:0] v1f9 = v1f7;
wire [2:0] v1fb = { v1fa };
wire [31:0] v1fc = ( v1fb == 3'd0) ? In_register_EAX : 
	( v1fb == 3'd1) ? In_register_ECX : 
	( v1fb == 3'd2) ? In_register_EDX : 
	( v1fb == 3'd3) ? In_register_EBX : 
	( v1fb == 3'd4) ? In_register_ESP : 
	( v1fb == 3'd5) ? In_register_EBP : 
	( v1fb == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1fe = v1fc;
wire [31:0] v1ff = v1f9 & v1fe;
wire [31:0] v207 = ( v8 ) ? In_register_EAX : v1ff;
wire [31:0] v209 = v207;
wire v20a = v209 == Out_register_EAX;
wire v20b = v200 == ve;
wire v20c = v20b;
wire v20d = v1f1 & v20c;
wire v20e = v20d;
wire [31:0] v211 = ( v8 ) ? In_register_EDX : v1ff;
wire [31:0] v213 = v211;
wire v214 = v213 == Out_register_EDX;
wire [7:0] v216 = In_register_DF;
wire v217 = v216 == Out_register_DF;
wire v218 = v200 == vc;
wire v219 = v218;
wire v21a = v1f1 & v219;
wire v21b = v21a;
wire [31:0] v21e = ( v8 ) ? In_register_ECX : v1ff;
wire [31:0] v220 = v21e;
wire v221 = v220 == Out_register_ECX;
wire v222 = v200 == vf;
wire v223 = v222;
wire v224 = v1f1 & v223;
wire v225 = v224;
wire [31:0] v228 = ( v8 ) ? In_register_EBP : v1ff;
wire [31:0] v22a = v228;
wire v22b = v22a == Out_register_EBP;
wire v22c = v200 == v9;
wire v22d = v22c;
wire v22e = v1f1 & v22d;
wire v22f = v22e;
wire [31:0] v232 = ( v8 ) ? In_register_EDI : v1ff;
wire [31:0] v234 = v232;
wire v235 = v234 == Out_register_EDI;
wire v236 = In_error_flag == Out_error_flag;
wire [31:0] v15 = 32'b00000000000000000000000000000000;
wire v237 = $signed(v1ff) < $signed(v15);
wire v239 = v237;
wire v23a = v239 == Out_register_SF;
wire v23b = v1ff == v15;
wire v23d = v23b;
wire v23e = v23d == Out_register_ZF;
wire v23f = v200 == vd;
wire v240 = v23f;
wire v241 = v1f1 & v240;
wire v242 = v241;
wire [31:0] v245 = ( v8 ) ? In_register_EBX : v1ff;
wire [31:0] v247 = v245;
wire v248 = v247 == Out_register_EBX;
wire v249 = v200 == vb;
wire v24a = v249;
wire v24b = v1f1 & v24a;
wire v24c = v24b;
wire [31:0] v24f = ( v8 ) ? In_register_ESP : v1ff;
wire [31:0] v251 = v24f;
wire v252 = v251 == Out_register_ESP;
wire [31:0] v16 = 32'b01100000000000000000000000000000;
wire [31:0] v254 = v16;
wire [31:0] v255 = In_register_EIP + v254;
wire [31:0] v257 = v255;
wire v258 = v257 == Out_register_EIP;
wire [31:0] v25a = In_register_CSBASE;
wire v25b = v25a == Out_register_CSBASE;
wire [31:0] v25d = In_register_ESBASE;
wire v25e = v25d == Out_register_ESBASE;
wire v17 = 1'b0;
wire v260 = v17;
wire v261 = v260 == Out_register_AF;
wire [31:0] v263 = In_register_GSBASE;
wire v264 = v263 == Out_register_GSBASE;
wire v265 = v17;
wire v266 = v265 == Out_register_CF;
wire [31:0] v268 = In_register_FSBASE;
wire v269 = v268 == Out_register_FSBASE;
wire v26a = v200 == v11;
wire v26b = v26a;
wire v26c = v1f1 & v26b;
wire v26d = v26c;
wire [31:0] v270 = ( v8 ) ? In_register_ESI : v1ff;
wire [31:0] v272 = v270;
wire v273 = v272 == Out_register_ESI;
wire v274 = v17;
wire v275 = v274 == Out_register_OF;
wire [7:0] v276 = v1ff[7:0];
wire [2:0] v277_aux = v276[0] + v276[1] + v276[2] + v276[3] + v276[4] + v276[5] + v276[6] + v276[7];
wire v277 = { 5'b00000, v277_aux };
wire [7:0] v18 = 8'b10000000;
wire [7:0] v278 = v277 & v18;
wire [7:0] v279 = v278 ^ v18;
wire v27a = v279[0:0];
wire v27c = v27a;
wire v27d = v27c == Out_register_PF;
wire [31:0] v27f = In_register_DSBASE;
wire v280 = v27f == Out_register_DSBASE;
wire v281 = v1f6 & v20a & v214 & v217 & v221 & v22b & v235 & v236 & v23a & v23e & v248 & v252 & v15c & v258 & v25b & v25e & v261 & v264 & v266 & v269 & v273 & v275 & v1f3 & v27d & v280;
wire v282 = v12 == v1eb;
wire [4:0] v19 = 5'b10011;
wire v283 = v19 == v1ed;
wire v284 = v14 == v1ef;
wire v285 = v282 & v283 & v284;
wire v286 = v285;
wire v287 = v286;
wire [7:0] v289 = In_register_DF;
wire v28a = v289 == Out_register_DF;
wire [2:0] v292 = { v1fa };
wire v293 = v292 == vd;
wire v294 = v293;
wire v295 = v285 & v294;
wire v296 = v295;
wire [31:0] v28c = v1f7;
wire [2:0] v28d = { v1fa };
wire [31:0] v28e = ( v28d == 3'd0) ? In_register_EAX : 
	( v28d == 3'd1) ? In_register_ECX : 
	( v28d == 3'd2) ? In_register_EDX : 
	( v28d == 3'd3) ? In_register_EBX : 
	( v28d == 3'd4) ? In_register_ESP : 
	( v28d == 3'd5) ? In_register_EBP : 
	( v28d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v290 = v28e;
wire [31:0] v291 = v28c | v290;
wire [31:0] v299 = ( v8 ) ? In_register_EBX : v291;
wire [31:0] v29b = v299;
wire v29c = v29b == Out_register_EBX;
wire v29d = v292 == v11;
wire v29e = v29d;
wire v29f = v285 & v29e;
wire v2a0 = v29f;
wire [31:0] v2a3 = ( v8 ) ? In_register_ESI : v291;
wire [31:0] v2a5 = v2a3;
wire v2a6 = v2a5 == Out_register_ESI;
wire v2a7 = v292 == v7;
wire v2a8 = v2a7;
wire v2a9 = v285 & v2a8;
wire v2aa = v2a9;
wire [31:0] v2ad = ( v8 ) ? In_register_EAX : v291;
wire [31:0] v2af = v2ad;
wire v2b0 = v2af == Out_register_EAX;
wire v2b1 = v292 == vc;
wire v2b2 = v2b1;
wire v2b3 = v285 & v2b2;
wire v2b4 = v2b3;
wire [31:0] v2b7 = ( v8 ) ? In_register_ECX : v291;
wire [31:0] v2b9 = v2b7;
wire v2ba = v2b9 == Out_register_ECX;
wire v2bb = v292 == v9;
wire v2bc = v2bb;
wire v2bd = v285 & v2bc;
wire v2be = v2bd;
wire [31:0] v2c1 = ( v8 ) ? In_register_EDI : v291;
wire [31:0] v2c3 = v2c1;
wire v2c4 = v2c3 == Out_register_EDI;
wire v2c5 = v292 == ve;
wire v2c6 = v2c5;
wire v2c7 = v285 & v2c6;
wire v2c8 = v2c7;
wire [31:0] v2cb = ( v8 ) ? In_register_EDX : v291;
wire [31:0] v2cd = v2cb;
wire v2ce = v2cd == Out_register_EDX;
wire v2d0 = In_register_AF;
wire v2d1 = v2d0 == Out_register_AF;
wire v2d2 = v292 == vb;
wire v2d3 = v2d2;
wire v2d4 = v285 & v2d3;
wire v2d5 = v2d4;
wire [31:0] v2d8 = ( v8 ) ? In_register_ESP : v291;
wire [31:0] v2da = v2d8;
wire v2db = v2da == Out_register_ESP;
wire v2dc = v292 == vf;
wire v2dd = v2dc;
wire v2de = v285 & v2dd;
wire v2df = v2de;
wire [31:0] v2e2 = ( v8 ) ? In_register_EBP : v291;
wire [31:0] v2e4 = v2e2;
wire v2e5 = v2e4 == Out_register_EBP;
wire v2e6 = In_error_flag == Out_error_flag;
wire [31:0] v2e8 = In_register_CSBASE;
wire v2e9 = v2e8 == Out_register_CSBASE;
wire [31:0] v2eb = In_register_SSBASE;
wire v2ec = v2eb == Out_register_SSBASE;
wire [31:0] v2ee = In_register_FSBASE;
wire v2ef = v2ee == Out_register_FSBASE;
wire [31:0] v2f1 = In_register_ESBASE;
wire v2f2 = v2f1 == Out_register_ESBASE;
wire [31:0] v2f4 = In_register_DSBASE;
wire v2f5 = v2f4 == Out_register_DSBASE;
wire v2f7 = v17;
wire v2f8 = v2f7 == Out_register_OF;
wire v2f9 = v17;
wire v2fa = v2f9 == Out_register_CF;
wire [31:0] v2fc = v16;
wire [31:0] v2fd = In_register_EIP + v2fc;
wire [31:0] v2ff = v2fd;
wire v300 = v2ff == Out_register_EIP;
wire [7:0] v301 = v291[7:0];
wire [2:0] v302_aux = v301[0] + v301[1] + v301[2] + v301[3] + v301[4] + v301[5] + v301[6] + v301[7];
wire v302 = { 5'b00000, v302_aux };
wire [7:0] v303 = v302 & v18;
wire [7:0] v304 = v303 ^ v18;
wire v305 = v304[0:0];
wire v307 = v305;
wire v308 = v307 == Out_register_PF;
wire v309 = $signed(v291) < $signed(v15);
wire v30b = v309;
wire v30c = v30b == Out_register_SF;
wire [31:0] v30e = In_register_GSBASE;
wire v30f = v30e == Out_register_GSBASE;
wire v310 = v291 == v15;
wire v312 = v310;
wire v313 = v312 == Out_register_ZF;
wire v314 = v287 & v28a & v29c & v2a6 & v2b0 & v2ba & v2c4 & v2ce & v2d1 & v2db & v2e5 & v2e6 & v2e9 & v2ec & v2ef & v2f2 & v2f5 & v2f8 & v2fa & v300 & v15c & v308 & v30c & v30f & v313;
wire [7:0] v1a = 8'b10001100;
wire v315 = v1a == v1eb;
wire [1:0] v316 = instruction_bits[15: 14];
wire v317 = v3 == v316;
wire [103:0] v1b = 104'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [103:0] v318 = instruction_bits[119: 16];
wire v319 = v1b == v318;
wire v31a = v315 & v317 & v319;
wire v31b = v31a;
wire v31c = v31b;
wire v31e = In_register_AF;
wire v31f = v31e == Out_register_AF;
wire [2:0] v32a = { v1fa };
wire v32b = v32a == v11;
wire v32c = v32b;
wire v32d = v31a & v32c;
wire v32e = v32d;
wire [2:0] v320 = instruction_bits[13: 11];
wire [2:0] v321 = { v320 };
wire [31:0] v322 = ( v321 == 3'd0) ? In_register_EAX : 
	( v321 == 3'd1) ? In_register_ECX : 
	( v321 == 3'd2) ? In_register_EDX : 
	( v321 == 3'd3) ? In_register_EBX : 
	( v321 == 3'd4) ? In_register_ESP : 
	( v321 == 3'd5) ? In_register_EBP : 
	( v321 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v324 = v322;
wire [2:0] v325 = { v1fa };
wire [31:0] v326 = ( v325 == 3'd0) ? In_register_EAX : 
	( v325 == 3'd1) ? In_register_ECX : 
	( v325 == 3'd2) ? In_register_EDX : 
	( v325 == 3'd3) ? In_register_EBX : 
	( v325 == 3'd4) ? In_register_ESP : 
	( v325 == 3'd5) ? In_register_EBP : 
	( v325 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v328 = v326;
wire [31:0] v329 = v324 ^ v328;
wire [31:0] v331 = ( v8 ) ? In_register_ESI : v329;
wire [31:0] v333 = v331;
wire v334 = v333 == Out_register_ESI;
wire [7:0] v336 = In_register_DF;
wire v337 = v336 == Out_register_DF;
wire v338 = In_error_flag == Out_error_flag;
wire v33a = v17;
wire v33b = v33a == Out_register_OF;
wire v33c = v32a == v7;
wire v33d = v33c;
wire v33e = v31a & v33d;
wire v33f = v33e;
wire [31:0] v342 = ( v8 ) ? In_register_EAX : v329;
wire [31:0] v344 = v342;
wire v345 = v344 == Out_register_EAX;
wire [31:0] v1c = 32'b01000000000000000000000000000000;
wire [31:0] v347 = v1c;
wire [31:0] v348 = In_register_EIP + v347;
wire [31:0] v34a = v348;
wire v34b = v34a == Out_register_EIP;
wire v34c = v32a == vc;
wire v34d = v34c;
wire v34e = v31a & v34d;
wire v34f = v34e;
wire [31:0] v352 = ( v8 ) ? In_register_ECX : v329;
wire [31:0] v354 = v352;
wire v355 = v354 == Out_register_ECX;
wire v356 = v32a == v9;
wire v357 = v356;
wire v358 = v31a & v357;
wire v359 = v358;
wire [31:0] v35c = ( v8 ) ? In_register_EDI : v329;
wire [31:0] v35e = v35c;
wire v35f = v35e == Out_register_EDI;
wire [31:0] v361 = In_register_CSBASE;
wire v362 = v361 == Out_register_CSBASE;
wire [31:0] v364 = In_register_GSBASE;
wire v365 = v364 == Out_register_GSBASE;
wire v366 = $signed(v329) < $signed(v15);
wire v368 = v366;
wire v369 = v368 == Out_register_SF;
wire v36a = v32a == vd;
wire v36b = v36a;
wire v36c = v31a & v36b;
wire v36d = v36c;
wire [31:0] v370 = ( v8 ) ? In_register_EBX : v329;
wire [31:0] v372 = v370;
wire v373 = v372 == Out_register_EBX;
wire v374 = v32a == ve;
wire v375 = v374;
wire v376 = v31a & v375;
wire v377 = v376;
wire [31:0] v37a = ( v8 ) ? In_register_EDX : v329;
wire [31:0] v37c = v37a;
wire v37d = v37c == Out_register_EDX;
wire [31:0] v37f = In_register_SSBASE;
wire v380 = v37f == Out_register_SSBASE;
wire v381 = v32a == vb;
wire v382 = v381;
wire v383 = v31a & v382;
wire v384 = v383;
wire [31:0] v387 = ( v8 ) ? In_register_ESP : v329;
wire [31:0] v389 = v387;
wire v38a = v389 == Out_register_ESP;
wire [7:0] v38b = v329[7:0];
wire [2:0] v38c_aux = v38b[0] + v38b[1] + v38b[2] + v38b[3] + v38b[4] + v38b[5] + v38b[6] + v38b[7];
wire v38c = { 5'b00000, v38c_aux };
wire [7:0] v38d = v38c & v18;
wire [7:0] v38e = v38d ^ v18;
wire v38f = v38e[0:0];
wire v391 = v38f;
wire v392 = v391 == Out_register_PF;
wire v393 = v32a == vf;
wire v394 = v393;
wire v395 = v31a & v394;
wire v396 = v395;
wire [31:0] v399 = ( v8 ) ? In_register_EBP : v329;
wire [31:0] v39b = v399;
wire v39c = v39b == Out_register_EBP;
wire [31:0] v39e = In_register_DSBASE;
wire v39f = v39e == Out_register_DSBASE;
wire [31:0] v3a1 = In_register_FSBASE;
wire v3a2 = v3a1 == Out_register_FSBASE;
wire v3a3 = v17;
wire v3a4 = v3a3 == Out_register_CF;
wire [31:0] v3a6 = In_register_ESBASE;
wire v3a7 = v3a6 == Out_register_ESBASE;
wire v3a8 = v329 == v15;
wire v3aa = v3a8;
wire v3ab = v3aa == Out_register_ZF;
wire v3ac = v31c & v31f & v15c & v334 & v337 & v338 & v33b & v345 & v34b & v355 & v35f & v362 & v365 & v369 & v373 & v37d & v380 & v38a & v392 & v39c & v39f & v3a2 & v3a4 & v3a7 & v3ab;
wire v3ad = v18 == v1eb;
wire v3ae = v3 == v316;
wire v3af = v1b == v318;
wire v3b0 = v3ad & v3ae & v3af;
wire v3b1 = v3b0;
wire v3b2 = v3b1;
wire [2:0] v3b3 = { v320 };
wire [31:0] v3b4 = ( v3b3 == 3'd0) ? In_register_EAX : 
	( v3b3 == 3'd1) ? In_register_ECX : 
	( v3b3 == 3'd2) ? In_register_EDX : 
	( v3b3 == 3'd3) ? In_register_EBX : 
	( v3b3 == 3'd4) ? In_register_ESP : 
	( v3b3 == 3'd5) ? In_register_EBP : 
	( v3b3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3b6 = v3b4;
wire [2:0] v3b7 = { v1fa };
wire [31:0] v3b8 = ( v3b7 == 3'd0) ? In_register_EAX : 
	( v3b7 == 3'd1) ? In_register_ECX : 
	( v3b7 == 3'd2) ? In_register_EDX : 
	( v3b7 == 3'd3) ? In_register_EBX : 
	( v3b7 == 3'd4) ? In_register_ESP : 
	( v3b7 == 3'd5) ? In_register_EBP : 
	( v3b7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3ba = v3b8;
wire [31:0] v3bb = v3b6 + v3ba;
wire v3bc = $signed(v3bb) < $signed(v15);
wire v3be = v3bc;
wire v3bf = v3be == Out_register_SF;
wire [7:0] v3c0 = v3bb[7:0];
wire [2:0] v3c1_aux = v3c0[0] + v3c0[1] + v3c0[2] + v3c0[3] + v3c0[4] + v3c0[5] + v3c0[6] + v3c0[7];
wire v3c1 = { 5'b00000, v3c1_aux };
wire [7:0] v3c2 = v3c1 & v18;
wire [7:0] v3c3 = v3c2 ^ v18;
wire v3c4 = v3c3[0:0];
wire v3c6 = v3c4;
wire v3c7 = v3c6 == Out_register_PF;
wire [2:0] v3c8 = { v1fa };
wire v3c9 = v3c8 == v7;
wire v3ca = v3c9;
wire v3cb = v3b0 & v3ca;
wire v3cc = v3cb;
wire [31:0] v3cf = ( v8 ) ? In_register_EAX : v3bb;
wire [31:0] v3d1 = v3cf;
wire v3d2 = v3d1 == Out_register_EAX;
wire v3d3 = v3bb == v15;
wire v3d5 = v3d3;
wire v3d6 = v3d5 == Out_register_ZF;
wire [31:0] v3d7 = v3bb ^ v3b6;
wire [31:0] v3d8 = v3d7 ^ v3ba;
wire [7:0] v3d9 = v3d8[7:0];
wire [7:0] v1d = 8'b00100000;
wire [7:0] v3da = v3d9 >> v1d;
wire [7:0] v3db = v3da & v18;
wire v3dc = v3db[0:0];
wire v3de = v3dc;
wire v3df = v3de == Out_register_AF;
wire v3e0 = v3c8 == vd;
wire v3e1 = v3e0;
wire v3e2 = v3b0 & v3e1;
wire v3e3 = v3e2;
wire [31:0] v3e6 = ( v8 ) ? In_register_EBX : v3bb;
wire [31:0] v3e8 = v3e6;
wire v3e9 = v3e8 == Out_register_EBX;
wire v3ea = v3c8 == vc;
wire v3eb = v3ea;
wire v3ec = v3b0 & v3eb;
wire v3ed = v3ec;
wire [31:0] v3f0 = ( v8 ) ? In_register_ECX : v3bb;
wire [31:0] v3f2 = v3f0;
wire v3f3 = v3f2 == Out_register_ECX;
wire v3f4 = v3c8 == ve;
wire v3f5 = v3f4;
wire v3f6 = v3b0 & v3f5;
wire v3f7 = v3f6;
wire [31:0] v3fa = ( v8 ) ? In_register_EDX : v3bb;
wire [31:0] v3fc = v3fa;
wire v3fd = v3fc == Out_register_EDX;
wire v3fe = v3c8 == v9;
wire v3ff = v3fe;
wire v400 = v3b0 & v3ff;
wire v401 = v400;
wire [31:0] v404 = ( v8 ) ? In_register_EDI : v3bb;
wire [31:0] v406 = v404;
wire v407 = v406 == Out_register_EDI;
wire v408 = v3c8 == vb;
wire v409 = v408;
wire v40a = v3b0 & v409;
wire v40b = v40a;
wire [31:0] v40e = ( v8 ) ? In_register_ESP : v3bb;
wire [31:0] v410 = v40e;
wire v411 = v410 == Out_register_ESP;
wire [31:0] v413 = v1c;
wire [31:0] v414 = In_register_EIP + v413;
wire [31:0] v416 = v414;
wire v417 = v416 == Out_register_EIP;
wire v418 = v3c8 == v11;
wire v419 = v418;
wire v41a = v3b0 & v419;
wire v41b = v41a;
wire [31:0] v41e = ( v8 ) ? In_register_ESI : v3bb;
wire [31:0] v420 = v41e;
wire v421 = v420 == Out_register_ESI;
wire [31:0] v422 = v3bb ^ v3ba;
wire [31:0] v1e = 32'b11111000000000000000000000000000;
wire [31:0] v423 = v422 >> v1e;
wire [31:0] v424 = v3d7 >> v1e;
wire [31:0] v425 = v423 + v424;
wire v426 = v425 == v1c;
wire v428 = v426;
wire v429 = v428 == Out_register_OF;
wire [31:0] v42b = In_register_CSBASE;
wire v42c = v42b == Out_register_CSBASE;
wire [31:0] v42e = In_register_ESBASE;
wire v42f = v42e == Out_register_ESBASE;
wire [31:0] v431 = In_register_DSBASE;
wire v432 = v431 == Out_register_DSBASE;
wire v433 = v3c8 == vf;
wire v434 = v433;
wire v435 = v3b0 & v434;
wire v436 = v435;
wire [31:0] v439 = ( v8 ) ? In_register_EBP : v3bb;
wire [31:0] v43b = v439;
wire v43c = v43b == Out_register_EBP;
wire [31:0] v43e = In_register_FSBASE;
wire v43f = v43e == Out_register_FSBASE;
wire v440 = In_error_flag == Out_error_flag;
wire v441 = v3bb < v3ba;
wire v442 = v3bb < v3b6;
wire v443 = v441 | v442;
wire v445 = v443;
wire v446 = v445 == Out_register_CF;
wire [31:0] v448 = In_register_GSBASE;
wire v449 = v448 == Out_register_GSBASE;
wire [7:0] v44b = In_register_DF;
wire v44c = v44b == Out_register_DF;
wire [31:0] v44e = In_register_SSBASE;
wire v44f = v44e == Out_register_SSBASE;
wire v450 = v3b2 & v3bf & v3c7 & v15c & v3d2 & v3d6 & v3df & v3e9 & v3f3 & v3fd & v407 & v411 & v417 & v421 & v429 & v42c & v42f & v432 & v43c & v43f & v440 & v446 & v449 & v44c & v44f;
wire [7:0] v1f = 8'b01000111;
wire v451 = v1f == v1eb;
wire v452 = v1b == v318;
wire v453 = v451 & v452;
wire v454 = v453;
wire v455 = v454;
wire [31:0] v457 = In_register_ESP;
wire v458 = v457 == Out_register_ESP;
wire [31:0] v20 = 32'b11111111111111111111111111111111;
wire [31:0] v459 = In_register_ECX + v20;
wire [31:0] v45b = v459;
wire v45c = v45b == Out_register_ECX;
wire [31:0] v45e = In_register_ESBASE;
wire v45f = v45e == Out_register_ESBASE;
wire [7:0] v461 = In_register_DF;
wire v462 = v461 == Out_register_DF;
wire v463 = In_error_flag == Out_error_flag;
wire [31:0] v465 = In_register_EDX;
wire v466 = v465 == Out_register_EDX;
wire [31:0] v468 = In_register_EDI;
wire v469 = v468 == Out_register_EDI;
wire [31:0] v46b = In_register_ESI;
wire v46c = v46b == Out_register_ESI;
wire [31:0] v46e = In_register_EBX;
wire v46f = v46e == Out_register_EBX;
wire [31:0] v472 = v1c;
wire [31:0] v473 = In_register_EIP + v472;
wire v470 = v459 != v15;
wire [31:0] v475 = v473;
wire [7:0] v476 = instruction_bits[15: 8];
wire [7:0] pad_1143 = (v476[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] v477 = { pad_1143, v476 };
wire [31:0] v478 = v473 + v477;
wire [31:0] v47a = v478;
wire [31:0] v47b = ( v470 == 1'd0) ? v475 : v47a;
wire [31:0] v47e = ( v8 ) ? v473 : v47b;
wire [31:0] v480 = v47e;
wire v481 = v480 == Out_register_EIP;
wire [31:0] v483 = In_register_EBP;
wire v484 = v483 == Out_register_EBP;
wire [31:0] v486 = In_register_CSBASE;
wire v487 = v486 == Out_register_CSBASE;
wire v489 = In_register_OF;
wire v48a = v489 == Out_register_OF;
wire [31:0] v48c = In_register_EAX;
wire v48d = v48c == Out_register_EAX;
wire [31:0] v48f = In_register_FSBASE;
wire v490 = v48f == Out_register_FSBASE;
wire [31:0] v492 = In_register_SSBASE;
wire v493 = v492 == Out_register_SSBASE;
wire v495 = In_register_AF;
wire v496 = v495 == Out_register_AF;
wire [31:0] v498 = In_register_DSBASE;
wire v499 = v498 == Out_register_DSBASE;
wire v49b = In_register_CF;
wire v49c = v49b == Out_register_CF;
wire [31:0] v49e = In_register_GSBASE;
wire v49f = v49e == Out_register_GSBASE;
wire v4a1 = In_register_PF;
wire v4a2 = v4a1 == Out_register_PF;
wire v4a4 = In_register_SF;
wire v4a5 = v4a4 == Out_register_SF;
wire v4a7 = In_register_ZF;
wire v4a8 = v4a7 == Out_register_ZF;
wire v4a9 = v15c & v458 & v45c & v45f & v462 & v463 & v466 & v469 & v46c & v46f & v481 & v484 & v455 & v487 & v48a & v48d & v490 & v493 & v496 & v499 & v49c & v49f & v4a2 & v4a5 & v4a8;
wire [7:0] v21 = 8'b10010110;
wire v4aa = v21 == v1eb;
wire v4ab = v3 == v316;
wire v4ac = v14 == v1ef;
wire v4ad = v4aa & v4ab & v4ac;
wire v4ae = v4ad;
wire v4af = v4ae;
wire [2:0] v4ba = { v320 };
wire v4bb = v4ba == vc;
wire v4bc = v4bb;
wire v4bd = v4ad & v4bc;
wire v4be = v4bd;
wire [31:0] v4b1 = v1f7;
wire [31:0] pad_1202 = (v4b1[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v4b2 = { pad_1202, v4b1 };
wire [2:0] v4b3 = { v1fa };
wire [31:0] v4b4 = ( v4b3 == 3'd0) ? In_register_EAX : 
	( v4b3 == 3'd1) ? In_register_ECX : 
	( v4b3 == 3'd2) ? In_register_EDX : 
	( v4b3 == 3'd3) ? In_register_EBX : 
	( v4b3 == 3'd4) ? In_register_ESP : 
	( v4b3 == 3'd5) ? In_register_EBP : 
	( v4b3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4b6 = v4b4;
wire [31:0] pad_1207 = (v4b6[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v4b7 = { pad_1207, v4b6 };
wire [63:0] v4b8 = v4b2 * v4b7;
wire [31:0] v4b9 = v4b8[31:0];
wire [31:0] v4c1 = ( v8 ) ? In_register_ECX : v4b9;
wire [31:0] v4c3 = v4c1;
wire v4c4 = v4c3 == Out_register_ECX;
wire v4c5 = v4ba == v9;
wire v4c6 = v4c5;
wire v4c7 = v4ad & v4c6;
wire v4c8 = v4c7;
wire [31:0] v4cb = ( v8 ) ? In_register_EDI : v4b9;
wire [31:0] v4cd = v4cb;
wire v4ce = v4cd == Out_register_EDI;
wire [63:0] v22 = 64'b0000000000000000000000000000000111111111111111111111111111111111;
wire [63:0] v4cf = v4b8 + v22;
wire [63:0] v23 = 64'b0000000000000000000000000000000011111111111111111111111111111111;
wire v4d0 = v4cf < v23;
wire v4d2 = v4d0;
wire v4d3 = v4d2 == Out_register_OF;
wire v4d4 = In_error_flag == Out_error_flag;
wire v4d5 = v4ba == ve;
wire v4d6 = v4d5;
wire v4d7 = v4ad & v4d6;
wire v4d8 = v4d7;
wire [31:0] v4db = ( v8 ) ? In_register_EDX : v4b9;
wire [31:0] v4dd = v4db;
wire v4de = v4dd == Out_register_EDX;
wire v4df = v4ba == v11;
wire v4e0 = v4df;
wire v4e1 = v4ad & v4e0;
wire v4e2 = v4e1;
wire [31:0] v4e5 = ( v8 ) ? In_register_ESI : v4b9;
wire [31:0] v4e7 = v4e5;
wire v4e8 = v4e7 == Out_register_ESI;
wire v4e9 = v4ba == v7;
wire v4ea = v4e9;
wire v4eb = v4ad & v4ea;
wire v4ec = v4eb;
wire [31:0] v4ef = ( v8 ) ? In_register_EAX : v4b9;
wire [31:0] v4f1 = v4ef;
wire v4f2 = v4f1 == Out_register_EAX;
wire v4f3 = v4ba == vd;
wire v4f4 = v4f3;
wire v4f5 = v4ad & v4f4;
wire v4f6 = v4f5;
wire [31:0] v4f9 = ( v8 ) ? In_register_EBX : v4b9;
wire [31:0] v4fb = v4f9;
wire v4fc = v4fb == Out_register_EBX;
wire v4fe = In_register_AF;
wire v4ff = v4fe == Out_register_AF;
wire v501 = In_register_ZF;
wire v502 = v501 == Out_register_ZF;
wire v503 = v4d0;
wire v504 = v503 == Out_register_CF;
wire v505 = v4ba == vb;
wire v506 = v505;
wire v507 = v4ad & v506;
wire v508 = v507;
wire [31:0] v50b = ( v8 ) ? In_register_ESP : v4b9;
wire [31:0] v50d = v50b;
wire v50e = v50d == Out_register_ESP;
wire v50f = v4ba == vf;
wire v510 = v50f;
wire v511 = v4ad & v510;
wire v512 = v511;
wire [31:0] v515 = ( v8 ) ? In_register_EBP : v4b9;
wire [31:0] v517 = v515;
wire v518 = v517 == Out_register_EBP;
wire [31:0] v51a = v16;
wire [31:0] v51b = In_register_EIP + v51a;
wire [31:0] v51d = v51b;
wire v51e = v51d == Out_register_EIP;
wire [31:0] v520 = In_register_CSBASE;
wire v521 = v520 == Out_register_CSBASE;
wire [31:0] v523 = In_register_SSBASE;
wire v524 = v523 == Out_register_SSBASE;
wire [31:0] v526 = In_register_ESBASE;
wire v527 = v526 == Out_register_ESBASE;
wire [31:0] v529 = In_register_GSBASE;
wire v52a = v529 == Out_register_GSBASE;
wire [31:0] v52c = In_register_FSBASE;
wire v52d = v52c == Out_register_FSBASE;
wire [7:0] v52f = In_register_DF;
wire v530 = v52f == Out_register_DF;
wire [31:0] v532 = In_register_DSBASE;
wire v533 = v532 == Out_register_DSBASE;
wire v535 = In_register_SF;
wire v536 = v535 == Out_register_SF;
wire v538 = In_register_PF;
wire v539 = v538 == Out_register_PF;
wire v53a = v4af & v15c & v4c4 & v4ce & v4d3 & v4d4 & v4de & v4e8 & v4f2 & v4fc & v4ff & v502 & v504 & v50e & v518 & v51e & v521 & v524 & v527 & v52a & v52d & v530 & v533 & v536 & v539;
wire [3:0] v26 = 4'b0010;
wire [7:0] v24 = 8'b11110001;
wire v53e = v24 == v1eb;
wire [4:0] v25 = 5'b00000;
wire v53f = v25 == v1ed;
wire v540 = v1b == v318;
wire [2:0] v541 = { v1fa };
wire v542 = v541 == vb;
wire v543 = v541 == vf;
wire v544 = v542 | v543;
wire v545 = v544 ^ v8;
wire [2:0] v546 = { v1fa };
wire v547 = v546 == vb;
wire v548 = v546 == vf;
wire v549 = v547 | v548;
wire v54a = v549 ^ v8;
wire v54b = v545 & v54a;
wire v54c = v53e & v53f & v540 & v54b;
wire [2:0] v53c = { v1fa };
wire [31:0] v53d = ( v53c == 3'd0) ? In_register_EAX : 
	( v53c == 3'd1) ? In_register_ECX : 
	( v53c == 3'd2) ? In_register_EDX : 
	( v53c == 3'd3) ? In_register_EBX : 
	( v53c == 3'd4) ? v15 : 
	( v53c == 3'd5) ? v15 : 
	( v53c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v54e = v53d;
wire [31:0] v550 = memory_0[79: 48];
wire v551 =  v26 == memory_1[15: 12] && v54e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v550 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v552 = v54c;
wire v553 = v552;
wire [31:0] v555 = In_register_SSBASE;
wire v556 = v555 == Out_register_SSBASE;
wire [31:0] v558 = In_register_EAX;
wire v559 = v558 == Out_register_EAX;
wire [31:0] v55a = In_register_SSBASE + In_register_ESP;
wire v55b =  v26 == memory_0[15: 12] && v55a == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v55d = In_register_OF;
wire v55e = v55d == Out_register_OF;
wire [31:0] v27 = 32'b00100000000000000000000000000000;
wire [31:0] v55f = In_register_ESP + v27;
wire [31:0] v561 = v55f;
wire v562 = v561 == Out_register_ESP;
wire v564 = In_register_AF;
wire v565 = v564 == Out_register_AF;
wire [31:0] v567 = In_register_ESBASE;
wire v568 = v567 == Out_register_ESBASE;
wire [31:0] v56a = In_register_EBX;
wire v56b = v56a == Out_register_EBX;
wire [31:0] v56d = In_register_ECX;
wire v56e = v56d == Out_register_ECX;
wire [31:0] v570 = In_register_EDX;
wire v571 = v570 == Out_register_EDX;
wire v573 = In_register_CF;
wire v574 = v573 == Out_register_CF;
wire [31:0] v576 = In_register_ESI;
wire v577 = v576 == Out_register_ESI;
wire v578 = In_error_flag == Out_error_flag;
wire [31:0] v57a = In_register_EDI;
wire v57b = v57a == Out_register_EDI;
wire [31:0] v57d = In_register_EBP;
wire v57e = v57d == Out_register_EBP;
wire [31:0] v580 = In_register_CSBASE;
wire v581 = v580 == Out_register_CSBASE;
wire [31:0] v583 = v1c;
wire [31:0] v584 = In_register_EIP + v583;
wire [31:0] v586 = v584;
wire v587 = v586 == Out_register_EIP;
wire [31:0] v589 = In_register_DSBASE;
wire v58a = v589 == Out_register_DSBASE;
wire [31:0] v58c = In_register_GSBASE;
wire v58d = v58c == Out_register_GSBASE;
wire [7:0] v58f = In_register_DF;
wire v590 = v58f == Out_register_DF;
wire [31:0] v592 = In_register_FSBASE;
wire v593 = v592 == Out_register_FSBASE;
wire v595 = In_register_PF;
wire v596 = v595 == Out_register_PF;
wire v598 = In_register_SF;
wire v599 = v598 == Out_register_SF;
wire v59b = In_register_ZF;
wire v59c = v59b == Out_register_ZF;
wire v59d = v551 & v556 & v559 & v55b & v55e & v553 & v562 & v565 & v568 & v56b & v56e & v571 & v574 & v577 & v15c & v578 & v57b & v57e & v581 & v587 & v58a & v58d & v590 & v593 & v596 & v599 & v59c;
wire [7:0] v28 = 8'b00110101;
wire v59e = v28 == v1eb;
wire [111:0] v29 = 112'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [111:0] v59f = instruction_bits[119: 8];
wire v5a0 = v29 == v59f;
wire v5a1 = v59e & v5a0;
wire v5a2 = v5a1;
wire v5a3 = v5a2;
wire [31:0] v5a5 = In_register_CSBASE;
wire v5a6 = v5a5 == Out_register_CSBASE;
wire [3:0] v2a = 4'b1000;
wire [31:0] v5a7 = In_register_DSBASE + In_register_ESI;
wire v5a8 =  v2a == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v5aa = In_register_EDI;
wire v5ab = v5aa == Out_register_EDI;
wire [31:0] v5ad = In_register_ECX;
wire v5ae = v5ad == Out_register_ECX;
wire v5af = In_error_flag == Out_error_flag;
wire v5b1 = In_register_PF;
wire v5b2 = v5b1 == Out_register_PF;
wire [31:0] v5b4 = In_register_EDX;
wire v5b5 = v5b4 == Out_register_EDX;
wire [31:0] v5b7 = In_register_EBX;
wire v5b8 = v5b7 == Out_register_EBX;
wire [31:0] v2b = 32'b10000000000000000000000000000000;
wire [31:0] v5ba = v2b;
wire [31:0] v5bb = In_register_EIP + v5ba;
wire [31:0] v5bd = v5bb;
wire v5be = v5bd == Out_register_EIP;
wire [7:0] v2c = 8'b00000000;
wire v5bf = In_register_DF == v2c;
wire [31:0] v5c0 = ( v5bf == 1'd0) ? v20 : v2b;
wire [31:0] v5c1 = v5c0 + In_register_ESI;
wire [31:0] v5c3 = v5c1;
wire v5c4 = v5c3 == Out_register_ESI;
wire [31:0] v5c6 = In_register_EBP;
wire v5c7 = v5c6 == Out_register_EBP;
wire [31:0] v2d = 32'b00000000111111111111111111111111;
wire [31:0] v5c8 = In_register_EAX & v2d;
wire [31:0] v5c9 = memory_0[79: 48];
wire [7:0] v5ca = v5c9[7:0];
wire [31:0] v5cb = { 24'b000000000000000000000000, v5ca };
wire [31:0] v5cc = v5c8 | v5cb;
wire [31:0] v5ce = v5cc;
wire v5cf = v5ce == Out_register_EAX;
wire v5d1 = In_register_AF;
wire v5d2 = v5d1 == Out_register_AF;
wire [31:0] v5d4 = In_register_ESBASE;
wire v5d5 = v5d4 == Out_register_ESBASE;
wire [7:0] v5d7 = In_register_DF;
wire v5d8 = v5d7 == Out_register_DF;
wire [31:0] v5da = In_register_GSBASE;
wire v5db = v5da == Out_register_GSBASE;
wire [31:0] v5dd = In_register_FSBASE;
wire v5de = v5dd == Out_register_FSBASE;
wire [31:0] v5e0 = In_register_ESP;
wire v5e1 = v5e0 == Out_register_ESP;
wire [31:0] v5e3 = In_register_DSBASE;
wire v5e4 = v5e3 == Out_register_DSBASE;
wire v5e6 = In_register_CF;
wire v5e7 = v5e6 == Out_register_CF;
wire v5e9 = In_register_OF;
wire v5ea = v5e9 == Out_register_OF;
wire [31:0] v5ec = In_register_SSBASE;
wire v5ed = v5ec == Out_register_SSBASE;
wire v5ef = In_register_SF;
wire v5f0 = v5ef == Out_register_SF;
wire v5f2 = In_register_ZF;
wire v5f3 = v5f2 == Out_register_ZF;
wire v5f4 = v5a6 & v5a8 & v5ab & v5ae & v15c & v5a3 & v5af & v5b2 & v5b5 & v5b8 & v5be & v5c4 & v5c7 & v5cf & v5d2 & v5d5 & v5d8 & v5db & v5de & v5e1 & v5e4 & v5e7 & v5ea & v5ed & v5f0 & v5f3;
wire [7:0] v2e = 8'b00011000;
wire v5f5 = v2e == v1eb;
wire [1:0] v2f = 2'b01;
wire v5f6 = v2f == v316;
wire v5f7 = v14 == v1ef;
wire [2:0] v5f8 = { v1fa };
wire v5f9 = v5f8 == vb;
wire v5fa = v5f8 == vf;
wire v5fb = v5f9 | v5fa;
wire v5fc = v5fb ^ v8;
wire [2:0] v5fd = { v1fa };
wire v5fe = v5fd == vb;
wire v5ff = v5fe;
wire v600 = v5ff ^ v8;
wire [2:0] v601 = { v1fa };
wire v602 = v601 == vb;
wire v603 = v601 == vf;
wire v604 = v602 | v603;
wire v605 = v604 ^ v8;
wire [2:0] v606 = { v1fa };
wire v607 = v606 == vb;
wire v608 = v607;
wire v609 = v608 ^ v8;
wire v60a = v5fc & v600 & v605 & v609;
wire v60b = v5f5 & v5f6 & v5f7 & v60a;
wire v60c = v2e == v1eb;
wire [1:0] v30 = 2'b10;
wire v60d = v30 == v316;
wire v60e = v4 == v11b;
wire [2:0] v60f = { v1fa };
wire v610 = v60f == vb;
wire v611 = v610;
wire v612 = v611 ^ v8;
wire [2:0] v613 = { v1fa };
wire v614 = v613 == vb;
wire v615 = v614;
wire v616 = v615 ^ v8;
wire [2:0] v617 = { v1fa };
wire v618 = v617 == vb;
wire v619 = v618;
wire v61a = v619 ^ v8;
wire [2:0] v61b = { v1fa };
wire v61c = v61b == vb;
wire v61d = v61c;
wire v61e = v61d ^ v8;
wire v61f = v612 & v616 & v61a & v61e;
wire v620 = v60c & v60d & v60e & v61f;
wire v621 = v60b | v620;
wire v622 = v621;
wire [31:0] v624 = In_register_EDX;
wire v625 = v624 == Out_register_EDX;
wire [7:0] v627 = In_register_DF;
wire v628 = v627 == Out_register_DF;
wire [31:0] v62a = In_register_EBP;
wire v62b = v62a == Out_register_EBP;
wire v62c = In_error_flag == Out_error_flag;
wire [31:0] v62e = In_register_EAX;
wire v62f = v62e == Out_register_EAX;
wire [31:0] v631 = In_register_CSBASE;
wire v632 = v631 == Out_register_CSBASE;
wire [2:0] v633 = { v1fa };
wire [31:0] v634 = ( v633 == 3'd0) ? In_register_EAX : 
	( v633 == 3'd1) ? In_register_ECX : 
	( v633 == 3'd2) ? In_register_EDX : 
	( v633 == 3'd3) ? In_register_EBX : 
	( v633 == 3'd4) ? v15 : 
	( v633 == 3'd5) ? v15 : 
	( v633 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v635 = v634 + v1f7;
wire [2:0] v637 = { v1fa };
wire [31:0] v638 = ( v637 == 3'd0) ? In_register_EAX : 
	( v637 == 3'd1) ? In_register_ECX : 
	( v637 == 3'd2) ? In_register_EDX : 
	( v637 == 3'd3) ? In_register_EBX : 
	( v637 == 3'd4) ? v15 : 
	( v637 == 3'd5) ? In_register_EBP : 
	( v637 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [7:0] v639 = instruction_bits[23: 16];
wire [7:0] pad_1594 = (v639[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] v63a = { pad_1594, v639 };
wire [31:0] v63b = v638 + v63a;
wire [31:0] v63d = ( v60b ) ? v635 : v63b;
wire [31:0] v63e = memory_0[79: 48];
wire [7:0] v63f = v63e[7:0];
wire [2:0] v640 = { v320 };
wire [31:0] v641 = ( v640 == 3'd0) ? In_register_EAX : 
	( v640 == 3'd1) ? In_register_ECX : 
	( v640 == 3'd2) ? In_register_EDX : 
	( v640 == 3'd3) ? In_register_EBX : 
	( v640 == 3'd4) ? In_register_EAX : 
	( v640 == 3'd5) ? In_register_ECX : 
	( v640 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v642 = { v320 };
wire v643 = v642 == vb;
wire v644 = v642 == v9;
wire v645 = v643 | v644;
wire v646 = v642 == vf;
wire v647 = v645 | v646;
wire v648 = v642 == v11;
wire v649 = v647 | v648;
wire [31:0] v31 = 32'b00010000000000000000000000000000;
wire [31:0] v64a = ( v649 == 1'd0) ? v15 : v31;
wire [31:0] v64b = v641 >> v64a;
wire [31:0] v32 = 32'b11111111000000000000000000000000;
wire [31:0] v64c = v64b & v32;
wire [2:0] v64e = { v320 };
wire [31:0] v64f = ( v64e == 3'd0) ? In_register_EAX : 
	( v64e == 3'd1) ? In_register_ECX : 
	( v64e == 3'd2) ? In_register_EDX : 
	( v64e == 3'd3) ? In_register_EBX : 
	( v64e == 3'd4) ? In_register_EAX : 
	( v64e == 3'd5) ? In_register_ECX : 
	( v64e == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v650 = { v320 };
wire v651 = v650 == vb;
wire v652 = v650 == v9;
wire v653 = v651 | v652;
wire v654 = v650 == vf;
wire v655 = v653 | v654;
wire v656 = v650 == v11;
wire v657 = v655 | v656;
wire [31:0] v658 = ( v657 == 1'd0) ? v15 : v31;
wire [31:0] v659 = v64f >> v658;
wire [31:0] v65a = v659 & v32;
wire [31:0] v65c = ( v60b ) ? v64c : v65a;
wire [7:0] v65d = v65c[7:0];
wire [7:0] v65e = v63f - v65d;
wire [7:0] v65f = { 7'b0000000, In_register_CF };
wire [7:0] v660 = v65e - v65f;
wire v661 =  v2a == memory_1[15: 12] && v63d == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v660 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [2:0] v662_aux = v660[0] + v660[1] + v660[2] + v660[3] + v660[4] + v660[5] + v660[6] + v660[7];
wire v662 = { 5'b00000, v662_aux };
wire [7:0] v663 = v662 & v18;
wire [7:0] v664 = v663 ^ v18;
wire v665 = v664[0:0];
wire v667 = v665;
wire v668 = v667 == Out_register_PF;
wire [31:0] v66b = ( v60b ) ? v16 : v10;
wire [31:0] v66c = In_register_EIP + v66b;
wire [31:0] v66e = v66c;
wire v66f = v66e == Out_register_EIP;
wire [31:0] v671 = In_register_EBX;
wire v672 = v671 == Out_register_EBX;
wire [31:0] v674 = In_register_DSBASE;
wire v675 = v674 == Out_register_DSBASE;
wire [31:0] v677 = In_register_ECX;
wire v678 = v677 == Out_register_ECX;
wire [31:0] v67a = In_register_ESBASE;
wire v67b = v67a == Out_register_ESBASE;
wire [31:0] v67d = In_register_GSBASE;
wire v67e = v67d == Out_register_GSBASE;
wire v67f = v63f < v65d;
wire v680 = v65e < v65f;
wire [7:0] v681 = { 7'b0000000, v680 };
wire [7:0] v682 = ( v67f == 1'd0) ? v681 : v18;
wire v683 = v682[0:0];
wire v685 = v683;
wire v686 = v685 == Out_register_CF;
wire [31:0] v688 = In_register_ESP;
wire v689 = v688 == Out_register_ESP;
wire [31:0] v68b = In_register_ESI;
wire v68c = v68b == Out_register_ESI;
wire [31:0] v68e = In_register_EDI;
wire v68f = v68e == Out_register_EDI;
wire [31:0] v691 = In_register_SSBASE;
wire v692 = v691 == Out_register_SSBASE;
wire [2:0] v693 = { v1fa };
wire [31:0] v694 = ( v693 == 3'd0) ? In_register_EAX : 
	( v693 == 3'd1) ? In_register_ECX : 
	( v693 == 3'd2) ? In_register_EDX : 
	( v693 == 3'd3) ? In_register_EBX : 
	( v693 == 3'd4) ? v15 : 
	( v693 == 3'd5) ? v15 : 
	( v693 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v695 = v694 + v1f7;
wire [2:0] v697 = { v1fa };
wire [31:0] v698 = ( v697 == 3'd0) ? In_register_EAX : 
	( v697 == 3'd1) ? In_register_ECX : 
	( v697 == 3'd2) ? In_register_EDX : 
	( v697 == 3'd3) ? In_register_EBX : 
	( v697 == 3'd4) ? v15 : 
	( v697 == 3'd5) ? In_register_EBP : 
	( v697 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v699 = v698 + v63a;
wire [31:0] v69b = ( v60b ) ? v695 : v699;
wire v69c =  v2a == memory_0[15: 12] && v69b == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v69e = In_register_FSBASE;
wire v69f = v69e == Out_register_FSBASE;
wire [7:0] v6a0 = v63f ^ v65d;
wire [7:0] v6a1 = v660 ^ v6a0;
wire [7:0] v6a2 = v6a1 >> v1d;
wire [7:0] v6a3 = v6a2 & v18;
wire v6a4 = v6a3[0:0];
wire v6a6 = v6a4;
wire v6a7 = v6a6 == Out_register_AF;
wire [7:0] v6a8 = v660 ^ v63f;
wire [7:0] v33 = 8'b11100000;
wire [7:0] v6a9 = v6a8 >> v33;
wire [7:0] v6aa = v6a0 >> v33;
wire [7:0] v6ab = v6a9 + v6aa;
wire [7:0] v34 = 8'b01000000;
wire v6ac = v6ab == v34;
wire v6ae = v6ac;
wire v6af = v6ae == Out_register_OF;
wire v6b0 = $signed(v660) < $signed(v2c);
wire v6b2 = v6b0;
wire v6b3 = v6b2 == Out_register_SF;
wire v6b4 = v65e == v65f;
wire v6b6 = v6b4;
wire v6b7 = v6b6 == Out_register_ZF;
wire v6b8 = v15c & v625 & v628 & v62b & v62c & v62f & v632 & v661 & v668 & v66f & v672 & v675 & v678 & v67b & v622 & v67e & v686 & v689 & v68c & v68f & v692 & v69c & v69f & v6a7 & v6af & v6b3 & v6b7;
wire v6b9 = v34 == v1eb;
wire [1:0] v35 = 2'b00;
wire v6ba = v35 == v316;
wire v6bb = v1b == v318;
wire [2:0] v6bc = { v1fa };
wire v6bd = v6bc == vb;
wire v6be = v6bc == vf;
wire v6bf = v6bd | v6be;
wire v6c0 = v6bf ^ v8;
wire [2:0] v6c1 = { v1fa };
wire v6c2 = v6c1 == vb;
wire v6c3 = v6c1 == vf;
wire v6c4 = v6c2 | v6c3;
wire v6c5 = v6c4 ^ v8;
wire v6c6 = v6c0 & v6c5;
wire v6c7 = v6b9 & v6ba & v6bb & v6c6;
wire [15:0] v36 = 16'b0110110001000000;
wire v6c8 = v36 == v117;
wire v6c9 = v35 == v119;
wire v6ca = v4 == v11b;
wire [2:0] v6cb = { v13c };
wire v6cc = v6cb == vb;
wire v6cd = v6cb == vf;
wire v6ce = v6cc | v6cd;
wire v6cf = v6ce ^ v8;
wire [2:0] v6d0 = { v13c };
wire v6d1 = v6d0 == vb;
wire v6d2 = v6d0 == vf;
wire v6d3 = v6d1 | v6d2;
wire v6d4 = v6d3 ^ v8;
wire v6d5 = v6cf & v6d4;
wire v6d6 = v6c8 & v6c9 & v6ca & v6d5;
wire [10:0] v37 = 11'b01000000001;
wire [10:0] v6d7 = instruction_bits[10: 0];
wire v6d8 = v37 == v6d7;
wire v6d9 = v30 == v316;
wire [87:0] v38 = 88'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [87:0] v6da = instruction_bits[119: 32];
wire v6db = v38 == v6da;
wire [2:0] v6dc = { v13c };
wire v6dd = v6dc == vb;
wire v6de = v6dc == vf;
wire v6df = v6dd | v6de;
wire v6e0 = v6df ^ v8;
wire [2:0] v6e1 = { v12c };
wire v6e2 = v6e1 == vb;
wire v6e3 = v6e2;
wire v6e4 = v6e3 ^ v8;
wire v6e5 = v6e0 & v6e4;
wire v6e6 = v6d8 & v6d9 & v6db & v6e5;
wire [10:0] v39 = 11'b01000000101;
wire v6e7 = v39 == v6d7;
wire v6e8 = v35 == v316;
wire v6e9 = v14 == v1ef;
wire v6ea = v6e7 & v6e8 & v6e9;
wire v6eb = v6c7 | v6d6 | v6e6 | v6ea;
wire v6ec = v6eb;
wire [31:0] v6ed = memory_0[79: 48];
wire [7:0] v6ee = v6ed[7:0];
wire [2:0] v719 = { v320 };
wire [31:0] v71a = ( v719 == 3'd0) ? In_register_EAX : 
	( v719 == 3'd1) ? In_register_ECX : 
	( v719 == 3'd2) ? In_register_EDX : 
	( v719 == 3'd3) ? In_register_EBX : 
	( v719 == 3'd4) ? In_register_EAX : 
	( v719 == 3'd5) ? In_register_ECX : 
	( v719 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v71b = { v320 };
wire v71c = v71b == vb;
wire v71d = v71b == v9;
wire v71e = v71c | v71d;
wire v71f = v71b == vf;
wire v720 = v71e | v71f;
wire v721 = v71b == v11;
wire v722 = v720 | v721;
wire [31:0] v723 = ( v722 == 1'd0) ? v15 : v31;
wire [31:0] v724 = v71a >> v723;
wire [31:0] v725 = v724 & v32;
wire [2:0] v6ef = { v320 };
wire [31:0] v6f0 = ( v6ef == 3'd0) ? In_register_EAX : 
	( v6ef == 3'd1) ? In_register_ECX : 
	( v6ef == 3'd2) ? In_register_EDX : 
	( v6ef == 3'd3) ? In_register_EBX : 
	( v6ef == 3'd4) ? In_register_EAX : 
	( v6ef == 3'd5) ? In_register_ECX : 
	( v6ef == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6f1 = { v320 };
wire v6f2 = v6f1 == vb;
wire v6f3 = v6f1 == v9;
wire v6f4 = v6f2 | v6f3;
wire v6f5 = v6f1 == vf;
wire v6f6 = v6f4 | v6f5;
wire v6f7 = v6f1 == v11;
wire v6f8 = v6f6 | v6f7;
wire [31:0] v6f9 = ( v6f8 == 1'd0) ? v15 : v31;
wire [31:0] v6fa = v6f0 >> v6f9;
wire [31:0] v6fb = v6fa & v32;
wire [2:0] v6fd = { v12c };
wire [31:0] v6fe = ( v6fd == 3'd0) ? In_register_EAX : 
	( v6fd == 3'd1) ? In_register_ECX : 
	( v6fd == 3'd2) ? In_register_EDX : 
	( v6fd == 3'd3) ? In_register_EBX : 
	( v6fd == 3'd4) ? In_register_EAX : 
	( v6fd == 3'd5) ? In_register_ECX : 
	( v6fd == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6ff = { v12c };
wire v700 = v6ff == vb;
wire v701 = v6ff == v9;
wire v702 = v700 | v701;
wire v703 = v6ff == vf;
wire v704 = v702 | v703;
wire v705 = v6ff == v11;
wire v706 = v704 | v705;
wire [31:0] v707 = ( v706 == 1'd0) ? v15 : v31;
wire [31:0] v708 = v6fe >> v707;
wire [31:0] v709 = v708 & v32;
wire [2:0] v70b = { v320 };
wire [31:0] v70c = ( v70b == 3'd0) ? In_register_EAX : 
	( v70b == 3'd1) ? In_register_ECX : 
	( v70b == 3'd2) ? In_register_EDX : 
	( v70b == 3'd3) ? In_register_EBX : 
	( v70b == 3'd4) ? In_register_EAX : 
	( v70b == 3'd5) ? In_register_ECX : 
	( v70b == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v70d = { v320 };
wire v70e = v70d == vb;
wire v70f = v70d == v9;
wire v710 = v70e | v70f;
wire v711 = v70d == vf;
wire v712 = v710 | v711;
wire v713 = v70d == v11;
wire v714 = v712 | v713;
wire [31:0] v715 = ( v714 == 1'd0) ? v15 : v31;
wire [31:0] v716 = v70c >> v715;
wire [31:0] v717 = v716 & v32;
wire [31:0] v727 = ( v6ea ) ? v725 : 
	( v6c7 ) ? v6fb : 
	( v6d6 ) ? v709 : v717;
wire [7:0] v728 = v727[7:0];
wire [7:0] v729 = v6ee + v728;
wire [7:0] v72a = v729 ^ v6ee;
wire [7:0] v72b = v72a ^ v728;
wire [7:0] v72c = v72b >> v1d;
wire [7:0] v72d = v72c & v18;
wire v72e = v72d[0:0];
wire v730 = v72e;
wire v731 = v730 == Out_register_AF;
wire v732 = In_error_flag == Out_error_flag;
wire [31:0] v734 = In_register_CSBASE;
wire v735 = v734 == Out_register_CSBASE;
wire [7:0] v736 = v729 ^ v728;
wire [7:0] v737 = v736 >> v33;
wire [7:0] v738 = v72a >> v33;
wire [7:0] v739 = v737 + v738;
wire v73a = v739 == v34;
wire v73c = v73a;
wire v73d = v73c == Out_register_OF;
wire [2:0] v740 = { v320 };
wire v741 = v740 == v7;
wire v742 = v741;
wire v743 = v6c7 & v742;
wire [2:0] v744 = { v12c };
wire v745 = v744 == v7;
wire v746 = v745;
wire v747 = v6d6 & v746;
wire [2:0] v748 = { v320 };
wire v749 = v748 == v7;
wire v74a = v749;
wire v74b = v6e6 & v74a;
wire [2:0] v74c = { v320 };
wire v74d = v74c == v7;
wire v74e = v74d;
wire v74f = v6ea & v74e;
wire v750 = v743 | v747 | v74b | v74f;
wire [31:0] v73e = { 24'b000000000000000000000000, v729 };
wire [31:0] v73f = v5c8 | v73e;
wire v755 = v740 == vb;
wire v756 = v755;
wire v757 = v6c7 & v756;
wire v758 = v744 == vb;
wire v759 = v758;
wire v75a = v6d6 & v759;
wire v75b = v748 == vb;
wire v75c = v75b;
wire v75d = v6e6 & v75c;
wire v75e = v74c == vb;
wire v75f = v75e;
wire v760 = v6ea & v75f;
wire v761 = v757 | v75a | v75d | v760;
wire [31:0] v3a = 32'b11111111000000001111111111111111;
wire [31:0] v752 = In_register_EAX & v3a;
wire [31:0] v753 = v73e << v31;
wire [31:0] v754 = v752 | v753;
wire [31:0] v764 = ( v8 ) ? In_register_EAX : 
	( v750 ) ? v73f : v754;
wire [31:0] v766 = v764;
wire v767 = v766 == Out_register_EAX;
wire v76a = v740 == ve;
wire v76b = v76a;
wire v76c = v6c7 & v76b;
wire v76d = v744 == ve;
wire v76e = v76d;
wire v76f = v6d6 & v76e;
wire v770 = v748 == ve;
wire v771 = v770;
wire v772 = v6e6 & v771;
wire v773 = v74c == ve;
wire v774 = v773;
wire v775 = v6ea & v774;
wire v776 = v76c | v76f | v772 | v775;
wire [31:0] v768 = In_register_EDX & v2d;
wire [31:0] v769 = v768 | v73e;
wire v77a = v740 == v11;
wire v77b = v77a;
wire v77c = v6c7 & v77b;
wire v77d = v744 == v11;
wire v77e = v77d;
wire v77f = v6d6 & v77e;
wire v780 = v748 == v11;
wire v781 = v780;
wire v782 = v6e6 & v781;
wire v783 = v74c == v11;
wire v784 = v783;
wire v785 = v6ea & v784;
wire v786 = v77c | v77f | v782 | v785;
wire [31:0] v778 = In_register_EDX & v3a;
wire [31:0] v779 = v778 | v753;
wire [31:0] v789 = ( v8 ) ? In_register_EDX : 
	( v776 ) ? v769 : v779;
wire [31:0] v78b = v789;
wire v78c = v78b == Out_register_EDX;
wire [31:0] v78e = In_register_ESI;
wire v78f = v78e == Out_register_ESI;
wire v792 = v740 == vf;
wire v793 = v792;
wire v794 = v6c7 & v793;
wire v795 = v744 == vf;
wire v796 = v795;
wire v797 = v6d6 & v796;
wire v798 = v748 == vf;
wire v799 = v798;
wire v79a = v6e6 & v799;
wire v79b = v74c == vf;
wire v79c = v79b;
wire v79d = v6ea & v79c;
wire v79e = v794 | v797 | v79a | v79d;
wire [31:0] v790 = In_register_ECX & v3a;
wire [31:0] v791 = v790 | v753;
wire v7a2 = v740 == vc;
wire v7a3 = v7a2;
wire v7a4 = v6c7 & v7a3;
wire v7a5 = v744 == vc;
wire v7a6 = v7a5;
wire v7a7 = v6d6 & v7a6;
wire v7a8 = v748 == vc;
wire v7a9 = v7a8;
wire v7aa = v6e6 & v7a9;
wire v7ab = v74c == vc;
wire v7ac = v7ab;
wire v7ad = v6ea & v7ac;
wire v7ae = v7a4 | v7a7 | v7aa | v7ad;
wire [31:0] v7a0 = In_register_ECX & v2d;
wire [31:0] v7a1 = v7a0 | v73e;
wire [31:0] v7b1 = ( v8 ) ? In_register_ECX : 
	( v79e ) ? v791 : v7a1;
wire [31:0] v7b3 = v7b1;
wire v7b4 = v7b3 == Out_register_ECX;
wire [7:0] v7b6 = In_register_DF;
wire v7b7 = v7b6 == Out_register_DF;
wire v7ba = v740 == vd;
wire v7bb = v7ba;
wire v7bc = v6c7 & v7bb;
wire v7bd = v744 == vd;
wire v7be = v7bd;
wire v7bf = v6d6 & v7be;
wire v7c0 = v748 == vd;
wire v7c1 = v7c0;
wire v7c2 = v6e6 & v7c1;
wire v7c3 = v74c == vd;
wire v7c4 = v7c3;
wire v7c5 = v6ea & v7c4;
wire v7c6 = v7bc | v7bf | v7c2 | v7c5;
wire [31:0] v7b8 = In_register_EBX & v2d;
wire [31:0] v7b9 = v7b8 | v73e;
wire v7ca = v740 == v9;
wire v7cb = v7ca;
wire v7cc = v6c7 & v7cb;
wire v7cd = v744 == v9;
wire v7ce = v7cd;
wire v7cf = v6d6 & v7ce;
wire v7d0 = v748 == v9;
wire v7d1 = v7d0;
wire v7d2 = v6e6 & v7d1;
wire v7d3 = v74c == v9;
wire v7d4 = v7d3;
wire v7d5 = v6ea & v7d4;
wire v7d6 = v7cc | v7cf | v7d2 | v7d5;
wire [31:0] v7c8 = In_register_EBX & v3a;
wire [31:0] v7c9 = v7c8 | v753;
wire [31:0] v7d9 = ( v8 ) ? In_register_EBX : 
	( v7c6 ) ? v7b9 : v7c9;
wire [31:0] v7db = v7d9;
wire v7dc = v7db == Out_register_EBX;
wire [31:0] v7de = In_register_SSBASE;
wire v7df = v7de == Out_register_SSBASE;
wire [31:0] v7e1 = In_register_ESP;
wire v7e2 = v7e1 == Out_register_ESP;
wire [31:0] v7e4 = In_register_EDI;
wire v7e5 = v7e4 == Out_register_EDI;
wire v7e6 = v729 == v2c;
wire v7e8 = v7e6;
wire v7e9 = v7e8 == Out_register_ZF;
wire [2:0] v7ed = { v13c };
wire [31:0] v7ee = ( v7ed == 3'd0) ? In_register_EAX : 
	( v7ed == 3'd1) ? In_register_ECX : 
	( v7ed == 3'd2) ? In_register_EDX : 
	( v7ed == 3'd3) ? In_register_EBX : 
	( v7ed == 3'd4) ? v15 : 
	( v7ed == 3'd5) ? v15 : 
	( v7ed == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v7ea = { v1fa };
wire [31:0] v7eb = ( v7ea == 3'd0) ? In_register_EAX : 
	( v7ea == 3'd1) ? In_register_ECX : 
	( v7ea == 3'd2) ? In_register_EDX : 
	( v7ea == 3'd3) ? In_register_EBX : 
	( v7ea == 3'd4) ? v15 : 
	( v7ea == 3'd5) ? v15 : 
	( v7ea == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v7f0 = { v13c };
wire [31:0] v7f1 = ( v7f0 == 3'd0) ? In_register_EAX : 
	( v7f0 == 3'd1) ? In_register_ECX : 
	( v7f0 == 3'd2) ? In_register_EDX : 
	( v7f0 == 3'd3) ? In_register_EBX : 
	( v7f0 == 3'd4) ? v15 : 
	( v7f0 == 3'd5) ? v15 : 
	( v7f0 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v7f2 = { v12c };
wire [31:0] v7f3 = ( v7f2 == 3'd0) ? In_register_EAX : 
	( v7f2 == 3'd1) ? In_register_ECX : 
	( v7f2 == 3'd2) ? In_register_EDX : 
	( v7f2 == 3'd3) ? In_register_EBX : 
	( v7f2 == 3'd4) ? v15 : 
	( v7f2 == 3'd5) ? In_register_EBP : 
	( v7f2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v7f4 = { 30'b000000000000000000000000000000, v119 };
wire [31:0] v7f5 = v7f3 << v7f4;
wire [31:0] v7f6 = v7f1 + v7f5;
wire [7:0] v7f7 = instruction_bits[31: 24];
wire [7:0] pad_2040 = (v7f7[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] v7f8 = { pad_2040, v7f7 };
wire [31:0] v7f9 = v7f6 + v7f8;
wire [31:0] v7fc = ( v6d6 ) ? v7ee : 
	( v6c7 ) ? v7eb : 
	( v6e6 ) ? v7f9 : v1f7;
wire v7fd =  v2a == memory_0[15: 12] && v7fc == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v7ff = In_register_DSBASE;
wire v800 = v7ff == Out_register_DSBASE;
wire [2:0] v801_aux = v729[0] + v729[1] + v729[2] + v729[3] + v729[4] + v729[5] + v729[6] + v729[7];
wire v801 = { 5'b00000, v801_aux };
wire [7:0] v802 = v801 & v18;
wire [7:0] v803 = v802 ^ v18;
wire v804 = v803[0:0];
wire v806 = v804;
wire v807 = v806 == Out_register_PF;
wire [31:0] v80c = ( v6e6 ) ? v27 : 
	( v6c7 ) ? v1c : 
	( v6ea ) ? v16 : v10;
wire [31:0] v80d = In_register_EIP + v80c;
wire [31:0] v80f = v80d;
wire v810 = v80f == Out_register_EIP;
wire [31:0] v812 = In_register_ESBASE;
wire v813 = v812 == Out_register_ESBASE;
wire [31:0] v815 = In_register_GSBASE;
wire v816 = v815 == Out_register_GSBASE;
wire [31:0] v818 = In_register_FSBASE;
wire v819 = v818 == Out_register_FSBASE;
wire v81a = v729 < v728;
wire v81b = v729 < v6ee;
wire v81c = v81a | v81b;
wire v81e = v81c;
wire v81f = v81e == Out_register_CF;
wire [31:0] v821 = In_register_EBP;
wire v822 = v821 == Out_register_EBP;
wire v823 = $signed(v729) < $signed(v2c);
wire v825 = v823;
wire v826 = v825 == Out_register_SF;
wire v827 = v6ec & v731 & v732 & v735 & v73d & v767 & v78c & v78f & v7b4 & v7b7 & v7dc & v7df & v7e2 & v7e5 & v7e9 & v7fd & v800 & v807 & v810 & v813 & v816 & v819 & v15c & v81f & v822 & v826;
wire [7:0] v3b = 8'b10011100;
wire v828 = v3b == v1eb;
wire v829 = instruction_bits[9: 9];
wire v82a = v8 == v829;
wire v82b = v35 == v316;
wire v82c = v1b == v318;
wire v82d = v828 & v82a & v82b & v82c;
wire v82e = v3b == v1eb;
wire v82f = v30 == v316;
wire v830 = v4 == v11b;
wire [2:0] v831 = { v1fa };
wire v832 = v831 == vb;
wire v833 = v831 == vf;
wire v834 = v832 | v833;
wire v835 = v834 ^ v8;
wire [2:0] v836 = { v1fa };
wire v837 = v836 == vb;
wire v838 = v837;
wire v839 = v838 ^ v8;
wire v83a = v835 & v839;
wire v83b = v82e & v82f & v830 & v83a;
wire v83c = v3b == v1eb;
wire v83d = v2f == v316;
wire v83e = v14 == v1ef;
wire [2:0] v83f = { v1fa };
wire v840 = v83f == vb;
wire v841 = v83f == vf;
wire v842 = v840 | v841;
wire v843 = v842 ^ v8;
wire [2:0] v844 = { v1fa };
wire v845 = v844 == vb;
wire v846 = v845;
wire v847 = v846 ^ v8;
wire v848 = v843 & v847;
wire v849 = v83c & v83d & v83e & v848;
wire v84a = v82d | v83b | v849;
wire v84b = v84a;
wire [31:0] v84d = In_register_ESI;
wire v84e = v84d == Out_register_ESI;
wire [31:0] v84f = memory_0[79: 48];
wire [2:0] v850 = { v320 };
wire [31:0] v851 = ( v850 == 3'd0) ? In_register_EAX : 
	( v850 == 3'd1) ? In_register_ECX : 
	( v850 == 3'd2) ? In_register_EDX : 
	( v850 == 3'd3) ? In_register_EBX : 
	( v850 == 3'd4) ? In_register_ESP : 
	( v850 == 3'd5) ? In_register_EBP : 
	( v850 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v853 = { v320 };
wire [31:0] v854 = ( v853 == 3'd0) ? In_register_EAX : 
	( v853 == 3'd1) ? In_register_ECX : 
	( v853 == 3'd2) ? In_register_EDX : 
	( v853 == 3'd3) ? In_register_EBX : 
	( v853 == 3'd4) ? In_register_ESP : 
	( v853 == 3'd5) ? In_register_EBP : 
	( v853 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v856 = { v320 };
wire [31:0] v857 = ( v856 == 3'd0) ? In_register_EAX : 
	( v856 == 3'd1) ? In_register_ECX : 
	( v856 == 3'd2) ? In_register_EDX : 
	( v856 == 3'd3) ? In_register_EBX : 
	( v856 == 3'd4) ? In_register_ESP : 
	( v856 == 3'd5) ? In_register_EBP : 
	( v856 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v859 = ( v82d ) ? v851 : 
	( v83b ) ? v854 : v857;
wire [31:0] v85a = v84f - v859;
wire v85b = $signed(v85a) < $signed(v15);
wire v85d = v85b;
wire v85e = v85d == Out_register_SF;
wire [31:0] v860 = In_register_EBP;
wire v861 = v860 == Out_register_EBP;
wire [31:0] v863 = In_register_FSBASE;
wire v864 = v863 == Out_register_FSBASE;
wire [31:0] v866 = In_register_EBX;
wire v867 = v866 == Out_register_EBX;
wire [31:0] v869 = In_register_ESBASE;
wire v86a = v869 == Out_register_ESBASE;
wire v86b = In_error_flag == Out_error_flag;
wire [31:0] v86d = In_register_EAX;
wire v86e = v86d == Out_register_EAX;
wire [7:0] v870 = In_register_DF;
wire v871 = v870 == Out_register_DF;
wire [31:0] v873 = In_register_EDI;
wire v874 = v873 == Out_register_EDI;
wire [31:0] v876 = In_register_ECX;
wire v877 = v876 == Out_register_ECX;
wire [31:0] v879 = In_register_EDX;
wire v87a = v879 == Out_register_EDX;
wire [31:0] v87c = In_register_ESP;
wire v87d = v87c == Out_register_ESP;
wire [31:0] v87f = In_register_CSBASE;
wire v880 = v87f == Out_register_CSBASE;
wire v881 = v84f == v859;
wire v883 = v881;
wire v884 = v883 == Out_register_ZF;
wire [31:0] v886 = In_register_DSBASE;
wire v887 = v886 == Out_register_DSBASE;
wire [2:0] v88d = { v1fa };
wire [31:0] v88e = ( v88d == 3'd0) ? In_register_EAX : 
	( v88d == 3'd1) ? In_register_ECX : 
	( v88d == 3'd2) ? In_register_EDX : 
	( v88d == 3'd3) ? In_register_EBX : 
	( v88d == 3'd4) ? v15 : 
	( v88d == 3'd5) ? v15 : 
	( v88d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v88f = v88e + v63a;
wire [2:0] v891 = { v1fa };
wire [31:0] v892 = ( v891 == 3'd0) ? In_register_EAX : 
	( v891 == 3'd1) ? In_register_ECX : 
	( v891 == 3'd2) ? In_register_EDX : 
	( v891 == 3'd3) ? In_register_EBX : 
	( v891 == 3'd4) ? v15 : 
	( v891 == 3'd5) ? v15 : 
	( v891 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v893 = v892 + v1f7;
wire v889 = instruction_bits[8: 8];
wire v888 = instruction_bits[10: 10];
wire [1:0] v88a = { v889 , v888 };
wire [31:0] v88b = ( v88a == 2'd0) ? In_register_EDX : 
	( v88a == 2'd1) ? In_register_ESI : 
	( v88a == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v895 = ( v83b ) ? v88f : 
	( v849 ) ? v893 : v88b;
wire v896 =  v26 == memory_0[15: 12] && v895 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v898 = In_register_SSBASE;
wire v899 = v898 == Out_register_SSBASE;
wire [31:0] v89a = v85a ^ v84f;
wire [31:0] v89b = v89a >> v1e;
wire [31:0] v89c = v84f ^ v859;
wire [31:0] v89d = v89c >> v1e;
wire [31:0] v89e = v89b + v89d;
wire v89f = v89e == v1c;
wire v8a1 = v89f;
wire v8a2 = v8a1 == Out_register_OF;
wire [31:0] v8a4 = In_register_GSBASE;
wire v8a5 = v8a4 == Out_register_GSBASE;
wire [31:0] v8a6 = v89c ^ v85a;
wire [7:0] v8a7 = v8a6[7:0];
wire [7:0] v8a8 = v8a7 >> v1d;
wire [7:0] v8a9 = v8a8 & v18;
wire v8aa = v8a9[0:0];
wire v8ac = v8aa;
wire v8ad = v8ac == Out_register_AF;
wire v8ae = v84f < v859;
wire v8b0 = v8ae;
wire v8b1 = v8b0 == Out_register_CF;
wire [31:0] v8b5 = ( v82d ) ? v1c : 
	( v849 ) ? v16 : v10;
wire [31:0] v8b6 = In_register_EIP + v8b5;
wire [31:0] v8b8 = v8b6;
wire v8b9 = v8b8 == Out_register_EIP;
wire [7:0] v8ba = v85a[7:0];
wire [2:0] v8bb_aux = v8ba[0] + v8ba[1] + v8ba[2] + v8ba[3] + v8ba[4] + v8ba[5] + v8ba[6] + v8ba[7];
wire v8bb = { 5'b00000, v8bb_aux };
wire [7:0] v8bc = v8bb & v18;
wire [7:0] v8bd = v8bc ^ v18;
wire v8be = v8bd[0:0];
wire v8c0 = v8be;
wire v8c1 = v8c0 == Out_register_PF;
wire v8c2 = v84e & v85e & v861 & v864 & v867 & v86a & v84b & v86b & v86e & v871 & v874 & v877 & v87a & v87d & v880 & v884 & v15c & v887 & v896 & v899 & v8a2 & v8a5 & v8ad & v8b1 & v8b9 & v8c1;
wire [7:0] v3c = 8'b10110101;
wire v8c3 = v3c == v1eb;
wire v8c4 = v29 == v59f;
wire v8c5 = v8c3 & v8c4;
wire v8c6 = v8c5;
wire v8c7 = v8c6;
wire v8c8 = In_error_flag == Out_error_flag;
wire [31:0] v8ca = In_register_FSBASE;
wire v8cb = v8ca == Out_register_FSBASE;
wire [31:0] v3d = 32'b00111111111111111111111111111111;
wire [31:0] v8cc = ( v5bf == 1'd0) ? v3d : v27;
wire [31:0] v8cd = v8cc + In_register_ESI;
wire [31:0] v8cf = v8cd;
wire v8d0 = v8cf == Out_register_ESI;
wire v8d1 =  v26 == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v8d3 = In_register_ECX;
wire v8d4 = v8d3 == Out_register_ECX;
wire [31:0] v8d6 = In_register_EDI;
wire v8d7 = v8d6 == Out_register_EDI;
wire [31:0] v8d8 = memory_0[79: 48];
wire [31:0] v8da = v8d8;
wire v8db = v8da == Out_register_EAX;
wire [31:0] v8dd = In_register_EBX;
wire v8de = v8dd == Out_register_EBX;
wire v8e0 = In_register_OF;
wire v8e1 = v8e0 == Out_register_OF;
wire [31:0] v8e3 = In_register_EBP;
wire v8e4 = v8e3 == Out_register_EBP;
wire [31:0] v8e6 = In_register_EDX;
wire v8e7 = v8e6 == Out_register_EDX;
wire v8e9 = In_register_PF;
wire v8ea = v8e9 == Out_register_PF;
wire [7:0] v8ec = In_register_DF;
wire v8ed = v8ec == Out_register_DF;
wire [31:0] v8ef = In_register_ESP;
wire v8f0 = v8ef == Out_register_ESP;
wire [31:0] v8f2 = v2b;
wire [31:0] v8f3 = In_register_EIP + v8f2;
wire [31:0] v8f5 = v8f3;
wire v8f6 = v8f5 == Out_register_EIP;
wire [31:0] v8f8 = In_register_CSBASE;
wire v8f9 = v8f8 == Out_register_CSBASE;
wire v8fb = In_register_AF;
wire v8fc = v8fb == Out_register_AF;
wire [31:0] v8fe = In_register_SSBASE;
wire v8ff = v8fe == Out_register_SSBASE;
wire [31:0] v901 = In_register_DSBASE;
wire v902 = v901 == Out_register_DSBASE;
wire [31:0] v904 = In_register_GSBASE;
wire v905 = v904 == Out_register_GSBASE;
wire [31:0] v907 = In_register_ESBASE;
wire v908 = v907 == Out_register_ESBASE;
wire v90a = In_register_CF;
wire v90b = v90a == Out_register_CF;
wire v90d = In_register_SF;
wire v90e = v90d == Out_register_SF;
wire v910 = In_register_ZF;
wire v911 = v910 == Out_register_ZF;
wire v912 = v8c7 & v15c & v8c8 & v8cb & v8d0 & v8d1 & v8d4 & v8d7 & v8db & v8de & v8e1 & v8e4 & v8e7 & v8ea & v8ed & v8f0 & v8f6 & v8f9 & v8fc & v8ff & v902 & v905 & v908 & v90b & v90e & v911;
wire [7:0] v3e = 8'b00000001;
wire v915 = v3e == v1eb;
wire v916 = v25 == v1ed;
wire v917 = v4 == v11b;
wire [2:0] v918 = { v1fa };
wire v919 = v918 == vb;
wire v91a = v918 == vf;
wire v91b = v919 | v91a;
wire v91c = v91b ^ v8;
wire [2:0] v91d = { v1fa };
wire v91e = v91d == vb;
wire v91f = v91d == vf;
wire v920 = v91e | v91f;
wire v921 = v920 ^ v8;
wire [2:0] v922 = { v1fa };
wire v923 = v922 == vb;
wire v924 = v922 == vf;
wire v925 = v923 | v924;
wire v926 = v925 ^ v8;
wire [2:0] v927 = { v1fa };
wire v928 = v927 == vb;
wire v929 = v927 == vf;
wire v92a = v928 | v929;
wire v92b = v92a ^ v8;
wire v92c = v91c & v921 & v926 & v92b;
wire v92d = v915 & v916 & v917 & v92c;
wire [2:0] v913 = { v1fa };
wire [31:0] v914 = ( v913 == 3'd0) ? In_register_EAX : 
	( v913 == 3'd1) ? In_register_ECX : 
	( v913 == 3'd2) ? In_register_EDX : 
	( v913 == 3'd3) ? In_register_EBX : 
	( v913 == 3'd4) ? v15 : 
	( v913 == 3'd5) ? v15 : 
	( v913 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v92f = v914;
wire [31:0] v930 = memory_0[79: 48];
wire [7:0] v931 = v930[7:0];
wire [31:0] v933 = v63a;
wire [7:0] v934 = v933[7:0];
wire [7:0] v935 = v931 + v934;
wire v936 =  v2a == memory_1[15: 12] && v92f == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v935 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v937 = v92d;
wire v938 = v937;
wire [31:0] v93a = In_register_EDI;
wire v93b = v93a == Out_register_EDI;
wire [31:0] v93d = In_register_CSBASE;
wire v93e = v93d == Out_register_CSBASE;
wire [31:0] v940 = In_register_EAX;
wire v941 = v940 == Out_register_EAX;
wire v942 = In_error_flag == Out_error_flag;
wire [2:0] v943 = { v1fa };
wire [31:0] v944 = ( v943 == 3'd0) ? In_register_EAX : 
	( v943 == 3'd1) ? In_register_ECX : 
	( v943 == 3'd2) ? In_register_EDX : 
	( v943 == 3'd3) ? In_register_EBX : 
	( v943 == 3'd4) ? v15 : 
	( v943 == 3'd5) ? v15 : 
	( v943 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v946 = v944;
wire v947 =  v2a == memory_0[15: 12] && v946 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] v949 = In_register_DF;
wire v94a = v949 == Out_register_DF;
wire [31:0] v94c = In_register_EBP;
wire v94d = v94c == Out_register_EBP;
wire [31:0] v94f = In_register_EDX;
wire v950 = v94f == Out_register_EDX;
wire [31:0] v952 = In_register_EBX;
wire v953 = v952 == Out_register_EBX;
wire [31:0] v955 = v10;
wire [31:0] v956 = In_register_EIP + v955;
wire [31:0] v958 = v956;
wire v959 = v958 == Out_register_EIP;
wire [31:0] v95b = In_register_GSBASE;
wire v95c = v95b == Out_register_GSBASE;
wire [31:0] v95e = In_register_SSBASE;
wire v95f = v95e == Out_register_SSBASE;
wire [31:0] v961 = In_register_ESI;
wire v962 = v961 == Out_register_ESI;
wire [31:0] v964 = In_register_ESBASE;
wire v965 = v964 == Out_register_ESBASE;
wire [31:0] v967 = In_register_ECX;
wire v968 = v967 == Out_register_ECX;
wire [31:0] v96a = In_register_DSBASE;
wire v96b = v96a == Out_register_DSBASE;
wire [31:0] v96d = In_register_FSBASE;
wire v96e = v96d == Out_register_FSBASE;
wire [7:0] v96f = v935 ^ v934;
wire [7:0] v970 = v96f ^ v931;
wire [7:0] v971 = v970 >> v1d;
wire [7:0] v972 = v971 & v18;
wire v973 = v972[0:0];
wire v975 = v973;
wire v976 = v975 == Out_register_AF;
wire [31:0] v978 = In_register_ESP;
wire v979 = v978 == Out_register_ESP;
wire [7:0] v97a = v935 ^ v931;
wire [7:0] v97b = v97a >> v33;
wire [7:0] v97c = v96f >> v33;
wire [7:0] v97d = v97b + v97c;
wire v97e = v97d == v34;
wire v980 = v97e;
wire v981 = v980 == Out_register_OF;
wire v982 = v935 < v931;
wire v983 = v935 < v934;
wire v984 = v982 | v983;
wire v986 = v984;
wire v987 = v986 == Out_register_CF;
wire [2:0] v988_aux = v935[0] + v935[1] + v935[2] + v935[3] + v935[4] + v935[5] + v935[6] + v935[7];
wire v988 = { 5'b00000, v988_aux };
wire [7:0] v989 = v988 & v18;
wire [7:0] v98a = v989 ^ v18;
wire v98b = v98a[0:0];
wire v98d = v98b;
wire v98e = v98d == Out_register_PF;
wire v98f = $signed(v935) < $signed(v2c);
wire v991 = v98f;
wire v992 = v991 == Out_register_SF;
wire v993 = v935 == v2c;
wire v995 = v993;
wire v996 = v995 == Out_register_ZF;
wire v997 = v15c & v936 & v93b & v93e & v941 & v942 & v947 & v94a & v94d & v938 & v950 & v953 & v959 & v95c & v95f & v962 & v965 & v968 & v96b & v96e & v976 & v979 & v981 & v987 & v98e & v992 & v996;
wire [7:0] v3f = 8'b01001000;
wire v9ad = v3f == v1eb;
wire v9ae = v2f == v316;
wire v9af = v14 == v1ef;
wire [2:0] v9b0 = { v1fa };
wire v9b1 = v9b0 == vb;
wire v9b2 = v9b0 == vf;
wire v9b3 = v9b1 | v9b2;
wire v9b4 = v9b3 ^ v8;
wire [2:0] v9b5 = { v1fa };
wire v9b6 = v9b5 == vb;
wire v9b7 = v9b6;
wire v9b8 = v9b7 ^ v8;
wire v9b9 = v9b4 & v9b8;
wire v9ba = v9ad & v9ae & v9af & v9b9;
wire [2:0] v9aa = { v1fa };
wire [31:0] v9ab = ( v9aa == 3'd0) ? In_register_EAX : 
	( v9aa == 3'd1) ? In_register_ECX : 
	( v9aa == 3'd2) ? In_register_EDX : 
	( v9aa == 3'd3) ? In_register_EBX : 
	( v9aa == 3'd4) ? v15 : 
	( v9aa == 3'd5) ? v15 : 
	( v9aa == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v9ac = v9ab + v1f7;
wire v99a = v3f == v1eb;
wire v99b = v35 == v316;
wire v99c = v1b == v318;
wire [2:0] v99d = { v1fa };
wire v99e = v99d == vb;
wire v99f = v99d == vf;
wire v9a0 = v99e | v99f;
wire v9a1 = v9a0 ^ v8;
wire [2:0] v9a2 = { v1fa };
wire v9a3 = v9a2 == vb;
wire v9a4 = v9a2 == vf;
wire v9a5 = v9a3 | v9a4;
wire v9a6 = v9a5 ^ v8;
wire v9a7 = v9a1 & v9a6;
wire v9a8 = v99a & v99b & v99c & v9a7;
wire [2:0] v998 = { v1fa };
wire [31:0] v999 = ( v998 == 3'd0) ? In_register_EAX : 
	( v998 == 3'd1) ? In_register_ECX : 
	( v998 == 3'd2) ? In_register_EDX : 
	( v998 == 3'd3) ? In_register_EBX : 
	( v998 == 3'd4) ? v15 : 
	( v998 == 3'd5) ? v15 : 
	( v998 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v9bc = ( v9ba ) ? v9ac : v999;
wire v9bd =  v2a == memory_0[15: 12] && v9bc == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v9be = v9a8 | v9ba;
wire v9bf = v9be;
wire [31:0] v9c1 = In_register_SSBASE;
wire v9c2 = v9c1 == Out_register_SSBASE;
wire [31:0] v9c4 = In_register_GSBASE;
wire v9c5 = v9c4 == Out_register_GSBASE;
wire [31:0] v9c7 = In_register_FSBASE;
wire v9c8 = v9c7 == Out_register_FSBASE;
wire [31:0] v9cb = ( v9a8 ) ? v1c : v16;
wire [31:0] v9cc = In_register_EIP + v9cb;
wire [31:0] v9ce = v9cc;
wire v9cf = v9ce == Out_register_EIP;
wire [31:0] v9d1 = In_register_ESI;
wire v9d2 = v9d1 == Out_register_ESI;
wire [2:0] v9f8 = { v320 };
wire v9f9 = v9f8 == vf;
wire v9fa = v9f9;
wire v9fb = v9a8 & v9fa;
wire [2:0] v9fc = { v320 };
wire v9fd = v9fc == vf;
wire v9fe = v9fd;
wire v9ff = v9ba & v9fe;
wire va00 = v9fb | v9ff;
wire [31:0] v9d3 = memory_0[79: 48];
wire [7:0] v9d4 = v9d3[7:0];
wire [2:0] v9d5 = { v320 };
wire [31:0] v9d6 = ( v9d5 == 3'd0) ? In_register_EAX : 
	( v9d5 == 3'd1) ? In_register_ECX : 
	( v9d5 == 3'd2) ? In_register_EDX : 
	( v9d5 == 3'd3) ? In_register_EBX : 
	( v9d5 == 3'd4) ? In_register_EAX : 
	( v9d5 == 3'd5) ? In_register_ECX : 
	( v9d5 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v9d7 = { v320 };
wire v9d8 = v9d7 == vb;
wire v9d9 = v9d7 == v9;
wire v9da = v9d8 | v9d9;
wire v9db = v9d7 == vf;
wire v9dc = v9da | v9db;
wire v9dd = v9d7 == v11;
wire v9de = v9dc | v9dd;
wire [31:0] v9df = ( v9de == 1'd0) ? v15 : v31;
wire [31:0] v9e0 = v9d6 >> v9df;
wire [31:0] v9e1 = v9e0 & v32;
wire [2:0] v9e3 = { v320 };
wire [31:0] v9e4 = ( v9e3 == 3'd0) ? In_register_EAX : 
	( v9e3 == 3'd1) ? In_register_ECX : 
	( v9e3 == 3'd2) ? In_register_EDX : 
	( v9e3 == 3'd3) ? In_register_EBX : 
	( v9e3 == 3'd4) ? In_register_EAX : 
	( v9e3 == 3'd5) ? In_register_ECX : 
	( v9e3 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v9e5 = { v320 };
wire v9e6 = v9e5 == vb;
wire v9e7 = v9e5 == v9;
wire v9e8 = v9e6 | v9e7;
wire v9e9 = v9e5 == vf;
wire v9ea = v9e8 | v9e9;
wire v9eb = v9e5 == v11;
wire v9ec = v9ea | v9eb;
wire [31:0] v9ed = ( v9ec == 1'd0) ? v15 : v31;
wire [31:0] v9ee = v9e4 >> v9ed;
wire [31:0] v9ef = v9ee & v32;
wire [31:0] v9f1 = ( v9a8 ) ? v9e1 : v9ef;
wire [7:0] v9f2 = v9f1[7:0];
wire [7:0] v9f3 = v9d4 + v9f2;
wire [7:0] v9f4 = v65f + v9f3;
wire [31:0] v9f5 = { 24'b000000000000000000000000, v9f4 };
wire [31:0] v9f6 = v9f5 << v31;
wire [31:0] v9f7 = v790 | v9f6;
wire va03 = v9f8 == vc;
wire va04 = va03;
wire va05 = v9a8 & va04;
wire va06 = v9fc == vc;
wire va07 = va06;
wire va08 = v9ba & va07;
wire va09 = va05 | va08;
wire [31:0] va02 = v7a0 | v9f5;
wire [31:0] va0c = ( v8 ) ? In_register_ECX : 
	( va00 ) ? v9f7 : va02;
wire [31:0] va0e = va0c;
wire va0f = va0e == Out_register_ECX;
wire va11 = v9f8 == ve;
wire va12 = va11;
wire va13 = v9a8 & va12;
wire va14 = v9fc == ve;
wire va15 = va14;
wire va16 = v9ba & va15;
wire va17 = va13 | va16;
wire [31:0] va10 = v768 | v9f5;
wire va1a = v9f8 == v11;
wire va1b = va1a;
wire va1c = v9a8 & va1b;
wire va1d = v9fc == v11;
wire va1e = va1d;
wire va1f = v9ba & va1e;
wire va20 = va1c | va1f;
wire [31:0] va19 = v778 | v9f6;
wire [31:0] va23 = ( v8 ) ? In_register_EDX : 
	( va17 ) ? va10 : va19;
wire [31:0] va25 = va23;
wire va26 = va25 == Out_register_EDX;
wire va27 = $signed(v9f4) < $signed(v2c);
wire va29 = va27;
wire va2a = va29 == Out_register_SF;
wire va2c = v9f8 == vd;
wire va2d = va2c;
wire va2e = v9a8 & va2d;
wire va2f = v9fc == vd;
wire va30 = va2f;
wire va31 = v9ba & va30;
wire va32 = va2e | va31;
wire [31:0] va2b = v7b8 | v9f5;
wire va35 = v9f8 == v9;
wire va36 = va35;
wire va37 = v9a8 & va36;
wire va38 = v9fc == v9;
wire va39 = va38;
wire va3a = v9ba & va39;
wire va3b = va37 | va3a;
wire [31:0] va34 = v7c8 | v9f6;
wire [31:0] va3e = ( v8 ) ? In_register_EBX : 
	( va32 ) ? va2b : va34;
wire [31:0] va40 = va3e;
wire va41 = va40 == Out_register_EBX;
wire [31:0] va43 = In_register_ESP;
wire va44 = va43 == Out_register_ESP;
wire va45 = In_error_flag == Out_error_flag;
wire [7:0] va46 = v9f4 ^ v9d4;
wire [7:0] va47 = va46 ^ v9f2;
wire [7:0] va48 = va47 >> v1d;
wire [7:0] va49 = va48 & v18;
wire va4a = va49[0:0];
wire va4c = va4a;
wire va4d = va4c == Out_register_AF;
wire [31:0] va4f = In_register_EDI;
wire va50 = va4f == Out_register_EDI;
wire [31:0] va52 = In_register_ESBASE;
wire va53 = va52 == Out_register_ESBASE;
wire [31:0] va55 = In_register_EBP;
wire va56 = va55 == Out_register_EBP;
wire [31:0] va58 = In_register_CSBASE;
wire va59 = va58 == Out_register_CSBASE;
wire [2:0] va5a_aux = v9f4[0] + v9f4[1] + v9f4[2] + v9f4[3] + v9f4[4] + v9f4[5] + v9f4[6] + v9f4[7];
wire va5a = { 5'b00000, va5a_aux };
wire [7:0] va5b = va5a & v18;
wire [7:0] va5c = va5b ^ v18;
wire va5d = va5c[0:0];
wire va5f = va5d;
wire va60 = va5f == Out_register_PF;
wire [31:0] va62 = In_register_DSBASE;
wire va63 = va62 == Out_register_DSBASE;
wire [7:0] va64 = v9f4 ^ v9f2;
wire [7:0] va65 = va64 >> v33;
wire [7:0] va66 = va46 >> v33;
wire [7:0] va67 = va65 + va66;
wire va68 = va67 == v34;
wire va6a = va68;
wire va6b = va6a == Out_register_OF;
wire va6c = v9f3 < v9f2;
wire va6d = v9f3 < v9d4;
wire va6e = va6c | va6d;
wire va6f = va6e ^ v8;
wire va70 = v9f4 < v9f3;
wire va71 = v9f4 < v65f;
wire va72 = va70 | va71;
wire [7:0] va73 = { 7'b0000000, va72 };
wire [7:0] va74 = ( va6f == 1'd0) ? v18 : va73;
wire va75 = va74[0:0];
wire va77 = va75;
wire va78 = va77 == Out_register_CF;
wire [7:0] va7a = In_register_DF;
wire va7b = va7a == Out_register_DF;
wire va7d = v9f8 == v7;
wire va7e = va7d;
wire va7f = v9a8 & va7e;
wire va80 = v9fc == v7;
wire va81 = va80;
wire va82 = v9ba & va81;
wire va83 = va7f | va82;
wire [31:0] va7c = v5c8 | v9f5;
wire va86 = v9f8 == vb;
wire va87 = va86;
wire va88 = v9a8 & va87;
wire va89 = v9fc == vb;
wire va8a = va89;
wire va8b = v9ba & va8a;
wire va8c = va88 | va8b;
wire [31:0] va85 = v752 | v9f6;
wire [31:0] va8f = ( v8 ) ? In_register_EAX : 
	( va83 ) ? va7c : va85;
wire [31:0] va91 = va8f;
wire va92 = va91 == Out_register_EAX;
wire va93 = v9f4 == v2c;
wire va95 = va93;
wire va96 = va95 == Out_register_ZF;
wire va97 = v9bd & v9c2 & v9c5 & v9c8 & v15c & v9cf & v9d2 & va0f & va26 & va2a & va41 & va44 & va45 & va4d & va50 & va53 & v9bf & va56 & va59 & va60 & va63 & va6b & va78 & va7b & va92 & va96;
wire [7:0] v40 = 8'b11000001;
wire va98 = v40 == v1eb;
wire [4:0] v41 = 5'b01000;
wire va99 = v41 == v1ed;
wire va9a = v4 == v11b;
wire [2:0] va9b = { v1fa };
wire va9c = va9b == vb;
wire va9d = va9b == vf;
wire va9e = va9c | va9d;
wire va9f = va9e ^ v8;
wire [2:0] vaa0 = { v1fa };
wire vaa1 = vaa0 == vb;
wire vaa2 = vaa0 == vf;
wire vaa3 = vaa1 | vaa2;
wire vaa4 = vaa3 ^ v8;
wire [2:0] vaa5 = { v1fa };
wire vaa6 = vaa5 == vb;
wire vaa7 = vaa5 == vf;
wire vaa8 = vaa6 | vaa7;
wire vaa9 = vaa8 ^ v8;
wire [2:0] vaaa = { v1fa };
wire vaab = vaaa == vb;
wire vaac = vaaa == vf;
wire vaad = vaab | vaac;
wire vaae = vaad ^ v8;
wire vaaf = va9f & vaa4 & vaa9 & vaae;
wire vab0 = va98 & va99 & va9a & vaaf;
wire vab1 = v40 == v1eb;
wire [4:0] v42 = 5'b01001;
wire vab2 = v42 == v1ed;
wire [63:0] v43 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
wire [63:0] vab3 = instruction_bits[119: 56];
wire vab4 = v43 == vab3;
wire [2:0] vab5 = { v1fa };
wire vab6 = vab5 == vb;
wire vab7 = vab6;
wire vab8 = vab7 ^ v8;
wire [2:0] vab9 = { v1fa };
wire vaba = vab9 == vb;
wire vabb = vaba;
wire vabc = vabb ^ v8;
wire [2:0] vabd = { v1fa };
wire vabe = vabd == vb;
wire vabf = vabe;
wire vac0 = vabf ^ v8;
wire [2:0] vac1 = { v1fa };
wire vac2 = vac1 == vb;
wire vac3 = vac2;
wire vac4 = vac3 ^ v8;
wire vac5 = vab8 & vabc & vac0 & vac4;
wire vac6 = vab1 & vab2 & vab4 & vac5;
wire vac7 = v40 == v1eb;
wire [4:0] v44 = 5'b01010;
wire vac8 = v44 == v1ed;
wire vac9 = v38 == v6da;
wire [2:0] vaca = { v1fa };
wire vacb = vaca == vb;
wire vacc = vaca == vf;
wire vacd = vacb | vacc;
wire vace = vacd ^ v8;
wire [2:0] vacf = { v1fa };
wire vad0 = vacf == vb;
wire vad1 = vad0;
wire vad2 = vad1 ^ v8;
wire [2:0] vad3 = { v1fa };
wire vad4 = vad3 == vb;
wire vad5 = vad3 == vf;
wire vad6 = vad4 | vad5;
wire vad7 = vad6 ^ v8;
wire [2:0] vad8 = { v1fa };
wire vad9 = vad8 == vb;
wire vada = vad9;
wire vadb = vada ^ v8;
wire vadc = vace & vad2 & vad7 & vadb;
wire vadd = vac7 & vac8 & vac9 & vadc;
wire vade = vab0 | vac6 | vadd;
wire vadf = vade;
wire [31:0] vae1 = In_register_DSBASE;
wire vae2 = vae1 == Out_register_DSBASE;
wire [31:0] vae4 = In_register_ESI;
wire vae5 = vae4 == Out_register_ESI;
wire [31:0] vae7 = In_register_CSBASE;
wire vae8 = vae7 == Out_register_CSBASE;
wire [31:0] vaea = In_register_EAX;
wire vaeb = vaea == Out_register_EAX;
wire [31:0] vaed = In_register_EBX;
wire vaee = vaed == Out_register_EBX;
wire [31:0] vaf0 = In_register_EDI;
wire vaf1 = vaf0 == Out_register_EDI;
wire vaf2 = In_error_flag == Out_error_flag;
wire [31:0] vaf4 = In_register_ECX;
wire vaf5 = vaf4 == Out_register_ECX;
wire [2:0] vaf9 = { v1fa };
wire [31:0] vafa = ( vaf9 == 3'd0) ? In_register_EAX : 
	( vaf9 == 3'd1) ? In_register_ECX : 
	( vaf9 == 3'd2) ? In_register_EDX : 
	( vaf9 == 3'd3) ? In_register_EBX : 
	( vaf9 == 3'd4) ? v15 : 
	( vaf9 == 3'd5) ? In_register_EBP : 
	( vaf9 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vafb = vafa + v1f7;
wire [2:0] vafd = { v1fa };
wire [31:0] vafe = ( vafd == 3'd0) ? In_register_EAX : 
	( vafd == 3'd1) ? In_register_ECX : 
	( vafd == 3'd2) ? In_register_EDX : 
	( vafd == 3'd3) ? In_register_EBX : 
	( vafd == 3'd4) ? v15 : 
	( vafd == 3'd5) ? v15 : 
	( vafd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vaff = vafe + v63a;
wire [2:0] vaf6 = { v1fa };
wire [31:0] vaf7 = ( vaf6 == 3'd0) ? In_register_EAX : 
	( vaf6 == 3'd1) ? In_register_ECX : 
	( vaf6 == 3'd2) ? In_register_EDX : 
	( vaf6 == 3'd3) ? In_register_EBX : 
	( vaf6 == 3'd4) ? v15 : 
	( vaf6 == 3'd5) ? v15 : 
	( vaf6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vb01 = ( vac6 ) ? vafb : 
	( vadd ) ? vaff : vaf7;
wire vb02 =  v26 == memory_0[15: 12] && vb01 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] vb04 = In_register_EDX;
wire vb05 = vb04 == Out_register_EDX;
wire [31:0] vb07 = In_register_ESP;
wire vb08 = vb07 == Out_register_ESP;
wire [31:0] vb09 = memory_0[79: 48];
wire [7:0] vb0b = instruction_bits[55: 48];
wire [7:0] pad_2828 = (vb0b[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] vb0c = { pad_2828, vb0b };
wire [31:0] vb0f = ( vadd ) ? v7f8 : 
	( vac6 ) ? vb0c : v63a;
wire [31:0] vb10 = vb09 + vb0f;
wire [31:0] vb11 = { 24'b000000000000000000000000, v65f };
wire [31:0] vb12 = vb10 + vb11;
wire [7:0] vb13 = vb12[7:0];
wire [2:0] vb14_aux = vb13[0] + vb13[1] + vb13[2] + vb13[3] + vb13[4] + vb13[5] + vb13[6] + vb13[7];
wire vb14 = { 5'b00000, vb14_aux };
wire [7:0] vb15 = vb14 & v18;
wire [7:0] vb16 = vb15 ^ v18;
wire vb17 = vb16[0:0];
wire vb19 = vb17;
wire vb1a = vb19 == Out_register_PF;
wire [2:0] vb1e = { v1fa };
wire [31:0] vb1f = ( vb1e == 3'd0) ? In_register_EAX : 
	( vb1e == 3'd1) ? In_register_ECX : 
	( vb1e == 3'd2) ? In_register_EDX : 
	( vb1e == 3'd3) ? In_register_EBX : 
	( vb1e == 3'd4) ? v15 : 
	( vb1e == 3'd5) ? In_register_EBP : 
	( vb1e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vb20 = vb1f + v1f7;
wire [2:0] vb22 = { v1fa };
wire [31:0] vb23 = ( vb22 == 3'd0) ? In_register_EAX : 
	( vb22 == 3'd1) ? In_register_ECX : 
	( vb22 == 3'd2) ? In_register_EDX : 
	( vb22 == 3'd3) ? In_register_EBX : 
	( vb22 == 3'd4) ? v15 : 
	( vb22 == 3'd5) ? v15 : 
	( vb22 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vb24 = vb23 + v63a;
wire [2:0] vb1b = { v1fa };
wire [31:0] vb1c = ( vb1b == 3'd0) ? In_register_EAX : 
	( vb1b == 3'd1) ? In_register_ECX : 
	( vb1b == 3'd2) ? In_register_EDX : 
	( vb1b == 3'd3) ? In_register_EBX : 
	( vb1b == 3'd4) ? v15 : 
	( vb1b == 3'd5) ? v15 : 
	( vb1b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vb26 = ( vac6 ) ? vb20 : 
	( vadd ) ? vb24 : vb1c;
wire vb27 =  v26 == memory_1[15: 12] && vb26 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && vb12 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] vb29 = In_register_SSBASE;
wire vb2a = vb29 == Out_register_SSBASE;
wire vb2b = vb12 == v15;
wire vb2d = vb2b;
wire vb2e = vb2d == Out_register_ZF;
wire [31:0] vb30 = In_register_EBP;
wire vb31 = vb30 == Out_register_EBP;
wire [31:0] v45 = 32'b11100000000000000000000000000000;
wire [31:0] vb35 = ( vac6 ) ? v45 : 
	( vadd ) ? v27 : v10;
wire [31:0] vb36 = In_register_EIP + vb35;
wire [31:0] vb38 = vb36;
wire vb39 = vb38 == Out_register_EIP;
wire [31:0] vb3b = In_register_ESBASE;
wire vb3c = vb3b == Out_register_ESBASE;
wire [31:0] vb3e = In_register_GSBASE;
wire vb3f = vb3e == Out_register_GSBASE;
wire [31:0] vb41 = In_register_FSBASE;
wire vb42 = vb41 == Out_register_FSBASE;
wire [31:0] vb43 = vb12 ^ vb09;
wire [31:0] vb44 = vb43 >> v1e;
wire [31:0] vb45 = vb12 ^ vb0f;
wire [31:0] vb46 = vb45 >> v1e;
wire [31:0] vb47 = vb44 + vb46;
wire vb48 = vb47 == v1c;
wire vb4a = vb48;
wire vb4b = vb4a == Out_register_OF;
wire [31:0] vb4c = vb45 ^ vb09;
wire [7:0] vb4d = vb4c[7:0];
wire [7:0] vb4e = vb4d >> v1d;
wire [7:0] vb4f = vb4e & v18;
wire vb50 = vb4f[0:0];
wire vb52 = vb50;
wire vb53 = vb52 == Out_register_AF;
wire vb54 = vb10 < vb09;
wire vb55 = vb10 < vb0f;
wire vb56 = vb54 | vb55;
wire vb57 = vb12 < vb10;
wire vb58 = vb12 < vb11;
wire vb59 = vb57 | vb58;
wire [7:0] vb5a = { 7'b0000000, vb59 };
wire [7:0] vb5b = ( vb56 == 1'd0) ? vb5a : v18;
wire vb5c = vb5b[0:0];
wire vb5e = vb5c;
wire vb5f = vb5e == Out_register_CF;
wire [7:0] vb61 = In_register_DF;
wire vb62 = vb61 == Out_register_DF;
wire vb63 = $signed(vb12) < $signed(v15);
wire vb65 = vb63;
wire vb66 = vb65 == Out_register_SF;
wire vb67 = vae2 & vae5 & v15c & vae8 & vaeb & vaee & vaf1 & vaf2 & vaf5 & vb02 & vb05 & vb08 & vb1a & vb27 & vb2a & vb2e & vb31 & vadf & vb39 & vb3c & vb3f & vb42 & vb4b & vb53 & vb5f & vb62 & vb66;
wire [7:0] v46 = 8'b10110000;
wire vb68 = v46 == v1eb;
wire [79:0] v47 = 80'b00000000000000000000000000000000000000000000000000000000000000000000000000000000;
wire [79:0] vb69 = instruction_bits[119: 40];
wire vb6a = v47 == vb69;
wire vb6b = vb68 & vb6a;
wire vb6c = vb6b;
wire vb6d = vb6c;
wire [31:0] vb6f = In_register_EBX;
wire vb70 = vb6f == Out_register_EBX;
wire [31:0] vb72 = In_register_EDI;
wire vb73 = vb72 == Out_register_EDI;
wire [31:0] vb74 = instruction_bits[39: 8];
wire [31:0] vb76 = vb74;
wire [31:0] vb78 = In_register_EAX;
wire [31:0] vb79 = vb76 | vb78;
wire [31:0] vb7c = ( v8 ) ? In_register_EAX : vb79;
wire [31:0] vb7e = vb7c;
wire vb7f = vb7e == Out_register_EAX;
wire vb81 = v17;
wire vb82 = vb81 == Out_register_CF;
wire [31:0] vb84 = In_register_EBP;
wire vb85 = vb84 == Out_register_EBP;
wire [31:0] vb87 = In_register_ECX;
wire vb88 = vb87 == Out_register_ECX;
wire vb89 = In_error_flag == Out_error_flag;
wire [31:0] vb8b = In_register_ESI;
wire vb8c = vb8b == Out_register_ESI;
wire [31:0] vb8e = In_register_EDX;
wire vb8f = vb8e == Out_register_EDX;
wire [31:0] vb91 = In_register_ESBASE;
wire vb92 = vb91 == Out_register_ESBASE;
wire [31:0] vb94 = In_register_CSBASE;
wire vb95 = vb94 == Out_register_CSBASE;
wire [31:0] vb97 = In_register_SSBASE;
wire vb98 = vb97 == Out_register_SSBASE;
wire [31:0] vb9a = In_register_DSBASE;
wire vb9b = vb9a == Out_register_DSBASE;
wire [31:0] vb9d = In_register_GSBASE;
wire vb9e = vb9d == Out_register_GSBASE;
wire vb9f = v17;
wire vba0 = vb9f == Out_register_OF;
wire vba1 = $signed(vb79) < $signed(v15);
wire vba3 = vba1;
wire vba4 = vba3 == Out_register_SF;
wire [31:0] vba6 = In_register_FSBASE;
wire vba7 = vba6 == Out_register_FSBASE;
wire [31:0] vba9 = In_register_ESP;
wire vbaa = vba9 == Out_register_ESP;
wire vbac = In_register_AF;
wire vbad = vbac == Out_register_AF;
wire [7:0] vbaf = In_register_DF;
wire vbb0 = vbaf == Out_register_DF;
wire [31:0] v48 = 32'b10100000000000000000000000000000;
wire [31:0] vbb2 = v48;
wire [31:0] vbb3 = In_register_EIP + vbb2;
wire [31:0] vbb5 = vbb3;
wire vbb6 = vbb5 == Out_register_EIP;
wire [7:0] vbb7 = vb79[7:0];
wire [2:0] vbb8_aux = vbb7[0] + vbb7[1] + vbb7[2] + vbb7[3] + vbb7[4] + vbb7[5] + vbb7[6] + vbb7[7];
wire vbb8 = { 5'b00000, vbb8_aux };
wire [7:0] vbb9 = vbb8 & v18;
wire [7:0] vbba = vbb9 ^ v18;
wire vbbb = vbba[0:0];
wire vbbd = vbbb;
wire vbbe = vbbd == Out_register_PF;
wire vbbf = vb79 == v15;
wire vbc1 = vbbf;
wire vbc2 = vbc1 == Out_register_ZF;
wire vbc3 = v15c & vb70 & vb73 & vb7f & vb82 & vb85 & vb88 & vb89 & vb8c & vb8f & vb6d & vb92 & vb95 & vb98 & vb9b & vb9e & vba0 & vba4 & vba7 & vbaa & vbad & vbb0 & vbb6 & vbbe & vbc2;
wire [7:0] v49 = 8'b00100001;
wire vbc4 = v49 == v1eb;
wire vbc5 = v35 == v316;
wire vbc6 = v1b == v318;
wire [2:0] vbc7 = { v1fa };
wire vbc8 = vbc7 == vb;
wire vbc9 = vbc7 == vf;
wire vbca = vbc8 | vbc9;
wire vbcb = vbca ^ v8;
wire [2:0] vbcc = { v1fa };
wire vbcd = vbcc == vb;
wire vbce = vbcc == vf;
wire vbcf = vbcd | vbce;
wire vbd0 = vbcf ^ v8;
wire vbd1 = vbcb & vbd0;
wire vbd2 = vbc4 & vbc5 & vbc6 & vbd1;
wire vbd3 = v49 == v1eb;
wire vbd4 = v30 == v316;
wire vbd5 = v4 == v11b;
wire [2:0] vbd6 = { v1fa };
wire vbd7 = vbd6 == vb;
wire vbd8 = vbd6 == vf;
wire vbd9 = vbd7 | vbd8;
wire vbda = vbd9 ^ v8;
wire [2:0] vbdb = { v1fa };
wire vbdc = vbdb == vb;
wire vbdd = vbdc;
wire vbde = vbdd ^ v8;
wire vbdf = vbda & vbde;
wire vbe0 = vbd3 & vbd4 & vbd5 & vbdf;
wire [10:0] v4a = 11'b00100001001;
wire vbe1 = v4a == v6d7;
wire vbe2 = v30 == v316;
wire vbe3 = v38 == v6da;
wire [2:0] vbe4 = { v13c };
wire vbe5 = vbe4 == vb;
wire vbe6 = vbe4 == vf;
wire vbe7 = vbe5 | vbe6;
wire vbe8 = vbe7 ^ v8;
wire [2:0] vbe9 = { v12c };
wire vbea = vbe9 == vb;
wire vbeb = vbea;
wire vbec = vbeb ^ v8;
wire vbed = vbe8 & vbec;
wire vbee = vbe1 & vbe2 & vbe3 & vbed;
wire vbef = v4a == v6d7;
wire vbf0 = v2f == v316;
wire vbf1 = v43 == vab3;
wire [2:0] vbf2 = { v13c };
wire vbf3 = vbf2 == vb;
wire vbf4 = vbf2 == vf;
wire vbf5 = vbf3 | vbf4;
wire vbf6 = vbf5 ^ v8;
wire [2:0] vbf7 = { v12c };
wire vbf8 = vbf7 == vb;
wire vbf9 = vbf8;
wire vbfa = vbf9 ^ v8;
wire vbfb = vbf6 & vbfa;
wire vbfc = vbef & vbf0 & vbf1 & vbfb;
wire vbfd = v49 == v1eb;
wire vbfe = v2f == v316;
wire vbff = v14 == v1ef;
wire [2:0] vc00 = { v1fa };
wire vc01 = vc00 == vb;
wire vc02 = vc00 == vf;
wire vc03 = vc01 | vc02;
wire vc04 = vc03 ^ v8;
wire [2:0] vc05 = { v1fa };
wire vc06 = vc05 == vb;
wire vc07 = vc06;
wire vc08 = vc07 ^ v8;
wire vc09 = vc04 & vc08;
wire vc0a = vbfd & vbfe & vbff & vc09;
wire vc0b = v4a == v6d7;
wire [4:0] v4b = 5'b00101;
wire [4:0] vc0c = instruction_bits[18: 14];
wire vc0d = v4b == vc0c;
wire vc0e = v43 == vab3;
wire vc0f = vc0b & vc0d & vc0e;
wire vc10 = vbd2 | vbe0 | vbee | vbfc | vc0a | vc0f;
wire vc11 = vc10;
wire [31:0] vc13 = In_register_CSBASE;
wire vc14 = vc13 == Out_register_CSBASE;
wire vc16 = In_register_AF;
wire vc17 = vc16 == Out_register_AF;
wire [2:0] vc18 = { v1fa };
wire [31:0] vc19 = ( vc18 == 3'd0) ? In_register_EAX : 
	( vc18 == 3'd1) ? In_register_ECX : 
	( vc18 == 3'd2) ? In_register_EDX : 
	( vc18 == 3'd3) ? In_register_EBX : 
	( vc18 == 3'd4) ? v15 : 
	( vc18 == 3'd5) ? v15 : 
	( vc18 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] vc1b = { v1fa };
wire [31:0] vc1c = ( vc1b == 3'd0) ? In_register_EAX : 
	( vc1b == 3'd1) ? In_register_ECX : 
	( vc1b == 3'd2) ? In_register_EDX : 
	( vc1b == 3'd3) ? In_register_EBX : 
	( vc1b == 3'd4) ? v15 : 
	( vc1b == 3'd5) ? v15 : 
	( vc1b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vc1d = vc1c + v63a;
wire [2:0] vc1f = { v13c };
wire [31:0] vc20 = ( vc1f == 3'd0) ? In_register_EAX : 
	( vc1f == 3'd1) ? In_register_ECX : 
	( vc1f == 3'd2) ? In_register_EDX : 
	( vc1f == 3'd3) ? In_register_EBX : 
	( vc1f == 3'd4) ? v15 : 
	( vc1f == 3'd5) ? v15 : 
	( vc1f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] vc21 = { v12c };
wire [31:0] vc22 = ( vc21 == 3'd0) ? In_register_EAX : 
	( vc21 == 3'd1) ? In_register_ECX : 
	( vc21 == 3'd2) ? In_register_EDX : 
	( vc21 == 3'd3) ? In_register_EBX : 
	( vc21 == 3'd4) ? v15 : 
	( vc21 == 3'd5) ? In_register_EBP : 
	( vc21 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vc23 = vc22 << v7f4;
wire [31:0] vc24 = vc20 + vc23;
wire [31:0] vc25 = vc24 + v7f8;
wire [2:0] vc27 = { v13c };
wire [31:0] vc28 = ( vc27 == 3'd0) ? In_register_EAX : 
	( vc27 == 3'd1) ? In_register_ECX : 
	( vc27 == 3'd2) ? In_register_EDX : 
	( vc27 == 3'd3) ? In_register_EBX : 
	( vc27 == 3'd4) ? v15 : 
	( vc27 == 3'd5) ? v15 : 
	( vc27 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] vc29 = { v12c };
wire [31:0] vc2a = ( vc29 == 3'd0) ? In_register_EAX : 
	( vc29 == 3'd1) ? In_register_ECX : 
	( vc29 == 3'd2) ? In_register_EDX : 
	( vc29 == 3'd3) ? In_register_EBX : 
	( vc29 == 3'd4) ? v15 : 
	( vc29 == 3'd5) ? In_register_EBP : 
	( vc29 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vc2b = vc2a << v7f4;
wire [31:0] vc2c = vc28 + vc2b;
wire [31:0] vc2d = instruction_bits[55: 24];
wire [31:0] vc2e = vc2c + vc2d;
wire [2:0] vc30 = { v1fa };
wire [31:0] vc31 = ( vc30 == 3'd0) ? In_register_EAX : 
	( vc30 == 3'd1) ? In_register_ECX : 
	( vc30 == 3'd2) ? In_register_EDX : 
	( vc30 == 3'd3) ? In_register_EBX : 
	( vc30 == 3'd4) ? v15 : 
	( vc30 == 3'd5) ? v15 : 
	( vc30 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vc32 = vc31 + v1f7;
wire [2:0] vc34 = { v12c };
wire [31:0] vc35 = ( vc34 == 3'd0) ? In_register_EAX : 
	( vc34 == 3'd1) ? In_register_ECX : 
	( vc34 == 3'd2) ? In_register_EDX : 
	( vc34 == 3'd3) ? In_register_EBX : 
	( vc34 == 3'd4) ? v15 : 
	( vc34 == 3'd5) ? In_register_EBP : 
	( vc34 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vc36 = vc35 << v7f4;
wire [31:0] vc37 = vc36 + vc2d;
wire [31:0] vc39 = ( vbd2 ) ? vc19 : 
	( vbe0 ) ? vc1d : 
	( vbee ) ? vc25 : 
	( vbfc ) ? vc2e : 
	( vc0a ) ? vc32 : vc37;
wire vc3a =  v2a == memory_0[15: 12] && vc39 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] vc3c = In_register_EAX;
wire vc3d = vc3c == Out_register_EAX;
wire [31:0] vc3f = In_register_ESBASE;
wire vc40 = vc3f == Out_register_ESBASE;
wire vc41 = In_error_flag == Out_error_flag;
wire [31:0] vc43 = In_register_EBX;
wire vc44 = vc43 == Out_register_EBX;
wire vc46 = v17;
wire vc47 = vc46 == Out_register_CF;
wire [31:0] vc49 = In_register_ESP;
wire vc4a = vc49 == Out_register_ESP;
wire [31:0] vc4c = In_register_ECX;
wire vc4d = vc4c == Out_register_ECX;
wire [31:0] vc4f = In_register_SSBASE;
wire vc50 = vc4f == Out_register_SSBASE;
wire [31:0] vc52 = In_register_ESI;
wire vc53 = vc52 == Out_register_ESI;
wire [31:0] vc55 = In_register_GSBASE;
wire vc56 = vc55 == Out_register_GSBASE;
wire [31:0] vc58 = In_register_EBP;
wire vc59 = vc58 == Out_register_EBP;
wire [31:0] vc5b = In_register_EDI;
wire vc5c = vc5b == Out_register_EDI;
wire [31:0] vc5e = In_register_EDX;
wire vc5f = vc5e == Out_register_EDX;
wire [7:0] vc61 = In_register_DF;
wire vc62 = vc61 == Out_register_DF;
wire [31:0] vc69 = ( vbfc | vc0f ) ? v45 : 
	( vbee ) ? v27 : 
	( vbd2 ) ? v1c : 
	( vc0a ) ? v16 : v10;
wire [31:0] vc6a = In_register_EIP + vc69;
wire [31:0] vc6c = vc6a;
wire vc6d = vc6c == Out_register_EIP;
wire [31:0] vc6f = In_register_DSBASE;
wire vc70 = vc6f == Out_register_DSBASE;
wire [31:0] vc71 = memory_0[79: 48];
wire [7:0] vc72 = vc71[7:0];
wire [2:0] vc73 = { v320 };
wire [31:0] vc74 = ( vc73 == 3'd0) ? In_register_EAX : 
	( vc73 == 3'd1) ? In_register_ECX : 
	( vc73 == 3'd2) ? In_register_EDX : 
	( vc73 == 3'd3) ? In_register_EBX : 
	( vc73 == 3'd4) ? In_register_EAX : 
	( vc73 == 3'd5) ? In_register_ECX : 
	( vc73 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vc75 = { v320 };
wire vc76 = vc75 == vb;
wire vc77 = vc75 == v9;
wire vc78 = vc76 | vc77;
wire vc79 = vc75 == vf;
wire vc7a = vc78 | vc79;
wire vc7b = vc75 == v11;
wire vc7c = vc7a | vc7b;
wire [31:0] vc7d = ( vc7c == 1'd0) ? v15 : v31;
wire [31:0] vc7e = vc74 >> vc7d;
wire [31:0] vc7f = vc7e & v32;
wire [2:0] vc81 = { v320 };
wire [31:0] vc82 = ( vc81 == 3'd0) ? In_register_EAX : 
	( vc81 == 3'd1) ? In_register_ECX : 
	( vc81 == 3'd2) ? In_register_EDX : 
	( vc81 == 3'd3) ? In_register_EBX : 
	( vc81 == 3'd4) ? In_register_EAX : 
	( vc81 == 3'd5) ? In_register_ECX : 
	( vc81 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vc83 = { v320 };
wire vc84 = vc83 == vb;
wire vc85 = vc83 == v9;
wire vc86 = vc84 | vc85;
wire vc87 = vc83 == vf;
wire vc88 = vc86 | vc87;
wire vc89 = vc83 == v11;
wire vc8a = vc88 | vc89;
wire [31:0] vc8b = ( vc8a == 1'd0) ? v15 : v31;
wire [31:0] vc8c = vc82 >> vc8b;
wire [31:0] vc8d = vc8c & v32;
wire [2:0] vc8f = { v320 };
wire [31:0] vc90 = ( vc8f == 3'd0) ? In_register_EAX : 
	( vc8f == 3'd1) ? In_register_ECX : 
	( vc8f == 3'd2) ? In_register_EDX : 
	( vc8f == 3'd3) ? In_register_EBX : 
	( vc8f == 3'd4) ? In_register_EAX : 
	( vc8f == 3'd5) ? In_register_ECX : 
	( vc8f == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vc91 = { v320 };
wire vc92 = vc91 == vb;
wire vc93 = vc91 == v9;
wire vc94 = vc92 | vc93;
wire vc95 = vc91 == vf;
wire vc96 = vc94 | vc95;
wire vc97 = vc91 == v11;
wire vc98 = vc96 | vc97;
wire [31:0] vc99 = ( vc98 == 1'd0) ? v15 : v31;
wire [31:0] vc9a = vc90 >> vc99;
wire [31:0] vc9b = vc9a & v32;
wire [2:0] vc9d = { v320 };
wire [31:0] vc9e = ( vc9d == 3'd0) ? In_register_EAX : 
	( vc9d == 3'd1) ? In_register_ECX : 
	( vc9d == 3'd2) ? In_register_EDX : 
	( vc9d == 3'd3) ? In_register_EBX : 
	( vc9d == 3'd4) ? In_register_EAX : 
	( vc9d == 3'd5) ? In_register_ECX : 
	( vc9d == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vc9f = { v320 };
wire vca0 = vc9f == vb;
wire vca1 = vc9f == v9;
wire vca2 = vca0 | vca1;
wire vca3 = vc9f == vf;
wire vca4 = vca2 | vca3;
wire vca5 = vc9f == v11;
wire vca6 = vca4 | vca5;
wire [31:0] vca7 = ( vca6 == 1'd0) ? v15 : v31;
wire [31:0] vca8 = vc9e >> vca7;
wire [31:0] vca9 = vca8 & v32;
wire [2:0] vcab = { v320 };
wire [31:0] vcac = ( vcab == 3'd0) ? In_register_EAX : 
	( vcab == 3'd1) ? In_register_ECX : 
	( vcab == 3'd2) ? In_register_EDX : 
	( vcab == 3'd3) ? In_register_EBX : 
	( vcab == 3'd4) ? In_register_EAX : 
	( vcab == 3'd5) ? In_register_ECX : 
	( vcab == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vcad = { v320 };
wire vcae = vcad == vb;
wire vcaf = vcad == v9;
wire vcb0 = vcae | vcaf;
wire vcb1 = vcad == vf;
wire vcb2 = vcb0 | vcb1;
wire vcb3 = vcad == v11;
wire vcb4 = vcb2 | vcb3;
wire [31:0] vcb5 = ( vcb4 == 1'd0) ? v15 : v31;
wire [31:0] vcb6 = vcac >> vcb5;
wire [31:0] vcb7 = vcb6 & v32;
wire [2:0] vcb9 = { v320 };
wire [31:0] vcba = ( vcb9 == 3'd0) ? In_register_EAX : 
	( vcb9 == 3'd1) ? In_register_ECX : 
	( vcb9 == 3'd2) ? In_register_EDX : 
	( vcb9 == 3'd3) ? In_register_EBX : 
	( vcb9 == 3'd4) ? In_register_EAX : 
	( vcb9 == 3'd5) ? In_register_ECX : 
	( vcb9 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vcbb = { v320 };
wire vcbc = vcbb == vb;
wire vcbd = vcbb == v9;
wire vcbe = vcbc | vcbd;
wire vcbf = vcbb == vf;
wire vcc0 = vcbe | vcbf;
wire vcc1 = vcbb == v11;
wire vcc2 = vcc0 | vcc1;
wire [31:0] vcc3 = ( vcc2 == 1'd0) ? v15 : v31;
wire [31:0] vcc4 = vcba >> vcc3;
wire [31:0] vcc5 = vcc4 & v32;
wire [31:0] vcc7 = ( vbd2 ) ? vc7f : 
	( vbe0 ) ? vc8d : 
	( vbee ) ? vc9b : 
	( vbfc ) ? vca9 : 
	( vc0a ) ? vcb7 : vcc5;
wire [7:0] vcc8 = vcc7[7:0];
wire [7:0] vcc9 = vc72 & vcc8;
wire [2:0] vcca_aux = vcc9[0] + vcc9[1] + vcc9[2] + vcc9[3] + vcc9[4] + vcc9[5] + vcc9[6] + vcc9[7];
wire vcca = { 5'b00000, vcca_aux };
wire [7:0] vccb = vcca & v18;
wire [7:0] vccc = vccb ^ v18;
wire vccd = vccc[0:0];
wire vccf = vccd;
wire vcd0 = vccf == Out_register_PF;
wire vcd1 = v17;
wire vcd2 = vcd1 == Out_register_OF;
wire [31:0] vcd4 = In_register_FSBASE;
wire vcd5 = vcd4 == Out_register_FSBASE;
wire vcd6 = $signed(vcc9) < $signed(v2c);
wire vcd8 = vcd6;
wire vcd9 = vcd8 == Out_register_SF;
wire vcda = vcc9 == v2c;
wire vcdc = vcda;
wire vcdd = vcdc == Out_register_ZF;
wire vcde = vc11 & vc14 & v15c & vc17 & vc3a & vc3d & vc40 & vc41 & vc44 & vc47 & vc4a & vc4d & vc50 & vc53 & vc56 & vc59 & vc5c & vc5f & vc62 & vc6d & vc70 & vcd0 & vcd2 & vcd5 & vcd9 & vcdd;
wire [7:0] v4c = 8'b11011110;
wire vcdf = v4c == v1eb;
wire vce0 = v1b == v318;
wire vce1 = vcdf & vce0;
wire vce2 = vce1;
wire vce3 = vce2;
wire [31:0] vce5 = In_register_EDX;
wire vce6 = vce5 == Out_register_EDX;
wire [31:0] vce8 = In_register_ECX;
wire vce9 = vce8 == Out_register_ECX;
wire vcea = In_error_flag == Out_error_flag;
wire [31:0] vcec = In_register_EAX;
wire vced = vcec == Out_register_EAX;
wire [31:0] vcef = In_register_ESP;
wire vcf0 = vcef == Out_register_ESP;
wire [31:0] vcf2 = In_register_ESI;
wire vcf3 = vcf2 == Out_register_ESI;
wire [31:0] vcf5 = In_register_EBX;
wire vcf6 = vcf5 == Out_register_EBX;
wire [31:0] vcf8 = In_register_EBP;
wire vcf9 = vcf8 == Out_register_EBP;
wire [31:0] vcfb = In_register_EDI;
wire vcfc = vcfb == Out_register_EDI;
wire [31:0] vcfe = In_register_ESBASE;
wire vcff = vcfe == Out_register_ESBASE;
wire [31:0] vd01 = In_register_DSBASE;
wire vd02 = vd01 == Out_register_DSBASE;
wire [31:0] vd04 = In_register_SSBASE;
wire vd05 = vd04 == Out_register_SSBASE;
wire [31:0] vd09 = v1c;
wire [31:0] vd0a = In_register_EIP + vd09;
wire [7:0] vd06 = { 7'b0000000, In_register_PF };
wire vd07 = vd06 == v2c;
wire [31:0] vd0c = vd0a;
wire [31:0] vd0d = vd0a + v477;
wire [31:0] vd0f = vd0d;
wire [31:0] vd10 = ( vd07 == 1'd0) ? vd0c : vd0f;
wire [31:0] vd13 = ( v8 ) ? vd0a : vd10;
wire [31:0] vd15 = vd13;
wire vd16 = vd15 == Out_register_EIP;
wire [7:0] vd18 = In_register_DF;
wire vd19 = vd18 == Out_register_DF;
wire [31:0] vd1b = In_register_FSBASE;
wire vd1c = vd1b == Out_register_FSBASE;
wire [31:0] vd1e = In_register_CSBASE;
wire vd1f = vd1e == Out_register_CSBASE;
wire vd21 = In_register_AF;
wire vd22 = vd21 == Out_register_AF;
wire [31:0] vd24 = In_register_GSBASE;
wire vd25 = vd24 == Out_register_GSBASE;
wire vd27 = In_register_OF;
wire vd28 = vd27 == Out_register_OF;
wire vd2a = In_register_PF;
wire vd2b = vd2a == Out_register_PF;
wire vd2d = In_register_CF;
wire vd2e = vd2d == Out_register_CF;
wire vd30 = In_register_SF;
wire vd31 = vd30 == Out_register_SF;
wire vd33 = In_register_ZF;
wire vd34 = vd33 == Out_register_ZF;
wire vd35 = vce3 & vce6 & vce9 & vcea & vced & vcf0 & vcf3 & vcf6 & vcf9 & vcfc & vcff & vd02 & vd05 & vd16 & vd19 & vd1c & vd1f & v15c & vd22 & vd25 & vd28 & vd2b & vd2e & vd31 & vd34;
wire [7:0] v4d = 8'b10101000;
wire vd36 = v4d == v1eb;
wire vd37 = v47 == vb69;
wire vd38 = vd36 & vd37;
wire vd39 = vd38;
wire vd3a = vd39;
wire [31:0] vd3c = In_register_ESI;
wire vd3d = vd3c == Out_register_ESI;
wire [31:0] vd3f = In_register_CSBASE;
wire vd40 = vd3f == Out_register_CSBASE;
wire [31:0] vd42 = vb74;
wire [31:0] vd44 = In_register_EAX;
wire [31:0] vd45 = vd42 + vd44;
wire [31:0] vd46 = vd45 + vb11;
wire [31:0] vd47 = vd46 ^ vd44;
wire [31:0] vd48 = vd47 >> v1e;
wire [31:0] vd49 = vd46 ^ vd42;
wire [31:0] vd4a = vd49 >> v1e;
wire [31:0] vd4b = vd48 + vd4a;
wire vd4c = vd4b == v1c;
wire vd4e = vd4c;
wire vd4f = vd4e == Out_register_OF;
wire [31:0] vd51 = In_register_ESP;
wire vd52 = vd51 == Out_register_ESP;
wire [31:0] vd54 = In_register_EBX;
wire vd55 = vd54 == Out_register_EBX;
wire [31:0] vd57 = In_register_ECX;
wire vd58 = vd57 == Out_register_ECX;
wire [31:0] vd5a = In_register_EDX;
wire vd5b = vd5a == Out_register_EDX;
wire [31:0] vd5d = In_register_GSBASE;
wire vd5e = vd5d == Out_register_GSBASE;
wire [31:0] vd60 = In_register_EDI;
wire vd61 = vd60 == Out_register_EDI;
wire [31:0] vd63 = In_register_FSBASE;
wire vd64 = vd63 == Out_register_FSBASE;
wire [31:0] vd66 = v48;
wire [31:0] vd67 = In_register_EIP + vd66;
wire [31:0] vd69 = vd67;
wire vd6a = vd69 == Out_register_EIP;
wire [31:0] vd6c = In_register_EBP;
wire vd6d = vd6c == Out_register_EBP;
wire [31:0] vd6f = In_register_SSBASE;
wire vd70 = vd6f == Out_register_SSBASE;
wire vd71 = In_error_flag == Out_error_flag;
wire vd72 = vd45 < vd44;
wire vd73 = vd45 < vd42;
wire vd74 = vd72 | vd73;
wire vd75 = vd46 < vd45;
wire vd76 = vd46 < vb11;
wire vd77 = vd75 | vd76;
wire [7:0] vd78 = { 7'b0000000, vd77 };
wire [7:0] vd79 = ( vd74 == 1'd0) ? vd78 : v18;
wire vd7a = vd79[0:0];
wire vd7c = vd7a;
wire vd7d = vd7c == Out_register_CF;
wire vd7e = $signed(vd46) < $signed(v15);
wire vd80 = vd7e;
wire vd81 = vd80 == Out_register_SF;
wire [31:0] vd83 = In_register_ESBASE;
wire vd84 = vd83 == Out_register_ESBASE;
wire [31:0] vd86 = In_register_DSBASE;
wire vd87 = vd86 == Out_register_DSBASE;
wire [31:0] vd8a = ( v8 ) ? In_register_EAX : vd46;
wire [31:0] vd8c = vd8a;
wire vd8d = vd8c == Out_register_EAX;
wire [31:0] vd8e = vd49 ^ vd44;
wire [7:0] vd8f = vd8e[7:0];
wire [7:0] vd90 = vd8f >> v1d;
wire [7:0] vd91 = vd90 & v18;
wire vd92 = vd91[0:0];
wire vd94 = vd92;
wire vd95 = vd94 == Out_register_AF;
wire [7:0] vd97 = In_register_DF;
wire vd98 = vd97 == Out_register_DF;
wire [7:0] vd99 = vd46[7:0];
wire [2:0] vd9a_aux = vd99[0] + vd99[1] + vd99[2] + vd99[3] + vd99[4] + vd99[5] + vd99[6] + vd99[7];
wire vd9a = { 5'b00000, vd9a_aux };
wire [7:0] vd9b = vd9a & v18;
wire [7:0] vd9c = vd9b ^ v18;
wire vd9d = vd9c[0:0];
wire vd9f = vd9d;
wire vda0 = vd9f == Out_register_PF;
wire vda1 = vd46 == v15;
wire vda3 = vda1;
wire vda4 = vda3 == Out_register_ZF;
wire vda5 = v15c & vd3d & vd40 & vd4f & vd52 & vd55 & vd58 & vd5b & vd5e & vd61 & vd64 & vd6a & vd6d & vd70 & vd71 & vd7d & vd81 & vd84 & vd3a & vd87 & vd8d & vd95 & vd98 & vda0 & vda4;
wire [7:0] v4e = 8'b11111111;
wire vda6 = v4e == v1eb;
wire [4:0] v4f = 5'b01111;
wire vda7 = v4f == v1ed;
wire vda8 = v1b == v318;
wire vda9 = vda6 & vda7 & vda8;
wire vdaa = vda9;
wire vdab = vdaa;
wire [31:0] vdad = In_register_EAX;
wire vdae = vdad == Out_register_EAX;
wire [31:0] vdb0 = In_register_DSBASE;
wire vdb1 = vdb0 == Out_register_DSBASE;
wire [31:0] vdb2 = In_register_ESP + v3d;
wire [31:0] vdb3 = In_register_SSBASE + vdb2;
wire [2:0] vdb4 = { v1fa };
wire [31:0] vdb5 = ( vdb4 == 3'd0) ? In_register_EAX : 
	( vdb4 == 3'd1) ? In_register_ECX : 
	( vdb4 == 3'd2) ? In_register_EDX : 
	( vdb4 == 3'd3) ? In_register_EBX : 
	( vdb4 == 3'd4) ? In_register_ESP : 
	( vdb4 == 3'd5) ? In_register_EBP : 
	( vdb4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] vdb7 = vdb5;
wire vdb8 =  v26 == memory_0[15: 12] && vdb3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && vdb7 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] vdba = In_register_EBX;
wire vdbb = vdba == Out_register_EBX;
wire [31:0] vdbd = vdb2;
wire vdbe = vdbd == Out_register_ESP;
wire vdc0 = In_register_PF;
wire vdc1 = vdc0 == Out_register_PF;
wire [31:0] vdc3 = In_register_EBP;
wire vdc4 = vdc3 == Out_register_EBP;
wire [31:0] vdc6 = In_register_GSBASE;
wire vdc7 = vdc6 == Out_register_GSBASE;
wire [31:0] vdc9 = In_register_EDX;
wire vdca = vdc9 == Out_register_EDX;
wire vdcb = In_error_flag == Out_error_flag;
wire [31:0] vdcd = In_register_ESI;
wire vdce = vdcd == Out_register_ESI;
wire [31:0] vdd0 = v1c;
wire [31:0] vdd1 = In_register_EIP + vdd0;
wire [31:0] vdd3 = vdd1;
wire vdd4 = vdd3 == Out_register_EIP;
wire [31:0] vdd6 = In_register_ECX;
wire vdd7 = vdd6 == Out_register_ECX;
wire vdd9 = In_register_AF;
wire vdda = vdd9 == Out_register_AF;
wire [31:0] vddc = In_register_EDI;
wire vddd = vddc == Out_register_EDI;
wire [31:0] vddf = In_register_FSBASE;
wire vde0 = vddf == Out_register_FSBASE;
wire [7:0] vde2 = In_register_DF;
wire vde3 = vde2 == Out_register_DF;
wire vde5 = In_register_CF;
wire vde6 = vde5 == Out_register_CF;
wire [31:0] vde8 = In_register_ESBASE;
wire vde9 = vde8 == Out_register_ESBASE;
wire [31:0] vdeb = In_register_SSBASE;
wire vdec = vdeb == Out_register_SSBASE;
wire vdee = In_register_OF;
wire vdef = vdee == Out_register_OF;
wire [31:0] vdf1 = In_register_CSBASE;
wire vdf2 = vdf1 == Out_register_CSBASE;
wire vdf4 = In_register_SF;
wire vdf5 = vdf4 == Out_register_SF;
wire vdf7 = In_register_ZF;
wire vdf8 = vdf7 == Out_register_ZF;
wire vdf9 = v15c & vdae & vdab & vdb1 & vdb8 & vdbb & vdbe & vdc1 & vdc4 & vdc7 & vdca & vdcb & vdce & vdd4 & vdd7 & vdda & vddd & vde0 & vde3 & vde6 & vde9 & vdec & vdef & vdf2 & vdf5 & vdf8;
wire [18:0] v50 = 19'b0000000100101100101;
wire [18:0] vdfa = instruction_bits[18: 0];
wire vdfb = v50 == vdfa;
wire [55:0] v51 = 56'b00000000000000000000000000000000000000000000000000000000;
wire [55:0] vdfc = instruction_bits[119: 64];
wire vdfd = v51 == vdfc;
wire vdfe = vdfb & vdfd;
wire vdff = vdfe;
wire ve00 = vdff;
wire [31:0] ve02 = In_register_ECX;
wire ve03 = ve02 == Out_register_ECX;
wire [31:0] ve05 = In_register_ESBASE;
wire ve06 = ve05 == Out_register_ESBASE;
wire [2:0] ve07 = { v12c };
wire [31:0] ve08 = ( ve07 == 3'd0) ? In_register_EAX : 
	( ve07 == 3'd1) ? In_register_ECX : 
	( ve07 == 3'd2) ? In_register_EDX : 
	( ve07 == 3'd3) ? In_register_EBX : 
	( ve07 == 3'd4) ? v15 : 
	( ve07 == 3'd5) ? In_register_EBP : 
	( ve07 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] ve09 = ve08 << v7f4;
wire [31:0] ve0a = ve09 + vc2d;
wire [31:0] ve0c = ve0a;
wire [31:0] ve0d = memory_0[79: 48];
wire [7:0] ve0e = ve0d[7:0];
wire [7:0] ve0f = instruction_bits[63: 56];
wire [7:0] pad_3600 = (ve0f[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] ve10 = { pad_3600, ve0f };
wire [31:0] ve12 = ve10;
wire [7:0] ve13 = ve12[7:0];
wire [7:0] ve14 = ve0e ^ ve13;
wire ve15 =  v2a == memory_1[15: 12] && ve0c == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && ve14 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] ve17 = In_register_GSBASE;
wire ve18 = ve17 == Out_register_GSBASE;
wire ve1a = v17;
wire ve1b = ve1a == Out_register_OF;
wire [31:0] ve1d = In_register_EDX;
wire ve1e = ve1d == Out_register_EDX;
wire [2:0] ve1f_aux = ve14[0] + ve14[1] + ve14[2] + ve14[3] + ve14[4] + ve14[5] + ve14[6] + ve14[7];
wire ve1f = { 5'b00000, ve1f_aux };
wire [7:0] ve20 = ve1f & v18;
wire [7:0] ve21 = ve20 ^ v18;
wire ve22 = ve21[0:0];
wire ve24 = ve22;
wire ve25 = ve24 == Out_register_PF;
wire ve26 = In_error_flag == Out_error_flag;
wire [31:0] ve28 = In_register_ESP;
wire ve29 = ve28 == Out_register_ESP;
wire ve2b = In_register_AF;
wire ve2c = ve2b == Out_register_AF;
wire [31:0] ve2e = In_register_ESI;
wire ve2f = ve2e == Out_register_ESI;
wire [31:0] ve31 = In_register_EBX;
wire ve32 = ve31 == Out_register_EBX;
wire [2:0] ve33 = { v12c };
wire [31:0] ve34 = ( ve33 == 3'd0) ? In_register_EAX : 
	( ve33 == 3'd1) ? In_register_ECX : 
	( ve33 == 3'd2) ? In_register_EDX : 
	( ve33 == 3'd3) ? In_register_EBX : 
	( ve33 == 3'd4) ? v15 : 
	( ve33 == 3'd5) ? In_register_EBP : 
	( ve33 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] ve35 = ve34 << v7f4;
wire [31:0] ve36 = ve35 + vc2d;
wire [31:0] ve38 = ve36;
wire ve39 =  v2a == memory_0[15: 12] && ve38 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] ve3b = In_register_EDI;
wire ve3c = ve3b == Out_register_EDI;
wire ve3d = v17;
wire ve3e = ve3d == Out_register_CF;
wire [31:0] ve40 = In_register_EBP;
wire ve41 = ve40 == Out_register_EBP;
wire [31:0] ve43 = v31;
wire [31:0] ve44 = In_register_EIP + ve43;
wire [31:0] ve46 = ve44;
wire ve47 = ve46 == Out_register_EIP;
wire [31:0] ve49 = In_register_CSBASE;
wire ve4a = ve49 == Out_register_CSBASE;
wire [31:0] ve4c = In_register_SSBASE;
wire ve4d = ve4c == Out_register_SSBASE;
wire [31:0] ve4f = In_register_EAX;
wire ve50 = ve4f == Out_register_EAX;
wire [31:0] ve52 = In_register_DSBASE;
wire ve53 = ve52 == Out_register_DSBASE;
wire [31:0] ve55 = In_register_FSBASE;
wire ve56 = ve55 == Out_register_FSBASE;
wire [7:0] ve58 = In_register_DF;
wire ve59 = ve58 == Out_register_DF;
wire ve5a = $signed(ve14) < $signed(v2c);
wire ve5c = ve5a;
wire ve5d = ve5c == Out_register_SF;
wire ve5e = ve14 == v2c;
wire ve60 = ve5e;
wire ve61 = ve60 == Out_register_ZF;
wire ve62 = ve00 & ve03 & ve06 & ve15 & ve18 & ve1b & v15c & ve1e & ve25 & ve26 & ve29 & ve2c & ve2f & ve32 & ve39 & ve3c & ve3e & ve41 & ve47 & ve4a & ve4d & ve50 & ve53 & ve56 & ve59 & ve5d & ve61;
wire [7:0] v52 = 8'b10110100;
wire ve63 = v52 == v1eb;
wire ve64 = v47 == vb69;
wire ve65 = ve63 & ve64;
wire ve66 = ve65;
wire ve67 = ve66;
wire [31:0] ve69 = In_register_CSBASE;
wire ve6a = ve69 == Out_register_CSBASE;
wire ve6b = In_error_flag == Out_error_flag;
wire [31:0] ve6d = In_register_EDX;
wire ve6e = ve6d == Out_register_EDX;
wire [31:0] ve70 = In_register_ESP;
wire ve71 = ve70 == Out_register_ESP;
wire [31:0] ve73 = In_register_EBX;
wire ve74 = ve73 == Out_register_EBX;
wire [31:0] ve76 = In_register_EDI;
wire ve77 = ve76 == Out_register_EDI;
wire [31:0] ve79 = In_register_DSBASE;
wire ve7a = ve79 == Out_register_DSBASE;
wire [7:0] ve7c = In_register_DF;
wire ve7d = ve7c == Out_register_DF;
wire [31:0] ve7f = In_register_EBP;
wire ve80 = ve7f == Out_register_EBP;
wire [31:0] ve82 = v48;
wire [31:0] ve83 = In_register_EIP + ve82;
wire [31:0] ve85 = ve83;
wire ve86 = ve85 == Out_register_EIP;
wire [31:0] ve88 = In_register_EAX;
wire [31:0] ve8a = vb74;
wire [31:0] ve8b = ve88 - ve8a;
wire [31:0] ve8e = ( v8 ) ? In_register_EAX : ve8b;
wire [31:0] ve90 = ve8e;
wire ve91 = ve90 == Out_register_EAX;
wire ve92 = ve88 < ve8a;
wire ve94 = ve92;
wire ve95 = ve94 == Out_register_CF;
wire [31:0] ve97 = In_register_ESI;
wire ve98 = ve97 == Out_register_ESI;
wire [31:0] ve99 = ve8b ^ ve88;
wire [31:0] ve9a = ve99 >> v1e;
wire [31:0] ve9b = ve8a ^ ve88;
wire [31:0] ve9c = ve9b >> v1e;
wire [31:0] ve9d = ve9a + ve9c;
wire ve9e = ve9d == v1c;
wire vea0 = ve9e;
wire vea1 = vea0 == Out_register_OF;
wire [31:0] vea3 = In_register_SSBASE;
wire vea4 = vea3 == Out_register_SSBASE;
wire vea5 = $signed(ve8b) < $signed(v15);
wire vea7 = vea5;
wire vea8 = vea7 == Out_register_SF;
wire [31:0] veaa = In_register_ESBASE;
wire veab = veaa == Out_register_ESBASE;
wire [31:0] vead = In_register_GSBASE;
wire veae = vead == Out_register_GSBASE;
wire [31:0] veb0 = In_register_ECX;
wire veb1 = veb0 == Out_register_ECX;
wire [31:0] veb3 = In_register_FSBASE;
wire veb4 = veb3 == Out_register_FSBASE;
wire [31:0] veb5 = ve9b ^ ve8b;
wire [7:0] veb6 = veb5[7:0];
wire [7:0] veb7 = veb6 >> v1d;
wire [7:0] veb8 = veb7 & v18;
wire veb9 = veb8[0:0];
wire vebb = veb9;
wire vebc = vebb == Out_register_AF;
wire [7:0] vebd = ve8b[7:0];
wire [2:0] vebe_aux = vebd[0] + vebd[1] + vebd[2] + vebd[3] + vebd[4] + vebd[5] + vebd[6] + vebd[7];
wire vebe = { 5'b00000, vebe_aux };
wire [7:0] vebf = vebe & v18;
wire [7:0] vec0 = vebf ^ v18;
wire vec1 = vec0[0:0];
wire vec3 = vec1;
wire vec4 = vec3 == Out_register_PF;
wire vec5 = ve88 == ve8a;
wire vec7 = vec5;
wire vec8 = vec7 == Out_register_ZF;
wire vec9 = v15c & ve6a & ve6b & ve6e & ve71 & ve74 & ve77 & ve7a & ve7d & ve67 & ve80 & ve86 & ve91 & ve95 & ve98 & vea1 & vea4 & vea8 & veab & veae & veb1 & veb4 & vebc & vec4 & vec8;
wire [7:0] v53 = 8'b10100000;
wire veca = v53 == v1eb;
wire vecb = v47 == vb69;
wire vecc = veca & vecb;
wire [15:0] v54 = 16'b0110110010100000;
wire vecd = v54 == v117;
wire vece = v14 == v1ef;
wire vecf = vecd & vece;
wire ved0 = vecc | vecf;
wire ved1 = ved0;
wire [31:0] ved4 = ( vecc ) ? v48 : v16;
wire [31:0] ved5 = In_register_EIP + ved4;
wire [31:0] ved7 = ved5;
wire ved8 = ved7 == Out_register_EIP;
wire [31:0] veda = In_register_ECX;
wire vedb = veda == Out_register_ECX;
wire [31:0] vedd = In_register_ESBASE;
wire vede = vedd == Out_register_ESBASE;
wire [31:0] vee0 = In_register_EBX;
wire vee1 = vee0 == Out_register_EBX;
wire [31:0] vee3 = In_register_EDX;
wire vee4 = vee3 == Out_register_EDX;
wire [31:0] vee7 = ( vecc ) ? vb74 : v1f7;
wire [31:0] veea = In_register_EAX;
wire [31:0] veeb = vee7 + veea;
wire veec = veeb == v15;
wire veee = veec;
wire veef = veee == Out_register_ZF;
wire [7:0] vef1 = In_register_DF;
wire vef2 = vef1 == Out_register_DF;
wire vef3 = $signed(veeb) < $signed(v15);
wire vef5 = vef3;
wire vef6 = vef5 == Out_register_SF;
wire vef7 = In_error_flag == Out_error_flag;
wire [31:0] vef9 = In_register_EDI;
wire vefa = vef9 == Out_register_EDI;
wire [31:0] vefc = In_register_EBP;
wire vefd = vefc == Out_register_EBP;
wire [31:0] veff = In_register_CSBASE;
wire vf00 = veff == Out_register_CSBASE;
wire [31:0] vf02 = In_register_SSBASE;
wire vf03 = vf02 == Out_register_SSBASE;
wire [31:0] vf05 = In_register_ESP;
wire vf06 = vf05 == Out_register_ESP;
wire [31:0] vf08 = In_register_GSBASE;
wire vf09 = vf08 == Out_register_GSBASE;
wire [31:0] vf0a = veeb ^ vee7;
wire [31:0] vf0b = vf0a ^ veea;
wire [7:0] vf0c = vf0b[7:0];
wire [7:0] vf0d = vf0c >> v1d;
wire [7:0] vf0e = vf0d & v18;
wire vf0f = vf0e[0:0];
wire vf11 = vf0f;
wire vf12 = vf11 == Out_register_AF;
wire [31:0] vf14 = In_register_DSBASE;
wire vf15 = vf14 == Out_register_DSBASE;
wire [31:0] vf17 = In_register_FSBASE;
wire vf18 = vf17 == Out_register_FSBASE;
wire vf19 = veeb < veea;
wire vf1a = veeb < vee7;
wire vf1b = vf19 | vf1a;
wire vf1d = vf1b;
wire vf1e = vf1d == Out_register_CF;
wire [31:0] vf21 = ( v8 ) ? In_register_EAX : veeb;
wire [31:0] vf23 = vf21;
wire vf24 = vf23 == Out_register_EAX;
wire [7:0] vf25 = veeb[7:0];
wire [2:0] vf26_aux = vf25[0] + vf25[1] + vf25[2] + vf25[3] + vf25[4] + vf25[5] + vf25[6] + vf25[7];
wire vf26 = { 5'b00000, vf26_aux };
wire [7:0] vf27 = vf26 & v18;
wire [7:0] vf28 = vf27 ^ v18;
wire vf29 = vf28[0:0];
wire vf2b = vf29;
wire vf2c = vf2b == Out_register_PF;
wire [31:0] vf2d = veeb ^ veea;
wire [31:0] vf2e = vf2d >> v1e;
wire [31:0] vf2f = vf0a >> v1e;
wire [31:0] vf30 = vf2e + vf2f;
wire vf31 = vf30 == v1c;
wire vf33 = vf31;
wire vf34 = vf33 == Out_register_OF;
wire [31:0] vf36 = In_register_ESI;
wire vf37 = vf36 == Out_register_ESI;
wire vf38 = ved1 & ved8 & vedb & vede & vee1 & vee4 & veef & vef2 & vef6 & vef7 & vefa & vefd & vf00 & vf03 & vf06 & vf09 & vf12 & vf15 & vf18 & vf1e & vf24 & vf2c & v15c & vf34 & vf37;
wire [7:0] v55 = 8'b00100100;
wire vf39 = v55 == v1eb;
wire vf3a = v1b == v318;
wire vf3b = vf39 & vf3a;
wire [15:0] v56 = 16'b0110011000100100;
wire vf3c = v56 == v117;
wire vf3d = v4 == v11b;
wire vf3e = vf3c & vf3d;
wire vf3f = vf3b | vf3e;
wire vf40 = vf3f;
wire vf42 = v17;
wire vf43 = vf42 == Out_register_AF;
wire [31:0] vf45 = In_register_DSBASE;
wire vf46 = vf45 == Out_register_DSBASE;
wire [31:0] vf49 = ( vf3e ) ? v63a : v477;
wire [7:0] vf4a = In_register_EAX[7:0];
wire [7:0] pad_3915 = (vf4a[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] vf4b = { pad_3915, vf4a };
wire [31:0] vf4e = vf4b;
wire [31:0] vf4f = vf49 & vf4e;
wire [7:0] vf50 = vf4f[7:0];
wire vf51 = $signed(vf50) < $signed(v2c);
wire vf53 = vf51;
wire vf54 = vf53 == Out_register_SF;
wire vf55 = In_error_flag == Out_error_flag;
wire [31:0] vf57 = In_register_EBX;
wire vf58 = vf57 == Out_register_EBX;
wire [31:0] vf5b = ( vf3b ) ? v1c : v10;
wire [31:0] vf5c = In_register_EIP + vf5b;
wire [31:0] vf5e = vf5c;
wire vf5f = vf5e == Out_register_EIP;
wire [31:0] vf61 = In_register_ECX;
wire vf62 = vf61 == Out_register_ECX;
wire [31:0] vf64 = In_register_ESI;
wire vf65 = vf64 == Out_register_ESI;
wire vf66 = v17;
wire vf67 = vf66 == Out_register_OF;
wire [31:0] vf68 = { 24'b000000000000000000000000, vf50 };
wire [31:0] vf69 = v5c8 | vf68;
wire [31:0] vf6c = ( v8 ) ? In_register_EAX : vf69;
wire [31:0] vf6e = vf6c;
wire vf6f = vf6e == Out_register_EAX;
wire [31:0] vf71 = In_register_EDX;
wire vf72 = vf71 == Out_register_EDX;
wire [31:0] vf74 = In_register_EDI;
wire vf75 = vf74 == Out_register_EDI;
wire [31:0] vf77 = In_register_SSBASE;
wire vf78 = vf77 == Out_register_SSBASE;
wire [7:0] vf7a = In_register_DF;
wire vf7b = vf7a == Out_register_DF;
wire [31:0] vf7d = In_register_EBP;
wire vf7e = vf7d == Out_register_EBP;
wire [31:0] vf80 = In_register_FSBASE;
wire vf81 = vf80 == Out_register_FSBASE;
wire [31:0] vf83 = In_register_CSBASE;
wire vf84 = vf83 == Out_register_CSBASE;
wire vf85 = v17;
wire vf86 = vf85 == Out_register_CF;
wire [31:0] vf88 = In_register_ESP;
wire vf89 = vf88 == Out_register_ESP;
wire [31:0] vf8b = In_register_ESBASE;
wire vf8c = vf8b == Out_register_ESBASE;
wire [31:0] vf8e = In_register_GSBASE;
wire vf8f = vf8e == Out_register_GSBASE;
wire [2:0] vf90_aux = vf50[0] + vf50[1] + vf50[2] + vf50[3] + vf50[4] + vf50[5] + vf50[6] + vf50[7];
wire vf90 = { 5'b00000, vf90_aux };
wire [7:0] vf91 = vf90 & v18;
wire [7:0] vf92 = vf91 ^ v18;
wire vf93 = vf92[0:0];
wire vf95 = vf93;
wire vf96 = vf95 == Out_register_PF;
wire vf97 = vf50 == v2c;
wire vf99 = vf97;
wire vf9a = vf99 == Out_register_ZF;
wire vf9b = vf43 & vf46 & vf54 & v15c & vf55 & vf58 & vf5f & vf40 & vf62 & vf65 & vf67 & vf6f & vf72 & vf75 & vf78 & vf7b & vf7e & vf81 & vf84 & vf86 & vf89 & vf8c & vf8f & vf96 & vf9a;
wire [10:0] v57 = 11'b01000100101;
wire vf9c = v57 == v6d7;
wire vf9d = v35 == v316;
wire vf9e = v14 == v1ef;
wire vf9f = vf9c & vf9d & vf9e;
wire [18:0] v58 = 19'b0010011001000100101;
wire vfa0 = v58 == vdfa;
wire vfa1 = v35 == v119;
wire vfa2 = v43 == vab3;
wire vfa3 = vfa0 & vfa1 & vfa2;
wire vfa4 = vf9f | vfa3;
wire vfa5 = vfa4;
wire [31:0] vfa7 = In_register_ESI;
wire vfa8 = vfa7 == Out_register_ESI;
wire vfa9 = In_error_flag == Out_error_flag;
wire [31:0] vfab = In_register_EDI;
wire vfac = vfab == Out_register_EDI;
wire [31:0] vfaf = ( vfa3 ) ? vc2d : v1f7;
wire vfb0 =  v2a == memory_0[15: 12] && vfaf == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] vfb2 = In_register_ESBASE;
wire vfb3 = vfb2 == Out_register_ESBASE;
wire [2:0] vfd7 = { v320 };
wire vfd8 = vfd7 == ve;
wire vfd9 = vfd8;
wire vfda = vf9f & vfd9;
wire [2:0] vfdb = { v12c };
wire vfdc = vfdb == ve;
wire vfdd = vfdc;
wire vfde = vfa3 & vfdd;
wire vfdf = vfda | vfde;
wire [31:0] vfb4 = memory_0[79: 48];
wire [7:0] vfb5 = vfb4[7:0];
wire [2:0] vfb6 = { v320 };
wire [31:0] vfb7 = ( vfb6 == 3'd0) ? In_register_EAX : 
	( vfb6 == 3'd1) ? In_register_ECX : 
	( vfb6 == 3'd2) ? In_register_EDX : 
	( vfb6 == 3'd3) ? In_register_EBX : 
	( vfb6 == 3'd4) ? In_register_EAX : 
	( vfb6 == 3'd5) ? In_register_ECX : 
	( vfb6 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vfb8 = { v320 };
wire vfb9 = vfb8 == vb;
wire vfba = vfb8 == v9;
wire vfbb = vfb9 | vfba;
wire vfbc = vfb8 == vf;
wire vfbd = vfbb | vfbc;
wire vfbe = vfb8 == v11;
wire vfbf = vfbd | vfbe;
wire [31:0] vfc0 = ( vfbf == 1'd0) ? v15 : v31;
wire [31:0] vfc1 = vfb7 >> vfc0;
wire [31:0] vfc2 = vfc1 & v32;
wire [2:0] vfc4 = { v12c };
wire [31:0] vfc5 = ( vfc4 == 3'd0) ? In_register_EAX : 
	( vfc4 == 3'd1) ? In_register_ECX : 
	( vfc4 == 3'd2) ? In_register_EDX : 
	( vfc4 == 3'd3) ? In_register_EBX : 
	( vfc4 == 3'd4) ? In_register_EAX : 
	( vfc4 == 3'd5) ? In_register_ECX : 
	( vfc4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] vfc6 = { v12c };
wire vfc7 = vfc6 == vb;
wire vfc8 = vfc6 == v9;
wire vfc9 = vfc7 | vfc8;
wire vfca = vfc6 == vf;
wire vfcb = vfc9 | vfca;
wire vfcc = vfc6 == v11;
wire vfcd = vfcb | vfcc;
wire [31:0] vfce = ( vfcd == 1'd0) ? v15 : v31;
wire [31:0] vfcf = vfc5 >> vfce;
wire [31:0] vfd0 = vfcf & v32;
wire [31:0] vfd2 = ( vf9f ) ? vfc2 : vfd0;
wire [7:0] vfd3 = vfd2[7:0];
wire [7:0] vfd4 = vfb5 & vfd3;
wire [31:0] vfd5 = { 24'b000000000000000000000000, vfd4 };
wire [31:0] vfd6 = v768 | vfd5;
wire vfe3 = vfd7 == v11;
wire vfe4 = vfe3;
wire vfe5 = vf9f & vfe4;
wire vfe6 = vfdb == v11;
wire vfe7 = vfe6;
wire vfe8 = vfa3 & vfe7;
wire vfe9 = vfe5 | vfe8;
wire [31:0] vfe1 = vfd5 << v31;
wire [31:0] vfe2 = v778 | vfe1;
wire [31:0] vfec = ( v8 ) ? In_register_EDX : 
	( vfdf ) ? vfd6 : vfe2;
wire [31:0] vfee = vfec;
wire vfef = vfee == Out_register_EDX;
wire vff1 = vfd7 == vd;
wire vff2 = vff1;
wire vff3 = vf9f & vff2;
wire vff4 = vfdb == vd;
wire vff5 = vff4;
wire vff6 = vfa3 & vff5;
wire vff7 = vff3 | vff6;
wire [31:0] vff0 = v7b8 | vfd5;
wire vffa = vfd7 == v9;
wire vffb = vffa;
wire vffc = vf9f & vffb;
wire vffd = vfdb == v9;
wire vffe = vffd;
wire vfff = vfa3 & vffe;
wire v1000 = vffc | vfff;
wire [31:0] vff9 = v7c8 | vfe1;
wire [31:0] v1003 = ( v8 ) ? In_register_EBX : 
	( vff7 ) ? vff0 : vff9;
wire [31:0] v1005 = v1003;
wire v1006 = v1005 == Out_register_EBX;
wire [31:0] v1008 = In_register_FSBASE;
wire v1009 = v1008 == Out_register_FSBASE;
wire [31:0] v100b = In_register_ESP;
wire v100c = v100b == Out_register_ESP;
wire [31:0] v100e = In_register_EBP;
wire v100f = v100e == Out_register_EBP;
wire [31:0] v1011 = In_register_CSBASE;
wire v1012 = v1011 == Out_register_CSBASE;
wire v1014 = v17;
wire v1015 = v1014 == Out_register_OF;
wire v1016 = v17;
wire v1017 = v1016 == Out_register_AF;
wire v1019 = vfd7 == vf;
wire v101a = v1019;
wire v101b = vf9f & v101a;
wire v101c = vfdb == vf;
wire v101d = v101c;
wire v101e = vfa3 & v101d;
wire v101f = v101b | v101e;
wire [31:0] v1018 = v790 | vfe1;
wire v1022 = vfd7 == vc;
wire v1023 = v1022;
wire v1024 = vf9f & v1023;
wire v1025 = vfdb == vc;
wire v1026 = v1025;
wire v1027 = vfa3 & v1026;
wire v1028 = v1024 | v1027;
wire [31:0] v1021 = v7a0 | vfd5;
wire [31:0] v102b = ( v8 ) ? In_register_ECX : 
	( v101f ) ? v1018 : v1021;
wire [31:0] v102d = v102b;
wire v102e = v102d == Out_register_ECX;
wire [31:0] v1030 = In_register_SSBASE;
wire v1031 = v1030 == Out_register_SSBASE;
wire [31:0] v1033 = In_register_DSBASE;
wire v1034 = v1033 == Out_register_DSBASE;
wire [31:0] v1036 = In_register_GSBASE;
wire v1037 = v1036 == Out_register_GSBASE;
wire [31:0] v103a = ( vfa3 ) ? v45 : v16;
wire [31:0] v103b = In_register_EIP + v103a;
wire [31:0] v103d = v103b;
wire v103e = v103d == Out_register_EIP;
wire v1040 = vfd7 == v7;
wire v1041 = v1040;
wire v1042 = vf9f & v1041;
wire v1043 = vfdb == v7;
wire v1044 = v1043;
wire v1045 = vfa3 & v1044;
wire v1046 = v1042 | v1045;
wire [31:0] v103f = v5c8 | vfd5;
wire v1049 = vfd7 == vb;
wire v104a = v1049;
wire v104b = vf9f & v104a;
wire v104c = vfdb == vb;
wire v104d = v104c;
wire v104e = vfa3 & v104d;
wire v104f = v104b | v104e;
wire [31:0] v1048 = v752 | vfe1;
wire [31:0] v1052 = ( v8 ) ? In_register_EAX : 
	( v1046 ) ? v103f : v1048;
wire [31:0] v1054 = v1052;
wire v1055 = v1054 == Out_register_EAX;
wire v1056 = v17;
wire v1057 = v1056 == Out_register_CF;
wire [7:0] v1059 = In_register_DF;
wire v105a = v1059 == Out_register_DF;
wire [2:0] v105b_aux = vfd4[0] + vfd4[1] + vfd4[2] + vfd4[3] + vfd4[4] + vfd4[5] + vfd4[6] + vfd4[7];
wire v105b = { 5'b00000, v105b_aux };
wire [7:0] v105c = v105b & v18;
wire [7:0] v105d = v105c ^ v18;
wire v105e = v105d[0:0];
wire v1060 = v105e;
wire v1061 = v1060 == Out_register_PF;
wire v1062 = $signed(vfd4) < $signed(v2c);
wire v1064 = v1062;
wire v1065 = v1064 == Out_register_SF;
wire v1066 = vfd4 == v2c;
wire v1068 = v1066;
wire v1069 = v1068 == Out_register_ZF;
wire v106a = vfa5 & v15c & vfa8 & vfa9 & vfac & vfb0 & vfb3 & vfef & v1006 & v1009 & v100c & v100f & v1012 & v1015 & v1017 & v102e & v1031 & v1034 & v1037 & v103e & v1055 & v1057 & v105a & v1061 & v1065 & v1069;
wire v106b = v40 == v1eb;
wire [4:0] v59 = 5'b00011;
wire v106c = v59 == v1ed;
wire v106d = v4 == v11b;
wire v106e = v106b & v106c & v106d;
wire v106f = v106e;
wire v1070 = v106f;
wire [31:0] v1072 = In_register_GSBASE;
wire v1073 = v1072 == Out_register_GSBASE;
wire [2:0] v107b = { v1fa };
wire v107c = v107b == vd;
wire v107d = v107c;
wire v107e = v106e & v107d;
wire v107f = v107e;
wire [31:0] v1075 = v63a;
wire [2:0] v1076 = { v1fa };
wire [31:0] v1077 = ( v1076 == 3'd0) ? In_register_EAX : 
	( v1076 == 3'd1) ? In_register_ECX : 
	( v1076 == 3'd2) ? In_register_EDX : 
	( v1076 == 3'd3) ? In_register_EBX : 
	( v1076 == 3'd4) ? In_register_ESP : 
	( v1076 == 3'd5) ? In_register_EBP : 
	( v1076 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1079 = v1077;
wire [31:0] v107a = v1075 + v1079;
wire [31:0] v1082 = ( v8 ) ? In_register_EBX : v107a;
wire [31:0] v1084 = v1082;
wire v1085 = v1084 == Out_register_EBX;
wire [31:0] v1087 = v10;
wire [31:0] v1088 = In_register_EIP + v1087;
wire [31:0] v108a = v1088;
wire v108b = v108a == Out_register_EIP;
wire v108c = In_error_flag == Out_error_flag;
wire v108d = v107b == v7;
wire v108e = v108d;
wire v108f = v106e & v108e;
wire v1090 = v108f;
wire [31:0] v1093 = ( v8 ) ? In_register_EAX : v107a;
wire [31:0] v1095 = v1093;
wire v1096 = v1095 == Out_register_EAX;
wire v1097 = v107a < v1079;
wire v1098 = v107a < v1075;
wire v1099 = v1097 | v1098;
wire v109b = v1099;
wire v109c = v109b == Out_register_CF;
wire v109d = v107b == ve;
wire v109e = v109d;
wire v109f = v106e & v109e;
wire v10a0 = v109f;
wire [31:0] v10a3 = ( v8 ) ? In_register_EDX : v107a;
wire [31:0] v10a5 = v10a3;
wire v10a6 = v10a5 == Out_register_EDX;
wire v10a7 = v107b == vb;
wire v10a8 = v10a7;
wire v10a9 = v106e & v10a8;
wire v10aa = v10a9;
wire [31:0] v10ad = ( v8 ) ? In_register_ESP : v107a;
wire [31:0] v10af = v10ad;
wire v10b0 = v10af == Out_register_ESP;
wire v10b1 = v107b == v11;
wire v10b2 = v10b1;
wire v10b3 = v106e & v10b2;
wire v10b4 = v10b3;
wire [31:0] v10b7 = ( v8 ) ? In_register_ESI : v107a;
wire [31:0] v10b9 = v10b7;
wire v10ba = v10b9 == Out_register_ESI;
wire v10bb = v107b == vf;
wire v10bc = v10bb;
wire v10bd = v106e & v10bc;
wire v10be = v10bd;
wire [31:0] v10c1 = ( v8 ) ? In_register_EBP : v107a;
wire [31:0] v10c3 = v10c1;
wire v10c4 = v10c3 == Out_register_EBP;
wire v10c5 = v107b == vc;
wire v10c6 = v10c5;
wire v10c7 = v106e & v10c6;
wire v10c8 = v10c7;
wire [31:0] v10cb = ( v8 ) ? In_register_ECX : v107a;
wire [31:0] v10cd = v10cb;
wire v10ce = v10cd == Out_register_ECX;
wire v10cf = v107b == v9;
wire v10d0 = v10cf;
wire v10d1 = v106e & v10d0;
wire v10d2 = v10d1;
wire [31:0] v10d5 = ( v8 ) ? In_register_EDI : v107a;
wire [31:0] v10d7 = v10d5;
wire v10d8 = v10d7 == Out_register_EDI;
wire [31:0] v10da = In_register_SSBASE;
wire v10db = v10da == Out_register_SSBASE;
wire [31:0] v10dd = In_register_ESBASE;
wire v10de = v10dd == Out_register_ESBASE;
wire [31:0] v10e0 = In_register_DSBASE;
wire v10e1 = v10e0 == Out_register_DSBASE;
wire [7:0] v10e3 = In_register_DF;
wire v10e4 = v10e3 == Out_register_DF;
wire [7:0] v10e5 = v107a[7:0];
wire [2:0] v10e6_aux = v10e5[0] + v10e5[1] + v10e5[2] + v10e5[3] + v10e5[4] + v10e5[5] + v10e5[6] + v10e5[7];
wire v10e6 = { 5'b00000, v10e6_aux };
wire [7:0] v10e7 = v10e6 & v18;
wire [7:0] v10e8 = v10e7 ^ v18;
wire v10e9 = v10e8[0:0];
wire v10eb = v10e9;
wire v10ec = v10eb == Out_register_PF;
wire [31:0] v10ee = In_register_FSBASE;
wire v10ef = v10ee == Out_register_FSBASE;
wire v10f0 = $signed(v107a) < $signed(v15);
wire v10f2 = v10f0;
wire v10f3 = v10f2 == Out_register_SF;
wire [31:0] v10f4 = v107a ^ v1079;
wire [31:0] v10f5 = v10f4 >> v1e;
wire [31:0] v10f6 = v107a ^ v1075;
wire [31:0] v10f7 = v10f6 >> v1e;
wire [31:0] v10f8 = v10f5 + v10f7;
wire v10f9 = v10f8 == v1c;
wire v10fb = v10f9;
wire v10fc = v10fb == Out_register_OF;
wire [31:0] v10fd = v10f6 ^ v1079;
wire [7:0] v10fe = v10fd[7:0];
wire [7:0] v10ff = v10fe >> v1d;
wire [7:0] v1100 = v10ff & v18;
wire v1101 = v1100[0:0];
wire v1103 = v1101;
wire v1104 = v1103 == Out_register_AF;
wire [31:0] v1106 = In_register_CSBASE;
wire v1107 = v1106 == Out_register_CSBASE;
wire v1108 = v107a == v15;
wire v110a = v1108;
wire v110b = v110a == Out_register_ZF;
wire v110c = v1073 & v1085 & v15c & v108b & v108c & v1096 & v109c & v10a6 & v10b0 & v10ba & v10c4 & v10ce & v10d8 & v10db & v10de & v10e1 & v10e4 & v1070 & v10ec & v10ef & v10f3 & v10fc & v1104 & v1107 & v110b;
wire [7:0] v5a = 8'b11000100;
wire v110d = v5a == v1eb;
wire v110e = v35 == v316;
wire v110f = v1b == v318;
wire [2:0] v1110 = { v1fa };
wire v1111 = v1110 == vb;
wire v1112 = v1110 == vf;
wire v1113 = v1111 | v1112;
wire v1114 = v1113 ^ v8;
wire [2:0] v1115 = { v1fa };
wire v1116 = v1115 == vb;
wire v1117 = v1115 == vf;
wire v1118 = v1116 | v1117;
wire v1119 = v1118 ^ v8;
wire v111a = v1114 & v1119;
wire v111b = v110d & v110e & v110f & v111a;
wire [10:0] v5b = 11'b11000100001;
wire v111c = v5b == v6d7;
wire v111d = v35 == v316;
wire v111e = v4 == v11b;
wire [2:0] v111f = { v13c };
wire v1120 = v111f == vb;
wire v1121 = v111f == vf;
wire v1122 = v1120 | v1121;
wire v1123 = v1122 ^ v8;
wire [2:0] v1124 = { v12c };
wire v1125 = v1124 == vb;
wire v1126 = v1125;
wire v1127 = v1126 ^ v8;
wire [2:0] v1128 = { v13c };
wire v1129 = v1128 == vf;
wire v112a = v1129;
wire v112b = v112a ^ v8;
wire v112c = v1123 & v1127 & v112b;
wire v112d = v111c & v111d & v111e & v112c;
wire v112e = v5a == v1eb;
wire v112f = v8 == v829;
wire v1130 = v30 == v316;
wire v1131 = v4 == v11b;
wire v1132 = v112e & v112f & v1130 & v1131;
wire v1133 = v111b | v112d | v1132;
wire v1134 = v1133;
wire [2:0] v1141 = { v320 };
wire v1142 = v1141 == ve;
wire v1143 = v1142;
wire v1144 = v111b & v1143;
wire [2:0] v1145 = { v320 };
wire v1146 = v1145 == ve;
wire v1147 = v1146;
wire v1148 = v112d & v1147;
wire [2:0] v1149 = { v320 };
wire v114a = v1149 == ve;
wire v114b = v114a;
wire v114c = v1132 & v114b;
wire v114d = v1144 | v1148 | v114c;
wire [31:0] v1135 = memory_0[79: 48];
wire [2:0] v113c = { v320 };
wire [31:0] v113d = ( v113c == 3'd0) ? In_register_EAX : 
	( v113c == 3'd1) ? In_register_ECX : 
	( v113c == 3'd2) ? In_register_EDX : 
	( v113c == 3'd3) ? In_register_EBX : 
	( v113c == 3'd4) ? In_register_ESP : 
	( v113c == 3'd5) ? In_register_EBP : 
	( v113c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1139 = { v320 };
wire [31:0] v113a = ( v1139 == 3'd0) ? In_register_EAX : 
	( v1139 == 3'd1) ? In_register_ECX : 
	( v1139 == 3'd2) ? In_register_EDX : 
	( v1139 == 3'd3) ? In_register_EBX : 
	( v1139 == 3'd4) ? In_register_ESP : 
	( v1139 == 3'd5) ? In_register_EBP : 
	( v1139 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1136 = { v320 };
wire [31:0] v1137 = ( v1136 == 3'd0) ? In_register_EAX : 
	( v1136 == 3'd1) ? In_register_ECX : 
	( v1136 == 3'd2) ? In_register_EDX : 
	( v1136 == 3'd3) ? In_register_EBX : 
	( v1136 == 3'd4) ? In_register_ESP : 
	( v1136 == 3'd5) ? In_register_EBP : 
	( v1136 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v113f = ( v1132 ) ? v113d : 
	( v112d ) ? v113a : v1137;
wire [31:0] v1140 = v1135 & v113f;
wire [31:0] v1150 = ( v8 ) ? In_register_EDX : v1140;
wire [31:0] v1152 = v1150;
wire v1153 = v1152 == Out_register_EDX;
wire v1154 = v1141 == vd;
wire v1155 = v1154;
wire v1156 = v111b & v1155;
wire v1157 = v1145 == vd;
wire v1158 = v1157;
wire v1159 = v112d & v1158;
wire v115a = v1149 == vd;
wire v115b = v115a;
wire v115c = v1132 & v115b;
wire v115d = v1156 | v1159 | v115c;
wire [31:0] v1160 = ( v8 ) ? In_register_EBX : v1140;
wire [31:0] v1162 = v1160;
wire v1163 = v1162 == Out_register_EBX;
wire [2:0] v1167 = { v13c };
wire [31:0] v1168 = ( v1167 == 3'd0) ? In_register_EAX : 
	( v1167 == 3'd1) ? In_register_ECX : 
	( v1167 == 3'd2) ? In_register_EDX : 
	( v1167 == 3'd3) ? In_register_EBX : 
	( v1167 == 3'd4) ? v15 : 
	( v1167 == 3'd5) ? v15 : 
	( v1167 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1169 = { v12c };
wire [31:0] v116a = ( v1169 == 3'd0) ? In_register_EAX : 
	( v1169 == 3'd1) ? In_register_ECX : 
	( v1169 == 3'd2) ? In_register_EDX : 
	( v1169 == 3'd3) ? In_register_EBX : 
	( v1169 == 3'd4) ? v15 : 
	( v1169 == 3'd5) ? In_register_EBP : 
	( v1169 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v116b = v116a << v7f4;
wire [31:0] v116c = v1168 + v116b;
wire [1:0] v116e = { v889 , v888 };
wire [31:0] v116f = ( v116e == 2'd0) ? In_register_EDX : 
	( v116e == 2'd1) ? In_register_ESI : 
	( v116e == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v1170 = v116f + v63a;
wire [2:0] v1164 = { v1fa };
wire [31:0] v1165 = ( v1164 == 3'd0) ? In_register_EAX : 
	( v1164 == 3'd1) ? In_register_ECX : 
	( v1164 == 3'd2) ? In_register_EDX : 
	( v1164 == 3'd3) ? In_register_EBX : 
	( v1164 == 3'd4) ? v15 : 
	( v1164 == 3'd5) ? v15 : 
	( v1164 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1172 = ( v112d ) ? v116c : 
	( v1132 ) ? v1170 : v1165;
wire v1173 =  v26 == memory_0[15: 12] && v1172 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v1174 = v1141 == v11;
wire v1175 = v1174;
wire v1176 = v111b & v1175;
wire v1177 = v1145 == v11;
wire v1178 = v1177;
wire v1179 = v112d & v1178;
wire v117a = v1149 == v11;
wire v117b = v117a;
wire v117c = v1132 & v117b;
wire v117d = v1176 | v1179 | v117c;
wire [31:0] v1180 = ( v8 ) ? In_register_ESI : v1140;
wire [31:0] v1182 = v1180;
wire v1183 = v1182 == Out_register_ESI;
wire v1184 = v1141 == vf;
wire v1185 = v1184;
wire v1186 = v111b & v1185;
wire v1187 = v1145 == vf;
wire v1188 = v1187;
wire v1189 = v112d & v1188;
wire v118a = v1149 == vf;
wire v118b = v118a;
wire v118c = v1132 & v118b;
wire v118d = v1186 | v1189 | v118c;
wire [31:0] v1190 = ( v8 ) ? In_register_EBP : v1140;
wire [31:0] v1192 = v1190;
wire v1193 = v1192 == Out_register_EBP;
wire v1194 = v1141 == vc;
wire v1195 = v1194;
wire v1196 = v111b & v1195;
wire v1197 = v1145 == vc;
wire v1198 = v1197;
wire v1199 = v112d & v1198;
wire v119a = v1149 == vc;
wire v119b = v119a;
wire v119c = v1132 & v119b;
wire v119d = v1196 | v1199 | v119c;
wire [31:0] v11a0 = ( v8 ) ? In_register_ECX : v1140;
wire [31:0] v11a2 = v11a0;
wire v11a3 = v11a2 == Out_register_ECX;
wire [31:0] v11a7 = ( v111b ) ? v1c : v10;
wire [31:0] v11a8 = In_register_EIP + v11a7;
wire [31:0] v11aa = v11a8;
wire v11ab = v11aa == Out_register_EIP;
wire v11ad = v17;
wire v11ae = v11ad == Out_register_CF;
wire v11af = v1141 == v9;
wire v11b0 = v11af;
wire v11b1 = v111b & v11b0;
wire v11b2 = v1145 == v9;
wire v11b3 = v11b2;
wire v11b4 = v112d & v11b3;
wire v11b5 = v1149 == v9;
wire v11b6 = v11b5;
wire v11b7 = v1132 & v11b6;
wire v11b8 = v11b1 | v11b4 | v11b7;
wire [31:0] v11bb = ( v8 ) ? In_register_EDI : v1140;
wire [31:0] v11bd = v11bb;
wire v11be = v11bd == Out_register_EDI;
wire v11bf = v17;
wire v11c0 = v11bf == Out_register_OF;
wire v11c1 = In_error_flag == Out_error_flag;
wire v11c2 = v1141 == v7;
wire v11c3 = v11c2;
wire v11c4 = v111b & v11c3;
wire v11c5 = v1145 == v7;
wire v11c6 = v11c5;
wire v11c7 = v112d & v11c6;
wire v11c8 = v1149 == v7;
wire v11c9 = v11c8;
wire v11ca = v1132 & v11c9;
wire v11cb = v11c4 | v11c7 | v11ca;
wire [31:0] v11ce = ( v8 ) ? In_register_EAX : v1140;
wire [31:0] v11d0 = v11ce;
wire v11d1 = v11d0 == Out_register_EAX;
wire [31:0] v11d3 = In_register_CSBASE;
wire v11d4 = v11d3 == Out_register_CSBASE;
wire v11d5 = v1140 == v15;
wire v11d7 = v11d5;
wire v11d8 = v11d7 == Out_register_ZF;
wire [31:0] v11da = In_register_SSBASE;
wire v11db = v11da == Out_register_SSBASE;
wire [31:0] v11dd = In_register_GSBASE;
wire v11de = v11dd == Out_register_GSBASE;
wire [7:0] v11df = v1140[7:0];
wire [2:0] v11e0_aux = v11df[0] + v11df[1] + v11df[2] + v11df[3] + v11df[4] + v11df[5] + v11df[6] + v11df[7];
wire v11e0 = { 5'b00000, v11e0_aux };
wire [7:0] v11e1 = v11e0 & v18;
wire [7:0] v11e2 = v11e1 ^ v18;
wire v11e3 = v11e2[0:0];
wire v11e5 = v11e3;
wire v11e6 = v11e5 == Out_register_PF;
wire [31:0] v11e8 = In_register_ESBASE;
wire v11e9 = v11e8 == Out_register_ESBASE;
wire v11ea = v1141 == vb;
wire v11eb = v11ea;
wire v11ec = v111b & v11eb;
wire v11ed = v1145 == vb;
wire v11ee = v11ed;
wire v11ef = v112d & v11ee;
wire v11f0 = v1149 == vb;
wire v11f1 = v11f0;
wire v11f2 = v1132 & v11f1;
wire v11f3 = v11ec | v11ef | v11f2;
wire [31:0] v11f6 = ( v8 ) ? In_register_ESP : v1140;
wire [31:0] v11f8 = v11f6;
wire v11f9 = v11f8 == Out_register_ESP;
wire [31:0] v11fb = In_register_DSBASE;
wire v11fc = v11fb == Out_register_DSBASE;
wire [31:0] v11fe = In_register_FSBASE;
wire v11ff = v11fe == Out_register_FSBASE;
wire v1200 = v17;
wire v1201 = v1200 == Out_register_AF;
wire [7:0] v1203 = In_register_DF;
wire v1204 = v1203 == Out_register_DF;
wire v1205 = $signed(v1140) < $signed(v15);
wire v1207 = v1205;
wire v1208 = v1207 == Out_register_SF;
wire v1209 = v1134 & v1153 & v1163 & v1173 & v1183 & v1193 & v11a3 & v11ab & v11ae & v11be & v11c0 & v11c1 & v11d1 & v11d4 & v11d8 & v11db & v11de & v11e6 & v11e9 & v11f9 & v15c & v11fc & v11ff & v1201 & v1204 & v1208;
wire [15:0] v5c = 16'b1000000100101000;
wire v120a = v5c == v117;
wire v120b = v43 == vab3;
wire [2:0] v120c = { v13c };
wire v120d = v120c == vb;
wire v120e = v120c == vf;
wire v120f = v120d | v120e;
wire v1210 = v120f ^ v8;
wire [2:0] v1211 = { v12c };
wire v1212 = v1211 == vb;
wire v1213 = v1212;
wire v1214 = v1213 ^ v8;
wire [2:0] v1215 = { v13c };
wire v1216 = v1215 == vf;
wire v1217 = v1216;
wire v1218 = v1217 ^ v8;
wire [2:0] v1219 = { v13c };
wire v121a = v1219 == vb;
wire v121b = v1219 == vf;
wire v121c = v121a | v121b;
wire v121d = v121c ^ v8;
wire [2:0] v121e = { v12c };
wire v121f = v121e == vb;
wire v1220 = v121f;
wire v1221 = v1220 ^ v8;
wire [2:0] v1222 = { v13c };
wire v1223 = v1222 == vf;
wire v1224 = v1223;
wire v1225 = v1224 ^ v8;
wire v1226 = v1210 & v1214 & v1218 & v121d & v1221 & v1225;
wire v1227 = v120a & v120b & v1226;
wire v1228 = v1227;
wire v1229 = v1228;
wire [31:0] v122b = In_register_ECX;
wire v122c = v122b == Out_register_ECX;
wire [31:0] v122e = v45;
wire [31:0] v122f = In_register_EIP + v122e;
wire [31:0] v1231 = v122f;
wire v1232 = v1231 == Out_register_EIP;
wire [31:0] v1234 = In_register_EAX;
wire v1235 = v1234 == Out_register_EAX;
wire v1236 = In_error_flag == Out_error_flag;
wire [2:0] v1237 = { v13c };
wire [31:0] v1238 = ( v1237 == 3'd0) ? In_register_EAX : 
	( v1237 == 3'd1) ? In_register_ECX : 
	( v1237 == 3'd2) ? In_register_EDX : 
	( v1237 == 3'd3) ? In_register_EBX : 
	( v1237 == 3'd4) ? v15 : 
	( v1237 == 3'd5) ? v15 : 
	( v1237 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1239 = { v12c };
wire [31:0] v123a = ( v1239 == 3'd0) ? In_register_EAX : 
	( v1239 == 3'd1) ? In_register_ECX : 
	( v1239 == 3'd2) ? In_register_EDX : 
	( v1239 == 3'd3) ? In_register_EBX : 
	( v1239 == 3'd4) ? v15 : 
	( v1239 == 3'd5) ? In_register_EBP : 
	( v1239 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v123b = v123a << v7f4;
wire [31:0] v123c = v1238 + v123b;
wire [31:0] v123e = v123c;
wire [31:0] v123f = memory_0[79: 48];
wire [31:0] v1241 = vc2d;
wire [31:0] v1242 = v123f + v1241;
wire [31:0] v1243 = v1242 + vb11;
wire v1244 =  v26 == memory_1[15: 12] && v123e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v1243 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [2:0] v1245 = { v13c };
wire [31:0] v1246 = ( v1245 == 3'd0) ? In_register_EAX : 
	( v1245 == 3'd1) ? In_register_ECX : 
	( v1245 == 3'd2) ? In_register_EDX : 
	( v1245 == 3'd3) ? In_register_EBX : 
	( v1245 == 3'd4) ? v15 : 
	( v1245 == 3'd5) ? v15 : 
	( v1245 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1247 = { v12c };
wire [31:0] v1248 = ( v1247 == 3'd0) ? In_register_EAX : 
	( v1247 == 3'd1) ? In_register_ECX : 
	( v1247 == 3'd2) ? In_register_EDX : 
	( v1247 == 3'd3) ? In_register_EBX : 
	( v1247 == 3'd4) ? v15 : 
	( v1247 == 3'd5) ? In_register_EBP : 
	( v1247 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1249 = v1248 << v7f4;
wire [31:0] v124a = v1246 + v1249;
wire [31:0] v124c = v124a;
wire v124d =  v26 == memory_0[15: 12] && v124c == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v124f = In_register_FSBASE;
wire v1250 = v124f == Out_register_FSBASE;
wire [31:0] v1252 = In_register_EBX;
wire v1253 = v1252 == Out_register_EBX;
wire [31:0] v1255 = In_register_SSBASE;
wire v1256 = v1255 == Out_register_SSBASE;
wire [31:0] v1258 = In_register_ESI;
wire v1259 = v1258 == Out_register_ESI;
wire [31:0] v125a = v1243 ^ v123f;
wire [31:0] v125b = v125a >> v1e;
wire [31:0] v125c = v1243 ^ v1241;
wire [31:0] v125d = v125c >> v1e;
wire [31:0] v125e = v125b + v125d;
wire v125f = v125e == v1c;
wire v1261 = v125f;
wire v1262 = v1261 == Out_register_OF;
wire [31:0] v1264 = In_register_DSBASE;
wire v1265 = v1264 == Out_register_DSBASE;
wire [7:0] v1267 = In_register_DF;
wire v1268 = v1267 == Out_register_DF;
wire [31:0] v126a = In_register_EDI;
wire v126b = v126a == Out_register_EDI;
wire [31:0] v126d = In_register_ESP;
wire v126e = v126d == Out_register_ESP;
wire [31:0] v1270 = In_register_EBP;
wire v1271 = v1270 == Out_register_EBP;
wire [31:0] v1273 = In_register_CSBASE;
wire v1274 = v1273 == Out_register_CSBASE;
wire [31:0] v1276 = In_register_ESBASE;
wire v1277 = v1276 == Out_register_ESBASE;
wire [31:0] v1279 = In_register_GSBASE;
wire v127a = v1279 == Out_register_GSBASE;
wire [31:0] v127c = In_register_EDX;
wire v127d = v127c == Out_register_EDX;
wire [31:0] v127e = v125c ^ v123f;
wire [7:0] v127f = v127e[7:0];
wire [7:0] v1280 = v127f >> v1d;
wire [7:0] v1281 = v1280 & v18;
wire v1282 = v1281[0:0];
wire v1284 = v1282;
wire v1285 = v1284 == Out_register_AF;
wire v1286 = v1242 < v123f;
wire v1287 = v1242 < v1241;
wire v1288 = v1286 | v1287;
wire v1289 = v1243 < v1242;
wire v128a = v1243 < vb11;
wire v128b = v1289 | v128a;
wire [7:0] v128c = { 7'b0000000, v128b };
wire [7:0] v128d = ( v1288 == 1'd0) ? v128c : v18;
wire v128e = v128d[0:0];
wire v1290 = v128e;
wire v1291 = v1290 == Out_register_CF;
wire [7:0] v1292 = v1243[7:0];
wire [2:0] v1293_aux = v1292[0] + v1292[1] + v1292[2] + v1292[3] + v1292[4] + v1292[5] + v1292[6] + v1292[7];
wire v1293 = { 5'b00000, v1293_aux };
wire [7:0] v1294 = v1293 & v18;
wire [7:0] v1295 = v1294 ^ v18;
wire v1296 = v1295[0:0];
wire v1298 = v1296;
wire v1299 = v1298 == Out_register_PF;
wire v129a = $signed(v1243) < $signed(v15);
wire v129c = v129a;
wire v129d = v129c == Out_register_SF;
wire v129e = v1243 == v15;
wire v12a0 = v129e;
wire v12a1 = v12a0 == Out_register_ZF;
wire v12a2 = v122c & v1232 & v1235 & v1236 & v1244 & v124d & v1250 & v1253 & v1256 & v1259 & v1229 & v1262 & v1265 & v1268 & v126b & v126e & v1271 & v1274 & v1277 & v15c & v127a & v127d & v1285 & v1291 & v1299 & v129d & v12a1;
wire [7:0] v5d = 8'b00010000;
wire v12a3 = v5d == v1eb;
wire v12a4 = v3 == v316;
wire v12a5 = v1b == v318;
wire v12a6 = v12a3 & v12a4 & v12a5;
wire v12a7 = v12a6;
wire v12a8 = v12a7;
wire [31:0] v12aa = In_register_ESP;
wire v12ab = v12aa == Out_register_ESP;
wire v12ac = In_error_flag == Out_error_flag;
wire [2:0] v12cf = { v1fa };
wire v12d0 = v12cf == vd;
wire v12d1 = v12d0;
wire v12d2 = v12a6 & v12d1;
wire v12d3 = v12d2;
wire [2:0] v12ad = { v320 };
wire [31:0] v12ae = ( v12ad == 3'd0) ? In_register_EAX : 
	( v12ad == 3'd1) ? In_register_ECX : 
	( v12ad == 3'd2) ? In_register_EDX : 
	( v12ad == 3'd3) ? In_register_EBX : 
	( v12ad == 3'd4) ? In_register_EAX : 
	( v12ad == 3'd5) ? In_register_ECX : 
	( v12ad == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v12af = { v320 };
wire v12b0 = v12af == vb;
wire v12b1 = v12af == v9;
wire v12b2 = v12b0 | v12b1;
wire v12b3 = v12af == vf;
wire v12b4 = v12b2 | v12b3;
wire v12b5 = v12af == v11;
wire v12b6 = v12b4 | v12b5;
wire [31:0] v12b7 = ( v12b6 == 1'd0) ? v15 : v31;
wire [31:0] v12b8 = v12ae >> v12b7;
wire [31:0] v12b9 = v12b8 & v32;
wire [31:0] v12bb = v12b9;
wire [2:0] v12bc = { v1fa };
wire [31:0] v12bd = ( v12bc == 3'd0) ? In_register_EAX : 
	( v12bc == 3'd1) ? In_register_ECX : 
	( v12bc == 3'd2) ? In_register_EDX : 
	( v12bc == 3'd3) ? In_register_EBX : 
	( v12bc == 3'd4) ? In_register_EAX : 
	( v12bc == 3'd5) ? In_register_ECX : 
	( v12bc == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v12be = { v1fa };
wire v12bf = v12be == vb;
wire v12c0 = v12be == v9;
wire v12c1 = v12bf | v12c0;
wire v12c2 = v12be == vf;
wire v12c3 = v12c1 | v12c2;
wire v12c4 = v12be == v11;
wire v12c5 = v12c3 | v12c4;
wire [31:0] v12c6 = ( v12c5 == 1'd0) ? v15 : v31;
wire [31:0] v12c7 = v12bd >> v12c6;
wire [31:0] v12c8 = v12c7 & v32;
wire [31:0] v12ca = v12c8;
wire [31:0] v12cb = v12bb | v12ca;
wire [7:0] v12cc = v12cb[7:0];
wire [31:0] v12cd = { 24'b000000000000000000000000, v12cc };
wire [31:0] v12ce = v7b8 | v12cd;
wire v12d7 = v12cf == v9;
wire v12d8 = v12d7;
wire v12d9 = v12a6 & v12d8;
wire v12da = v12d9;
wire [31:0] v12d5 = v12cd << v31;
wire [31:0] v12d6 = v7c8 | v12d5;
wire [31:0] v12dd = ( v8 ) ? In_register_EBX : 
	( v12d3 ) ? v12ce : v12d6;
wire [31:0] v12df = v12dd;
wire v12e0 = v12df == Out_register_EBX;
wire v12e2 = v12cf == ve;
wire v12e3 = v12e2;
wire v12e4 = v12a6 & v12e3;
wire v12e5 = v12e4;
wire [31:0] v12e1 = v768 | v12cd;
wire v12e8 = v12cf == v11;
wire v12e9 = v12e8;
wire v12ea = v12a6 & v12e9;
wire v12eb = v12ea;
wire [31:0] v12e7 = v778 | v12d5;
wire [31:0] v12ee = ( v8 ) ? In_register_EDX : 
	( v12e5 ) ? v12e1 : v12e7;
wire [31:0] v12f0 = v12ee;
wire v12f1 = v12f0 == Out_register_EDX;
wire v12f2 = v12cc == v2c;
wire v12f4 = v12f2;
wire v12f5 = v12f4 == Out_register_ZF;
wire [31:0] v12f7 = In_register_ESI;
wire v12f8 = v12f7 == Out_register_ESI;
wire v1300 = v12cf == vc;
wire v1301 = v1300;
wire v1302 = v12a6 & v1301;
wire v1303 = v1302;
wire [31:0] v12ff = v7a0 | v12cd;
wire v12fa = v12cf == vf;
wire v12fb = v12fa;
wire v12fc = v12a6 & v12fb;
wire v12fd = v12fc;
wire [31:0] v12f9 = v790 | v12d5;
wire [31:0] v1306 = ( v8 ) ? In_register_ECX : 
	( v1303 ) ? v12ff : v12f9;
wire [31:0] v1308 = v1306;
wire v1309 = v1308 == Out_register_ECX;
wire [31:0] v130b = In_register_EDI;
wire v130c = v130b == Out_register_EDI;
wire v130e = v17;
wire v130f = v130e == Out_register_OF;
wire [31:0] v1311 = v1c;
wire [31:0] v1312 = In_register_EIP + v1311;
wire [31:0] v1314 = v1312;
wire v1315 = v1314 == Out_register_EIP;
wire [31:0] v1317 = In_register_CSBASE;
wire v1318 = v1317 == Out_register_CSBASE;
wire [7:0] v131a = In_register_DF;
wire v131b = v131a == Out_register_DF;
wire v1323 = v12cf == vb;
wire v1324 = v1323;
wire v1325 = v12a6 & v1324;
wire v1326 = v1325;
wire [31:0] v1322 = v752 | v12d5;
wire v131d = v12cf == v7;
wire v131e = v131d;
wire v131f = v12a6 & v131e;
wire v1320 = v131f;
wire [31:0] v131c = v5c8 | v12cd;
wire [31:0] v1329 = ( v8 ) ? In_register_EAX : 
	( v1326 ) ? v1322 : v131c;
wire [31:0] v132b = v1329;
wire v132c = v132b == Out_register_EAX;
wire [31:0] v132e = In_register_SSBASE;
wire v132f = v132e == Out_register_SSBASE;
wire [31:0] v1331 = In_register_ESBASE;
wire v1332 = v1331 == Out_register_ESBASE;
wire v1333 = $signed(v12cc) < $signed(v2c);
wire v1335 = v1333;
wire v1336 = v1335 == Out_register_SF;
wire [31:0] v1338 = In_register_DSBASE;
wire v1339 = v1338 == Out_register_DSBASE;
wire [31:0] v133b = In_register_EBP;
wire v133c = v133b == Out_register_EBP;
wire [2:0] v133d_aux = v12cc[0] + v12cc[1] + v12cc[2] + v12cc[3] + v12cc[4] + v12cc[5] + v12cc[6] + v12cc[7];
wire v133d = { 5'b00000, v133d_aux };
wire [7:0] v133e = v133d & v18;
wire [7:0] v133f = v133e ^ v18;
wire v1340 = v133f[0:0];
wire v1342 = v1340;
wire v1343 = v1342 == Out_register_PF;
wire v1345 = In_register_AF;
wire v1346 = v1345 == Out_register_AF;
wire [31:0] v1348 = In_register_FSBASE;
wire v1349 = v1348 == Out_register_FSBASE;
wire v134a = v17;
wire v134b = v134a == Out_register_CF;
wire [31:0] v134d = In_register_GSBASE;
wire v134e = v134d == Out_register_GSBASE;
wire v134f = v12a8 & v12ab & v12ac & v12e0 & v12f1 & v12f5 & v12f8 & v1309 & v130c & v130f & v1315 & v1318 & v131b & v132c & v132f & v1332 & v15c & v1336 & v1339 & v133c & v1343 & v1346 & v1349 & v134b & v134e;
wire [7:0] v5e = 8'b00111110;
wire v1350 = v5e == v1eb;
wire v1351 = v1b == v318;
wire v1352 = v1350 & v1351;
wire v1353 = v1352;
wire v1354 = v1353;
wire [31:0] v1356 = In_register_ECX;
wire v1357 = v1356 == Out_register_ECX;
wire [31:0] v1359 = In_register_EDX;
wire v135a = v1359 == Out_register_EDX;
wire [31:0] v135c = In_register_EAX;
wire v135d = v135c == Out_register_EAX;
wire [31:0] v135f = In_register_EDI;
wire v1360 = v135f == Out_register_EDI;
wire [31:0] v1363 = v1c;
wire [31:0] v1364 = In_register_EIP + v1363;
wire v1361 = In_register_SF ^ In_register_OF;
wire [31:0] v1366 = v1364;
wire [31:0] v1367 = v1364 + v477;
wire [31:0] v1369 = v1367;
wire [31:0] v136a = ( v1361 == 1'd0) ? v1366 : v1369;
wire [31:0] v136d = ( v8 ) ? v1364 : v136a;
wire [31:0] v136f = v136d;
wire v1370 = v136f == Out_register_EIP;
wire v1372 = In_register_CF;
wire v1373 = v1372 == Out_register_CF;
wire [31:0] v1375 = In_register_EBX;
wire v1376 = v1375 == Out_register_EBX;
wire [31:0] v1378 = In_register_GSBASE;
wire v1379 = v1378 == Out_register_GSBASE;
wire [31:0] v137b = In_register_ESP;
wire v137c = v137b == Out_register_ESP;
wire [31:0] v137e = In_register_ESI;
wire v137f = v137e == Out_register_ESI;
wire [31:0] v1381 = In_register_EBP;
wire v1382 = v1381 == Out_register_EBP;
wire [31:0] v1384 = In_register_SSBASE;
wire v1385 = v1384 == Out_register_SSBASE;
wire [31:0] v1387 = In_register_CSBASE;
wire v1388 = v1387 == Out_register_CSBASE;
wire [7:0] v138a = In_register_DF;
wire v138b = v138a == Out_register_DF;
wire [31:0] v138d = In_register_ESBASE;
wire v138e = v138d == Out_register_ESBASE;
wire [31:0] v1390 = In_register_DSBASE;
wire v1391 = v1390 == Out_register_DSBASE;
wire v1393 = In_register_OF;
wire v1394 = v1393 == Out_register_OF;
wire v1396 = In_register_AF;
wire v1397 = v1396 == Out_register_AF;
wire [31:0] v1399 = In_register_FSBASE;
wire v139a = v1399 == Out_register_FSBASE;
wire v139c = In_register_PF;
wire v139d = v139c == Out_register_PF;
wire v139f = In_register_SF;
wire v13a0 = v139f == Out_register_SF;
wire v13a1 = In_error_flag == Out_error_flag;
wire v13a3 = In_register_ZF;
wire v13a4 = v13a3 == Out_register_ZF;
wire v13a5 = v1354 & v15c & v1357 & v135a & v135d & v1360 & v1370 & v1373 & v1376 & v1379 & v137c & v137f & v1382 & v1385 & v1388 & v138b & v138e & v1391 & v1394 & v1397 & v139a & v139d & v13a0 & v13a1 & v13a4;
wire [7:0] v5f = 8'b11010111;
wire v13a6 = v5f == v1eb;
wire v13a7 = v1b == v318;
wire v13a8 = v13a6 & v13a7;
wire v13a9 = v13a8;
wire v13aa = v13a9;
wire v13ac = In_register_PF;
wire v13ad = v13ac == Out_register_PF;
wire [31:0] v13af = In_register_ECX;
wire v13b0 = v13af == Out_register_ECX;
wire v13b1 = In_error_flag == Out_error_flag;
wire [31:0] v13b3 = In_register_EAX;
wire v13b4 = v13b3 == Out_register_EAX;
wire [31:0] v13b6 = In_register_EDX;
wire v13b7 = v13b6 == Out_register_EDX;
wire [31:0] v13b9 = In_register_EBX;
wire v13ba = v13b9 == Out_register_EBX;
wire v13bc = In_register_OF;
wire v13bd = v13bc == Out_register_OF;
wire [31:0] v13bf = In_register_ESI;
wire v13c0 = v13bf == Out_register_ESI;
wire [31:0] v13c2 = In_register_EDI;
wire v13c3 = v13c2 == Out_register_EDI;
wire [31:0] v13c5 = In_register_EBP;
wire v13c6 = v13c5 == Out_register_EBP;
wire [31:0] v13c8 = In_register_DSBASE;
wire v13c9 = v13c8 == Out_register_DSBASE;
wire v13cb = In_register_CF;
wire v13cc = v13cb == Out_register_CF;
wire [31:0] v13ce = In_register_GSBASE;
wire v13cf = v13ce == Out_register_GSBASE;
wire [31:0] v13d1 = In_register_ESP;
wire v13d2 = v13d1 == Out_register_ESP;
wire [31:0] v13d4 = v1c;
wire [31:0] v13d5 = In_register_EIP + v13d4;
wire [31:0] v13d6 = v13d5 + v477;
wire [31:0] v13d8 = v13d6;
wire [31:0] v13db = v13d8;
wire [31:0] v13dd = v13db;
wire v13de = v13dd == Out_register_EIP;
wire v13e0 = In_register_SF;
wire v13e1 = v13e0 == Out_register_SF;
wire [31:0] v13e3 = In_register_CSBASE;
wire v13e4 = v13e3 == Out_register_CSBASE;
wire [31:0] v13e6 = In_register_SSBASE;
wire v13e7 = v13e6 == Out_register_SSBASE;
wire [31:0] v13e9 = In_register_FSBASE;
wire v13ea = v13e9 == Out_register_FSBASE;
wire [31:0] v13ec = In_register_ESBASE;
wire v13ed = v13ec == Out_register_ESBASE;
wire [7:0] v13ef = In_register_DF;
wire v13f0 = v13ef == Out_register_DF;
wire v13f2 = In_register_AF;
wire v13f3 = v13f2 == Out_register_AF;
wire v13f5 = In_register_ZF;
wire v13f6 = v13f5 == Out_register_ZF;
wire v13f7 = v13aa & v13ad & v13b0 & v13b1 & v15c & v13b4 & v13b7 & v13ba & v13bd & v13c0 & v13c3 & v13c6 & v13c9 & v13cc & v13cf & v13d2 & v13de & v13e1 & v13e4 & v13e7 & v13ea & v13ed & v13f0 & v13f3 & v13f6;
wire v13f8 = In_error_flag == Out_error_flag;
wire [7:0] v60 = 8'b10011111;
wire v13f9 = v60 == v1eb;
wire v13fa = v29 == v59f;
wire v13fb = v13f9 & v13fa;
wire v13fc = v13fb;
wire v13fd = v13fc;
wire [31:0] v13ff = In_register_CSBASE;
wire v1400 = v13ff == Out_register_CSBASE;
wire [31:0] v1402 = In_register_EAX;
wire v1403 = v1402 == Out_register_EAX;
wire [7:0] v1405 = In_register_DF;
wire v1406 = v1405 == Out_register_DF;
wire [31:0] v1408 = In_register_ESI;
wire v1409 = v1408 == Out_register_ESI;
wire [31:0] v140b = In_register_FSBASE;
wire v140c = v140b == Out_register_FSBASE;
wire [31:0] v140e = In_register_EDX;
wire v140f = v140e == Out_register_EDX;
wire v1411 = v8;
wire v1412 = v1411 == Out_register_CF;
wire [31:0] v1414 = In_register_SSBASE;
wire v1415 = v1414 == Out_register_SSBASE;
wire [31:0] v1417 = In_register_ESP;
wire v1418 = v1417 == Out_register_ESP;
wire [31:0] v141a = In_register_GSBASE;
wire v141b = v141a == Out_register_GSBASE;
wire [31:0] v141d = In_register_EDI;
wire v141e = v141d == Out_register_EDI;
wire v1420 = In_register_ZF;
wire v1421 = v1420 == Out_register_ZF;
wire [31:0] v1423 = v2b;
wire [31:0] v1424 = In_register_EIP + v1423;
wire [31:0] v1426 = v1424;
wire v1427 = v1426 == Out_register_EIP;
wire [31:0] v1429 = In_register_DSBASE;
wire v142a = v1429 == Out_register_DSBASE;
wire [31:0] v142c = In_register_EBP;
wire v142d = v142c == Out_register_EBP;
wire [31:0] v142f = In_register_ESBASE;
wire v1430 = v142f == Out_register_ESBASE;
wire v1432 = In_register_SF;
wire v1433 = v1432 == Out_register_SF;
wire v1435 = In_register_AF;
wire v1436 = v1435 == Out_register_AF;
wire [31:0] v1438 = In_register_ECX;
wire v1439 = v1438 == Out_register_ECX;
wire [31:0] v143b = In_register_EBX;
wire v143c = v143b == Out_register_EBX;
wire v143e = In_register_OF;
wire v143f = v143e == Out_register_OF;
wire v1441 = In_register_PF;
wire v1442 = v1441 == Out_register_PF;
wire v1443 = v13f8 & v13fd & v1400 & v1403 & v1406 & v15c & v1409 & v140c & v140f & v1412 & v1415 & v1418 & v141b & v141e & v1421 & v1427 & v142a & v142d & v1430 & v1433 & v1436 & v1439 & v143c & v143f & v1442;
wire [7:0] v61 = 8'b10100100;
wire v1444 = v61 == v1eb;
wire v1445 = v47 == vb69;
wire v1446 = v1444 & v1445;
wire v1447 = v1446;
wire v1448 = v1447;
wire v1449 = In_error_flag == Out_error_flag;
wire [31:0] v144b = In_register_EDI;
wire v144c = v144b == Out_register_EDI;
wire [31:0] v144e = vb74;
wire [31:0] v1450 = In_register_EAX;
wire [31:0] v1451 = v144e & v1450;
wire [7:0] v1452 = v1451[7:0];
wire [2:0] v1453_aux = v1452[0] + v1452[1] + v1452[2] + v1452[3] + v1452[4] + v1452[5] + v1452[6] + v1452[7];
wire v1453 = { 5'b00000, v1453_aux };
wire [7:0] v1454 = v1453 & v18;
wire [7:0] v1455 = v1454 ^ v18;
wire v1456 = v1455[0:0];
wire v1458 = v1456;
wire v1459 = v1458 == Out_register_PF;
wire [31:0] v145b = In_register_EBX;
wire v145c = v145b == Out_register_EBX;
wire [31:0] v145f = ( v8 ) ? In_register_EAX : v1451;
wire [31:0] v1461 = v145f;
wire v1462 = v1461 == Out_register_EAX;
wire v1464 = v17;
wire v1465 = v1464 == Out_register_AF;
wire [31:0] v1467 = In_register_ECX;
wire v1468 = v1467 == Out_register_ECX;
wire [31:0] v146a = In_register_ESI;
wire v146b = v146a == Out_register_ESI;
wire [31:0] v146d = In_register_ESP;
wire v146e = v146d == Out_register_ESP;
wire [31:0] v1470 = In_register_EDX;
wire v1471 = v1470 == Out_register_EDX;
wire [7:0] v1473 = In_register_DF;
wire v1474 = v1473 == Out_register_DF;
wire [31:0] v1476 = In_register_EBP;
wire v1477 = v1476 == Out_register_EBP;
wire v1478 = v17;
wire v1479 = v1478 == Out_register_OF;
wire [31:0] v147b = In_register_SSBASE;
wire v147c = v147b == Out_register_SSBASE;
wire [31:0] v147e = In_register_GSBASE;
wire v147f = v147e == Out_register_GSBASE;
wire [31:0] v1481 = In_register_ESBASE;
wire v1482 = v1481 == Out_register_ESBASE;
wire [31:0] v1484 = In_register_DSBASE;
wire v1485 = v1484 == Out_register_DSBASE;
wire [31:0] v1487 = In_register_FSBASE;
wire v1488 = v1487 == Out_register_FSBASE;
wire [31:0] v148a = v48;
wire [31:0] v148b = In_register_EIP + v148a;
wire [31:0] v148d = v148b;
wire v148e = v148d == Out_register_EIP;
wire v148f = v17;
wire v1490 = v148f == Out_register_CF;
wire [31:0] v1492 = In_register_CSBASE;
wire v1493 = v1492 == Out_register_CSBASE;
wire v1494 = $signed(v1451) < $signed(v15);
wire v1496 = v1494;
wire v1497 = v1496 == Out_register_SF;
wire v1498 = v1451 == v15;
wire v149a = v1498;
wire v149b = v149a == Out_register_ZF;
wire v149c = v1448 & v1449 & v144c & v1459 & v15c & v145c & v1462 & v1465 & v1468 & v146b & v146e & v1471 & v1474 & v1477 & v1479 & v147c & v147f & v1482 & v1485 & v1488 & v148e & v1490 & v1493 & v1497 & v149b;
wire v149d = v4e == v1eb;
wire [4:0] v62 = 5'b01011;
wire v149e = v62 == v1ed;
wire v149f = v1b == v318;
wire v14a0 = v149d & v149e & v149f;
wire v14a1 = v14a0;
wire v14a2 = v14a1;
wire v14a4 = In_register_ZF;
wire v14a5 = v14a4 == Out_register_ZF;
wire [31:0] v14a7 = In_register_EBX;
wire v14a8 = v14a7 == Out_register_EBX;
wire v14aa = In_register_PF;
wire v14ab = v14aa == Out_register_PF;
wire [31:0] v14ad = In_register_EDX;
wire v14ae = v14ad == Out_register_EDX;
wire [31:0] v14b0 = v1c;
wire [31:0] v14b1 = In_register_EIP + v14b0;
wire [31:0] v14b3 = v14b1;
wire v14b4 =  v26 == memory_0[15: 12] && vdb3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v14b3 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v14b5 = In_error_flag == Out_error_flag;
wire [31:0] v14b7 = In_register_EAX;
wire v14b8 = v14b7 == Out_register_EAX;
wire [31:0] v14ba = In_register_EDI;
wire v14bb = v14ba == Out_register_EDI;
wire [31:0] v14bd = In_register_ESBASE;
wire v14be = v14bd == Out_register_ESBASE;
wire [31:0] v14c0 = vdb2;
wire v14c1 = v14c0 == Out_register_ESP;
wire [31:0] v14c3 = In_register_ESI;
wire v14c4 = v14c3 == Out_register_ESI;
wire [31:0] v14c6 = In_register_EBP;
wire v14c7 = v14c6 == Out_register_EBP;
wire [2:0] v14c8 = { v1fa };
wire [31:0] v14c9 = ( v14c8 == 3'd0) ? In_register_EAX : 
	( v14c8 == 3'd1) ? In_register_ECX : 
	( v14c8 == 3'd2) ? In_register_EDX : 
	( v14c8 == 3'd3) ? In_register_EBX : 
	( v14c8 == 3'd4) ? In_register_ESP : 
	( v14c8 == 3'd5) ? In_register_EBP : 
	( v14c8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v14cb = v14c9;
wire [31:0] v14cf = ( v14a1 ) ? v14b3 : v14cb;
wire [31:0] v14d1 = v14cf;
wire v14d2 = v14d1 == Out_register_EIP;
wire [31:0] v14d4 = In_register_SSBASE;
wire v14d5 = v14d4 == Out_register_SSBASE;
wire [31:0] v14d7 = In_register_DSBASE;
wire v14d8 = v14d7 == Out_register_DSBASE;
wire [31:0] v14da = In_register_GSBASE;
wire v14db = v14da == Out_register_GSBASE;
wire [31:0] v14dd = In_register_ECX;
wire v14de = v14dd == Out_register_ECX;
wire [31:0] v14e0 = In_register_FSBASE;
wire v14e1 = v14e0 == Out_register_FSBASE;
wire [7:0] v14e3 = In_register_DF;
wire v14e4 = v14e3 == Out_register_DF;
wire v14e6 = In_register_CF;
wire v14e7 = v14e6 == Out_register_CF;
wire v14e9 = In_register_AF;
wire v14ea = v14e9 == Out_register_AF;
wire v14ec = In_register_OF;
wire v14ed = v14ec == Out_register_OF;
wire [31:0] v14ef = In_register_CSBASE;
wire v14f0 = v14ef == Out_register_CSBASE;
wire v14f2 = In_register_SF;
wire v14f3 = v14f2 == Out_register_SF;
wire v14f4 = v14a2 & v15c & v14a5 & v14a8 & v14ab & v14ae & v14b4 & v14b5 & v14b8 & v14bb & v14be & v14c1 & v14c4 & v14c7 & v14d2 & v14d5 & v14d8 & v14db & v14de & v14e1 & v14e4 & v14e7 & v14ea & v14ed & v14f0 & v14f3;
wire v14f5 = In_error_flag == Out_error_flag;
wire [7:0] v63 = 8'b10101111;
wire v14f6 = v63 == v1eb;
wire v14f7 = v29 == v59f;
wire v14f8 = v14f6 & v14f7;
wire v14f9 = v14f8;
wire v14fa = v14f9;
wire [31:0] v14fc = In_register_SSBASE;
wire v14fd = v14fc == Out_register_SSBASE;
wire v14ff = In_register_AF;
wire v1500 = v14ff == Out_register_AF;
wire [31:0] v1502 = In_register_EAX;
wire v1503 = v1502 == Out_register_EAX;
wire [31:0] v1505 = v2b;
wire [31:0] v1506 = In_register_EIP + v1505;
wire [31:0] v1508 = v1506;
wire v1509 = v1508 == Out_register_EIP;
wire [31:0] v150b = In_register_EBX;
wire v150c = v150b == Out_register_EBX;
wire [31:0] v150e = In_register_EDI;
wire v150f = v150e == Out_register_EDI;
wire [31:0] v1511 = In_register_GSBASE;
wire v1512 = v1511 == Out_register_GSBASE;
wire [31:0] v1514 = In_register_ECX;
wire v1515 = v1514 == Out_register_ECX;
wire [31:0] v1517 = In_register_EDX;
wire v1518 = v1517 == Out_register_EDX;
wire [31:0] v151a = In_register_EBP;
wire v151b = v151a == Out_register_EBP;
wire [31:0] v151d = In_register_FSBASE;
wire v151e = v151d == Out_register_FSBASE;
wire [31:0] v1520 = In_register_ESP;
wire v1521 = v1520 == Out_register_ESP;
wire [31:0] v1523 = In_register_CSBASE;
wire v1524 = v1523 == Out_register_CSBASE;
wire v1526 = In_register_PF;
wire v1527 = v1526 == Out_register_PF;
wire [31:0] v1529 = In_register_ESBASE;
wire v152a = v1529 == Out_register_ESBASE;
wire [31:0] v152c = In_register_ESI;
wire v152d = v152c == Out_register_ESI;
wire [31:0] v152f = In_register_DSBASE;
wire v1530 = v152f == Out_register_DSBASE;
wire v1532 = In_register_SF;
wire v1533 = v1532 == Out_register_SF;
wire [7:0] v1535 = In_register_DF;
wire v1536 = v1535 == Out_register_DF;
wire v1538 = In_register_OF;
wire v1539 = v1538 == Out_register_OF;
wire v153a = v65f == v2c;
wire v153c = v153a;
wire v153d = v153c == Out_register_CF;
wire v153f = In_register_ZF;
wire v1540 = v153f == Out_register_ZF;
wire v1541 = v14f5 & v14fd & v1500 & v15c & v1503 & v1509 & v150c & v150f & v14fa & v1512 & v1515 & v1518 & v151b & v151e & v1521 & v1524 & v1527 & v152a & v152d & v1530 & v1533 & v1536 & v1539 & v153d & v1540;
wire [18:0] v64 = 19'b0000000100100100101;
wire v1546 = v64 == vdfa;
wire v1547 = v51 == vdfc;
wire v1548 = v1546 & v1547;
wire [2:0] v1542 = { v12c };
wire [31:0] v1543 = ( v1542 == 3'd0) ? In_register_EAX : 
	( v1542 == 3'd1) ? In_register_ECX : 
	( v1542 == 3'd2) ? In_register_EDX : 
	( v1542 == 3'd3) ? In_register_EBX : 
	( v1542 == 3'd4) ? v15 : 
	( v1542 == 3'd5) ? In_register_EBP : 
	( v1542 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1544 = v1543 << v7f4;
wire [31:0] v1545 = v1544 + vc2d;
wire [31:0] v154a = v1545;
wire v154b =  v2a == memory_0[15: 12] && v154a == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [2:0] v154c = { v12c };
wire [31:0] v154d = ( v154c == 3'd0) ? In_register_EAX : 
	( v154c == 3'd1) ? In_register_ECX : 
	( v154c == 3'd2) ? In_register_EDX : 
	( v154c == 3'd3) ? In_register_EBX : 
	( v154c == 3'd4) ? v15 : 
	( v154c == 3'd5) ? In_register_EBP : 
	( v154c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v154e = v154d << v7f4;
wire [31:0] v154f = v154e + vc2d;
wire [31:0] v1551 = v154f;
wire [31:0] v1552 = memory_0[79: 48];
wire [7:0] v1553 = v1552[7:0];
wire [31:0] v1555 = ve10;
wire [7:0] v1556 = v1555[7:0];
wire [7:0] v1557 = v1553 & v1556;
wire v1558 =  v2a == memory_1[15: 12] && v1551 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v1557 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v1559 = v1548;
wire v155a = v1559;
wire [31:0] v155c = In_register_EBP;
wire v155d = v155c == Out_register_EBP;
wire [31:0] v155f = In_register_SSBASE;
wire v1560 = v155f == Out_register_SSBASE;
wire [31:0] v1562 = In_register_EDX;
wire v1563 = v1562 == Out_register_EDX;
wire [31:0] v1565 = In_register_ESI;
wire v1566 = v1565 == Out_register_ESI;
wire v1568 = v17;
wire v1569 = v1568 == Out_register_AF;
wire [31:0] v156b = In_register_ESBASE;
wire v156c = v156b == Out_register_ESBASE;
wire v156d = In_error_flag == Out_error_flag;
wire [31:0] v156f = In_register_DSBASE;
wire v1570 = v156f == Out_register_DSBASE;
wire v1571 = v17;
wire v1572 = v1571 == Out_register_CF;
wire v1573 = v1557 == v2c;
wire v1575 = v1573;
wire v1576 = v1575 == Out_register_ZF;
wire [31:0] v1578 = In_register_EBX;
wire v1579 = v1578 == Out_register_EBX;
wire [31:0] v157b = In_register_ESP;
wire v157c = v157b == Out_register_ESP;
wire [31:0] v157e = In_register_ECX;
wire v157f = v157e == Out_register_ECX;
wire [31:0] v1581 = In_register_EAX;
wire v1582 = v1581 == Out_register_EAX;
wire [31:0] v1584 = In_register_EDI;
wire v1585 = v1584 == Out_register_EDI;
wire [31:0] v1587 = v31;
wire [31:0] v1588 = In_register_EIP + v1587;
wire [31:0] v158a = v1588;
wire v158b = v158a == Out_register_EIP;
wire [31:0] v158d = In_register_CSBASE;
wire v158e = v158d == Out_register_CSBASE;
wire [31:0] v1590 = In_register_GSBASE;
wire v1591 = v1590 == Out_register_GSBASE;
wire [2:0] v1592_aux = v1557[0] + v1557[1] + v1557[2] + v1557[3] + v1557[4] + v1557[5] + v1557[6] + v1557[7];
wire v1592 = { 5'b00000, v1592_aux };
wire [7:0] v1593 = v1592 & v18;
wire [7:0] v1594 = v1593 ^ v18;
wire v1595 = v1594[0:0];
wire v1597 = v1595;
wire v1598 = v1597 == Out_register_PF;
wire [31:0] v159a = In_register_FSBASE;
wire v159b = v159a == Out_register_FSBASE;
wire [7:0] v159d = In_register_DF;
wire v159e = v159d == Out_register_DF;
wire v159f = v17;
wire v15a0 = v159f == Out_register_OF;
wire v15a1 = $signed(v1557) < $signed(v2c);
wire v15a3 = v15a1;
wire v15a4 = v15a3 == Out_register_SF;
wire v15a5 = v15c & v154b & v1558 & v155a & v155d & v1560 & v1563 & v1566 & v1569 & v156c & v156d & v1570 & v1572 & v1576 & v1579 & v157c & v157f & v1582 & v1585 & v158b & v158e & v1591 & v1598 & v159b & v159e & v15a0 & v15a4;
wire v15a8 = v4e == v1eb;
wire v15a9 = v59 == v1ed;
wire v15aa = v1b == v318;
wire v15ab = v15a8 & v15a9 & v15aa;
wire v15b7 = v15ab;
wire v15b8 = v15b7;
wire [2:0] v15af = { v1fa };
wire v15b0 = v15af == v9;
wire v15b1 = v15b0;
wire v15b2 = v15ab & v15b1;
wire v15b3 = v15b2;
wire [2:0] v15a6 = { v1fa };
wire [31:0] v15a7 = ( v15a6 == 3'd0) ? In_register_EAX : 
	( v15a6 == 3'd1) ? In_register_ECX : 
	( v15a6 == 3'd2) ? In_register_EDX : 
	( v15a6 == 3'd3) ? In_register_EBX : 
	( v15a6 == 3'd4) ? In_register_ESP : 
	( v15a6 == 3'd5) ? In_register_EBP : 
	( v15a6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v15ad = v15a7;
wire [31:0] v15ae = v15ad + v2b;
wire [31:0] v15b6 = ( v8 ) ? In_register_EDI : v15ae;
wire [31:0] v15ba = v15b6;
wire v15bb = v15ba == Out_register_EDI;
wire v15bc = v15af == vb;
wire v15bd = v15bc;
wire v15be = v15ab & v15bd;
wire v15bf = v15be;
wire [31:0] v15c2 = ( v8 ) ? In_register_ESP : v15ae;
wire [31:0] v15c4 = v15c2;
wire v15c5 = v15c4 == Out_register_ESP;
wire [31:0] v15c6 = v15ae ^ v15ad;
wire [31:0] v15c7 = v15c6 >> v1e;
wire [31:0] v15c8 = v15ae >> v1e;
wire [31:0] v15c9 = v15c7 + v15c8;
wire v15ca = v15c9 == v1c;
wire v15cc = v15ca;
wire v15cd = v15cc == Out_register_OF;
wire v15ce = v15af == v7;
wire v15cf = v15ce;
wire v15d0 = v15ab & v15cf;
wire v15d1 = v15d0;
wire [31:0] v15d4 = ( v8 ) ? In_register_EAX : v15ae;
wire [31:0] v15d6 = v15d4;
wire v15d7 = v15d6 == Out_register_EAX;
wire v15d8 = v15af == vc;
wire v15d9 = v15d8;
wire v15da = v15ab & v15d9;
wire v15db = v15da;
wire [31:0] v15de = ( v8 ) ? In_register_ECX : v15ae;
wire [31:0] v15e0 = v15de;
wire v15e1 = v15e0 == Out_register_ECX;
wire v15e2 = v15af == v11;
wire v15e3 = v15e2;
wire v15e4 = v15ab & v15e3;
wire v15e5 = v15e4;
wire [31:0] v15e8 = ( v8 ) ? In_register_ESI : v15ae;
wire [31:0] v15ea = v15e8;
wire v15eb = v15ea == Out_register_ESI;
wire v15ec = In_error_flag == Out_error_flag;
wire [7:0] v15ed = v15c6[7:0];
wire [7:0] v15ee = v15ed >> v1d;
wire [7:0] v15ef = v15ee & v18;
wire v15f0 = v15ef[0:0];
wire v15f2 = v15f0;
wire v15f3 = v15f2 == Out_register_AF;
wire v15f4 = v15af == vd;
wire v15f5 = v15f4;
wire v15f6 = v15ab & v15f5;
wire v15f7 = v15f6;
wire [31:0] v15fa = ( v8 ) ? In_register_EBX : v15ae;
wire [31:0] v15fc = v15fa;
wire v15fd = v15fc == Out_register_EBX;
wire v15fe = v15af == ve;
wire v15ff = v15fe;
wire v1600 = v15ab & v15ff;
wire v1601 = v1600;
wire [31:0] v1604 = ( v8 ) ? In_register_EDX : v15ae;
wire [31:0] v1606 = v1604;
wire v1607 = v1606 == Out_register_EDX;
wire [31:0] v1609 = v1c;
wire [31:0] v160a = In_register_EIP + v1609;
wire [31:0] v160c = v160a;
wire v160d = v160c == Out_register_EIP;
wire [31:0] v160f = In_register_CSBASE;
wire v1610 = v160f == Out_register_CSBASE;
wire v1612 = In_register_CF;
wire v1613 = v1612 == Out_register_CF;
wire [31:0] v1615 = In_register_ESBASE;
wire v1616 = v1615 == Out_register_ESBASE;
wire [31:0] v1618 = In_register_DSBASE;
wire v1619 = v1618 == Out_register_DSBASE;
wire [31:0] v161b = In_register_GSBASE;
wire v161c = v161b == Out_register_GSBASE;
wire v161d = v15af == vf;
wire v161e = v161d;
wire v161f = v15ab & v161e;
wire v1620 = v161f;
wire [31:0] v1623 = ( v8 ) ? In_register_EBP : v15ae;
wire [31:0] v1625 = v1623;
wire v1626 = v1625 == Out_register_EBP;
wire [31:0] v1628 = In_register_FSBASE;
wire v1629 = v1628 == Out_register_FSBASE;
wire [7:0] v162b = In_register_DF;
wire v162c = v162b == Out_register_DF;
wire [31:0] v162e = In_register_SSBASE;
wire v162f = v162e == Out_register_SSBASE;
wire [7:0] v1630 = v15ae[7:0];
wire [2:0] v1631_aux = v1630[0] + v1630[1] + v1630[2] + v1630[3] + v1630[4] + v1630[5] + v1630[6] + v1630[7];
wire v1631 = { 5'b00000, v1631_aux };
wire [7:0] v1632 = v1631 & v18;
wire [7:0] v1633 = v1632 ^ v18;
wire v1634 = v1633[0:0];
wire v1636 = v1634;
wire v1637 = v1636 == Out_register_PF;
wire v1638 = $signed(v15ae) < $signed(v15);
wire v163a = v1638;
wire v163b = v163a == Out_register_SF;
wire v163c = v15ae == v15;
wire v163e = v163c;
wire v163f = v163e == Out_register_ZF;
wire v1640 = v15bb & v15c5 & v15cd & v15d7 & v15e1 & v15eb & v15ec & v15f3 & v15fd & v15c & v1607 & v15b8 & v160d & v1610 & v1613 & v1616 & v1619 & v161c & v1626 & v1629 & v162c & v162f & v1637 & v163b & v163f;
wire v1641 = v4e == v1eb;
wire v1642 = v44 == v1ed;
wire v1643 = v4 == v11b;
wire [2:0] v1644 = { v1fa };
wire v1645 = v1644 == vb;
wire v1646 = v1645;
wire v1647 = v1646 ^ v8;
wire [2:0] v1648 = { v1fa };
wire v1649 = v1648 == vb;
wire v164a = v1649;
wire v164b = v164a ^ v8;
wire v164c = v1647 & v164b;
wire v164d = v1641 & v1642 & v1643 & v164c;
wire [15:0] v65 = 16'b1111111100101001;
wire v164e = v65 == v117;
wire v164f = instruction_bits[20: 20];
wire v1650 = v8 == v164f;
wire v1651 = v43 == vab3;
wire [2:0] v1652 = { v13c };
wire v1653 = v1652 == v7;
wire v1654 = v1652 == vc;
wire v1655 = v1652 == ve;
wire v1656 = v1652 == vd;
wire v1657 = v1652 == v11;
wire v1658 = v1652 == v9;
wire v1659 = v1653 | v1654 | v1655 | v1656 | v1657 | v1658;
wire v165a = v1659 ^ v8;
wire v165b = v165a;
wire v165c = v164e & v1650 & v1651 & v165b;
wire v165d = v4e == v1eb;
wire v165e = v42 == v1ed;
wire v165f = v14 == v1ef;
wire [2:0] v1660 = { v1fa };
wire v1661 = v1660 == vb;
wire v1662 = v1661;
wire v1663 = v1662 ^ v8;
wire [2:0] v1664 = { v1fa };
wire v1665 = v1664 == vb;
wire v1666 = v1665;
wire v1667 = v1666 ^ v8;
wire v1668 = v1663 & v1667;
wire v1669 = v165d & v165e & v165f & v1668;
wire v166a = v164d | v165c | v1669;
wire v166b = v166a;
wire [31:0] v166d = In_register_EAX;
wire v166e = v166d == Out_register_EAX;
wire v166f = In_error_flag == Out_error_flag;
wire [31:0] v1671 = In_register_EDX;
wire v1672 = v1671 == Out_register_EDX;
wire [31:0] v1674 = In_register_EDI;
wire v1675 = v1674 == Out_register_EDI;
wire [31:0] v1677 = In_register_EBP;
wire v1678 = v1677 == Out_register_EBP;
wire v167a = In_register_OF;
wire v167b = v167a == Out_register_OF;
wire [31:0] v167f = ( v165c ) ? v45 : 
	( v1669 ) ? v16 : v10;
wire [31:0] v1680 = In_register_EIP + v167f;
wire [31:0] v1684 = v1680;
wire v1685 =  v26 == memory_1[15: 12] && vdb3 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v1684 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v1687 = vdb2;
wire v1688 = v1687 == Out_register_ESP;
wire [31:0] v1689 = memory_0[79: 48];
wire [31:0] v168d = ( v166a ) ? v1684 : v1689;
wire [31:0] v168f = v168d;
wire v1690 = v168f == Out_register_EIP;
wire [31:0] v1692 = In_register_SSBASE;
wire v1693 = v1692 == Out_register_SSBASE;
wire [2:0] v1694 = { v1fa };
wire [31:0] v1695 = ( v1694 == 3'd0) ? In_register_EAX : 
	( v1694 == 3'd1) ? In_register_ECX : 
	( v1694 == 3'd2) ? In_register_EDX : 
	( v1694 == 3'd3) ? In_register_EBX : 
	( v1694 == 3'd4) ? v15 : 
	( v1694 == 3'd5) ? In_register_EBP : 
	( v1694 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1696 = v1695 + v63a;
wire [2:0] v1698 = { v13c };
wire [31:0] v1699 = ( v1698 == 3'd0) ? v15 : 
	( v1698 == 3'd1) ? v15 : 
	( v1698 == 3'd2) ? v15 : 
	( v1698 == 3'd3) ? v15 : 
	( v1698 == 3'd4) ? In_register_ESP : 
	( v1698 == 3'd5) ? In_register_EBP : 
	( v1698 == 3'd6) ? v15 : v15;
wire v169b = instruction_bits[19: 19];
wire v169a = instruction_bits[21: 21];
wire [1:0] v169c = { v169b , v169a };
wire [31:0] v169d = ( v169c == 2'd0) ? In_register_EDX : 
	( v169c == 2'd1) ? In_register_ESI : 
	( v169c == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v169e = v169d << v7f4;
wire [31:0] v169f = v1699 + v169e;
wire [31:0] v16a0 = v169f + vc2d;
wire [2:0] v16a2 = { v1fa };
wire [31:0] v16a3 = ( v16a2 == 3'd0) ? In_register_EAX : 
	( v16a2 == 3'd1) ? In_register_ECX : 
	( v16a2 == 3'd2) ? In_register_EDX : 
	( v16a2 == 3'd3) ? In_register_EBX : 
	( v16a2 == 3'd4) ? v15 : 
	( v16a2 == 3'd5) ? In_register_EBP : 
	( v16a2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v16a4 = v16a3 + v1f7;
wire [31:0] v16a6 = ( v164d ) ? v1696 : 
	( v165c ) ? v16a0 : v16a4;
wire v16a7 =  v26 == memory_0[15: 12] && v16a6 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v16a9 = In_register_ESI;
wire v16aa = v16a9 == Out_register_ESI;
wire [31:0] v16ac = In_register_CSBASE;
wire v16ad = v16ac == Out_register_CSBASE;
wire [31:0] v16af = In_register_DSBASE;
wire v16b0 = v16af == Out_register_DSBASE;
wire [31:0] v16b2 = In_register_ESBASE;
wire v16b3 = v16b2 == Out_register_ESBASE;
wire [31:0] v16b5 = In_register_GSBASE;
wire v16b6 = v16b5 == Out_register_GSBASE;
wire [31:0] v16b8 = In_register_FSBASE;
wire v16b9 = v16b8 == Out_register_FSBASE;
wire v16bb = In_register_AF;
wire v16bc = v16bb == Out_register_AF;
wire [31:0] v16be = In_register_ECX;
wire v16bf = v16be == Out_register_ECX;
wire [7:0] v16c1 = In_register_DF;
wire v16c2 = v16c1 == Out_register_DF;
wire [31:0] v16c4 = In_register_EBX;
wire v16c5 = v16c4 == Out_register_EBX;
wire v16c7 = In_register_CF;
wire v16c8 = v16c7 == Out_register_CF;
wire v16ca = In_register_PF;
wire v16cb = v16ca == Out_register_PF;
wire v16cd = In_register_SF;
wire v16ce = v16cd == Out_register_SF;
wire v16d0 = In_register_ZF;
wire v16d1 = v16d0 == Out_register_ZF;
wire v16d2 = v166b & v166e & v166f & v1672 & v1675 & v1678 & v167b & v1685 & v1688 & v1690 & v1693 & v16a7 & v16aa & v16ad & v16b0 & v16b3 & v15c & v16b6 & v16b9 & v16bc & v16bf & v16c2 & v16c5 & v16c8 & v16cb & v16ce & v16d1;
wire [15:0] v66 = 16'b0110001110100000;
wire v16d3 = v66 == v117;
wire v16d4 = v43 == vab3;
wire v16d5 = v16d3 & v16d4;
wire [7:0] v67 = 8'b01100011;
wire v16d6 = v67 == v1eb;
wire [4:0] v68 = 5'b00010;
wire v16d7 = v68 == v1ed;
wire v16d8 = v38 == v6da;
wire [2:0] v16d9 = { v1fa };
wire v16da = v16d9 == vb;
wire v16db = v16da;
wire v16dc = v16db ^ v8;
wire [2:0] v16dd = { v1fa };
wire v16de = v16dd == vb;
wire v16df = v16de;
wire v16e0 = v16df ^ v8;
wire v16e1 = v16dc & v16e0;
wire v16e2 = v16d6 & v16d7 & v16d8 & v16e1;
wire v16e3 = v67 == v1eb;
wire v16e4 = v25 == v1ed;
wire v16e5 = v4 == v11b;
wire [2:0] v16e6 = { v1fa };
wire v16e7 = v16e6 == vb;
wire v16e8 = v16e6 == vf;
wire v16e9 = v16e7 | v16e8;
wire v16ea = v16e9 ^ v8;
wire [2:0] v16eb = { v1fa };
wire v16ec = v16eb == vb;
wire v16ed = v16eb == vf;
wire v16ee = v16ec | v16ed;
wire v16ef = v16ee ^ v8;
wire v16f0 = v16ea & v16ef;
wire v16f1 = v16e3 & v16e4 & v16e5 & v16f0;
wire [15:0] v69 = 16'b0110001100100000;
wire v16f2 = v69 == v117;
wire v16f3 = v38 == v6da;
wire [2:0] v16f4 = { v13c };
wire v16f5 = v16f4 == vb;
wire v16f6 = v16f4 == vf;
wire v16f7 = v16f5 | v16f6;
wire v16f8 = v16f7 ^ v8;
wire [2:0] v16f9 = { v12c };
wire v16fa = v16f9 == vb;
wire v16fb = v16fa;
wire v16fc = v16fb ^ v8;
wire [2:0] v16fd = { v13c };
wire v16fe = v16fd == vf;
wire v16ff = v16fe;
wire v1700 = v16ff ^ v8;
wire v1701 = v16f8 & v16fc & v1700;
wire v1702 = v16f2 & v16f3 & v1701;
wire v1703 = v67 == v1eb;
wire [4:0] v6a = 5'b00001;
wire v1704 = v6a == v1ed;
wire v1705 = v43 == vab3;
wire [2:0] v1706 = { v1fa };
wire v1707 = v1706 == vb;
wire v1708 = v1707;
wire v1709 = v1708 ^ v8;
wire [2:0] v170a = { v1fa };
wire v170b = v170a == vb;
wire v170c = v170b;
wire v170d = v170c ^ v8;
wire v170e = v1709 & v170d;
wire v170f = v1703 & v1704 & v1705 & v170e;
wire [15:0] v6b = 16'b0110001100100001;
wire v1710 = v6b == v117;
wire v1711 = v51 == vdfc;
wire [2:0] v1712 = { v13c };
wire v1713 = v1712 == v7;
wire v1714 = v1712 == vc;
wire v1715 = v1712 == ve;
wire v1716 = v1712 == vd;
wire v1717 = v1712 == v11;
wire v1718 = v1712 == v9;
wire v1719 = v1713 | v1714 | v1715 | v1716 | v1717 | v1718;
wire v171a = v1719 ^ v8;
wire [2:0] v171b = { v12c };
wire v171c = v171b == vb;
wire v171d = v171c;
wire v171e = v171d ^ v8;
wire v171f = v171a & v171e;
wire v1720 = v1710 & v1711 & v171f;
wire [15:0] v6c = 16'b0110001100100010;
wire v1721 = v6c == v117;
wire v1722 = v47 == vb69;
wire [2:0] v1723 = { v13c };
wire v1724 = v1723 == vb;
wire v1725 = v1723 == vf;
wire v1726 = v1724 | v1725;
wire v1727 = v1726 ^ v8;
wire [2:0] v1728 = { v12c };
wire v1729 = v1728 == vb;
wire v172a = v1729;
wire v172b = v172a ^ v8;
wire v172c = v1727 & v172b;
wire v172d = v1721 & v1722 & v172c;
wire [18:0] v6d = 19'b0110001100100000101;
wire v172e = v6d == vdfa;
wire v172f = v51 == vdfc;
wire [2:0] v1730 = { v12c };
wire v1731 = v1730 == vb;
wire v1732 = v1731;
wire v1733 = v1732 ^ v8;
wire v1734 = v1733;
wire v1735 = v172e & v172f & v1734;
wire v1736 = v16d5 | v16e2 | v16f1 | v1702 | v170f | v1720 | v172d | v1735;
wire v1737 = v1736;
wire [31:0] v1739 = In_register_ESI;
wire v173a = v1739 == Out_register_ESI;
wire [2:0] v173c = { v1fa };
wire [31:0] v173d = ( v173c == 3'd0) ? In_register_EAX : 
	( v173c == 3'd1) ? In_register_ECX : 
	( v173c == 3'd2) ? In_register_EDX : 
	( v173c == 3'd3) ? In_register_EBX : 
	( v173c == 3'd4) ? v15 : 
	( v173c == 3'd5) ? In_register_EBP : 
	( v173c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v173e = v173d + v63a;
wire [2:0] v1743 = { v13c };
wire [31:0] v1744 = ( v1743 == 3'd0) ? In_register_EAX : 
	( v1743 == 3'd1) ? In_register_ECX : 
	( v1743 == 3'd2) ? In_register_EDX : 
	( v1743 == 3'd3) ? In_register_EBX : 
	( v1743 == 3'd4) ? v15 : 
	( v1743 == 3'd5) ? v15 : 
	( v1743 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1745 = { v12c };
wire [31:0] v1746 = ( v1745 == 3'd0) ? In_register_EAX : 
	( v1745 == 3'd1) ? In_register_ECX : 
	( v1745 == 3'd2) ? In_register_EDX : 
	( v1745 == 3'd3) ? In_register_EBX : 
	( v1745 == 3'd4) ? v15 : 
	( v1745 == 3'd5) ? In_register_EBP : 
	( v1745 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1747 = v1746 << v7f4;
wire [31:0] v1748 = v1744 + v1747;
wire [2:0] v174a = { v1fa };
wire [31:0] v174b = ( v174a == 3'd0) ? In_register_EAX : 
	( v174a == 3'd1) ? In_register_ECX : 
	( v174a == 3'd2) ? In_register_EDX : 
	( v174a == 3'd3) ? In_register_EBX : 
	( v174a == 3'd4) ? v15 : 
	( v174a == 3'd5) ? In_register_EBP : 
	( v174a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v174c = v174b + v1f7;
wire [2:0] v174e = { v13c };
wire [31:0] v174f = ( v174e == 3'd0) ? v15 : 
	( v174e == 3'd1) ? v15 : 
	( v174e == 3'd2) ? v15 : 
	( v174e == 3'd3) ? v15 : 
	( v174e == 3'd4) ? In_register_ESP : 
	( v174e == 3'd5) ? In_register_EBP : 
	( v174e == 3'd6) ? v15 : v15;
wire [2:0] v1750 = { v12c };
wire [31:0] v1751 = ( v1750 == 3'd0) ? In_register_EAX : 
	( v1750 == 3'd1) ? In_register_ECX : 
	( v1750 == 3'd2) ? In_register_EDX : 
	( v1750 == 3'd3) ? In_register_EBX : 
	( v1750 == 3'd4) ? v15 : 
	( v1750 == 3'd5) ? In_register_EBP : 
	( v1750 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1752 = v1751 << v7f4;
wire [31:0] v1753 = v174f + v1752;
wire [31:0] v1754 = v1753 + vc2d;
wire [2:0] v1756 = { v13c };
wire [31:0] v1757 = ( v1756 == 3'd0) ? In_register_EAX : 
	( v1756 == 3'd1) ? In_register_ECX : 
	( v1756 == 3'd2) ? In_register_EDX : 
	( v1756 == 3'd3) ? In_register_EBX : 
	( v1756 == 3'd4) ? v15 : 
	( v1756 == 3'd5) ? v15 : 
	( v1756 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1758 = { v12c };
wire [31:0] v1759 = ( v1758 == 3'd0) ? In_register_EAX : 
	( v1758 == 3'd1) ? In_register_ECX : 
	( v1758 == 3'd2) ? In_register_EDX : 
	( v1758 == 3'd3) ? In_register_EBX : 
	( v1758 == 3'd4) ? v15 : 
	( v1758 == 3'd5) ? In_register_EBP : 
	( v1758 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v175a = v1759 << v7f4;
wire [31:0] v175b = v1757 + v175a;
wire [31:0] v175c = v175b + v7f8;
wire [2:0] v175e = { v12c };
wire [31:0] v175f = ( v175e == 3'd0) ? In_register_EAX : 
	( v175e == 3'd1) ? In_register_ECX : 
	( v175e == 3'd2) ? In_register_EDX : 
	( v175e == 3'd3) ? In_register_EBX : 
	( v175e == 3'd4) ? v15 : 
	( v175e == 3'd5) ? In_register_EBP : 
	( v175e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1760 = v175f << v7f4;
wire [31:0] v1761 = v1760 + vc2d;
wire [2:0] v1740 = { v1fa };
wire [31:0] v1741 = ( v1740 == 3'd0) ? In_register_EAX : 
	( v1740 == 3'd1) ? In_register_ECX : 
	( v1740 == 3'd2) ? In_register_EDX : 
	( v1740 == 3'd3) ? In_register_EBX : 
	( v1740 == 3'd4) ? v15 : 
	( v1740 == 3'd5) ? v15 : 
	( v1740 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1763 = ( v16e2 ) ? v173e : 
	( v1702 ) ? v1748 : 
	( v170f ) ? v174c : 
	( v1720 ) ? v1754 : 
	( v172d ) ? v175c : 
	( v1735 ) ? v1761 : 
	( v16f1 ) ? v1741 : v1f7;
wire [7:0] v176a = instruction_bits[39: 32];
wire [7:0] pad_5995 = (v176a[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] v176b = { pad_5995, v176a };
wire [31:0] v176e = ( v172d ) ? v176b : 
	( v16e2 | v1702 ) ? v7f8 : 
	( v16d5 | v170f ) ? vb0c : 
	( v1720 | v1735 ) ? ve10 : v63a;
wire [7:0] v176f = v176e[7:0];
wire v1770 =  v2a == memory_0[15: 12] && v1763 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v176f == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v1772 = In_register_PF;
wire v1773 = v1772 == Out_register_PF;
wire [31:0] v1775 = In_register_FSBASE;
wire v1776 = v1775 == Out_register_FSBASE;
wire v1778 = In_register_ZF;
wire v1779 = v1778 == Out_register_ZF;
wire v177a = In_error_flag == Out_error_flag;
wire [31:0] v177c = In_register_CSBASE;
wire v177d = v177c == Out_register_CSBASE;
wire [31:0] v177f = In_register_EBX;
wire v1780 = v177f == Out_register_EBX;
wire v1782 = In_register_OF;
wire v1783 = v1782 == Out_register_OF;
wire [31:0] v1785 = In_register_EDI;
wire v1786 = v1785 == Out_register_EDI;
wire [31:0] v1788 = In_register_GSBASE;
wire v1789 = v1788 == Out_register_GSBASE;
wire [31:0] v178b = In_register_EAX;
wire v178c = v178b == Out_register_EAX;
wire [31:0] v178e = In_register_ECX;
wire v178f = v178e == Out_register_ECX;
wire [31:0] v1791 = In_register_ESP;
wire v1792 = v1791 == Out_register_ESP;
wire [31:0] v179b = ( v172d ) ? v48 : 
	( v16d5 | v170f ) ? v45 : 
	( v1720 | v1735 ) ? v31 : 
	( v16e2 | v1702 ) ? v27 : v10;
wire [31:0] v179c = In_register_EIP + v179b;
wire [31:0] v179e = v179c;
wire v179f = v179e == Out_register_EIP;
wire [31:0] v17a1 = In_register_EBP;
wire v17a2 = v17a1 == Out_register_EBP;
wire [31:0] v17a4 = In_register_SSBASE;
wire v17a5 = v17a4 == Out_register_SSBASE;
wire [31:0] v17a7 = In_register_ESBASE;
wire v17a8 = v17a7 == Out_register_ESBASE;
wire v17aa = In_register_AF;
wire v17ab = v17aa == Out_register_AF;
wire [31:0] v17ad = In_register_EDX;
wire v17ae = v17ad == Out_register_EDX;
wire [31:0] v17b0 = In_register_DSBASE;
wire v17b1 = v17b0 == Out_register_DSBASE;
wire v17b3 = In_register_CF;
wire v17b4 = v17b3 == Out_register_CF;
wire [7:0] v17b6 = In_register_DF;
wire v17b7 = v17b6 == Out_register_DF;
wire v17b9 = In_register_SF;
wire v17ba = v17b9 == Out_register_SF;
wire v17bb = v1737 & v173a & v1770 & v1773 & v1776 & v1779 & v177a & v177d & v1780 & v1783 & v1786 & v1789 & v178c & v178f & v1792 & v179f & v17a2 & v17a5 & v15c & v17a8 & v17ab & v17ae & v17b1 & v17b4 & v17b7 & v17ba;
wire v17bc = v40 == v1eb;
wire v17bd = v6a == v1ed;
wire v17be = v43 == vab3;
wire [2:0] v17bf = { v1fa };
wire v17c0 = v17bf == vb;
wire v17c1 = v17bf == vf;
wire v17c2 = v17c0 | v17c1;
wire v17c3 = v17c2 ^ v8;
wire [2:0] v17c4 = { v1fa };
wire v17c5 = v17c4 == vb;
wire v17c6 = v17c5;
wire v17c7 = v17c6 ^ v8;
wire [2:0] v17c8 = { v1fa };
wire v17c9 = v17c8 == vb;
wire v17ca = v17c8 == vf;
wire v17cb = v17c9 | v17ca;
wire v17cc = v17cb ^ v8;
wire [2:0] v17cd = { v1fa };
wire v17ce = v17cd == vb;
wire v17cf = v17ce;
wire v17d0 = v17cf ^ v8;
wire v17d1 = v17c3 & v17c7 & v17cc & v17d0;
wire v17d2 = v17bc & v17bd & v17be & v17d1;
wire v17d3 = v40 == v1eb;
wire v17d4 = v68 == v1ed;
wire v17d5 = v38 == v6da;
wire [2:0] v17d6 = { v1fa };
wire v17d7 = v17d6 == vb;
wire v17d8 = v17d6 == vf;
wire v17d9 = v17d7 | v17d8;
wire v17da = v17d9 ^ v8;
wire [2:0] v17db = { v1fa };
wire v17dc = v17db == vb;
wire v17dd = v17dc;
wire v17de = v17dd ^ v8;
wire [2:0] v17df = { v1fa };
wire v17e0 = v17df == vb;
wire v17e1 = v17df == vf;
wire v17e2 = v17e0 | v17e1;
wire v17e3 = v17e2 ^ v8;
wire [2:0] v17e4 = { v1fa };
wire v17e5 = v17e4 == vb;
wire v17e6 = v17e5;
wire v17e7 = v17e6 ^ v8;
wire v17e8 = v17da & v17de & v17e3 & v17e7;
wire v17e9 = v17d3 & v17d4 & v17d5 & v17e8;
wire [15:0] v6e = 16'b1100000100100010;
wire v17ea = v6e == v117;
wire v17eb = v47 == vb69;
wire [2:0] v17ec = { v13c };
wire v17ed = v17ec == v7;
wire v17ee = v17ec == vc;
wire v17ef = v17ec == ve;
wire v17f0 = v17ec == vd;
wire v17f1 = v17ec == v11;
wire v17f2 = v17ec == v9;
wire v17f3 = v17ed | v17ee | v17ef | v17f0 | v17f1 | v17f2;
wire v17f4 = v17f3 ^ v8;
wire [2:0] v17f5 = { v12c };
wire v17f6 = v17f5 == vb;
wire v17f7 = v17f6;
wire v17f8 = v17f7 ^ v8;
wire [2:0] v17f9 = { v13c };
wire v17fa = v17f9 == v7;
wire v17fb = v17f9 == vc;
wire v17fc = v17f9 == ve;
wire v17fd = v17f9 == vd;
wire v17fe = v17f9 == v11;
wire v17ff = v17f9 == v9;
wire v1800 = v17fa | v17fb | v17fc | v17fd | v17fe | v17ff;
wire v1801 = v1800 ^ v8;
wire [2:0] v1802 = { v12c };
wire v1803 = v1802 == vb;
wire v1804 = v1803;
wire v1805 = v1804 ^ v8;
wire v1806 = v17f4 & v17f8 & v1801 & v1805;
wire v1807 = v17ea & v17eb & v1806;
wire v1808 = v17d2 | v17e9 | v1807;
wire v1809 = v1808;
wire [31:0] v180b = In_register_SSBASE;
wire v180c = v180b == Out_register_SSBASE;
wire [2:0] v180d = { v1fa };
wire [31:0] v180e = ( v180d == 3'd0) ? In_register_EAX : 
	( v180d == 3'd1) ? In_register_ECX : 
	( v180d == 3'd2) ? In_register_EDX : 
	( v180d == 3'd3) ? In_register_EBX : 
	( v180d == 3'd4) ? v15 : 
	( v180d == 3'd5) ? v15 : 
	( v180d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v180f = v180e + v1f7;
wire [2:0] v1811 = { v1fa };
wire [31:0] v1812 = ( v1811 == 3'd0) ? In_register_EAX : 
	( v1811 == 3'd1) ? In_register_ECX : 
	( v1811 == 3'd2) ? In_register_EDX : 
	( v1811 == 3'd3) ? In_register_EBX : 
	( v1811 == 3'd4) ? v15 : 
	( v1811 == 3'd5) ? v15 : 
	( v1811 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1813 = v1812 + v63a;
wire [2:0] v1815 = { v13c };
wire [31:0] v1816 = ( v1815 == 3'd0) ? v15 : 
	( v1815 == 3'd1) ? v15 : 
	( v1815 == 3'd2) ? v15 : 
	( v1815 == 3'd3) ? v15 : 
	( v1815 == 3'd4) ? In_register_ESP : 
	( v1815 == 3'd5) ? In_register_EBP : 
	( v1815 == 3'd6) ? v15 : v15;
wire [2:0] v1817 = { v12c };
wire [31:0] v1818 = ( v1817 == 3'd0) ? In_register_EAX : 
	( v1817 == 3'd1) ? In_register_ECX : 
	( v1817 == 3'd2) ? In_register_EDX : 
	( v1817 == 3'd3) ? In_register_EBX : 
	( v1817 == 3'd4) ? v15 : 
	( v1817 == 3'd5) ? In_register_EBP : 
	( v1817 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1819 = v1818 << v7f4;
wire [31:0] v181a = v1816 + v1819;
wire [31:0] v181b = v181a + v7f8;
wire [31:0] v181d = ( v17d2 ) ? v180f : 
	( v17e9 ) ? v1813 : v181b;
wire v181e =  v26 == memory_0[15: 12] && v181d == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v181f = In_error_flag == Out_error_flag;
wire [7:0] v1821 = In_register_DF;
wire v1822 = v1821 == Out_register_DF;
wire [31:0] v1824 = In_register_EAX;
wire v1825 = v1824 == Out_register_EAX;
wire [31:0] v1827 = In_register_EBX;
wire v1828 = v1827 == Out_register_EBX;
wire [31:0] v182a = In_register_ECX;
wire v182b = v182a == Out_register_ECX;
wire [31:0] v182f = ( v1807 ) ? v48 : 
	( v17d2 ) ? v45 : v27;
wire [31:0] v1830 = In_register_EIP + v182f;
wire [31:0] v1832 = v1830;
wire v1833 = v1832 == Out_register_EIP;
wire [31:0] v1835 = In_register_EDX;
wire v1836 = v1835 == Out_register_EDX;
wire [2:0] v1837 = { v1fa };
wire [31:0] v1838 = ( v1837 == 3'd0) ? In_register_EAX : 
	( v1837 == 3'd1) ? In_register_ECX : 
	( v1837 == 3'd2) ? In_register_EDX : 
	( v1837 == 3'd3) ? In_register_EBX : 
	( v1837 == 3'd4) ? v15 : 
	( v1837 == 3'd5) ? v15 : 
	( v1837 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1839 = v1838 + v1f7;
wire [2:0] v183b = { v1fa };
wire [31:0] v183c = ( v183b == 3'd0) ? In_register_EAX : 
	( v183b == 3'd1) ? In_register_ECX : 
	( v183b == 3'd2) ? In_register_EDX : 
	( v183b == 3'd3) ? In_register_EBX : 
	( v183b == 3'd4) ? v15 : 
	( v183b == 3'd5) ? v15 : 
	( v183b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v183d = v183c + v63a;
wire [2:0] v183f = { v13c };
wire [31:0] v1840 = ( v183f == 3'd0) ? v15 : 
	( v183f == 3'd1) ? v15 : 
	( v183f == 3'd2) ? v15 : 
	( v183f == 3'd3) ? v15 : 
	( v183f == 3'd4) ? In_register_ESP : 
	( v183f == 3'd5) ? In_register_EBP : 
	( v183f == 3'd6) ? v15 : v15;
wire [2:0] v1841 = { v12c };
wire [31:0] v1842 = ( v1841 == 3'd0) ? In_register_EAX : 
	( v1841 == 3'd1) ? In_register_ECX : 
	( v1841 == 3'd2) ? In_register_EDX : 
	( v1841 == 3'd3) ? In_register_EBX : 
	( v1841 == 3'd4) ? v15 : 
	( v1841 == 3'd5) ? In_register_EBP : 
	( v1841 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1843 = v1842 << v7f4;
wire [31:0] v1844 = v1840 + v1843;
wire [31:0] v1845 = v1844 + v7f8;
wire [31:0] v1847 = ( v17d2 ) ? v1839 : 
	( v17e9 ) ? v183d : v1845;
wire [31:0] v1848 = memory_0[79: 48];
wire [31:0] v184c = ( v1807 ) ? v176b : 
	( v17e9 ) ? v7f8 : vb0c;
wire [31:0] v184d = v1848 + v184c;
wire v184e =  v26 == memory_1[15: 12] && v1847 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v184d == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v1850 = In_register_ESI;
wire v1851 = v1850 == Out_register_ESI;
wire [31:0] v1853 = In_register_EDI;
wire v1854 = v1853 == Out_register_EDI;
wire [31:0] v1856 = In_register_ESBASE;
wire v1857 = v1856 == Out_register_ESBASE;
wire [31:0] v1859 = In_register_EBP;
wire v185a = v1859 == Out_register_EBP;
wire [31:0] v185c = In_register_CSBASE;
wire v185d = v185c == Out_register_CSBASE;
wire v185e = v184d < v1848;
wire v185f = v184d < v184c;
wire v1860 = v185e | v185f;
wire v1862 = v1860;
wire v1863 = v1862 == Out_register_CF;
wire [31:0] v1865 = In_register_FSBASE;
wire v1866 = v1865 == Out_register_FSBASE;
wire [31:0] v1867 = v184d ^ v1848;
wire [31:0] v1868 = v1867 >> v1e;
wire [31:0] v1869 = v184d ^ v184c;
wire [31:0] v186a = v1869 >> v1e;
wire [31:0] v186b = v1868 + v186a;
wire v186c = v186b == v1c;
wire v186e = v186c;
wire v186f = v186e == Out_register_OF;
wire [31:0] v1871 = In_register_DSBASE;
wire v1872 = v1871 == Out_register_DSBASE;
wire [31:0] v1874 = In_register_GSBASE;
wire v1875 = v1874 == Out_register_GSBASE;
wire [31:0] v1877 = In_register_ESP;
wire v1878 = v1877 == Out_register_ESP;
wire [31:0] v1879 = v1869 ^ v1848;
wire [7:0] v187a = v1879[7:0];
wire [7:0] v187b = v187a >> v1d;
wire [7:0] v187c = v187b & v18;
wire v187d = v187c[0:0];
wire v187f = v187d;
wire v1880 = v187f == Out_register_AF;
wire [7:0] v1881 = v184d[7:0];
wire [2:0] v1882_aux = v1881[0] + v1881[1] + v1881[2] + v1881[3] + v1881[4] + v1881[5] + v1881[6] + v1881[7];
wire v1882 = { 5'b00000, v1882_aux };
wire [7:0] v1883 = v1882 & v18;
wire [7:0] v1884 = v1883 ^ v18;
wire v1885 = v1884[0:0];
wire v1887 = v1885;
wire v1888 = v1887 == Out_register_PF;
wire v1889 = $signed(v184d) < $signed(v15);
wire v188b = v1889;
wire v188c = v188b == Out_register_SF;
wire v188d = v184d == v15;
wire v188f = v188d;
wire v1890 = v188f == Out_register_ZF;
wire v1891 = v180c & v181e & v181f & v1822 & v1809 & v1825 & v1828 & v182b & v15c & v1833 & v1836 & v184e & v1851 & v1854 & v1857 & v185a & v185d & v1863 & v1866 & v186f & v1872 & v1875 & v1878 & v1880 & v1888 & v188c & v1890;
wire [10:0] v6f = 11'b00001000101;
wire v1892 = v6f == v6d7;
wire v1893 = v35 == v316;
wire v1894 = v14 == v1ef;
wire v1895 = v1892 & v1893 & v1894;
wire [7:0] v70 = 8'b00001000;
wire v1896 = v70 == v1eb;
wire v1897 = v30 == v316;
wire v1898 = v4 == v11b;
wire [2:0] v1899 = { v1fa };
wire v189a = v1899 == vb;
wire v189b = v189a;
wire v189c = v189b ^ v8;
wire [2:0] v189d = { v1fa };
wire v189e = v189d == vb;
wire v189f = v189e;
wire v18a0 = v189f ^ v8;
wire [2:0] v18a1 = { v1fa };
wire v18a2 = v18a1 == vb;
wire v18a3 = v18a2;
wire v18a4 = v18a3 ^ v8;
wire [2:0] v18a5 = { v1fa };
wire v18a6 = v18a5 == vb;
wire v18a7 = v18a6;
wire v18a8 = v18a7 ^ v8;
wire v18a9 = v189c & v18a0 & v18a4 & v18a8;
wire v18aa = v1896 & v1897 & v1898 & v18a9;
wire v18ab = v70 == v1eb;
wire v18ac = v2f == v316;
wire v18ad = v14 == v1ef;
wire [2:0] v18ae = { v1fa };
wire v18af = v18ae == vb;
wire v18b0 = v18ae == vf;
wire v18b1 = v18af | v18b0;
wire v18b2 = v18b1 ^ v8;
wire [2:0] v18b3 = { v1fa };
wire v18b4 = v18b3 == vb;
wire v18b5 = v18b4;
wire v18b6 = v18b5 ^ v8;
wire [2:0] v18b7 = { v1fa };
wire v18b8 = v18b7 == vb;
wire v18b9 = v18b7 == vf;
wire v18ba = v18b8 | v18b9;
wire v18bb = v18ba ^ v8;
wire [2:0] v18bc = { v1fa };
wire v18bd = v18bc == vb;
wire v18be = v18bd;
wire v18bf = v18be ^ v8;
wire v18c0 = v18b2 & v18b6 & v18bb & v18bf;
wire v18c1 = v18ab & v18ac & v18ad & v18c0;
wire v18c2 = v1895 | v18aa | v18c1;
wire v18c3 = v18c2;
wire [31:0] v18c5 = In_register_ECX;
wire v18c6 = v18c5 == Out_register_ECX;
wire [31:0] v18c7 = memory_0[79: 48];
wire [7:0] v18c8 = v18c7[7:0];
wire [2:0] v18c9 = { v320 };
wire [31:0] v18ca = ( v18c9 == 3'd0) ? In_register_EAX : 
	( v18c9 == 3'd1) ? In_register_ECX : 
	( v18c9 == 3'd2) ? In_register_EDX : 
	( v18c9 == 3'd3) ? In_register_EBX : 
	( v18c9 == 3'd4) ? In_register_EAX : 
	( v18c9 == 3'd5) ? In_register_ECX : 
	( v18c9 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v18cb = { v320 };
wire v18cc = v18cb == vb;
wire v18cd = v18cb == v9;
wire v18ce = v18cc | v18cd;
wire v18cf = v18cb == vf;
wire v18d0 = v18ce | v18cf;
wire v18d1 = v18cb == v11;
wire v18d2 = v18d0 | v18d1;
wire [31:0] v18d3 = ( v18d2 == 1'd0) ? v15 : v31;
wire [31:0] v18d4 = v18ca >> v18d3;
wire [31:0] v18d5 = v18d4 & v32;
wire [2:0] v18d7 = { v320 };
wire [31:0] v18d8 = ( v18d7 == 3'd0) ? In_register_EAX : 
	( v18d7 == 3'd1) ? In_register_ECX : 
	( v18d7 == 3'd2) ? In_register_EDX : 
	( v18d7 == 3'd3) ? In_register_EBX : 
	( v18d7 == 3'd4) ? In_register_EAX : 
	( v18d7 == 3'd5) ? In_register_ECX : 
	( v18d7 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v18d9 = { v320 };
wire v18da = v18d9 == vb;
wire v18db = v18d9 == v9;
wire v18dc = v18da | v18db;
wire v18dd = v18d9 == vf;
wire v18de = v18dc | v18dd;
wire v18df = v18d9 == v11;
wire v18e0 = v18de | v18df;
wire [31:0] v18e1 = ( v18e0 == 1'd0) ? v15 : v31;
wire [31:0] v18e2 = v18d8 >> v18e1;
wire [31:0] v18e3 = v18e2 & v32;
wire [2:0] v18e5 = { v320 };
wire [31:0] v18e6 = ( v18e5 == 3'd0) ? In_register_EAX : 
	( v18e5 == 3'd1) ? In_register_ECX : 
	( v18e5 == 3'd2) ? In_register_EDX : 
	( v18e5 == 3'd3) ? In_register_EBX : 
	( v18e5 == 3'd4) ? In_register_EAX : 
	( v18e5 == 3'd5) ? In_register_ECX : 
	( v18e5 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v18e7 = { v320 };
wire v18e8 = v18e7 == vb;
wire v18e9 = v18e7 == v9;
wire v18ea = v18e8 | v18e9;
wire v18eb = v18e7 == vf;
wire v18ec = v18ea | v18eb;
wire v18ed = v18e7 == v11;
wire v18ee = v18ec | v18ed;
wire [31:0] v18ef = ( v18ee == 1'd0) ? v15 : v31;
wire [31:0] v18f0 = v18e6 >> v18ef;
wire [31:0] v18f1 = v18f0 & v32;
wire [31:0] v18f3 = ( v1895 ) ? v18d5 : 
	( v18aa ) ? v18e3 : v18f1;
wire [7:0] v18f4 = v18f3[7:0];
wire [7:0] v18f5 = v18c8 + v18f4;
wire [7:0] v18f6 = v65f + v18f5;
wire v18f7 = $signed(v18f6) < $signed(v2c);
wire v18f9 = v18f7;
wire v18fa = v18f9 == Out_register_SF;
wire [2:0] v18fc = { v1fa };
wire [31:0] v18fd = ( v18fc == 3'd0) ? In_register_EAX : 
	( v18fc == 3'd1) ? In_register_ECX : 
	( v18fc == 3'd2) ? In_register_EDX : 
	( v18fc == 3'd3) ? In_register_EBX : 
	( v18fc == 3'd4) ? v15 : 
	( v18fc == 3'd5) ? In_register_EBP : 
	( v18fc == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v18fe = v18fd + v63a;
wire [2:0] v1900 = { v1fa };
wire [31:0] v1901 = ( v1900 == 3'd0) ? In_register_EAX : 
	( v1900 == 3'd1) ? In_register_ECX : 
	( v1900 == 3'd2) ? In_register_EDX : 
	( v1900 == 3'd3) ? In_register_EBX : 
	( v1900 == 3'd4) ? v15 : 
	( v1900 == 3'd5) ? v15 : 
	( v1900 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1902 = v1901 + v1f7;
wire [31:0] v1904 = ( v18aa ) ? v18fe : 
	( v18c1 ) ? v1902 : v1f7;
wire v1905 =  v2a == memory_0[15: 12] && v1904 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v1907 = In_register_EBX;
wire v1908 = v1907 == Out_register_EBX;
wire [31:0] v190a = In_register_ESI;
wire v190b = v190a == Out_register_ESI;
wire [31:0] v190d = In_register_ESP;
wire v190e = v190d == Out_register_ESP;
wire [2:0] v1910 = { v1fa };
wire [31:0] v1911 = ( v1910 == 3'd0) ? In_register_EAX : 
	( v1910 == 3'd1) ? In_register_ECX : 
	( v1910 == 3'd2) ? In_register_EDX : 
	( v1910 == 3'd3) ? In_register_EBX : 
	( v1910 == 3'd4) ? v15 : 
	( v1910 == 3'd5) ? In_register_EBP : 
	( v1910 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1912 = v1911 + v63a;
wire [2:0] v1914 = { v1fa };
wire [31:0] v1915 = ( v1914 == 3'd0) ? In_register_EAX : 
	( v1914 == 3'd1) ? In_register_ECX : 
	( v1914 == 3'd2) ? In_register_EDX : 
	( v1914 == 3'd3) ? In_register_EBX : 
	( v1914 == 3'd4) ? v15 : 
	( v1914 == 3'd5) ? v15 : 
	( v1914 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1916 = v1915 + v1f7;
wire [31:0] v1918 = ( v18aa ) ? v1912 : 
	( v18c1 ) ? v1916 : v1f7;
wire v1919 =  v2a == memory_1[15: 12] && v1918 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v18f6 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v191b = In_register_GSBASE;
wire v191c = v191b == Out_register_GSBASE;
wire [31:0] v191e = In_register_EBP;
wire v191f = v191e == Out_register_EBP;
wire [31:0] v1921 = In_register_EDX;
wire v1922 = v1921 == Out_register_EDX;
wire [31:0] v1924 = In_register_EAX;
wire v1925 = v1924 == Out_register_EAX;
wire [31:0] v1927 = In_register_EDI;
wire v1928 = v1927 == Out_register_EDI;
wire v1929 = v18f5 < v18c8;
wire v192a = v18f5 < v18f4;
wire v192b = v1929 | v192a;
wire v192c = v192b ^ v8;
wire v192d = v18f6 < v18f5;
wire v192e = v18f6 < v65f;
wire v192f = v192d | v192e;
wire [7:0] v1930 = { 7'b0000000, v192f };
wire [7:0] v1931 = ( v192c == 1'd0) ? v18 : v1930;
wire v1932 = v1931[0:0];
wire v1934 = v1932;
wire v1935 = v1934 == Out_register_CF;
wire [31:0] v1939 = ( v1895 | v18c1 ) ? v16 : v10;
wire [31:0] v193a = In_register_EIP + v1939;
wire [31:0] v193c = v193a;
wire v193d = v193c == Out_register_EIP;
wire [31:0] v193f = In_register_CSBASE;
wire v1940 = v193f == Out_register_CSBASE;
wire [31:0] v1942 = In_register_ESBASE;
wire v1943 = v1942 == Out_register_ESBASE;
wire [31:0] v1945 = In_register_DSBASE;
wire v1946 = v1945 == Out_register_DSBASE;
wire [7:0] v1947 = v18f6 ^ v18c8;
wire [7:0] v1948 = v1947 >> v33;
wire [7:0] v1949 = v18f6 ^ v18f4;
wire [7:0] v194a = v1949 >> v33;
wire [7:0] v194b = v1948 + v194a;
wire v194c = v194b == v34;
wire v194e = v194c;
wire v194f = v194e == Out_register_OF;
wire [31:0] v1951 = In_register_FSBASE;
wire v1952 = v1951 == Out_register_FSBASE;
wire [7:0] v1953 = v1949 ^ v18c8;
wire [7:0] v1954 = v1953 >> v1d;
wire [7:0] v1955 = v1954 & v18;
wire v1956 = v1955[0:0];
wire v1958 = v1956;
wire v1959 = v1958 == Out_register_AF;
wire [7:0] v195b = In_register_DF;
wire v195c = v195b == Out_register_DF;
wire v195d = In_error_flag == Out_error_flag;
wire [31:0] v195f = In_register_SSBASE;
wire v1960 = v195f == Out_register_SSBASE;
wire [2:0] v1961_aux = v18f6[0] + v18f6[1] + v18f6[2] + v18f6[3] + v18f6[4] + v18f6[5] + v18f6[6] + v18f6[7];
wire v1961 = { 5'b00000, v1961_aux };
wire [7:0] v1962 = v1961 & v18;
wire [7:0] v1963 = v1962 ^ v18;
wire v1964 = v1963[0:0];
wire v1966 = v1964;
wire v1967 = v1966 == Out_register_PF;
wire v1968 = v18f6 == v2c;
wire v196a = v1968;
wire v196b = v196a == Out_register_ZF;
wire v196c = v18c6 & v18fa & v1905 & v15c & v1908 & v190b & v190e & v1919 & v191c & v191f & v1922 & v1925 & v1928 & v18c3 & v1935 & v193d & v1940 & v1943 & v1946 & v194f & v1952 & v1959 & v195c & v195d & v1960 & v1967 & v196b;
wire v196d = v34 == v1eb;
wire v196e = v3 == v316;
wire v196f = v1b == v318;
wire v1970 = v196d & v196e & v196f;
wire v1971 = v1970;
wire v1972 = v1971;
wire [31:0] v1974 = In_register_GSBASE;
wire v1975 = v1974 == Out_register_GSBASE;
wire v1976 = In_error_flag == Out_error_flag;
wire [2:0] v1977 = { v1fa };
wire [31:0] v1978 = ( v1977 == 3'd0) ? In_register_EAX : 
	( v1977 == 3'd1) ? In_register_ECX : 
	( v1977 == 3'd2) ? In_register_EDX : 
	( v1977 == 3'd3) ? In_register_EBX : 
	( v1977 == 3'd4) ? In_register_EAX : 
	( v1977 == 3'd5) ? In_register_ECX : 
	( v1977 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v1979 = { v1fa };
wire v197a = v1979 == vb;
wire v197b = v1979 == v9;
wire v197c = v197a | v197b;
wire v197d = v1979 == vf;
wire v197e = v197c | v197d;
wire v197f = v1979 == v11;
wire v1980 = v197e | v197f;
wire [31:0] v1981 = ( v1980 == 1'd0) ? v15 : v31;
wire [31:0] v1982 = v1978 >> v1981;
wire [31:0] v1983 = v1982 & v32;
wire [31:0] v1985 = v1983;
wire [7:0] v1986 = v1985[7:0];
wire [2:0] v1987 = { v320 };
wire [31:0] v1988 = ( v1987 == 3'd0) ? In_register_EAX : 
	( v1987 == 3'd1) ? In_register_ECX : 
	( v1987 == 3'd2) ? In_register_EDX : 
	( v1987 == 3'd3) ? In_register_EBX : 
	( v1987 == 3'd4) ? In_register_EAX : 
	( v1987 == 3'd5) ? In_register_ECX : 
	( v1987 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v1989 = { v320 };
wire v198a = v1989 == vb;
wire v198b = v1989 == v9;
wire v198c = v198a | v198b;
wire v198d = v1989 == vf;
wire v198e = v198c | v198d;
wire v198f = v1989 == v11;
wire v1990 = v198e | v198f;
wire [31:0] v1991 = ( v1990 == 1'd0) ? v15 : v31;
wire [31:0] v1992 = v1988 >> v1991;
wire [31:0] v1993 = v1992 & v32;
wire [31:0] v1995 = v1993;
wire [7:0] v1996 = v1995[7:0];
wire [7:0] v1997 = v1986 + v1996;
wire v1998 = $signed(v1997) < $signed(v2c);
wire v199a = v1998;
wire v199b = v199a == Out_register_SF;
wire [31:0] v199d = In_register_DSBASE;
wire v199e = v199d == Out_register_DSBASE;
wire [2:0] v19a1 = { v320 };
wire v19a9 = v19a1 == v11;
wire v19aa = v19a9;
wire v19ab = v1970 & v19aa;
wire v19ac = v19ab;
wire [31:0] v199f = { 24'b000000000000000000000000, v1997 };
wire [31:0] v19a7 = v199f << v31;
wire [31:0] v19a8 = v778 | v19a7;
wire v19a2 = v19a1 == ve;
wire v19a3 = v19a2;
wire v19a4 = v1970 & v19a3;
wire v19a5 = v19a4;
wire [31:0] v19a0 = v768 | v199f;
wire [31:0] v19af = ( v8 ) ? In_register_EDX : 
	( v19ac ) ? v19a8 : v19a0;
wire [31:0] v19b1 = v19af;
wire v19b2 = v19b1 == Out_register_EDX;
wire v19b4 = v19a1 == vd;
wire v19b5 = v19b4;
wire v19b6 = v1970 & v19b5;
wire v19b7 = v19b6;
wire [31:0] v19b3 = v7b8 | v199f;
wire v19ba = v19a1 == v9;
wire v19bb = v19ba;
wire v19bc = v1970 & v19bb;
wire v19bd = v19bc;
wire [31:0] v19b9 = v7c8 | v19a7;
wire [31:0] v19c0 = ( v8 ) ? In_register_EBX : 
	( v19b7 ) ? v19b3 : v19b9;
wire [31:0] v19c2 = v19c0;
wire v19c3 = v19c2 == Out_register_EBX;
wire [31:0] v19c5 = In_register_CSBASE;
wire v19c6 = v19c5 == Out_register_CSBASE;
wire [7:0] v19c7 = v1997 ^ v1986;
wire [7:0] v19c8 = v19c7 ^ v1996;
wire [7:0] v19c9 = v19c8 >> v1d;
wire [7:0] v19ca = v19c9 & v18;
wire v19cb = v19ca[0:0];
wire v19cd = v19cb;
wire v19ce = v19cd == Out_register_AF;
wire v19d0 = v19a1 == v7;
wire v19d1 = v19d0;
wire v19d2 = v1970 & v19d1;
wire v19d3 = v19d2;
wire [31:0] v19cf = v5c8 | v199f;
wire v19d6 = v19a1 == vb;
wire v19d7 = v19d6;
wire v19d8 = v1970 & v19d7;
wire v19d9 = v19d8;
wire [31:0] v19d5 = v752 | v19a7;
wire [31:0] v19dc = ( v8 ) ? In_register_EAX : 
	( v19d3 ) ? v19cf : v19d5;
wire [31:0] v19de = v19dc;
wire v19df = v19de == Out_register_EAX;
wire v19e0 = v1997 == v2c;
wire v19e2 = v19e0;
wire v19e3 = v19e2 == Out_register_ZF;
wire [31:0] v19e5 = In_register_ESI;
wire v19e6 = v19e5 == Out_register_ESI;
wire [31:0] v19e8 = In_register_EDI;
wire v19e9 = v19e8 == Out_register_EDI;
wire v19eb = v19a1 == vf;
wire v19ec = v19eb;
wire v19ed = v1970 & v19ec;
wire v19ee = v19ed;
wire [31:0] v19ea = v790 | v19a7;
wire v19f1 = v19a1 == vc;
wire v19f2 = v19f1;
wire v19f3 = v1970 & v19f2;
wire v19f4 = v19f3;
wire [31:0] v19f0 = v7a0 | v199f;
wire [31:0] v19f7 = ( v8 ) ? In_register_ECX : 
	( v19ee ) ? v19ea : v19f0;
wire [31:0] v19f9 = v19f7;
wire v19fa = v19f9 == Out_register_ECX;
wire [2:0] v19fb_aux = v1997[0] + v1997[1] + v1997[2] + v1997[3] + v1997[4] + v1997[5] + v1997[6] + v1997[7];
wire v19fb = { 5'b00000, v19fb_aux };
wire [7:0] v19fc = v19fb & v18;
wire [7:0] v19fd = v19fc ^ v18;
wire v19fe = v19fd[0:0];
wire v1a00 = v19fe;
wire v1a01 = v1a00 == Out_register_PF;
wire [31:0] v1a03 = In_register_ESBASE;
wire v1a04 = v1a03 == Out_register_ESBASE;
wire v1a05 = v1997 < v1996;
wire v1a06 = v1997 < v1986;
wire v1a07 = v1a05 | v1a06;
wire v1a09 = v1a07;
wire v1a0a = v1a09 == Out_register_CF;
wire [31:0] v1a0c = v1c;
wire [31:0] v1a0d = In_register_EIP + v1a0c;
wire [31:0] v1a0f = v1a0d;
wire v1a10 = v1a0f == Out_register_EIP;
wire [7:0] v1a11 = v1997 ^ v1996;
wire [7:0] v1a12 = v1a11 >> v33;
wire [7:0] v1a13 = v19c7 >> v33;
wire [7:0] v1a14 = v1a12 + v1a13;
wire v1a15 = v1a14 == v34;
wire v1a17 = v1a15;
wire v1a18 = v1a17 == Out_register_OF;
wire [31:0] v1a1a = In_register_SSBASE;
wire v1a1b = v1a1a == Out_register_SSBASE;
wire [31:0] v1a1d = In_register_EBP;
wire v1a1e = v1a1d == Out_register_EBP;
wire [31:0] v1a20 = In_register_ESP;
wire v1a21 = v1a20 == Out_register_ESP;
wire [31:0] v1a23 = In_register_FSBASE;
wire v1a24 = v1a23 == Out_register_FSBASE;
wire [7:0] v1a26 = In_register_DF;
wire v1a27 = v1a26 == Out_register_DF;
wire v1a28 = v1975 & v1976 & v199b & v199e & v15c & v19b2 & v19c3 & v19c6 & v19ce & v19df & v1972 & v19e3 & v19e6 & v19e9 & v19fa & v1a01 & v1a04 & v1a0a & v1a10 & v1a18 & v1a1b & v1a1e & v1a21 & v1a24 & v1a27;
wire [7:0] v71 = 8'b11101111;
wire v1a29 = v71 == v1eb;
wire v1a2a = v25 == v1ed;
wire v1a2b = v14 == v1ef;
wire [2:0] v1a2c = { v1fa };
wire v1a2d = v1a2c == vb;
wire v1a2e = v1a2c == vf;
wire v1a2f = v1a2d | v1a2e;
wire v1a30 = v1a2f ^ v8;
wire [2:0] v1a31 = { v1fa };
wire v1a32 = v1a31 == vb;
wire v1a33 = v1a31 == vf;
wire v1a34 = v1a32 | v1a33;
wire v1a35 = v1a34 ^ v8;
wire v1a36 = v1a30 & v1a35;
wire v1a37 = v1a29 & v1a2a & v1a2b & v1a36;
wire [15:0] v72 = 16'b1110111100100000;
wire v1a38 = v72 == v117;
wire v1a39 = v43 == vab3;
wire [2:0] v1a3a = { v13c };
wire v1a3b = v1a3a == vb;
wire v1a3c = v1a3a == vf;
wire v1a3d = v1a3b | v1a3c;
wire v1a3e = v1a3d ^ v8;
wire [2:0] v1a3f = { v12c };
wire v1a40 = v1a3f == vb;
wire v1a41 = v1a40;
wire v1a42 = v1a41 ^ v8;
wire [2:0] v1a43 = { v13c };
wire v1a44 = v1a43 == vf;
wire v1a45 = v1a44;
wire v1a46 = v1a45 ^ v8;
wire v1a47 = v1a3e & v1a42 & v1a46;
wire v1a48 = v1a38 & v1a39 & v1a47;
wire v1a49 = v1a37 | v1a48;
wire v1a4a = v1a49;
wire [31:0] v1a4c = In_register_CSBASE;
wire v1a4d = v1a4c == Out_register_CSBASE;
wire [31:0] v1a4f = In_register_ECX;
wire v1a50 = v1a4f == Out_register_ECX;
wire [31:0] v1a53 = ( v1a48 ) ? v45 : v16;
wire [31:0] v1a54 = In_register_EIP + v1a53;
wire [31:0] v1a56 = v1a54;
wire v1a57 = v1a56 == Out_register_EIP;
wire [31:0] v1a59 = In_register_EBX;
wire v1a5a = v1a59 == Out_register_EBX;
wire [31:0] v1a5b = memory_0[79: 48];
wire [31:0] v1a5e = ( v1a48 ) ? vc2d : v1f7;
wire [31:0] v1a5f = v1a5b & v1a5e;
wire v1a60 = v1a5f == v15;
wire v1a62 = v1a60;
wire v1a63 = v1a62 == Out_register_ZF;
wire v1a64 = In_error_flag == Out_error_flag;
wire [31:0] v1a66 = In_register_EDX;
wire v1a67 = v1a66 == Out_register_EDX;
wire [31:0] v1a69 = In_register_ESI;
wire v1a6a = v1a69 == Out_register_ESI;
wire [31:0] v1a6c = In_register_DSBASE;
wire v1a6d = v1a6c == Out_register_DSBASE;
wire [7:0] v1a6f = In_register_DF;
wire v1a70 = v1a6f == Out_register_DF;
wire [31:0] v1a72 = In_register_EDI;
wire v1a73 = v1a72 == Out_register_EDI;
wire [31:0] v1a75 = In_register_ESP;
wire v1a76 = v1a75 == Out_register_ESP;
wire [31:0] v1a78 = In_register_EAX;
wire v1a79 = v1a78 == Out_register_EAX;
wire [31:0] v1a7b = In_register_EBP;
wire v1a7c = v1a7b == Out_register_EBP;
wire [31:0] v1a7e = In_register_SSBASE;
wire v1a7f = v1a7e == Out_register_SSBASE;
wire [31:0] v1a81 = In_register_ESBASE;
wire v1a82 = v1a81 == Out_register_ESBASE;
wire [31:0] v1a84 = In_register_GSBASE;
wire v1a85 = v1a84 == Out_register_GSBASE;
wire [31:0] v1a87 = In_register_FSBASE;
wire v1a88 = v1a87 == Out_register_FSBASE;
wire v1a8a = In_register_AF;
wire v1a8b = v1a8a == Out_register_AF;
wire [2:0] v1a8f = { v13c };
wire [31:0] v1a90 = ( v1a8f == 3'd0) ? In_register_EAX : 
	( v1a8f == 3'd1) ? In_register_ECX : 
	( v1a8f == 3'd2) ? In_register_EDX : 
	( v1a8f == 3'd3) ? In_register_EBX : 
	( v1a8f == 3'd4) ? v15 : 
	( v1a8f == 3'd5) ? v15 : 
	( v1a8f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1a91 = { v12c };
wire [31:0] v1a92 = ( v1a91 == 3'd0) ? In_register_EAX : 
	( v1a91 == 3'd1) ? In_register_ECX : 
	( v1a91 == 3'd2) ? In_register_EDX : 
	( v1a91 == 3'd3) ? In_register_EBX : 
	( v1a91 == 3'd4) ? v15 : 
	( v1a91 == 3'd5) ? In_register_EBP : 
	( v1a91 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1a93 = v1a92 << v7f4;
wire [31:0] v1a94 = v1a90 + v1a93;
wire [2:0] v1a8c = { v1fa };
wire [31:0] v1a8d = ( v1a8c == 3'd0) ? In_register_EAX : 
	( v1a8c == 3'd1) ? In_register_ECX : 
	( v1a8c == 3'd2) ? In_register_EDX : 
	( v1a8c == 3'd3) ? In_register_EBX : 
	( v1a8c == 3'd4) ? v15 : 
	( v1a8c == 3'd5) ? v15 : 
	( v1a8c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1a96 = ( v1a48 ) ? v1a94 : v1a8d;
wire v1a97 =  v26 == memory_0[15: 12] && v1a96 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v1a99 = v17;
wire v1a9a = v1a99 == Out_register_OF;
wire v1a9b = v17;
wire v1a9c = v1a9b == Out_register_CF;
wire [7:0] v1a9d = v1a5f[7:0];
wire [2:0] v1a9e_aux = v1a9d[0] + v1a9d[1] + v1a9d[2] + v1a9d[3] + v1a9d[4] + v1a9d[5] + v1a9d[6] + v1a9d[7];
wire v1a9e = { 5'b00000, v1a9e_aux };
wire [7:0] v1a9f = v1a9e & v18;
wire [7:0] v1aa0 = v1a9f ^ v18;
wire v1aa1 = v1aa0[0:0];
wire v1aa3 = v1aa1;
wire v1aa4 = v1aa3 == Out_register_PF;
wire v1aa5 = $signed(v1a5f) < $signed(v15);
wire v1aa7 = v1aa5;
wire v1aa8 = v1aa7 == Out_register_SF;
wire v1aa9 = v1a4d & v1a50 & v1a57 & v1a5a & v1a63 & v1a64 & v1a67 & v1a6a & v1a6d & v1a70 & v1a73 & v15c & v1a76 & v1a79 & v1a7c & v1a7f & v1a82 & v1a85 & v1a88 & v1a4a & v1a8b & v1a97 & v1a9a & v1a9c & v1aa4 & v1aa8;
wire v1aaa = v4e == v1eb;
wire [4:0] v73 = 5'b10001;
wire v1aab = v73 == v1ed;
wire v1aac = v14 == v1ef;
wire [2:0] v1aad = { v1fa };
wire v1aae = v1aad == vb;
wire v1aaf = v1aad == vf;
wire v1ab0 = v1aae | v1aaf;
wire v1ab1 = v1ab0 ^ v8;
wire [2:0] v1ab2 = { v1fa };
wire v1ab3 = v1ab2 == vb;
wire v1ab4 = v1ab3;
wire v1ab5 = v1ab4 ^ v8;
wire [2:0] v1ab6 = { v1fa };
wire v1ab7 = v1ab6 == vb;
wire v1ab8 = v1ab6 == vf;
wire v1ab9 = v1ab7 | v1ab8;
wire v1aba = v1ab9 ^ v8;
wire [2:0] v1abb = { v1fa };
wire v1abc = v1abb == vb;
wire v1abd = v1abc;
wire v1abe = v1abd ^ v8;
wire v1abf = v1ab1 & v1ab5 & v1aba & v1abe;
wire v1ac0 = v1aaa & v1aab & v1aac & v1abf;
wire v1ac1 = v4e == v1eb;
wire v1ac2 = v8 == v829;
wire [4:0] v74 = 5'b10000;
wire v1ac3 = v74 == v1ed;
wire v1ac4 = v1b == v318;
wire v1ac5 = v1ac1 & v1ac2 & v1ac3 & v1ac4;
wire [15:0] v75 = 16'b1111111110110000;
wire v1ac6 = v75 == v117;
wire v1ac7 = v14 == v1ef;
wire v1ac8 = v1ac6 & v1ac7;
wire v1ac9 = v1ac0 | v1ac5 | v1ac8;
wire v1aca = v1ac9;
wire [2:0] v1acb = { v1fa };
wire [31:0] v1acc = ( v1acb == 3'd0) ? In_register_EAX : 
	( v1acb == 3'd1) ? In_register_ECX : 
	( v1acb == 3'd2) ? In_register_EDX : 
	( v1acb == 3'd3) ? In_register_EBX : 
	( v1acb == 3'd4) ? v15 : 
	( v1acb == 3'd5) ? v15 : 
	( v1acb == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1acd = v1acc + v1f7;
wire [1:0] v1acf = { v889 , v888 };
wire [31:0] v1ad0 = ( v1acf == 2'd0) ? In_register_EDX : 
	( v1acf == 2'd1) ? In_register_ESI : 
	( v1acf == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v1ad3 = ( v1ac0 ) ? v1acd : 
	( v1ac5 ) ? v1ad0 : v1f7;
wire v1ad4 =  v26 == memory_0[15: 12] && v1ad3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v1ad6 = In_register_SSBASE;
wire v1ad7 = v1ad6 == Out_register_SSBASE;
wire [31:0] v1ad9 = In_register_GSBASE;
wire v1ada = v1ad9 == Out_register_GSBASE;
wire v1adb = In_error_flag == Out_error_flag;
wire [31:0] v1add = In_register_EDI;
wire v1ade = v1add == Out_register_EDI;
wire [31:0] v1ae0 = In_register_EAX;
wire v1ae1 = v1ae0 == Out_register_EAX;
wire [31:0] v1ae3 = In_register_EBX;
wire v1ae4 = v1ae3 == Out_register_EBX;
wire [31:0] v1ae6 = In_register_ECX;
wire v1ae7 = v1ae6 == Out_register_ECX;
wire [31:0] v1ae9 = In_register_DSBASE;
wire v1aea = v1ae9 == Out_register_DSBASE;
wire [31:0] v1aec = In_register_ESP;
wire v1aed = v1aec == Out_register_ESP;
wire [31:0] v1af1 = ( v1ac5 ) ? v1c : v16;
wire [31:0] v1af2 = In_register_EIP + v1af1;
wire [31:0] v1af4 = v1af2;
wire v1af5 = v1af4 == Out_register_EIP;
wire [31:0] v1af7 = In_register_EBP;
wire v1af8 = v1af7 == Out_register_EBP;
wire [31:0] v1afa = In_register_ESI;
wire v1afb = v1afa == Out_register_ESI;
wire [31:0] v1afc = memory_0[79: 48];
wire [31:0] v1afd = v1afc + v20;
wire [31:0] v1afe = v1afd ^ v1afc;
wire [7:0] v1aff = v1afe[7:0];
wire [7:0] v1b00 = v1aff >> v1d;
wire [7:0] v1b01 = v1b00 & v18;
wire v1b02 = v1b01[0:0];
wire v1b04 = v1b02;
wire v1b05 = v1b04 == Out_register_AF;
wire [31:0] v1b07 = In_register_CSBASE;
wire v1b08 = v1b07 == Out_register_CSBASE;
wire [31:0] v1b0a = In_register_ESBASE;
wire v1b0b = v1b0a == Out_register_ESBASE;
wire [2:0] v1b0c = { v1fa };
wire [31:0] v1b0d = ( v1b0c == 3'd0) ? In_register_EAX : 
	( v1b0c == 3'd1) ? In_register_ECX : 
	( v1b0c == 3'd2) ? In_register_EDX : 
	( v1b0c == 3'd3) ? In_register_EBX : 
	( v1b0c == 3'd4) ? v15 : 
	( v1b0c == 3'd5) ? v15 : 
	( v1b0c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1b0e = v1b0d + v1f7;
wire [1:0] v1b10 = { v889 , v888 };
wire [31:0] v1b11 = ( v1b10 == 2'd0) ? In_register_EDX : 
	( v1b10 == 2'd1) ? In_register_ESI : 
	( v1b10 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v1b14 = ( v1ac0 ) ? v1b0e : 
	( v1ac5 ) ? v1b11 : v1f7;
wire v1b15 =  v26 == memory_1[15: 12] && v1b14 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v1afd == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v1b17 = In_register_FSBASE;
wire v1b18 = v1b17 == Out_register_FSBASE;
wire v1b1a = In_register_CF;
wire v1b1b = v1b1a == Out_register_CF;
wire [7:0] v1b1c = v1afd[7:0];
wire [2:0] v1b1d_aux = v1b1c[0] + v1b1c[1] + v1b1c[2] + v1b1c[3] + v1b1c[4] + v1b1c[5] + v1b1c[6] + v1b1c[7];
wire v1b1d = { 5'b00000, v1b1d_aux };
wire [7:0] v1b1e = v1b1d & v18;
wire [7:0] v1b1f = v1b1e ^ v18;
wire v1b20 = v1b1f[0:0];
wire v1b22 = v1b20;
wire v1b23 = v1b22 == Out_register_PF;
wire [31:0] v1b25 = In_register_EDX;
wire v1b26 = v1b25 == Out_register_EDX;
wire [31:0] v1b27 = v1afe >> v1e;
wire [31:0] v1b28 = v1afc >> v1e;
wire [31:0] v1b29 = v1b27 + v1b28;
wire v1b2a = v1b29 == v1c;
wire v1b2c = v1b2a;
wire v1b2d = v1b2c == Out_register_OF;
wire [7:0] v1b2f = In_register_DF;
wire v1b30 = v1b2f == Out_register_DF;
wire v1b31 = $signed(v1afd) < $signed(v15);
wire v1b33 = v1b31;
wire v1b34 = v1b33 == Out_register_SF;
wire v1b35 = v1afd == v15;
wire v1b37 = v1b35;
wire v1b38 = v1b37 == Out_register_ZF;
wire v1b39 = v1aca & v15c & v1ad4 & v1ad7 & v1ada & v1adb & v1ade & v1ae1 & v1ae4 & v1ae7 & v1aea & v1aed & v1af5 & v1af8 & v1afb & v1b05 & v1b08 & v1b0b & v1b15 & v1b18 & v1b1b & v1b23 & v1b26 & v1b2d & v1b30 & v1b34 & v1b38;
wire [7:0] v76 = 8'b01100101;
wire v1b3a = v76 == v1eb;
wire v1b3b = v29 == v59f;
wire v1b3c = v1b3a & v1b3b;
wire v1b3d = v1b3c;
wire v1b3e = v1b3d;
wire [31:0] v1b40 = In_register_EDX;
wire v1b41 = v1b40 == Out_register_EDX;
wire v1b42 = In_error_flag == Out_error_flag;
wire [31:0] v1b44 = In_register_EBX;
wire v1b45 = v1b44 == Out_register_EBX;
wire [31:0] v1b47 = In_register_ESBASE;
wire v1b48 = v1b47 == Out_register_ESBASE;
wire v1b49 =  v2a == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v1b4a = memory_0[79: 48];
wire [7:0] v1b4b = v1b4a[7:0];
wire [31:0] v1b4c = memory_1[79: 48];
wire [7:0] v1b4d = v1b4c[7:0];
wire v1b4e = v1b4b == v1b4d;
wire v1b50 = v1b4e;
wire v1b51 = v1b50 == Out_register_ZF;
wire [7:0] v1b52 = v1b4b - v1b4d;
wire v1b53 = $signed(v1b52) < $signed(v2c);
wire v1b55 = v1b53;
wire v1b56 = v1b55 == Out_register_SF;
wire [31:0] v1b58 = In_register_ECX;
wire v1b59 = v1b58 == Out_register_ECX;
wire [31:0] v1b5b = v5c1;
wire v1b5c = v1b5b == Out_register_ESI;
wire [31:0] v1b5d = v5c0 + In_register_EDI;
wire [31:0] v1b5f = v1b5d;
wire v1b60 = v1b5f == Out_register_EDI;
wire [7:0] v1b61 = v1b4d ^ v1b4b;
wire [7:0] v1b62 = v1b61 ^ v1b52;
wire [7:0] v1b63 = v1b62 >> v1d;
wire [7:0] v1b64 = v1b63 & v18;
wire v1b65 = v1b64[0:0];
wire v1b67 = v1b65;
wire v1b68 = v1b67 == Out_register_AF;
wire [31:0] v1b6a = v2b;
wire [31:0] v1b6b = In_register_EIP + v1b6a;
wire [31:0] v1b6d = v1b6b;
wire v1b6e = v1b6d == Out_register_EIP;
wire [31:0] v1b70 = In_register_CSBASE;
wire v1b71 = v1b70 == Out_register_CSBASE;
wire [31:0] v1b73 = In_register_SSBASE;
wire v1b74 = v1b73 == Out_register_SSBASE;
wire [31:0] v1b76 = In_register_DSBASE;
wire v1b77 = v1b76 == Out_register_DSBASE;
wire [31:0] v1b79 = In_register_EBP;
wire v1b7a = v1b79 == Out_register_EBP;
wire [31:0] v1b7c = In_register_GSBASE;
wire v1b7d = v1b7c == Out_register_GSBASE;
wire [31:0] v1b7f = In_register_ESP;
wire v1b80 = v1b7f == Out_register_ESP;
wire [31:0] v1b82 = In_register_FSBASE;
wire v1b83 = v1b82 == Out_register_FSBASE;
wire v1b84 = v1b4b < v1b4d;
wire v1b86 = v1b84;
wire v1b87 = v1b86 == Out_register_CF;
wire [31:0] v1b89 = In_register_EAX;
wire v1b8a = v1b89 == Out_register_EAX;
wire [7:0] v1b8c = In_register_DF;
wire v1b8d = v1b8c == Out_register_DF;
wire [31:0] v1b8e = In_register_ESBASE + In_register_EDI;
wire v1b8f =  v2a == memory_1[15: 12] && v1b8e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b0 == memory_1[1: 1];
wire [7:0] v1b90 = v1b52 ^ v1b4b;
wire [7:0] v1b91 = v1b90 >> v33;
wire [7:0] v1b92 = v1b61 >> v33;
wire [7:0] v1b93 = v1b91 + v1b92;
wire v1b94 = v1b93 == v34;
wire v1b96 = v1b94;
wire v1b97 = v1b96 == Out_register_OF;
wire [2:0] v1b98_aux = v1b52[0] + v1b52[1] + v1b52[2] + v1b52[3] + v1b52[4] + v1b52[5] + v1b52[6] + v1b52[7];
wire v1b98 = { 5'b00000, v1b98_aux };
wire [7:0] v1b99 = v1b98 & v18;
wire [7:0] v1b9a = v1b99 ^ v18;
wire v1b9b = v1b9a[0:0];
wire v1b9d = v1b9b;
wire v1b9e = v1b9d == Out_register_PF;
wire v1b9f = v1b3e & v15c & v1b41 & v1b42 & v1b45 & v1b48 & v1b49 & v1b51 & v1b56 & v1b59 & v1b5c & v1b60 & v1b68 & v1b6e & v1b71 & v1b74 & v1b77 & v1b7a & v1b7d & v1b80 & v1b83 & v1b87 & v1b8a & v1b8d & v1b8f & v1b97 & v1b9e;
wire v1ba0 = v40 == v1eb;
wire v1ba1 = v62 == v1ed;
wire v1ba2 = v4 == v11b;
wire v1ba3 = v1ba0 & v1ba1 & v1ba2;
wire v1bb4 = v1ba3;
wire v1bb5 = v1bb4;
wire [2:0] v1bac = { v1fa };
wire v1bad = v1bac == v9;
wire v1bae = v1bad;
wire v1baf = v1ba3 & v1bae;
wire v1bb0 = v1baf;
wire [31:0] v1ba5 = v63a;
wire [2:0] v1ba6 = { v1fa };
wire [31:0] v1ba7 = ( v1ba6 == 3'd0) ? In_register_EAX : 
	( v1ba6 == 3'd1) ? In_register_ECX : 
	( v1ba6 == 3'd2) ? In_register_EDX : 
	( v1ba6 == 3'd3) ? In_register_EBX : 
	( v1ba6 == 3'd4) ? In_register_ESP : 
	( v1ba6 == 3'd5) ? In_register_EBP : 
	( v1ba6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1ba9 = v1ba7;
wire [31:0] v1baa = v1ba5 + v1ba9;
wire [31:0] v1bab = v1baa + vb11;
wire [31:0] v1bb3 = ( v8 ) ? In_register_EDI : v1bab;
wire [31:0] v1bb7 = v1bb3;
wire v1bb8 = v1bb7 == Out_register_EDI;
wire [31:0] v1bba = v10;
wire [31:0] v1bbb = In_register_EIP + v1bba;
wire [31:0] v1bbd = v1bbb;
wire v1bbe = v1bbd == Out_register_EIP;
wire [31:0] v1bc0 = In_register_CSBASE;
wire v1bc1 = v1bc0 == Out_register_CSBASE;
wire v1bc2 = v1bac == v7;
wire v1bc3 = v1bc2;
wire v1bc4 = v1ba3 & v1bc3;
wire v1bc5 = v1bc4;
wire [31:0] v1bc8 = ( v8 ) ? In_register_EAX : v1bab;
wire [31:0] v1bca = v1bc8;
wire v1bcb = v1bca == Out_register_EAX;
wire v1bcc = In_error_flag == Out_error_flag;
wire v1bcd = v1bac == vc;
wire v1bce = v1bcd;
wire v1bcf = v1ba3 & v1bce;
wire v1bd0 = v1bcf;
wire [31:0] v1bd3 = ( v8 ) ? In_register_ECX : v1bab;
wire [31:0] v1bd5 = v1bd3;
wire v1bd6 = v1bd5 == Out_register_ECX;
wire [31:0] v1bd8 = In_register_FSBASE;
wire v1bd9 = v1bd8 == Out_register_FSBASE;
wire [7:0] v1bdb = In_register_DF;
wire v1bdc = v1bdb == Out_register_DF;
wire v1bdd = v1bac == ve;
wire v1bde = v1bdd;
wire v1bdf = v1ba3 & v1bde;
wire v1be0 = v1bdf;
wire [31:0] v1be3 = ( v8 ) ? In_register_EDX : v1bab;
wire [31:0] v1be5 = v1be3;
wire v1be6 = v1be5 == Out_register_EDX;
wire v1be7 = v1bac == v11;
wire v1be8 = v1be7;
wire v1be9 = v1ba3 & v1be8;
wire v1bea = v1be9;
wire [31:0] v1bed = ( v8 ) ? In_register_ESI : v1bab;
wire [31:0] v1bef = v1bed;
wire v1bf0 = v1bef == Out_register_ESI;
wire [31:0] v1bf2 = In_register_SSBASE;
wire v1bf3 = v1bf2 == Out_register_SSBASE;
wire [31:0] v1bf5 = In_register_ESBASE;
wire v1bf6 = v1bf5 == Out_register_ESBASE;
wire v1bf7 = v1bac == vb;
wire v1bf8 = v1bf7;
wire v1bf9 = v1ba3 & v1bf8;
wire v1bfa = v1bf9;
wire [31:0] v1bfd = ( v8 ) ? In_register_ESP : v1bab;
wire [31:0] v1bff = v1bfd;
wire v1c00 = v1bff == Out_register_ESP;
wire v1c01 = v1baa < v1ba9;
wire v1c02 = v1baa < v1ba5;
wire v1c03 = v1c01 | v1c02;
wire v1c04 = v1bab < v1baa;
wire v1c05 = v1bab < vb11;
wire v1c06 = v1c04 | v1c05;
wire [7:0] v1c07 = { 7'b0000000, v1c06 };
wire [7:0] v1c08 = ( v1c03 == 1'd0) ? v1c07 : v18;
wire v1c09 = v1c08[0:0];
wire v1c0b = v1c09;
wire v1c0c = v1c0b == Out_register_CF;
wire v1c0d = v1bac == vd;
wire v1c0e = v1c0d;
wire v1c0f = v1ba3 & v1c0e;
wire v1c10 = v1c0f;
wire [31:0] v1c13 = ( v8 ) ? In_register_EBX : v1bab;
wire [31:0] v1c15 = v1c13;
wire v1c16 = v1c15 == Out_register_EBX;
wire [31:0] v1c18 = In_register_GSBASE;
wire v1c19 = v1c18 == Out_register_GSBASE;
wire v1c1a = v1bac == vf;
wire v1c1b = v1c1a;
wire v1c1c = v1ba3 & v1c1b;
wire v1c1d = v1c1c;
wire [31:0] v1c20 = ( v8 ) ? In_register_EBP : v1bab;
wire [31:0] v1c22 = v1c20;
wire v1c23 = v1c22 == Out_register_EBP;
wire [7:0] v1c24 = v1bab[7:0];
wire [2:0] v1c25_aux = v1c24[0] + v1c24[1] + v1c24[2] + v1c24[3] + v1c24[4] + v1c24[5] + v1c24[6] + v1c24[7];
wire v1c25 = { 5'b00000, v1c25_aux };
wire [7:0] v1c26 = v1c25 & v18;
wire [7:0] v1c27 = v1c26 ^ v18;
wire v1c28 = v1c27[0:0];
wire v1c2a = v1c28;
wire v1c2b = v1c2a == Out_register_PF;
wire [31:0] v1c2d = In_register_DSBASE;
wire v1c2e = v1c2d == Out_register_DSBASE;
wire [31:0] v1c2f = v1bab ^ v1ba5;
wire [31:0] v1c30 = v1c2f ^ v1ba9;
wire [7:0] v1c31 = v1c30[7:0];
wire [7:0] v1c32 = v1c31 >> v1d;
wire [7:0] v1c33 = v1c32 & v18;
wire v1c34 = v1c33[0:0];
wire v1c36 = v1c34;
wire v1c37 = v1c36 == Out_register_AF;
wire [31:0] v1c38 = v1bab ^ v1ba9;
wire [31:0] v1c39 = v1c38 >> v1e;
wire [31:0] v1c3a = v1c2f >> v1e;
wire [31:0] v1c3b = v1c39 + v1c3a;
wire v1c3c = v1c3b == v1c;
wire v1c3e = v1c3c;
wire v1c3f = v1c3e == Out_register_OF;
wire v1c40 = $signed(v1bab) < $signed(v15);
wire v1c42 = v1c40;
wire v1c43 = v1c42 == Out_register_SF;
wire v1c44 = v1bab == v15;
wire v1c46 = v1c44;
wire v1c47 = v1c46 == Out_register_ZF;
wire v1c48 = v1bb8 & v15c & v1bbe & v1bc1 & v1bcb & v1bcc & v1bd6 & v1bd9 & v1bdc & v1be6 & v1bf0 & v1bf3 & v1bf6 & v1c00 & v1c0c & v1c16 & v1bb5 & v1c19 & v1c23 & v1c2b & v1c2e & v1c37 & v1c3f & v1c43 & v1c47;
wire v1c49 = In_error_flag == Out_error_flag;
wire [7:0] v77 = 8'b00011111;
wire v1c4a = v77 == v1eb;
wire v1c4b = v29 == v59f;
wire v1c4c = v1c4a & v1c4b;
wire [15:0] v78 = 16'b1010011000011111;
wire v1c4d = v78 == v117;
wire v1c4e = v1b == v318;
wire v1c4f = v1c4d & v1c4e;
wire v1c50 = v1c4c | v1c4f;
wire v1c51 = v1c50;
wire v1c53 = In_register_OF;
wire v1c54 = v1c53 == Out_register_OF;
wire [31:0] v1c56 = In_register_EAX;
wire v1c57 = v1c56 == Out_register_EAX;
wire [31:0] v1c59 = In_register_ESP;
wire v1c5a = v1c59 == Out_register_ESP;
wire [31:0] v1c5c = In_register_EBX;
wire v1c5d = v1c5c == Out_register_EBX;
wire [31:0] v1c5f = In_register_EDX;
wire v1c60 = v1c5f == Out_register_EDX;
wire [31:0] v1c62 = In_register_GSBASE;
wire v1c63 = v1c62 == Out_register_GSBASE;
wire [31:0] v1c65 = In_register_ECX;
wire v1c66 = v1c65 == Out_register_ECX;
wire [31:0] v1c68 = In_register_ESI;
wire v1c69 = v1c68 == Out_register_ESI;
wire [31:0] v1c6b = In_register_EBP;
wire v1c6c = v1c6b == Out_register_EBP;
wire [31:0] v1c6e = In_register_CSBASE;
wire v1c6f = v1c6e == Out_register_CSBASE;
wire [31:0] v1c71 = In_register_EDI;
wire v1c72 = v1c71 == Out_register_EDI;
wire [31:0] v1c75 = ( v1c4c ) ? v2b : v1c;
wire [31:0] v1c76 = In_register_EIP + v1c75;
wire [31:0] v1c78 = v1c76;
wire v1c79 = v1c78 == Out_register_EIP;
wire [31:0] v1c7b = In_register_DSBASE;
wire v1c7c = v1c7b == Out_register_DSBASE;
wire [31:0] v1c7e = In_register_ESBASE;
wire v1c7f = v1c7e == Out_register_ESBASE;
wire [31:0] v1c81 = In_register_FSBASE;
wire v1c82 = v1c81 == Out_register_FSBASE;
wire v1c84 = In_register_AF;
wire v1c85 = v1c84 == Out_register_AF;
wire v1c87 = v17;
wire v1c88 = v1c87 == Out_register_CF;
wire [31:0] v1c8a = In_register_SSBASE;
wire v1c8b = v1c8a == Out_register_SSBASE;
wire [7:0] v1c8d = In_register_DF;
wire v1c8e = v1c8d == Out_register_DF;
wire v1c90 = In_register_PF;
wire v1c91 = v1c90 == Out_register_PF;
wire v1c93 = In_register_SF;
wire v1c94 = v1c93 == Out_register_SF;
wire v1c96 = In_register_ZF;
wire v1c97 = v1c96 == Out_register_ZF;
wire v1c98 = v1c49 & v1c54 & v1c57 & v1c5a & v1c5d & v1c60 & v1c63 & v1c66 & v1c51 & v1c69 & v1c6c & v1c6f & v1c72 & v1c79 & v1c7c & v1c7f & v1c82 & v1c85 & v15c & v1c88 & v1c8b & v1c8e & v1c91 & v1c94 & v1c97;
wire v1c99 = v1d == v1eb;
wire v1c9a = v1b == v318;
wire v1c9b = v1c99 & v1c9a;
wire [15:0] v79 = 16'b0110110000100000;
wire v1c9d = v79 == v117;
wire v1c9e = v4 == v11b;
wire v1c9f = v1c9d & v1c9e;
wire v1caa = v1c9b | v1c9f;
wire v1cae = v1caa;
wire [31:0] v1ca1 = ( v1c9f ) ? v63a : v477;
wire [7:0] v1ca2 = v1ca1[7:0];
wire [31:0] v1ca5 = vf4b;
wire [7:0] v1ca6 = v1ca5[7:0];
wire [7:0] v1ca7 = v1ca2 + v1ca6;
wire [31:0] v1ca8 = { 24'b000000000000000000000000, v1ca7 };
wire [31:0] v1ca9 = v5c8 | v1ca8;
wire [31:0] v1cad = ( v8 ) ? In_register_EAX : v1ca9;
wire [31:0] v1cb0 = v1cad;
wire v1cb1 = v1cb0 == Out_register_EAX;
wire [31:0] v1cb3 = In_register_EBX;
wire v1cb4 = v1cb3 == Out_register_EBX;
wire [31:0] v1cb6 = In_register_EBP;
wire v1cb7 = v1cb6 == Out_register_EBP;
wire [7:0] v1cb9 = In_register_DF;
wire v1cba = v1cb9 == Out_register_DF;
wire v1cbb = In_error_flag == Out_error_flag;
wire v1cbc = $signed(v1ca7) < $signed(v2c);
wire v1cbe = v1cbc;
wire v1cbf = v1cbe == Out_register_SF;
wire [31:0] v1cc1 = In_register_EDX;
wire v1cc2 = v1cc1 == Out_register_EDX;
wire [31:0] v1cc4 = In_register_ECX;
wire v1cc5 = v1cc4 == Out_register_ECX;
wire [31:0] v1cc7 = In_register_ESP;
wire v1cc8 = v1cc7 == Out_register_ESP;
wire [31:0] v1cca = In_register_EDI;
wire v1ccb = v1cca == Out_register_EDI;
wire [31:0] v1ccd = In_register_CSBASE;
wire v1cce = v1ccd == Out_register_CSBASE;
wire [31:0] v1cd1 = ( v1c9b ) ? v1c : v10;
wire [31:0] v1cd2 = In_register_EIP + v1cd1;
wire [31:0] v1cd4 = v1cd2;
wire v1cd5 = v1cd4 == Out_register_EIP;
wire [31:0] v1cd7 = In_register_SSBASE;
wire v1cd8 = v1cd7 == Out_register_SSBASE;
wire [31:0] v1cda = In_register_ESBASE;
wire v1cdb = v1cda == Out_register_ESBASE;
wire [31:0] v1cdd = In_register_GSBASE;
wire v1cde = v1cdd == Out_register_GSBASE;
wire [7:0] v1cdf = v1ca7 ^ v1ca2;
wire [7:0] v1ce0 = v1cdf ^ v1ca6;
wire [7:0] v1ce1 = v1ce0 >> v1d;
wire [7:0] v1ce2 = v1ce1 & v18;
wire v1ce3 = v1ce2[0:0];
wire v1ce5 = v1ce3;
wire v1ce6 = v1ce5 == Out_register_AF;
wire v1ce7 = v1ca7 < v1ca6;
wire v1ce8 = v1ca7 < v1ca2;
wire v1ce9 = v1ce7 | v1ce8;
wire v1ceb = v1ce9;
wire v1cec = v1ceb == Out_register_CF;
wire [31:0] v1cee = In_register_ESI;
wire v1cef = v1cee == Out_register_ESI;
wire [7:0] v1cf0 = v1ca7 ^ v1ca6;
wire [7:0] v1cf1 = v1cf0 >> v33;
wire [7:0] v1cf2 = v1cdf >> v33;
wire [7:0] v1cf3 = v1cf1 + v1cf2;
wire v1cf4 = v1cf3 == v34;
wire v1cf6 = v1cf4;
wire v1cf7 = v1cf6 == Out_register_OF;
wire [31:0] v1cf9 = In_register_DSBASE;
wire v1cfa = v1cf9 == Out_register_DSBASE;
wire [2:0] v1cfb_aux = v1ca7[0] + v1ca7[1] + v1ca7[2] + v1ca7[3] + v1ca7[4] + v1ca7[5] + v1ca7[6] + v1ca7[7];
wire v1cfb = { 5'b00000, v1cfb_aux };
wire [7:0] v1cfc = v1cfb & v18;
wire [7:0] v1cfd = v1cfc ^ v18;
wire v1cfe = v1cfd[0:0];
wire v1d00 = v1cfe;
wire v1d01 = v1d00 == Out_register_PF;
wire [31:0] v1d03 = In_register_FSBASE;
wire v1d04 = v1d03 == Out_register_FSBASE;
wire v1d05 = v1ca7 == v2c;
wire v1d07 = v1d05;
wire v1d08 = v1d07 == Out_register_ZF;
wire v1d09 = v1cb1 & v1cb4 & v1cb7 & v1cba & v1cbb & v15c & v1cbf & v1cc2 & v1cc5 & v1cc8 & v1ccb & v1cce & v1cd5 & v1cd8 & v1cdb & v1cde & v1ce6 & v1cec & v1cae & v1cef & v1cf7 & v1cfa & v1d01 & v1d04 & v1d08;
wire [7:0] v7a = 8'b00010001;
wire v1d0a = v7a == v1eb;
wire v1d0b = v2f == v316;
wire v1d0c = v14 == v1ef;
wire [2:0] v1d0d = { v1fa };
wire v1d0e = v1d0d == vb;
wire v1d0f = v1d0d == vf;
wire v1d10 = v1d0e | v1d0f;
wire v1d11 = v1d10 ^ v8;
wire [2:0] v1d12 = { v1fa };
wire v1d13 = v1d12 == vb;
wire v1d14 = v1d13;
wire v1d15 = v1d14 ^ v8;
wire v1d16 = v1d11 & v1d15;
wire v1d17 = v1d0a & v1d0b & v1d0c & v1d16;
wire v1d18 = v1d17;
wire v1d19 = v1d18;
wire [2:0] v1d1a = { v1fa };
wire [31:0] v1d1b = ( v1d1a == 3'd0) ? In_register_EAX : 
	( v1d1a == 3'd1) ? In_register_ECX : 
	( v1d1a == 3'd2) ? In_register_EDX : 
	( v1d1a == 3'd3) ? In_register_EBX : 
	( v1d1a == 3'd4) ? v15 : 
	( v1d1a == 3'd5) ? v15 : 
	( v1d1a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1d1c = v1d1b + v1f7;
wire [31:0] v1d1e = v1d1c;
wire [2:0] v1d1f = { v320 };
wire [31:0] v1d20 = ( v1d1f == 3'd0) ? In_register_EAX : 
	( v1d1f == 3'd1) ? In_register_ECX : 
	( v1d1f == 3'd2) ? In_register_EDX : 
	( v1d1f == 3'd3) ? In_register_EBX : 
	( v1d1f == 3'd4) ? In_register_EAX : 
	( v1d1f == 3'd5) ? In_register_ECX : 
	( v1d1f == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v1d21 = { v320 };
wire v1d22 = v1d21 == vb;
wire v1d23 = v1d21 == v9;
wire v1d24 = v1d22 | v1d23;
wire v1d25 = v1d21 == vf;
wire v1d26 = v1d24 | v1d25;
wire v1d27 = v1d21 == v11;
wire v1d28 = v1d26 | v1d27;
wire [31:0] v1d29 = ( v1d28 == 1'd0) ? v15 : v31;
wire [31:0] v1d2a = v1d20 >> v1d29;
wire [31:0] v1d2b = v1d2a & v32;
wire [31:0] v1d2d = v1d2b;
wire [7:0] v1d2e = v1d2d[7:0];
wire v1d2f =  v2a == memory_0[15: 12] && v1d1e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v1d2e == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] v1d31 = In_register_ECX;
wire v1d32 = v1d31 == Out_register_ECX;
wire [31:0] v1d34 = In_register_EAX;
wire v1d35 = v1d34 == Out_register_EAX;
wire v1d37 = In_register_AF;
wire v1d38 = v1d37 == Out_register_AF;
wire [31:0] v1d3a = In_register_ESI;
wire v1d3b = v1d3a == Out_register_ESI;
wire [31:0] v1d3d = In_register_EBX;
wire v1d3e = v1d3d == Out_register_EBX;
wire [31:0] v1d40 = In_register_ESBASE;
wire v1d41 = v1d40 == Out_register_ESBASE;
wire [31:0] v1d43 = In_register_EDX;
wire v1d44 = v1d43 == Out_register_EDX;
wire [31:0] v1d46 = In_register_SSBASE;
wire v1d47 = v1d46 == Out_register_SSBASE;
wire [31:0] v1d49 = In_register_EDI;
wire v1d4a = v1d49 == Out_register_EDI;
wire [31:0] v1d4c = In_register_ESP;
wire v1d4d = v1d4c == Out_register_ESP;
wire [31:0] v1d4f = In_register_EBP;
wire v1d50 = v1d4f == Out_register_EBP;
wire [7:0] v1d52 = In_register_DF;
wire v1d53 = v1d52 == Out_register_DF;
wire [31:0] v1d55 = v16;
wire [31:0] v1d56 = In_register_EIP + v1d55;
wire [31:0] v1d58 = v1d56;
wire v1d59 = v1d58 == Out_register_EIP;
wire [31:0] v1d5b = In_register_CSBASE;
wire v1d5c = v1d5b == Out_register_CSBASE;
wire v1d5e = In_register_ZF;
wire v1d5f = v1d5e == Out_register_ZF;
wire [31:0] v1d61 = In_register_DSBASE;
wire v1d62 = v1d61 == Out_register_DSBASE;
wire [31:0] v1d64 = In_register_GSBASE;
wire v1d65 = v1d64 == Out_register_GSBASE;
wire [31:0] v1d67 = In_register_FSBASE;
wire v1d68 = v1d67 == Out_register_FSBASE;
wire v1d6a = In_register_CF;
wire v1d6b = v1d6a == Out_register_CF;
wire v1d6d = In_register_OF;
wire v1d6e = v1d6d == Out_register_OF;
wire v1d70 = In_register_PF;
wire v1d71 = v1d70 == Out_register_PF;
wire v1d72 = In_error_flag == Out_error_flag;
wire v1d74 = In_register_SF;
wire v1d75 = v1d74 == Out_register_SF;
wire v1d76 = v1d19 & v1d2f & v1d32 & v1d35 & v1d38 & v1d3b & v1d3e & v1d41 & v1d44 & v1d47 & v1d4a & v1d4d & v1d50 & v15c & v1d53 & v1d59 & v1d5c & v1d5f & v1d62 & v1d65 & v1d68 & v1d6b & v1d6e & v1d71 & v1d72 & v1d75;
wire [7:0] v7b = 8'b10011110;
wire v1d77 = v7b == v1eb;
wire v1d78 = v1b == v318;
wire v1d79 = v1d77 & v1d78;
wire v1d7a = v1d79;
wire v1d7b = v1d7a;
wire [31:0] v1d7d = In_register_EDI;
wire v1d7e = v1d7d == Out_register_EDI;
wire [31:0] v1d80 = In_register_GSBASE;
wire v1d81 = v1d80 == Out_register_GSBASE;
wire v1d83 = In_register_SF;
wire v1d84 = v1d83 == Out_register_SF;
wire [31:0] v1d88 = v1c;
wire [31:0] v1d89 = In_register_EIP + v1d88;
wire [7:0] v1d85 = { 7'b0000000, In_register_SF };
wire v1d86 = v1d85 == v2c;
wire [31:0] v1d8b = v1d89;
wire [31:0] v1d8c = v1d89 + v477;
wire [31:0] v1d8e = v1d8c;
wire [31:0] v1d8f = ( v1d86 == 1'd0) ? v1d8b : v1d8e;
wire [31:0] v1d92 = ( v8 ) ? v1d89 : v1d8f;
wire [31:0] v1d94 = v1d92;
wire v1d95 = v1d94 == Out_register_EIP;
wire [31:0] v1d97 = In_register_EAX;
wire v1d98 = v1d97 == Out_register_EAX;
wire [31:0] v1d9a = In_register_ESBASE;
wire v1d9b = v1d9a == Out_register_ESBASE;
wire [31:0] v1d9d = In_register_ECX;
wire v1d9e = v1d9d == Out_register_ECX;
wire v1da0 = In_register_PF;
wire v1da1 = v1da0 == Out_register_PF;
wire [31:0] v1da3 = In_register_ESI;
wire v1da4 = v1da3 == Out_register_ESI;
wire v1da5 = In_error_flag == Out_error_flag;
wire [31:0] v1da7 = In_register_CSBASE;
wire v1da8 = v1da7 == Out_register_CSBASE;
wire [31:0] v1daa = In_register_EBP;
wire v1dab = v1daa == Out_register_EBP;
wire [31:0] v1dad = In_register_EBX;
wire v1dae = v1dad == Out_register_EBX;
wire [31:0] v1db0 = In_register_SSBASE;
wire v1db1 = v1db0 == Out_register_SSBASE;
wire [31:0] v1db3 = In_register_ESP;
wire v1db4 = v1db3 == Out_register_ESP;
wire [31:0] v1db6 = In_register_DSBASE;
wire v1db7 = v1db6 == Out_register_DSBASE;
wire [31:0] v1db9 = In_register_EDX;
wire v1dba = v1db9 == Out_register_EDX;
wire v1dbc = In_register_AF;
wire v1dbd = v1dbc == Out_register_AF;
wire v1dbf = In_register_CF;
wire v1dc0 = v1dbf == Out_register_CF;
wire [31:0] v1dc2 = In_register_FSBASE;
wire v1dc3 = v1dc2 == Out_register_FSBASE;
wire [7:0] v1dc5 = In_register_DF;
wire v1dc6 = v1dc5 == Out_register_DF;
wire v1dc8 = In_register_OF;
wire v1dc9 = v1dc8 == Out_register_OF;
wire v1dcb = In_register_ZF;
wire v1dcc = v1dcb == Out_register_ZF;
wire v1dcd = v1d7b & v1d7e & v1d81 & v1d84 & v1d95 & v1d98 & v1d9b & v1d9e & v1da1 & v1da4 & v1da5 & v1da8 & v15c & v1dab & v1dae & v1db1 & v1db4 & v1db7 & v1dba & v1dbd & v1dc0 & v1dc3 & v1dc6 & v1dc9 & v1dcc;
wire [7:0] v7c = 8'b00101000;
wire v1dce = v7c == v1eb;
wire v1dcf = v1b == v318;
wire v1dd0 = v1dce & v1dcf;
wire v1ddb = v1dd0;
wire v1ddf = v1ddb;
wire [31:0] v1dd2 = v477;
wire [7:0] v1dd3 = v1dd2[7:0];
wire [31:0] v1dd5 = vf4b;
wire [7:0] v1dd6 = v1dd5[7:0];
wire [7:0] v1dd7 = v1dd3 + v1dd6;
wire [7:0] v1dd8 = v65f + v1dd7;
wire [31:0] v1dd9 = { 24'b000000000000000000000000, v1dd8 };
wire [31:0] v1dda = v5c8 | v1dd9;
wire [31:0] v1dde = ( v8 ) ? In_register_EAX : v1dda;
wire [31:0] v1de1 = v1dde;
wire v1de2 = v1de1 == Out_register_EAX;
wire [31:0] v1de4 = In_register_EBX;
wire v1de5 = v1de4 == Out_register_EBX;
wire [31:0] v1de7 = In_register_EBP;
wire v1de8 = v1de7 == Out_register_EBP;
wire [31:0] v1dea = In_register_ECX;
wire v1deb = v1dea == Out_register_ECX;
wire [31:0] v1ded = In_register_SSBASE;
wire v1dee = v1ded == Out_register_SSBASE;
wire [31:0] v1df0 = In_register_CSBASE;
wire v1df1 = v1df0 == Out_register_CSBASE;
wire [31:0] v1df3 = In_register_EDX;
wire v1df4 = v1df3 == Out_register_EDX;
wire [31:0] v1df6 = In_register_FSBASE;
wire v1df7 = v1df6 == Out_register_FSBASE;
wire v1df8 = In_error_flag == Out_error_flag;
wire [31:0] v1dfa = v1c;
wire [31:0] v1dfb = In_register_EIP + v1dfa;
wire [31:0] v1dfd = v1dfb;
wire v1dfe = v1dfd == Out_register_EIP;
wire [31:0] v1e00 = In_register_ESI;
wire v1e01 = v1e00 == Out_register_ESI;
wire [7:0] v1e03 = In_register_DF;
wire v1e04 = v1e03 == Out_register_DF;
wire [31:0] v1e06 = In_register_ESP;
wire v1e07 = v1e06 == Out_register_ESP;
wire [31:0] v1e09 = In_register_ESBASE;
wire v1e0a = v1e09 == Out_register_ESBASE;
wire [31:0] v1e0c = In_register_DSBASE;
wire v1e0d = v1e0c == Out_register_DSBASE;
wire [31:0] v1e0f = In_register_GSBASE;
wire v1e10 = v1e0f == Out_register_GSBASE;
wire [7:0] v1e11 = v1dd8 ^ v1dd3;
wire [7:0] v1e12 = v1e11 ^ v1dd6;
wire [7:0] v1e13 = v1e12 >> v1d;
wire [7:0] v1e14 = v1e13 & v18;
wire v1e15 = v1e14[0:0];
wire v1e17 = v1e15;
wire v1e18 = v1e17 == Out_register_AF;
wire v1e19 = v1dd7 < v1dd6;
wire v1e1a = v1dd7 < v1dd3;
wire v1e1b = v1e19 | v1e1a;
wire v1e1c = v1e1b ^ v8;
wire v1e1d = v1dd8 < v1dd7;
wire v1e1e = v1dd8 < v65f;
wire v1e1f = v1e1d | v1e1e;
wire [7:0] v1e20 = { 7'b0000000, v1e1f };
wire [7:0] v1e21 = ( v1e1c == 1'd0) ? v18 : v1e20;
wire v1e22 = v1e21[0:0];
wire v1e24 = v1e22;
wire v1e25 = v1e24 == Out_register_CF;
wire [2:0] v1e26_aux = v1dd8[0] + v1dd8[1] + v1dd8[2] + v1dd8[3] + v1dd8[4] + v1dd8[5] + v1dd8[6] + v1dd8[7];
wire v1e26 = { 5'b00000, v1e26_aux };
wire [7:0] v1e27 = v1e26 & v18;
wire [7:0] v1e28 = v1e27 ^ v18;
wire v1e29 = v1e28[0:0];
wire v1e2b = v1e29;
wire v1e2c = v1e2b == Out_register_PF;
wire [7:0] v1e2d = v1dd8 ^ v1dd6;
wire [7:0] v1e2e = v1e2d >> v33;
wire [7:0] v1e2f = v1e11 >> v33;
wire [7:0] v1e30 = v1e2e + v1e2f;
wire v1e31 = v1e30 == v34;
wire v1e33 = v1e31;
wire v1e34 = v1e33 == Out_register_OF;
wire [31:0] v1e36 = In_register_EDI;
wire v1e37 = v1e36 == Out_register_EDI;
wire v1e38 = $signed(v1dd8) < $signed(v2c);
wire v1e3a = v1e38;
wire v1e3b = v1e3a == Out_register_SF;
wire v1e3c = v1dd8 == v2c;
wire v1e3e = v1e3c;
wire v1e3f = v1e3e == Out_register_ZF;
wire v1e40 = v15c & v1de2 & v1de5 & v1ddf & v1de8 & v1deb & v1dee & v1df1 & v1df4 & v1df7 & v1df8 & v1dfe & v1e01 & v1e04 & v1e07 & v1e0a & v1e0d & v1e10 & v1e18 & v1e25 & v1e2c & v1e34 & v1e37 & v1e3b & v1e3f;
wire [7:0] v7d = 8'b00111111;
wire v1e41 = v7d == v1eb;
wire v1e42 = v29 == v59f;
wire v1e43 = v1e41 & v1e42;
wire v1e44 = v1e43;
wire v1e45 = v1e44;
wire [31:0] v1e47 = In_register_ESP;
wire v1e48 = v1e47 == Out_register_ESP;
wire [31:0] v1e4a = In_register_ESI;
wire v1e4b = v1e4a == Out_register_ESI;
wire [31:0] v1e4d = In_register_EBP;
wire v1e4e = v1e4d == Out_register_EBP;
wire [31:0] v1e50 = In_register_EAX;
wire v1e51 = v1e50 == Out_register_EAX;
wire [31:0] v1e53 = In_register_EBX;
wire v1e54 = v1e53 == Out_register_EBX;
wire [31:0] v1e56 = v2b;
wire [31:0] v1e57 = In_register_EIP + v1e56;
wire [31:0] v1e59 = v1e57;
wire v1e5a = v1e59 == Out_register_EIP;
wire v1e5b = In_error_flag == Out_error_flag;
wire [31:0] v1e5d = In_register_EDI;
wire v1e5e = v1e5d == Out_register_EDI;
wire [31:0] v1e60 = In_register_ECX;
wire v1e61 = v1e60 == Out_register_ECX;
wire [31:0] v1e63 = In_register_CSBASE;
wire v1e64 = v1e63 == Out_register_CSBASE;
wire [31:0] v1e66 = In_register_ESBASE;
wire v1e67 = v1e66 == Out_register_ESBASE;
wire v1e69 = In_register_AF;
wire v1e6a = v1e69 == Out_register_AF;
wire [31:0] v1e6c = In_register_EDX;
wire v1e6d = v1e6c == Out_register_EDX;
wire [31:0] v1e6f = In_register_SSBASE;
wire v1e70 = v1e6f == Out_register_SSBASE;
wire [31:0] v1e72 = In_register_DSBASE;
wire v1e73 = v1e72 == Out_register_DSBASE;
wire [31:0] v1e75 = In_register_GSBASE;
wire v1e76 = v1e75 == Out_register_GSBASE;
wire [31:0] v1e78 = In_register_FSBASE;
wire v1e79 = v1e78 == Out_register_FSBASE;
wire v1e7b = In_register_CF;
wire v1e7c = v1e7b == Out_register_CF;
wire [7:0] v1e7e = v2c;
wire v1e7f = v1e7e == Out_register_DF;
wire v1e81 = In_register_OF;
wire v1e82 = v1e81 == Out_register_OF;
wire v1e84 = In_register_PF;
wire v1e85 = v1e84 == Out_register_PF;
wire v1e87 = In_register_SF;
wire v1e88 = v1e87 == Out_register_SF;
wire v1e8a = In_register_ZF;
wire v1e8b = v1e8a == Out_register_ZF;
wire v1e8c = v1e45 & v1e48 & v15c & v1e4b & v1e4e & v1e51 & v1e54 & v1e5a & v1e5b & v1e5e & v1e61 & v1e64 & v1e67 & v1e6a & v1e6d & v1e70 & v1e73 & v1e76 & v1e79 & v1e7c & v1e7f & v1e82 & v1e85 & v1e88 & v1e8b;
wire [7:0] v7e = 8'b11000000;
wire v1e90 = v7e == v1eb;
wire v1e91 = v30 == v316;
wire v1e92 = v4 == v11b;
wire [2:0] v1e93 = { v1fa };
wire v1e94 = v1e93 == vb;
wire v1e95 = v1e93 == vf;
wire v1e96 = v1e94 | v1e95;
wire v1e97 = v1e96 ^ v8;
wire [2:0] v1e98 = { v1fa };
wire v1e99 = v1e98 == vb;
wire v1e9a = v1e99;
wire v1e9b = v1e9a ^ v8;
wire v1e9c = v1e97 & v1e9b;
wire v1e9d = v1e90 & v1e91 & v1e92 & v1e9c;
wire v1ea1 = v7e == v1eb;
wire v1ea2 = v2f == v316;
wire v1ea3 = v14 == v1ef;
wire [2:0] v1ea4 = { v1fa };
wire v1ea5 = v1ea4 == vb;
wire v1ea6 = v1ea4 == vf;
wire v1ea7 = v1ea5 | v1ea6;
wire v1ea8 = v1ea7 ^ v8;
wire [2:0] v1ea9 = { v1fa };
wire v1eaa = v1ea9 == vb;
wire v1eab = v1eaa;
wire v1eac = v1eab ^ v8;
wire v1ead = v1ea8 & v1eac;
wire v1eae = v1ea1 & v1ea2 & v1ea3 & v1ead;
wire [10:0] v7f = 11'b11000000001;
wire v1eb2 = v7f == v6d7;
wire v1eb3 = v35 == v316;
wire v1eb4 = v4 == v11b;
wire [2:0] v1eb5 = { v13c };
wire v1eb6 = v1eb5 == vb;
wire v1eb7 = v1eb5 == vf;
wire v1eb8 = v1eb6 | v1eb7;
wire v1eb9 = v1eb8 ^ v8;
wire [2:0] v1eba = { v12c };
wire v1ebb = v1eba == vb;
wire v1ebc = v1ebb;
wire v1ebd = v1ebc ^ v8;
wire [2:0] v1ebe = { v13c };
wire v1ebf = v1ebe == vf;
wire v1ec0 = v1ebf;
wire v1ec1 = v1ec0 ^ v8;
wire v1ec2 = v1eb9 & v1ebd & v1ec1;
wire v1ec3 = v1eb2 & v1eb3 & v1eb4 & v1ec2;
wire v1ed7 = v1e9d | v1eae | v1ec3;
wire v1ed8 = v1ed7;
wire [2:0] v1ec7 = { v320 };
wire v1ec8 = v1ec7 == v7;
wire v1ec9 = v1ec8;
wire v1eca = v1e9d & v1ec9;
wire [2:0] v1ecb = { v320 };
wire v1ecc = v1ecb == v7;
wire v1ecd = v1ecc;
wire v1ece = v1eae & v1ecd;
wire [2:0] v1ecf = { v320 };
wire v1ed0 = v1ecf == v7;
wire v1ed1 = v1ed0;
wire v1ed2 = v1ec3 & v1ed1;
wire v1ed3 = v1eca | v1ece | v1ed2;
wire [31:0] v1e8d = memory_0[79: 48];
wire [2:0] v1e9f = { v320 };
wire [31:0] v1ea0 = ( v1e9f == 3'd0) ? In_register_EAX : 
	( v1e9f == 3'd1) ? In_register_ECX : 
	( v1e9f == 3'd2) ? In_register_EDX : 
	( v1e9f == 3'd3) ? In_register_EBX : 
	( v1e9f == 3'd4) ? In_register_ESP : 
	( v1e9f == 3'd5) ? In_register_EBP : 
	( v1e9f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1e8e = { v320 };
wire [31:0] v1e8f = ( v1e8e == 3'd0) ? In_register_EAX : 
	( v1e8e == 3'd1) ? In_register_ECX : 
	( v1e8e == 3'd2) ? In_register_EDX : 
	( v1e8e == 3'd3) ? In_register_EBX : 
	( v1e8e == 3'd4) ? In_register_ESP : 
	( v1e8e == 3'd5) ? In_register_EBP : 
	( v1e8e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1eb0 = { v320 };
wire [31:0] v1eb1 = ( v1eb0 == 3'd0) ? In_register_EAX : 
	( v1eb0 == 3'd1) ? In_register_ECX : 
	( v1eb0 == 3'd2) ? In_register_EDX : 
	( v1eb0 == 3'd3) ? In_register_EBX : 
	( v1eb0 == 3'd4) ? In_register_ESP : 
	( v1eb0 == 3'd5) ? In_register_EBP : 
	( v1eb0 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1ec5 = ( v1eae ) ? v1ea0 : 
	( v1e9d ) ? v1e8f : v1eb1;
wire [31:0] v1ec6 = v1e8d + v1ec5;
wire [31:0] v1ed6 = ( v8 ) ? In_register_EAX : v1ec6;
wire [31:0] v1eda = v1ed6;
wire v1edb = v1eda == Out_register_EAX;
wire [7:0] v1edd = In_register_DF;
wire v1ede = v1edd == Out_register_DF;
wire v1edf = In_error_flag == Out_error_flag;
wire v1ee0 = v1ec7 == vb;
wire v1ee1 = v1ee0;
wire v1ee2 = v1e9d & v1ee1;
wire v1ee3 = v1ecb == vb;
wire v1ee4 = v1ee3;
wire v1ee5 = v1eae & v1ee4;
wire v1ee6 = v1ecf == vb;
wire v1ee7 = v1ee6;
wire v1ee8 = v1ec3 & v1ee7;
wire v1ee9 = v1ee2 | v1ee5 | v1ee8;
wire [31:0] v1eec = ( v8 ) ? In_register_ESP : v1ec6;
wire [31:0] v1eee = v1eec;
wire v1eef = v1eee == Out_register_ESP;
wire v1ef0 = v1ec7 == vd;
wire v1ef1 = v1ef0;
wire v1ef2 = v1e9d & v1ef1;
wire v1ef3 = v1ecb == vd;
wire v1ef4 = v1ef3;
wire v1ef5 = v1eae & v1ef4;
wire v1ef6 = v1ecf == vd;
wire v1ef7 = v1ef6;
wire v1ef8 = v1ec3 & v1ef7;
wire v1ef9 = v1ef2 | v1ef5 | v1ef8;
wire [31:0] v1efc = ( v8 ) ? In_register_EBX : v1ec6;
wire [31:0] v1efe = v1efc;
wire v1eff = v1efe == Out_register_EBX;
wire v1f00 = v1ec7 == ve;
wire v1f01 = v1f00;
wire v1f02 = v1e9d & v1f01;
wire v1f03 = v1ecb == ve;
wire v1f04 = v1f03;
wire v1f05 = v1eae & v1f04;
wire v1f06 = v1ecf == ve;
wire v1f07 = v1f06;
wire v1f08 = v1ec3 & v1f07;
wire v1f09 = v1f02 | v1f05 | v1f08;
wire [31:0] v1f0c = ( v8 ) ? In_register_EDX : v1ec6;
wire [31:0] v1f0e = v1f0c;
wire v1f0f = v1f0e == Out_register_EDX;
wire v1f10 = v1ec7 == vc;
wire v1f11 = v1f10;
wire v1f12 = v1e9d & v1f11;
wire v1f13 = v1ecb == vc;
wire v1f14 = v1f13;
wire v1f15 = v1eae & v1f14;
wire v1f16 = v1ecf == vc;
wire v1f17 = v1f16;
wire v1f18 = v1ec3 & v1f17;
wire v1f19 = v1f12 | v1f15 | v1f18;
wire [31:0] v1f1c = ( v8 ) ? In_register_ECX : v1ec6;
wire [31:0] v1f1e = v1f1c;
wire v1f1f = v1f1e == Out_register_ECX;
wire [2:0] v1f28 = { v13c };
wire [31:0] v1f29 = ( v1f28 == 3'd0) ? In_register_EAX : 
	( v1f28 == 3'd1) ? In_register_ECX : 
	( v1f28 == 3'd2) ? In_register_EDX : 
	( v1f28 == 3'd3) ? In_register_EBX : 
	( v1f28 == 3'd4) ? v15 : 
	( v1f28 == 3'd5) ? v15 : 
	( v1f28 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1f2a = { v12c };
wire [31:0] v1f2b = ( v1f2a == 3'd0) ? In_register_EAX : 
	( v1f2a == 3'd1) ? In_register_ECX : 
	( v1f2a == 3'd2) ? In_register_EDX : 
	( v1f2a == 3'd3) ? In_register_EBX : 
	( v1f2a == 3'd4) ? v15 : 
	( v1f2a == 3'd5) ? In_register_EBP : 
	( v1f2a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1f2c = v1f2b << v7f4;
wire [31:0] v1f2d = v1f29 + v1f2c;
wire [2:0] v1f20 = { v1fa };
wire [31:0] v1f21 = ( v1f20 == 3'd0) ? In_register_EAX : 
	( v1f20 == 3'd1) ? In_register_ECX : 
	( v1f20 == 3'd2) ? In_register_EDX : 
	( v1f20 == 3'd3) ? In_register_EBX : 
	( v1f20 == 3'd4) ? v15 : 
	( v1f20 == 3'd5) ? v15 : 
	( v1f20 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1f22 = v1f21 + v63a;
wire [2:0] v1f24 = { v1fa };
wire [31:0] v1f25 = ( v1f24 == 3'd0) ? In_register_EAX : 
	( v1f24 == 3'd1) ? In_register_ECX : 
	( v1f24 == 3'd2) ? In_register_EDX : 
	( v1f24 == 3'd3) ? In_register_EBX : 
	( v1f24 == 3'd4) ? v15 : 
	( v1f24 == 3'd5) ? v15 : 
	( v1f24 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1f26 = v1f25 + v1f7;
wire [31:0] v1f2f = ( v1ec3 ) ? v1f2d : 
	( v1e9d ) ? v1f22 : v1f26;
wire v1f30 =  v26 == memory_0[15: 12] && v1f2f == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v1f31 = v1ec7 == v11;
wire v1f32 = v1f31;
wire v1f33 = v1e9d & v1f32;
wire v1f34 = v1ecb == v11;
wire v1f35 = v1f34;
wire v1f36 = v1eae & v1f35;
wire v1f37 = v1ecf == v11;
wire v1f38 = v1f37;
wire v1f39 = v1ec3 & v1f38;
wire v1f3a = v1f33 | v1f36 | v1f39;
wire [31:0] v1f3d = ( v8 ) ? In_register_ESI : v1ec6;
wire [31:0] v1f3f = v1f3d;
wire v1f40 = v1f3f == Out_register_ESI;
wire [31:0] v1f44 = ( v1eae ) ? v16 : v10;
wire [31:0] v1f45 = In_register_EIP + v1f44;
wire [31:0] v1f47 = v1f45;
wire v1f48 = v1f47 == Out_register_EIP;
wire [31:0] v1f4a = In_register_SSBASE;
wire v1f4b = v1f4a == Out_register_SSBASE;
wire v1f4c = v1ec7 == v9;
wire v1f4d = v1f4c;
wire v1f4e = v1e9d & v1f4d;
wire v1f4f = v1ecb == v9;
wire v1f50 = v1f4f;
wire v1f51 = v1eae & v1f50;
wire v1f52 = v1ecf == v9;
wire v1f53 = v1f52;
wire v1f54 = v1ec3 & v1f53;
wire v1f55 = v1f4e | v1f51 | v1f54;
wire [31:0] v1f58 = ( v8 ) ? In_register_EDI : v1ec6;
wire [31:0] v1f5a = v1f58;
wire v1f5b = v1f5a == Out_register_EDI;
wire [31:0] v1f5c = v1ec6 ^ v1ec5;
wire [31:0] v1f5d = v1f5c >> v1e;
wire [31:0] v1f5e = v1ec6 ^ v1e8d;
wire [31:0] v1f5f = v1f5e >> v1e;
wire [31:0] v1f60 = v1f5d + v1f5f;
wire v1f61 = v1f60 == v1c;
wire v1f63 = v1f61;
wire v1f64 = v1f63 == Out_register_OF;
wire [31:0] v1f65 = v1f5e ^ v1ec5;
wire [7:0] v1f66 = v1f65[7:0];
wire [7:0] v1f67 = v1f66 >> v1d;
wire [7:0] v1f68 = v1f67 & v18;
wire v1f69 = v1f68[0:0];
wire v1f6b = v1f69;
wire v1f6c = v1f6b == Out_register_AF;
wire [31:0] v1f6e = In_register_ESBASE;
wire v1f6f = v1f6e == Out_register_ESBASE;
wire v1f70 = v1ec6 == v15;
wire v1f72 = v1f70;
wire v1f73 = v1f72 == Out_register_ZF;
wire v1f74 = $signed(v1ec6) < $signed(v15);
wire v1f76 = v1f74;
wire v1f77 = v1f76 == Out_register_SF;
wire v1f78 = v1ec7 == vf;
wire v1f79 = v1f78;
wire v1f7a = v1e9d & v1f79;
wire v1f7b = v1ecb == vf;
wire v1f7c = v1f7b;
wire v1f7d = v1eae & v1f7c;
wire v1f7e = v1ecf == vf;
wire v1f7f = v1f7e;
wire v1f80 = v1ec3 & v1f7f;
wire v1f81 = v1f7a | v1f7d | v1f80;
wire [31:0] v1f84 = ( v8 ) ? In_register_EBP : v1ec6;
wire [31:0] v1f86 = v1f84;
wire v1f87 = v1f86 == Out_register_EBP;
wire [31:0] v1f89 = In_register_CSBASE;
wire v1f8a = v1f89 == Out_register_CSBASE;
wire [31:0] v1f8c = In_register_DSBASE;
wire v1f8d = v1f8c == Out_register_DSBASE;
wire [31:0] v1f8f = In_register_GSBASE;
wire v1f90 = v1f8f == Out_register_GSBASE;
wire v1f91 = v1ec6 < v1ec5;
wire v1f92 = v1ec6 < v1e8d;
wire v1f93 = v1f91 | v1f92;
wire v1f95 = v1f93;
wire v1f96 = v1f95 == Out_register_CF;
wire [31:0] v1f98 = In_register_FSBASE;
wire v1f99 = v1f98 == Out_register_FSBASE;
wire [7:0] v1f9a = v1ec6[7:0];
wire [2:0] v1f9b_aux = v1f9a[0] + v1f9a[1] + v1f9a[2] + v1f9a[3] + v1f9a[4] + v1f9a[5] + v1f9a[6] + v1f9a[7];
wire v1f9b = { 5'b00000, v1f9b_aux };
wire [7:0] v1f9c = v1f9b & v18;
wire [7:0] v1f9d = v1f9c ^ v18;
wire v1f9e = v1f9d[0:0];
wire v1fa0 = v1f9e;
wire v1fa1 = v1fa0 == Out_register_PF;
wire v1fa2 = v1edb & v1ede & v1edf & v15c & v1eef & v1eff & v1f0f & v1f1f & v1f30 & v1ed8 & v1f40 & v1f48 & v1f4b & v1f5b & v1f64 & v1f6c & v1f6f & v1f73 & v1f77 & v1f87 & v1f8a & v1f8d & v1f90 & v1f96 & v1f99 & v1fa1;
wire [15:0] v80 = 16'b0000000100110100;
wire v1fa3 = v80 == v117;
wire v1fa4 = v38 == v6da;
wire [2:0] v1fa5 = { v13c };
wire v1fa6 = v1fa5 == vb;
wire v1fa7 = v1fa5 == vf;
wire v1fa8 = v1fa6 | v1fa7;
wire v1fa9 = v1fa8 ^ v8;
wire [2:0] v1faa = { v12c };
wire v1fab = v1faa == vb;
wire v1fac = v1fab;
wire v1fad = v1fac ^ v8;
wire [2:0] v1fae = { v13c };
wire v1faf = v1fae == vf;
wire v1fb0 = v1faf;
wire v1fb1 = v1fb0 ^ v8;
wire [2:0] v1fb2 = { v13c };
wire v1fb3 = v1fb2 == vb;
wire v1fb4 = v1fb2 == vf;
wire v1fb5 = v1fb3 | v1fb4;
wire v1fb6 = v1fb5 ^ v8;
wire [2:0] v1fb7 = { v12c };
wire v1fb8 = v1fb7 == vb;
wire v1fb9 = v1fb8;
wire v1fba = v1fb9 ^ v8;
wire [2:0] v1fbb = { v13c };
wire v1fbc = v1fbb == vf;
wire v1fbd = v1fbc;
wire v1fbe = v1fbd ^ v8;
wire v1fbf = v1fa9 & v1fad & v1fb1 & v1fb6 & v1fba & v1fbe;
wire v1fc0 = v1fa3 & v1fa4 & v1fbf;
wire v1fc1 = v1fc0;
wire v1fc2 = v1fc1;
wire [31:0] v1fc4 = In_register_EBX;
wire v1fc5 = v1fc4 == Out_register_EBX;
wire [31:0] v1fc7 = In_register_ESI;
wire v1fc8 = v1fc7 == Out_register_ESI;
wire v1fc9 = In_error_flag == Out_error_flag;
wire [31:0] v1fca = memory_0[79: 48];
wire [7:0] v1fcb = v1fca[7:0];
wire [31:0] v1fcd = v7f8;
wire [7:0] v1fce = v1fcd[7:0];
wire [7:0] v1fcf = v1fcb - v1fce;
wire [7:0] v1fd0 = v1fcf ^ v1fcb;
wire [7:0] v1fd1 = v1fd0 >> v33;
wire [7:0] v1fd2 = v1fcb ^ v1fce;
wire [7:0] v1fd3 = v1fd2 >> v33;
wire [7:0] v1fd4 = v1fd1 + v1fd3;
wire v1fd5 = v1fd4 == v34;
wire v1fd7 = v1fd5;
wire v1fd8 = v1fd7 == Out_register_OF;
wire v1fd9 = v1fcb < v1fce;
wire v1fdb = v1fd9;
wire v1fdc = v1fdb == Out_register_CF;
wire [2:0] v1fdd = { v13c };
wire [31:0] v1fde = ( v1fdd == 3'd0) ? In_register_EAX : 
	( v1fdd == 3'd1) ? In_register_ECX : 
	( v1fdd == 3'd2) ? In_register_EDX : 
	( v1fdd == 3'd3) ? In_register_EBX : 
	( v1fdd == 3'd4) ? v15 : 
	( v1fdd == 3'd5) ? v15 : 
	( v1fdd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1fdf = { v12c };
wire [31:0] v1fe0 = ( v1fdf == 3'd0) ? In_register_EAX : 
	( v1fdf == 3'd1) ? In_register_ECX : 
	( v1fdf == 3'd2) ? In_register_EDX : 
	( v1fdf == 3'd3) ? In_register_EBX : 
	( v1fdf == 3'd4) ? v15 : 
	( v1fdf == 3'd5) ? In_register_EBP : 
	( v1fdf == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1fe1 = v1fe0 << v7f4;
wire [31:0] v1fe2 = v1fde + v1fe1;
wire [31:0] v1fe4 = v1fe2;
wire v1fe5 =  v2a == memory_1[15: 12] && v1fe4 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v1fcf == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v1fe7 = In_register_FSBASE;
wire v1fe8 = v1fe7 == Out_register_FSBASE;
wire v1fe9 = $signed(v1fcf) < $signed(v2c);
wire v1feb = v1fe9;
wire v1fec = v1feb == Out_register_SF;
wire [31:0] v1fee = In_register_SSBASE;
wire v1fef = v1fee == Out_register_SSBASE;
wire [2:0] v1ff0 = { v13c };
wire [31:0] v1ff1 = ( v1ff0 == 3'd0) ? In_register_EAX : 
	( v1ff0 == 3'd1) ? In_register_ECX : 
	( v1ff0 == 3'd2) ? In_register_EDX : 
	( v1ff0 == 3'd3) ? In_register_EBX : 
	( v1ff0 == 3'd4) ? v15 : 
	( v1ff0 == 3'd5) ? v15 : 
	( v1ff0 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v1ff2 = { v12c };
wire [31:0] v1ff3 = ( v1ff2 == 3'd0) ? In_register_EAX : 
	( v1ff2 == 3'd1) ? In_register_ECX : 
	( v1ff2 == 3'd2) ? In_register_EDX : 
	( v1ff2 == 3'd3) ? In_register_EBX : 
	( v1ff2 == 3'd4) ? v15 : 
	( v1ff2 == 3'd5) ? In_register_EBP : 
	( v1ff2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v1ff4 = v1ff3 << v7f4;
wire [31:0] v1ff5 = v1ff1 + v1ff4;
wire [31:0] v1ff7 = v1ff5;
wire v1ff8 =  v2a == memory_0[15: 12] && v1ff7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v1ffa = In_register_EAX;
wire v1ffb = v1ffa == Out_register_EAX;
wire [31:0] v1ffd = In_register_ECX;
wire v1ffe = v1ffd == Out_register_ECX;
wire [31:0] v2000 = In_register_ESP;
wire v2001 = v2000 == Out_register_ESP;
wire [31:0] v2003 = In_register_EDX;
wire v2004 = v2003 == Out_register_EDX;
wire [31:0] v2006 = In_register_EDI;
wire v2007 = v2006 == Out_register_EDI;
wire [31:0] v2009 = In_register_DSBASE;
wire v200a = v2009 == Out_register_DSBASE;
wire [31:0] v200c = In_register_CSBASE;
wire v200d = v200c == Out_register_CSBASE;
wire [2:0] v200e_aux = v1fcf[0] + v1fcf[1] + v1fcf[2] + v1fcf[3] + v1fcf[4] + v1fcf[5] + v1fcf[6] + v1fcf[7];
wire v200e = { 5'b00000, v200e_aux };
wire [7:0] v200f = v200e & v18;
wire [7:0] v2010 = v200f ^ v18;
wire v2011 = v2010[0:0];
wire v2013 = v2011;
wire v2014 = v2013 == Out_register_PF;
wire [31:0] v2016 = In_register_EBP;
wire v2017 = v2016 == Out_register_EBP;
wire [31:0] v2019 = v27;
wire [31:0] v201a = In_register_EIP + v2019;
wire [31:0] v201c = v201a;
wire v201d = v201c == Out_register_EIP;
wire [31:0] v201f = In_register_ESBASE;
wire v2020 = v201f == Out_register_ESBASE;
wire [31:0] v2022 = In_register_GSBASE;
wire v2023 = v2022 == Out_register_GSBASE;
wire [7:0] v2024 = v1fd2 ^ v1fcf;
wire [7:0] v2025 = v2024 >> v1d;
wire [7:0] v2026 = v2025 & v18;
wire v2027 = v2026[0:0];
wire v2029 = v2027;
wire v202a = v2029 == Out_register_AF;
wire [7:0] v202c = In_register_DF;
wire v202d = v202c == Out_register_DF;
wire v202e = v1fcb == v1fce;
wire v2030 = v202e;
wire v2031 = v2030 == Out_register_ZF;
wire v2032 = v1fc2 & v1fc5 & v15c & v1fc8 & v1fc9 & v1fd8 & v1fdc & v1fe5 & v1fe8 & v1fec & v1fef & v1ff8 & v1ffb & v1ffe & v2001 & v2004 & v2007 & v200a & v200d & v2014 & v2017 & v201d & v2020 & v2023 & v202a & v202d & v2031;
wire [7:0] v81 = 8'b01101111;
wire v2033 = v81 == v1eb;
wire [4:0] v82 = 5'b10110;
wire v2034 = v82 == v1ed;
wire v2035 = v4 == v11b;
wire [2:0] v2036 = { v1fa };
wire v2037 = v2036 == vb;
wire v2038 = v2036 == vf;
wire v2039 = v2037 | v2038;
wire v203a = v2039 ^ v8;
wire [2:0] v203b = { v1fa };
wire v203c = v203b == vb;
wire v203d = v203c;
wire v203e = v203d ^ v8;
wire v203f = v203a & v203e;
wire v2040 = v2033 & v2034 & v2035 & v203f;
wire v2041 = v2040;
wire v2042 = v2041;
wire [31:0] v2044 = v10;
wire [31:0] v2045 = In_register_EIP + v2044;
wire [31:0] v2047 = v2045;
wire v2048 = v2047 == Out_register_EIP;
wire [31:0] v204a = In_register_EDI;
wire v204b = v204a == Out_register_EDI;
wire [31:0] v204c = memory_0[79: 48];
wire [7:0] v204d = v204c[7:0];
wire [7:0] pad_8270 = (v204d[7:7] == 1'b1) ?8'b11111111 : 8'b00000000;
wire [15:0] v204e = { pad_8270, v204d };
wire [7:0] pad_8271 = (vf4a[7:7] == 1'b1) ?8'b11111111 : 8'b00000000;
wire [15:0] v204f = { pad_8271, vf4a };
wire [15:0] v2050 = v204e * v204f;
wire [7:0] v2051 = v2050[7:0];
wire [31:0] v2052 = { 24'b000000000000000000000000, v2051 };
wire [31:0] v2053 = v5c8 | v2052;
wire [31:0] v2054 = v2053 & v3a;
wire [15:0] v83 = 16'b0001000000000000;
wire [15:0] v2055 = v2050 >> v83;
wire [7:0] v2056 = v2055[7:0];
wire [31:0] v2057 = { 24'b000000000000000000000000, v2056 };
wire [31:0] v2058 = v2057 << v31;
wire [31:0] v2059 = v2054 | v2058;
wire [31:0] v205b = v2059;
wire v205c = v205b == Out_register_EAX;
wire [31:0] v205e = In_register_EBX;
wire v205f = v205e == Out_register_EBX;
wire [31:0] v2061 = In_register_ESBASE;
wire v2062 = v2061 == Out_register_ESBASE;
wire [31:0] v2064 = In_register_ECX;
wire v2065 = v2064 == Out_register_ECX;
wire [15:0] v84 = 16'b0000000111111111;
wire [15:0] v2066 = v2050 + v84;
wire [15:0] v85 = 16'b0000000011111111;
wire v2067 = v2066 < v85;
wire v2069 = v2067;
wire v206a = v2069 == Out_register_OF;
wire [31:0] v206c = In_register_EBP;
wire v206d = v206c == Out_register_EBP;
wire [31:0] v206f = In_register_EDX;
wire v2070 = v206f == Out_register_EDX;
wire [31:0] v2072 = In_register_ESI;
wire v2073 = v2072 == Out_register_ESI;
wire [2:0] v2074 = { v1fa };
wire [31:0] v2075 = ( v2074 == 3'd0) ? In_register_EAX : 
	( v2074 == 3'd1) ? In_register_ECX : 
	( v2074 == 3'd2) ? In_register_EDX : 
	( v2074 == 3'd3) ? In_register_EBX : 
	( v2074 == 3'd4) ? v15 : 
	( v2074 == 3'd5) ? v15 : 
	( v2074 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2076 = v2075 + v63a;
wire [31:0] v2078 = v2076;
wire v2079 =  v2a == memory_0[15: 12] && v2078 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v207b = In_register_ESP;
wire v207c = v207b == Out_register_ESP;
wire v207d = In_error_flag == Out_error_flag;
wire [31:0] v207f = In_register_CSBASE;
wire v2080 = v207f == Out_register_CSBASE;
wire [31:0] v2082 = In_register_SSBASE;
wire v2083 = v2082 == Out_register_SSBASE;
wire [31:0] v2085 = In_register_DSBASE;
wire v2086 = v2085 == Out_register_DSBASE;
wire [31:0] v2088 = In_register_GSBASE;
wire v2089 = v2088 == Out_register_GSBASE;
wire [31:0] v208b = In_register_FSBASE;
wire v208c = v208b == Out_register_FSBASE;
wire v208d = v2067;
wire v208e = v208d == Out_register_CF;
wire v2090 = In_register_AF;
wire v2091 = v2090 == Out_register_AF;
wire [7:0] v2093 = In_register_DF;
wire v2094 = v2093 == Out_register_DF;
wire v2096 = In_register_PF;
wire v2097 = v2096 == Out_register_PF;
wire v2099 = In_register_SF;
wire v209a = v2099 == Out_register_SF;
wire v209c = In_register_ZF;
wire v209d = v209c == Out_register_ZF;
wire v209e = v2042 & v2048 & v204b & v205c & v205f & v2062 & v2065 & v206a & v206d & v2070 & v2073 & v2079 & v207c & v207d & v2080 & v2083 & v15c & v2086 & v2089 & v208c & v208e & v2091 & v2094 & v2097 & v209a & v209d;
wire [15:0] v86 = 16'b0110011011000001;
wire v209f = v86 == v117;
wire [4:0] v20a0 = instruction_bits[23: 19];
wire v20a1 = v59 == v20a0;
wire v20a2 = v38 == v6da;
wire v20a3 = v209f & v20a1 & v20a2;
wire v20b8 = v20a3;
wire v20b9 = v20b8;
wire [2:0] v20b0 = { v13c };
wire v20b1 = v20b0 == vd;
wire v20b2 = v20b1;
wire v20b3 = v20a3 & v20b2;
wire v20b4 = v20b3;
wire [31:0] v20a5 = v7f8;
wire [15:0] v20a6 = v20a5[15:0];
wire [2:0] v20a7 = { v13c };
wire [31:0] v20a8 = ( v20a7 == 3'd0) ? In_register_EAX : 
	( v20a7 == 3'd1) ? In_register_ECX : 
	( v20a7 == 3'd2) ? In_register_EDX : 
	( v20a7 == 3'd3) ? In_register_EBX : 
	( v20a7 == 3'd4) ? In_register_ESP : 
	( v20a7 == 3'd5) ? In_register_EBP : 
	( v20a7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v20a9 = v20a8 & v6;
wire [31:0] v20ab = v20a9;
wire [15:0] v20ac = v20ab[15:0];
wire [15:0] v20ad = v20a6 + v20ac;
wire [31:0] v20ae = { 16'b0000000000000000, v20ad };
wire [31:0] v20af = v17c | v20ae;
wire [31:0] v20b7 = ( v8 ) ? In_register_EBX : v20af;
wire [31:0] v20bb = v20b7;
wire v20bc = v20bb == Out_register_EBX;
wire v20be = v20b0 == v9;
wire v20bf = v20be;
wire v20c0 = v20a3 & v20bf;
wire v20c1 = v20c0;
wire [31:0] v20bd = v149 | v20ae;
wire [31:0] v20c4 = ( v8 ) ? In_register_EDI : v20bd;
wire [31:0] v20c6 = v20c4;
wire v20c7 = v20c6 == Out_register_EDI;
wire [15:0] v87 = 16'b0000000000000000;
wire v20c8 = v20ad == v87;
wire v20ca = v20c8;
wire v20cb = v20ca == Out_register_ZF;
wire v20cd = v20b0 == vb;
wire v20ce = v20cd;
wire v20cf = v20a3 & v20ce;
wire v20d0 = v20cf;
wire [31:0] v20cc = v15d | v20ae;
wire [31:0] v20d3 = ( v8 ) ? In_register_ESP : v20cc;
wire [31:0] v20d5 = v20d3;
wire v20d6 = v20d5 == Out_register_ESP;
wire [31:0] v20d8 = In_register_FSBASE;
wire v20d9 = v20d8 == Out_register_FSBASE;
wire v20db = v20b0 == vc;
wire v20dc = v20db;
wire v20dd = v20a3 & v20dc;
wire v20de = v20dd;
wire [31:0] v20da = v16f | v20ae;
wire [31:0] v20e1 = ( v8 ) ? In_register_ECX : v20da;
wire [31:0] v20e3 = v20e1;
wire v20e4 = v20e3 == Out_register_ECX;
wire v20e6 = v20b0 == vf;
wire v20e7 = v20e6;
wire v20e8 = v20a3 & v20e7;
wire v20e9 = v20e8;
wire [31:0] v20e5 = v196 | v20ae;
wire [31:0] v20ec = ( v8 ) ? In_register_EBP : v20e5;
wire [31:0] v20ee = v20ec;
wire v20ef = v20ee == Out_register_EBP;
wire v20f1 = v20b0 == ve;
wire v20f2 = v20f1;
wire v20f3 = v20a3 & v20f2;
wire v20f4 = v20f3;
wire [31:0] v20f0 = v189 | v20ae;
wire [31:0] v20f7 = ( v8 ) ? In_register_EDX : v20f0;
wire [31:0] v20f9 = v20f7;
wire v20fa = v20f9 == Out_register_EDX;
wire v20fc = v20b0 == v11;
wire v20fd = v20fc;
wire v20fe = v20a3 & v20fd;
wire v20ff = v20fe;
wire [31:0] v20fb = v1d8 | v20ae;
wire [31:0] v2102 = ( v8 ) ? In_register_ESI : v20fb;
wire [31:0] v2104 = v2102;
wire v2105 = v2104 == Out_register_ESI;
wire v2106 = $signed(v20ad) < $signed(v87);
wire v2108 = v2106;
wire v2109 = v2108 == Out_register_SF;
wire v210a = In_error_flag == Out_error_flag;
wire [31:0] v210c = v27;
wire [31:0] v210d = In_register_EIP + v210c;
wire [31:0] v210f = v210d;
wire v2110 = v210f == Out_register_EIP;
wire [31:0] v2112 = In_register_SSBASE;
wire v2113 = v2112 == Out_register_SSBASE;
wire [31:0] v2115 = In_register_ESBASE;
wire v2116 = v2115 == Out_register_ESBASE;
wire [31:0] v2118 = In_register_CSBASE;
wire v2119 = v2118 == Out_register_CSBASE;
wire [31:0] v211b = In_register_DSBASE;
wire v211c = v211b == Out_register_DSBASE;
wire [7:0] v211e = In_register_DF;
wire v211f = v211e == Out_register_DF;
wire [31:0] v2121 = In_register_GSBASE;
wire v2122 = v2121 == Out_register_GSBASE;
wire [15:0] v2123 = v20ad ^ v20a6;
wire [15:0] v2124 = v2123 ^ v20ac;
wire [7:0] v2125 = v2124[7:0];
wire [7:0] v2126 = v2125 >> v1d;
wire [7:0] v2127 = v2126 & v18;
wire v2128 = v2127[0:0];
wire v212a = v2128;
wire v212b = v212a == Out_register_AF;
wire v212d = v20b0 == v7;
wire v212e = v212d;
wire v212f = v20a3 & v212e;
wire v2130 = v212f;
wire [31:0] v212c = v12b | v20ae;
wire [31:0] v2133 = ( v8 ) ? In_register_EAX : v212c;
wire [31:0] v2135 = v2133;
wire v2136 = v2135 == Out_register_EAX;
wire v2137 = v20ad < v20ac;
wire v2138 = v20ad < v20a6;
wire v2139 = v2137 | v2138;
wire v213b = v2139;
wire v213c = v213b == Out_register_CF;
wire [15:0] v213d = v20ad ^ v20ac;
wire [15:0] v88 = 16'b1111000000000000;
wire [15:0] v213e = v213d >> v88;
wire [15:0] v213f = v2123 >> v88;
wire [15:0] v2140 = v213e + v213f;
wire [15:0] v89 = 16'b0100000000000000;
wire v2141 = v2140 == v89;
wire v2143 = v2141;
wire v2144 = v2143 == Out_register_OF;
wire [7:0] v2145 = v20ad[7:0];
wire [2:0] v2146_aux = v2145[0] + v2145[1] + v2145[2] + v2145[3] + v2145[4] + v2145[5] + v2145[6] + v2145[7];
wire v2146 = { 5'b00000, v2146_aux };
wire [7:0] v2147 = v2146 & v18;
wire [7:0] v2148 = v2147 ^ v18;
wire v2149 = v2148[0:0];
wire v214b = v2149;
wire v214c = v214b == Out_register_PF;
wire v214d = v20bc & v15c & v20b9 & v20c7 & v20cb & v20d6 & v20d9 & v20e4 & v20ef & v20fa & v2105 & v2109 & v210a & v2110 & v2113 & v2116 & v2119 & v211c & v211f & v2122 & v212b & v2136 & v213c & v2144 & v214c;
wire v214e = v40 == v1eb;
wire v214f = v8 == v829;
wire [4:0] v8a = 5'b11000;
wire v2150 = v8a == v1ed;
wire v2151 = v4 == v11b;
wire v2152 = v214e & v214f & v2150 & v2151;
wire v2153 = v40 == v1eb;
wire [4:0] v8b = 5'b11010;
wire v2154 = v8b == v1ed;
wire v2155 = v38 == v6da;
wire [2:0] v2156 = { v1fa };
wire v2157 = v2156 == vb;
wire v2158 = v2157;
wire v2159 = v2158 ^ v8;
wire [2:0] v215a = { v1fa };
wire v215b = v215a == vb;
wire v215c = v215b;
wire v215d = v215c ^ v8;
wire [2:0] v215e = { v1fa };
wire v215f = v215e == vb;
wire v2160 = v215f;
wire v2161 = v2160 ^ v8;
wire [2:0] v2162 = { v1fa };
wire v2163 = v2162 == vb;
wire v2164 = v2163;
wire v2165 = v2164 ^ v8;
wire v2166 = v2159 & v215d & v2161 & v2165;
wire v2167 = v2153 & v2154 & v2155 & v2166;
wire v2168 = v2152 | v2167;
wire v2169 = v2168;
wire [31:0] v216c = ( v2167 ) ? v27 : v10;
wire [31:0] v216d = In_register_EIP + v216c;
wire [31:0] v216f = v216d;
wire v2170 = v216f == Out_register_EIP;
wire [31:0] v2172 = In_register_EDI;
wire v2173 = v2172 == Out_register_EDI;
wire [31:0] v2175 = In_register_ECX;
wire v2176 = v2175 == Out_register_ECX;
wire [2:0] v217a = { v1fa };
wire [31:0] v217b = ( v217a == 3'd0) ? In_register_EAX : 
	( v217a == 3'd1) ? In_register_ECX : 
	( v217a == 3'd2) ? In_register_EDX : 
	( v217a == 3'd3) ? In_register_EBX : 
	( v217a == 3'd4) ? v15 : 
	( v217a == 3'd5) ? In_register_EBP : 
	( v217a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v217c = v217b + v63a;
wire [1:0] v2177 = { v889 , v888 };
wire [31:0] v2178 = ( v2177 == 2'd0) ? In_register_EDX : 
	( v2177 == 2'd1) ? In_register_ESI : 
	( v2177 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v217e = ( v2167 ) ? v217c : v2178;
wire [31:0] v217f = memory_0[79: 48];
wire [31:0] v2182 = ( v2167 ) ? v7f8 : v63a;
wire [31:0] v2183 = v217f - v2182;
wire [31:0] v2184 = v2183 - vb11;
wire v2185 =  v26 == memory_1[15: 12] && v217e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v2184 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v2187 = In_register_ESI;
wire v2188 = v2187 == Out_register_ESI;
wire [2:0] v218c = { v1fa };
wire [31:0] v218d = ( v218c == 3'd0) ? In_register_EAX : 
	( v218c == 3'd1) ? In_register_ECX : 
	( v218c == 3'd2) ? In_register_EDX : 
	( v218c == 3'd3) ? In_register_EBX : 
	( v218c == 3'd4) ? v15 : 
	( v218c == 3'd5) ? In_register_EBP : 
	( v218c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v218e = v218d + v63a;
wire [1:0] v2189 = { v889 , v888 };
wire [31:0] v218a = ( v2189 == 2'd0) ? In_register_EDX : 
	( v2189 == 2'd1) ? In_register_ESI : 
	( v2189 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v2190 = ( v2167 ) ? v218e : v218a;
wire v2191 =  v26 == memory_0[15: 12] && v2190 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2193 = In_register_SSBASE;
wire v2194 = v2193 == Out_register_SSBASE;
wire [31:0] v2196 = In_register_ESP;
wire v2197 = v2196 == Out_register_ESP;
wire [31:0] v2199 = In_register_ESBASE;
wire v219a = v2199 == Out_register_ESBASE;
wire [31:0] v219c = In_register_EAX;
wire v219d = v219c == Out_register_EAX;
wire [31:0] v219f = In_register_EDX;
wire v21a0 = v219f == Out_register_EDX;
wire v21a1 = In_error_flag == Out_error_flag;
wire [31:0] v21a3 = In_register_EBP;
wire v21a4 = v21a3 == Out_register_EBP;
wire [31:0] v21a6 = In_register_FSBASE;
wire v21a7 = v21a6 == Out_register_FSBASE;
wire [31:0] v21a9 = In_register_CSBASE;
wire v21aa = v21a9 == Out_register_CSBASE;
wire v21ab = $signed(v2184) < $signed(v15);
wire v21ad = v21ab;
wire v21ae = v21ad == Out_register_SF;
wire [31:0] v21b0 = In_register_GSBASE;
wire v21b1 = v21b0 == Out_register_GSBASE;
wire [31:0] v21b3 = In_register_EBX;
wire v21b4 = v21b3 == Out_register_EBX;
wire [31:0] v21b6 = In_register_DSBASE;
wire v21b7 = v21b6 == Out_register_DSBASE;
wire [31:0] v21b8 = v217f ^ v2182;
wire [31:0] v21b9 = v2184 ^ v21b8;
wire [7:0] v21ba = v21b9[7:0];
wire [7:0] v21bb = v21ba >> v1d;
wire [7:0] v21bc = v21bb & v18;
wire v21bd = v21bc[0:0];
wire v21bf = v21bd;
wire v21c0 = v21bf == Out_register_AF;
wire v21c1 = v217f < v2182;
wire v21c2 = v2183 < vb11;
wire [7:0] v21c3 = { 7'b0000000, v21c2 };
wire [7:0] v21c4 = ( v21c1 == 1'd0) ? v21c3 : v18;
wire v21c5 = v21c4[0:0];
wire v21c7 = v21c5;
wire v21c8 = v21c7 == Out_register_CF;
wire [7:0] v21ca = In_register_DF;
wire v21cb = v21ca == Out_register_DF;
wire [31:0] v21cc = v2184 ^ v217f;
wire [31:0] v21cd = v21cc >> v1e;
wire [31:0] v21ce = v21b8 >> v1e;
wire [31:0] v21cf = v21cd + v21ce;
wire v21d0 = v21cf == v1c;
wire v21d2 = v21d0;
wire v21d3 = v21d2 == Out_register_OF;
wire [7:0] v21d4 = v2184[7:0];
wire [2:0] v21d5_aux = v21d4[0] + v21d4[1] + v21d4[2] + v21d4[3] + v21d4[4] + v21d4[5] + v21d4[6] + v21d4[7];
wire v21d5 = { 5'b00000, v21d5_aux };
wire [7:0] v21d6 = v21d5 & v18;
wire [7:0] v21d7 = v21d6 ^ v18;
wire v21d8 = v21d7[0:0];
wire v21da = v21d8;
wire v21db = v21da == Out_register_PF;
wire v21dc = v2183 == vb11;
wire v21de = v21dc;
wire v21df = v21de == Out_register_ZF;
wire v21e0 = v2169 & v2170 & v2173 & v2176 & v2185 & v2188 & v2191 & v2194 & v2197 & v219a & v15c & v219d & v21a0 & v21a1 & v21a4 & v21a7 & v21aa & v21ae & v21b1 & v21b4 & v21b7 & v21c0 & v21c8 & v21cb & v21d3 & v21db & v21df;
wire v21e1 = In_error_flag == Out_error_flag;
wire [7:0] v8c = 8'b01011100;
wire v21e2 = v8c == v1eb;
wire v21e3 = v2f == v316;
wire v21e4 = v14 == v1ef;
wire [2:0] v21e5 = { v1fa };
wire v21e6 = v21e5 == vb;
wire v21e7 = v21e5 == vf;
wire v21e8 = v21e6 | v21e7;
wire v21e9 = v21e8 ^ v8;
wire [2:0] v21ea = { v1fa };
wire v21eb = v21ea == vb;
wire v21ec = v21eb;
wire v21ed = v21ec ^ v8;
wire v21ee = v21e9 & v21ed;
wire v21ef = v21e2 & v21e3 & v21e4 & v21ee;
wire [10:0] v8d = 11'b01011100101;
wire v21f0 = v8d == v6d7;
wire v21f1 = v35 == v316;
wire v21f2 = v14 == v1ef;
wire v21f3 = v21f0 & v21f1 & v21f2;
wire v21f4 = v21ef | v21f3;
wire v21f5 = v21f4;
wire [31:0] v21f7 = In_register_ESBASE;
wire v21f8 = v21f7 == Out_register_ESBASE;
wire [2:0] v21f9 = { v1fa };
wire [31:0] v21fa = ( v21f9 == 3'd0) ? In_register_EAX : 
	( v21f9 == 3'd1) ? In_register_ECX : 
	( v21f9 == 3'd2) ? In_register_EDX : 
	( v21f9 == 3'd3) ? In_register_EBX : 
	( v21f9 == 3'd4) ? v15 : 
	( v21f9 == 3'd5) ? v15 : 
	( v21f9 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v21fb = v21fa + v1f7;
wire [31:0] v21fe = ( v21ef ) ? v21fb : v1f7;
wire v21ff =  v2a == memory_0[15: 12] && v21fe == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2201 = In_register_EAX;
wire v2202 = v2201 == Out_register_EAX;
wire [2:0] v2203 = { v320 };
wire [31:0] v2204 = ( v2203 == 3'd0) ? In_register_EAX : 
	( v2203 == 3'd1) ? In_register_ECX : 
	( v2203 == 3'd2) ? In_register_EDX : 
	( v2203 == 3'd3) ? In_register_EBX : 
	( v2203 == 3'd4) ? In_register_EAX : 
	( v2203 == 3'd5) ? In_register_ECX : 
	( v2203 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2205 = { v320 };
wire v2206 = v2205 == vb;
wire v2207 = v2205 == v9;
wire v2208 = v2206 | v2207;
wire v2209 = v2205 == vf;
wire v220a = v2208 | v2209;
wire v220b = v2205 == v11;
wire v220c = v220a | v220b;
wire [31:0] v220d = ( v220c == 1'd0) ? v15 : v31;
wire [31:0] v220e = v2204 >> v220d;
wire [31:0] v220f = v220e & v32;
wire [2:0] v2211 = { v320 };
wire [31:0] v2212 = ( v2211 == 3'd0) ? In_register_EAX : 
	( v2211 == 3'd1) ? In_register_ECX : 
	( v2211 == 3'd2) ? In_register_EDX : 
	( v2211 == 3'd3) ? In_register_EBX : 
	( v2211 == 3'd4) ? In_register_EAX : 
	( v2211 == 3'd5) ? In_register_ECX : 
	( v2211 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2213 = { v320 };
wire v2214 = v2213 == vb;
wire v2215 = v2213 == v9;
wire v2216 = v2214 | v2215;
wire v2217 = v2213 == vf;
wire v2218 = v2216 | v2217;
wire v2219 = v2213 == v11;
wire v221a = v2218 | v2219;
wire [31:0] v221b = ( v221a == 1'd0) ? v15 : v31;
wire [31:0] v221c = v2212 >> v221b;
wire [31:0] v221d = v221c & v32;
wire [31:0] v221f = ( v21ef ) ? v220f : v221d;
wire [7:0] v2220 = v221f[7:0];
wire [31:0] v2221 = memory_0[79: 48];
wire [7:0] v2222 = v2221[7:0];
wire [7:0] v2223 = v2220 - v2222;
wire [2:0] v2224_aux = v2223[0] + v2223[1] + v2223[2] + v2223[3] + v2223[4] + v2223[5] + v2223[6] + v2223[7];
wire v2224 = { 5'b00000, v2224_aux };
wire [7:0] v2225 = v2224 & v18;
wire [7:0] v2226 = v2225 ^ v18;
wire v2227 = v2226[0:0];
wire v2229 = v2227;
wire v222a = v2229 == Out_register_PF;
wire [7:0] v222c = In_register_DF;
wire v222d = v222c == Out_register_DF;
wire [7:0] v222e = v2222 ^ v2220;
wire [7:0] v222f = v222e ^ v2223;
wire [7:0] v2230 = v222f >> v1d;
wire [7:0] v2231 = v2230 & v18;
wire v2232 = v2231[0:0];
wire v2234 = v2232;
wire v2235 = v2234 == Out_register_AF;
wire [31:0] v2237 = In_register_FSBASE;
wire v2238 = v2237 == Out_register_FSBASE;
wire [31:0] v223a = In_register_EBX;
wire v223b = v223a == Out_register_EBX;
wire [31:0] v223d = In_register_ECX;
wire v223e = v223d == Out_register_ECX;
wire [31:0] v2240 = In_register_GSBASE;
wire v2241 = v2240 == Out_register_GSBASE;
wire [31:0] v2243 = In_register_EDX;
wire v2244 = v2243 == Out_register_EDX;
wire [31:0] v2246 = In_register_ESP;
wire v2247 = v2246 == Out_register_ESP;
wire [31:0] v224a = v16;
wire [31:0] v224b = In_register_EIP + v224a;
wire [31:0] v224d = v224b;
wire v224e = v224d == Out_register_EIP;
wire [31:0] v2250 = In_register_ESI;
wire v2251 = v2250 == Out_register_ESI;
wire [31:0] v2253 = In_register_DSBASE;
wire v2254 = v2253 == Out_register_DSBASE;
wire [31:0] v2256 = In_register_EBP;
wire v2257 = v2256 == Out_register_EBP;
wire [31:0] v2259 = In_register_EDI;
wire v225a = v2259 == Out_register_EDI;
wire [31:0] v225c = In_register_CSBASE;
wire v225d = v225c == Out_register_CSBASE;
wire [7:0] v225e = v2223 ^ v2220;
wire [7:0] v225f = v225e >> v33;
wire [7:0] v2260 = v222e >> v33;
wire [7:0] v2261 = v225f + v2260;
wire v2262 = v2261 == v34;
wire v2264 = v2262;
wire v2265 = v2264 == Out_register_OF;
wire v2266 = v2222 > v2220;
wire v2268 = v2266;
wire v2269 = v2268 == Out_register_CF;
wire [31:0] v226b = In_register_SSBASE;
wire v226c = v226b == Out_register_SSBASE;
wire v226d = $signed(v2223) < $signed(v2c);
wire v226f = v226d;
wire v2270 = v226f == Out_register_SF;
wire v2271 = v2222 == v2220;
wire v2273 = v2271;
wire v2274 = v2273 == Out_register_ZF;
wire v2275 = v21e1 & v21f8 & v21ff & v21f5 & v2202 & v222a & v222d & v15c & v2235 & v2238 & v223b & v223e & v2241 & v2244 & v2247 & v224e & v2251 & v2254 & v2257 & v225a & v225d & v2265 & v2269 & v226c & v2270 & v2274;
wire [7:0] v8e = 8'b00000100;
wire v2276 = v8e == v1eb;
wire v2277 = v2f == v316;
wire v2278 = v14 == v1ef;
wire [2:0] v2279 = { v1fa };
wire v227a = v2279 == vb;
wire v227b = v2279 == vf;
wire v227c = v227a | v227b;
wire v227d = v227c ^ v8;
wire [2:0] v227e = { v1fa };
wire v227f = v227e == vb;
wire v2280 = v227f;
wire v2281 = v2280 ^ v8;
wire [2:0] v2282 = { v1fa };
wire v2283 = v2282 == vb;
wire v2284 = v2282 == vf;
wire v2285 = v2283 | v2284;
wire v2286 = v2285 ^ v8;
wire [2:0] v2287 = { v1fa };
wire v2288 = v2287 == vb;
wire v2289 = v2288;
wire v228a = v2289 ^ v8;
wire v228b = v227d & v2281 & v2286 & v228a;
wire v228c = v2276 & v2277 & v2278 & v228b;
wire v228d = v8e == v1eb;
wire v228e = v8 == v829;
wire v228f = v35 == v316;
wire v2290 = v1b == v318;
wire v2291 = v228d & v228e & v228f & v2290;
wire [10:0] v8f = 11'b00000100101;
wire v2292 = v8f == v6d7;
wire v2293 = v35 == v316;
wire v2294 = v14 == v1ef;
wire v2295 = v2292 & v2293 & v2294;
wire v2296 = v8e == v1eb;
wire v2297 = v8 == v829;
wire v2298 = v30 == v316;
wire v2299 = v4 == v11b;
wire v229a = v2296 & v2297 & v2298 & v2299;
wire v229b = v228c | v2291 | v2295 | v229a;
wire v229c = v229b;
wire [31:0] v229e = In_register_EAX;
wire v229f = v229e == Out_register_EAX;
wire [2:0] v22a0 = { v1fa };
wire [31:0] v22a1 = ( v22a0 == 3'd0) ? In_register_EAX : 
	( v22a0 == 3'd1) ? In_register_ECX : 
	( v22a0 == 3'd2) ? In_register_EDX : 
	( v22a0 == 3'd3) ? In_register_EBX : 
	( v22a0 == 3'd4) ? v15 : 
	( v22a0 == 3'd5) ? v15 : 
	( v22a0 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v22a2 = v22a1 + v1f7;
wire [1:0] v22a8 = { v889 , v888 };
wire [31:0] v22a9 = ( v22a8 == 2'd0) ? In_register_EDX : 
	( v22a8 == 2'd1) ? In_register_ESI : 
	( v22a8 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v22aa = v22a9 + v63a;
wire [1:0] v22a4 = { v889 , v888 };
wire [31:0] v22a5 = ( v22a4 == 2'd0) ? In_register_EDX : 
	( v22a4 == 2'd1) ? In_register_ESI : 
	( v22a4 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v22ac = ( v228c ) ? v22a2 : 
	( v229a ) ? v22aa : 
	( v2291 ) ? v22a5 : v1f7;
wire v22ad =  v2a == memory_0[15: 12] && v22ac == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v22b2 = ( v2291 ) ? v1c : 
	( v228c | v2295 ) ? v16 : v10;
wire [31:0] v22b3 = In_register_EIP + v22b2;
wire [31:0] v22b5 = v22b3;
wire v22b6 = v22b5 == Out_register_EIP;
wire v22b7 = In_error_flag == Out_error_flag;
wire [31:0] v22b9 = In_register_ESBASE;
wire v22ba = v22b9 == Out_register_ESBASE;
wire [31:0] v22bc = In_register_CSBASE;
wire v22bd = v22bc == Out_register_CSBASE;
wire [31:0] v22bf = In_register_FSBASE;
wire v22c0 = v22bf == Out_register_FSBASE;
wire [31:0] v22c2 = In_register_EDX;
wire v22c3 = v22c2 == Out_register_EDX;
wire [31:0] v22c4 = memory_0[79: 48];
wire [7:0] v22c5 = v22c4[7:0];
wire [2:0] v22d4 = { v320 };
wire [31:0] v22d5 = ( v22d4 == 3'd0) ? In_register_EAX : 
	( v22d4 == 3'd1) ? In_register_ECX : 
	( v22d4 == 3'd2) ? In_register_EDX : 
	( v22d4 == 3'd3) ? In_register_EBX : 
	( v22d4 == 3'd4) ? In_register_EAX : 
	( v22d4 == 3'd5) ? In_register_ECX : 
	( v22d4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v22d6 = { v320 };
wire v22d7 = v22d6 == vb;
wire v22d8 = v22d6 == v9;
wire v22d9 = v22d7 | v22d8;
wire v22da = v22d6 == vf;
wire v22db = v22d9 | v22da;
wire v22dc = v22d6 == v11;
wire v22dd = v22db | v22dc;
wire [31:0] v22de = ( v22dd == 1'd0) ? v15 : v31;
wire [31:0] v22df = v22d5 >> v22de;
wire [31:0] v22e0 = v22df & v32;
wire [2:0] v22e2 = { v320 };
wire [31:0] v22e3 = ( v22e2 == 3'd0) ? In_register_EAX : 
	( v22e2 == 3'd1) ? In_register_ECX : 
	( v22e2 == 3'd2) ? In_register_EDX : 
	( v22e2 == 3'd3) ? In_register_EBX : 
	( v22e2 == 3'd4) ? In_register_EAX : 
	( v22e2 == 3'd5) ? In_register_ECX : 
	( v22e2 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v22e4 = { v320 };
wire v22e5 = v22e4 == vb;
wire v22e6 = v22e4 == v9;
wire v22e7 = v22e5 | v22e6;
wire v22e8 = v22e4 == vf;
wire v22e9 = v22e7 | v22e8;
wire v22ea = v22e4 == v11;
wire v22eb = v22e9 | v22ea;
wire [31:0] v22ec = ( v22eb == 1'd0) ? v15 : v31;
wire [31:0] v22ed = v22e3 >> v22ec;
wire [31:0] v22ee = v22ed & v32;
wire [2:0] v22f0 = { v320 };
wire [31:0] v22f1 = ( v22f0 == 3'd0) ? In_register_EAX : 
	( v22f0 == 3'd1) ? In_register_ECX : 
	( v22f0 == 3'd2) ? In_register_EDX : 
	( v22f0 == 3'd3) ? In_register_EBX : 
	( v22f0 == 3'd4) ? In_register_EAX : 
	( v22f0 == 3'd5) ? In_register_ECX : 
	( v22f0 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v22f2 = { v320 };
wire v22f3 = v22f2 == vb;
wire v22f4 = v22f2 == v9;
wire v22f5 = v22f3 | v22f4;
wire v22f6 = v22f2 == vf;
wire v22f7 = v22f5 | v22f6;
wire v22f8 = v22f2 == v11;
wire v22f9 = v22f7 | v22f8;
wire [31:0] v22fa = ( v22f9 == 1'd0) ? v15 : v31;
wire [31:0] v22fb = v22f1 >> v22fa;
wire [31:0] v22fc = v22fb & v32;
wire [2:0] v22c6 = { v320 };
wire [31:0] v22c7 = ( v22c6 == 3'd0) ? In_register_EAX : 
	( v22c6 == 3'd1) ? In_register_ECX : 
	( v22c6 == 3'd2) ? In_register_EDX : 
	( v22c6 == 3'd3) ? In_register_EBX : 
	( v22c6 == 3'd4) ? In_register_EAX : 
	( v22c6 == 3'd5) ? In_register_ECX : 
	( v22c6 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v22c8 = { v320 };
wire v22c9 = v22c8 == vb;
wire v22ca = v22c8 == v9;
wire v22cb = v22c9 | v22ca;
wire v22cc = v22c8 == vf;
wire v22cd = v22cb | v22cc;
wire v22ce = v22c8 == v11;
wire v22cf = v22cd | v22ce;
wire [31:0] v22d0 = ( v22cf == 1'd0) ? v15 : v31;
wire [31:0] v22d1 = v22c7 >> v22d0;
wire [31:0] v22d2 = v22d1 & v32;
wire [31:0] v22fe = ( v2291 ) ? v22e0 : 
	( v2295 ) ? v22ee : 
	( v229a ) ? v22fc : v22d2;
wire [7:0] v22ff = v22fe[7:0];
wire [7:0] v2300 = v22c5 & v22ff;
wire [2:0] v2301_aux = v2300[0] + v2300[1] + v2300[2] + v2300[3] + v2300[4] + v2300[5] + v2300[6] + v2300[7];
wire v2301 = { 5'b00000, v2301_aux };
wire [7:0] v2302 = v2301 & v18;
wire [7:0] v2303 = v2302 ^ v18;
wire v2304 = v2303[0:0];
wire v2306 = v2304;
wire v2307 = v2306 == Out_register_PF;
wire v2309 = v17;
wire v230a = v2309 == Out_register_AF;
wire [31:0] v230c = In_register_EBP;
wire v230d = v230c == Out_register_EBP;
wire [31:0] v230f = In_register_EBX;
wire v2310 = v230f == Out_register_EBX;
wire v2311 = v17;
wire v2312 = v2311 == Out_register_OF;
wire [31:0] v2314 = In_register_EDI;
wire v2315 = v2314 == Out_register_EDI;
wire [31:0] v2317 = In_register_SSBASE;
wire v2318 = v2317 == Out_register_SSBASE;
wire [31:0] v231a = In_register_DSBASE;
wire v231b = v231a == Out_register_DSBASE;
wire [31:0] v231d = In_register_ESI;
wire v231e = v231d == Out_register_ESI;
wire [31:0] v2320 = In_register_ECX;
wire v2321 = v2320 == Out_register_ECX;
wire [31:0] v2323 = In_register_GSBASE;
wire v2324 = v2323 == Out_register_GSBASE;
wire [7:0] v2326 = In_register_DF;
wire v2327 = v2326 == Out_register_DF;
wire [31:0] v2329 = In_register_ESP;
wire v232a = v2329 == Out_register_ESP;
wire v232b = v17;
wire v232c = v232b == Out_register_CF;
wire [2:0] v232d = { v1fa };
wire [31:0] v232e = ( v232d == 3'd0) ? In_register_EAX : 
	( v232d == 3'd1) ? In_register_ECX : 
	( v232d == 3'd2) ? In_register_EDX : 
	( v232d == 3'd3) ? In_register_EBX : 
	( v232d == 3'd4) ? v15 : 
	( v232d == 3'd5) ? v15 : 
	( v232d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v232f = v232e + v1f7;
wire [1:0] v2335 = { v889 , v888 };
wire [31:0] v2336 = ( v2335 == 2'd0) ? In_register_EDX : 
	( v2335 == 2'd1) ? In_register_ESI : 
	( v2335 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v2337 = v2336 + v63a;
wire [1:0] v2331 = { v889 , v888 };
wire [31:0] v2332 = ( v2331 == 2'd0) ? In_register_EDX : 
	( v2331 == 2'd1) ? In_register_ESI : 
	( v2331 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v2339 = ( v228c ) ? v232f : 
	( v229a ) ? v2337 : 
	( v2291 ) ? v2332 : v1f7;
wire v233a =  v2a == memory_1[15: 12] && v2339 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v2300 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v233b = $signed(v2300) < $signed(v2c);
wire v233d = v233b;
wire v233e = v233d == Out_register_SF;
wire v233f = v2300 == v2c;
wire v2341 = v233f;
wire v2342 = v2341 == Out_register_ZF;
wire v2343 = v229f & v22ad & v15c & v22b6 & v229c & v22b7 & v22ba & v22bd & v22c0 & v22c3 & v2307 & v230a & v230d & v2310 & v2312 & v2315 & v2318 & v231b & v231e & v2321 & v2324 & v2327 & v232a & v232c & v233a & v233e & v2342;
wire [7:0] v90 = 8'b01111110;
wire v2344 = v90 == v1eb;
wire v2345 = v1b == v318;
wire v2346 = v2344 & v2345;
wire v2347 = v2346;
wire v2348 = v2347;
wire [31:0] v234a = In_register_EBX;
wire v234b = v234a == Out_register_EBX;
wire [31:0] v234d = In_register_EAX;
wire v234e = v234d == Out_register_EAX;
wire [31:0] v2350 = In_register_EDX;
wire v2351 = v2350 == Out_register_EDX;
wire [31:0] v2353 = In_register_ESI;
wire v2354 = v2353 == Out_register_ESI;
wire [31:0] v2356 = In_register_ECX;
wire v2357 = v2356 == Out_register_ECX;
wire [31:0] v2359 = In_register_ESP;
wire v235a = v2359 == Out_register_ESP;
wire [31:0] v235c = In_register_EBP;
wire v235d = v235c == Out_register_EBP;
wire [31:0] v235f = In_register_EDI;
wire v2360 = v235f == Out_register_EDI;
wire [31:0] v2363 = v1c;
wire [31:0] v2364 = In_register_EIP + v2363;
wire v2361 = In_register_ZF | v1361;
wire [31:0] v2366 = v2364;
wire [31:0] v2367 = v2364 + v477;
wire [31:0] v2369 = v2367;
wire [31:0] v236a = ( v2361 == 1'd0) ? v2366 : v2369;
wire [31:0] v236d = ( v8 ) ? v2364 : v236a;
wire [31:0] v236f = v236d;
wire v2370 = v236f == Out_register_EIP;
wire [31:0] v2372 = In_register_ESBASE;
wire v2373 = v2372 == Out_register_ESBASE;
wire [31:0] v2375 = In_register_SSBASE;
wire v2376 = v2375 == Out_register_SSBASE;
wire [31:0] v2378 = In_register_CSBASE;
wire v2379 = v2378 == Out_register_CSBASE;
wire v237b = In_register_PF;
wire v237c = v237b == Out_register_PF;
wire [31:0] v237e = In_register_DSBASE;
wire v237f = v237e == Out_register_DSBASE;
wire v2380 = In_error_flag == Out_error_flag;
wire [31:0] v2382 = In_register_GSBASE;
wire v2383 = v2382 == Out_register_GSBASE;
wire [31:0] v2385 = In_register_FSBASE;
wire v2386 = v2385 == Out_register_FSBASE;
wire v2388 = In_register_CF;
wire v2389 = v2388 == Out_register_CF;
wire v238b = In_register_AF;
wire v238c = v238b == Out_register_AF;
wire v238e = In_register_OF;
wire v238f = v238e == Out_register_OF;
wire [7:0] v2391 = In_register_DF;
wire v2392 = v2391 == Out_register_DF;
wire v2394 = In_register_SF;
wire v2395 = v2394 == Out_register_SF;
wire v2397 = In_register_ZF;
wire v2398 = v2397 == Out_register_ZF;
wire v2399 = v234b & v234e & v2351 & v15c & v2354 & v2357 & v235a & v2348 & v235d & v2360 & v2370 & v2373 & v2376 & v2379 & v237c & v237f & v2380 & v2383 & v2386 & v2389 & v238c & v238f & v2392 & v2395 & v2398;
wire [7:0] v91 = 8'b11010101;
wire v239a = v91 == v1eb;
wire v239b = v29 == v59f;
wire v239c = v239a & v239b;
wire v239d = v239c;
wire v239e = v239d;
wire [31:0] v23a0 = v2b;
wire [31:0] v23a1 = In_register_EIP + v23a0;
wire [31:0] v23a3 = v23a1;
wire v23a4 = v23a3 == Out_register_EIP;
wire [31:0] v23a6 = In_register_EBX;
wire v23a7 = v23a6 == Out_register_EBX;
wire [7:0] v23a9 = In_register_DF;
wire v23aa = v23a9 == Out_register_DF;
wire [31:0] v23ac = In_register_ECX;
wire v23ad = v23ac == Out_register_ECX;
wire [31:0] v23af = In_register_EBP;
wire v23b0 = v23af == Out_register_EBP;
wire [31:0] v23b2 = In_register_EAX;
wire v23b3 = v23b2 == Out_register_EAX;
wire [31:0] v23b5 = In_register_GSBASE;
wire v23b6 = v23b5 == Out_register_GSBASE;
wire [31:0] v23b8 = In_register_EDX;
wire v23b9 = v23b8 == Out_register_EDX;
wire [31:0] v23bb = In_register_ESI;
wire v23bc = v23bb == Out_register_ESI;
wire v23bd = In_error_flag == Out_error_flag;
wire [31:0] v23be = v8cc + In_register_EDI;
wire [31:0] v23c0 = v23be;
wire v23c1 = v23c0 == Out_register_EDI;
wire [31:0] v23c3 = In_register_ESP;
wire v23c4 = v23c3 == Out_register_ESP;
wire [31:0] v23c6 = In_register_CSBASE;
wire v23c7 = v23c6 == Out_register_CSBASE;
wire [31:0] v23c9 = In_register_SSBASE;
wire v23ca = v23c9 == Out_register_SSBASE;
wire [31:0] v23cc = In_register_ESBASE;
wire v23cd = v23cc == Out_register_ESBASE;
wire v23cf = In_register_CF;
wire v23d0 = v23cf == Out_register_CF;
wire v23d2 = In_register_ZF;
wire v23d3 = v23d2 == Out_register_ZF;
wire [31:0] v23d5 = In_register_DSBASE;
wire v23d6 = v23d5 == Out_register_DSBASE;
wire [31:0] v23d8 = In_register_FSBASE;
wire v23d9 = v23d8 == Out_register_FSBASE;
wire v23db = In_register_AF;
wire v23dc = v23db == Out_register_AF;
wire v23de = In_register_OF;
wire v23df = v23de == Out_register_OF;
wire v23e1 = In_register_PF;
wire v23e2 = v23e1 == Out_register_PF;
wire v23e3 =  v26 == memory_0[15: 12] && v1b8e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && In_register_EAX == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v23e5 = In_register_SF;
wire v23e6 = v23e5 == Out_register_SF;
wire v23e7 = v239e & v15c & v23a4 & v23a7 & v23aa & v23ad & v23b0 & v23b3 & v23b6 & v23b9 & v23bc & v23bd & v23c1 & v23c4 & v23c7 & v23ca & v23cd & v23d0 & v23d3 & v23d6 & v23d9 & v23dc & v23df & v23e2 & v23e3 & v23e6;
wire v23e8 = v40 == v1eb;
wire [4:0] v92 = 5'b11111;
wire v23e9 = v92 == v1ed;
wire v23ea = v4 == v11b;
wire v23eb = v23e8 & v23e9 & v23ea;
wire v23ec = v23eb;
wire v23ed = v23ec;
wire [31:0] v23ef = v10;
wire [31:0] v23f0 = In_register_EIP + v23ef;
wire [31:0] v23f2 = v23f0;
wire v23f3 = v23f2 == Out_register_EIP;
wire [31:0] v23f5 = In_register_FSBASE;
wire v23f6 = v23f5 == Out_register_FSBASE;
wire [2:0] v23f7 = { v1fa };
wire [31:0] v23f8 = ( v23f7 == 3'd0) ? In_register_EAX : 
	( v23f7 == 3'd1) ? In_register_ECX : 
	( v23f7 == 3'd2) ? In_register_EDX : 
	( v23f7 == 3'd3) ? In_register_EBX : 
	( v23f7 == 3'd4) ? In_register_ESP : 
	( v23f7 == 3'd5) ? In_register_EBP : 
	( v23f7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v23fa = v23f8;
wire [31:0] v23fc = v63a;
wire [31:0] v23fd = v23fa - v23fc;
wire v23fe = $signed(v23fd) < $signed(v15);
wire v2400 = v23fe;
wire v2401 = v2400 == Out_register_SF;
wire [31:0] v2403 = In_register_CSBASE;
wire v2404 = v2403 == Out_register_CSBASE;
wire [31:0] v2406 = In_register_EDI;
wire v2407 = v2406 == Out_register_EDI;
wire v2408 = In_error_flag == Out_error_flag;
wire [31:0] v240a = In_register_EBX;
wire v240b = v240a == Out_register_EBX;
wire [31:0] v240d = In_register_EAX;
wire v240e = v240d == Out_register_EAX;
wire [31:0] v2410 = In_register_ESP;
wire v2411 = v2410 == Out_register_ESP;
wire [31:0] v2412 = v23fd ^ v23fa;
wire [31:0] v2413 = v2412 >> v1e;
wire [31:0] v2414 = v23fc ^ v23fa;
wire [31:0] v2415 = v2414 >> v1e;
wire [31:0] v2416 = v2413 + v2415;
wire v2417 = v2416 == v1c;
wire v2419 = v2417;
wire v241a = v2419 == Out_register_OF;
wire [31:0] v241c = In_register_ECX;
wire v241d = v241c == Out_register_ECX;
wire [31:0] v241f = In_register_EBP;
wire v2420 = v241f == Out_register_EBP;
wire [31:0] v2422 = In_register_EDX;
wire v2423 = v2422 == Out_register_EDX;
wire [31:0] v2425 = In_register_SSBASE;
wire v2426 = v2425 == Out_register_SSBASE;
wire [31:0] v2428 = In_register_ESI;
wire v2429 = v2428 == Out_register_ESI;
wire [31:0] v242b = In_register_ESBASE;
wire v242c = v242b == Out_register_ESBASE;
wire [31:0] v242e = In_register_DSBASE;
wire v242f = v242e == Out_register_DSBASE;
wire [31:0] v2431 = In_register_GSBASE;
wire v2432 = v2431 == Out_register_GSBASE;
wire [31:0] v2433 = v2414 ^ v23fd;
wire [7:0] v2434 = v2433[7:0];
wire [7:0] v2435 = v2434 >> v1d;
wire [7:0] v2436 = v2435 & v18;
wire v2437 = v2436[0:0];
wire v2439 = v2437;
wire v243a = v2439 == Out_register_AF;
wire v243b = v23fa < v23fc;
wire v243d = v243b;
wire v243e = v243d == Out_register_CF;
wire [7:0] v2440 = In_register_DF;
wire v2441 = v2440 == Out_register_DF;
wire [7:0] v2442 = v23fd[7:0];
wire [2:0] v2443_aux = v2442[0] + v2442[1] + v2442[2] + v2442[3] + v2442[4] + v2442[5] + v2442[6] + v2442[7];
wire v2443 = { 5'b00000, v2443_aux };
wire [7:0] v2444 = v2443 & v18;
wire [7:0] v2445 = v2444 ^ v18;
wire v2446 = v2445[0:0];
wire v2448 = v2446;
wire v2449 = v2448 == Out_register_PF;
wire v244a = v23fa == v23fc;
wire v244c = v244a;
wire v244d = v244c == Out_register_ZF;
wire v244e = v23ed & v23f3 & v23f6 & v2401 & v2404 & v2407 & v2408 & v240b & v240e & v2411 & v241a & v241d & v2420 & v15c & v2423 & v2426 & v2429 & v242c & v242f & v2432 & v243a & v243e & v2441 & v2449 & v244d;
wire v244f = In_error_flag == Out_error_flag;
wire v2450 = v3f == v1eb;
wire v2451 = v3 == v316;
wire v2452 = v1b == v318;
wire v2453 = v2450 & v2451 & v2452;
wire v2454 = v2453;
wire v2455 = v2454;
wire [2:0] v247a = { v320 };
wire v247b = v247a == v7;
wire v247c = v247b;
wire v247d = v2453 & v247c;
wire v247e = v247d;
wire [2:0] v2456 = { v1fa };
wire [31:0] v2457 = ( v2456 == 3'd0) ? In_register_EAX : 
	( v2456 == 3'd1) ? In_register_ECX : 
	( v2456 == 3'd2) ? In_register_EDX : 
	( v2456 == 3'd3) ? In_register_EBX : 
	( v2456 == 3'd4) ? In_register_EAX : 
	( v2456 == 3'd5) ? In_register_ECX : 
	( v2456 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2458 = { v1fa };
wire v2459 = v2458 == vb;
wire v245a = v2458 == v9;
wire v245b = v2459 | v245a;
wire v245c = v2458 == vf;
wire v245d = v245b | v245c;
wire v245e = v2458 == v11;
wire v245f = v245d | v245e;
wire [31:0] v2460 = ( v245f == 1'd0) ? v15 : v31;
wire [31:0] v2461 = v2457 >> v2460;
wire [31:0] v2462 = v2461 & v32;
wire [31:0] v2464 = v2462;
wire [7:0] v2465 = v2464[7:0];
wire [2:0] v2466 = { v320 };
wire [31:0] v2467 = ( v2466 == 3'd0) ? In_register_EAX : 
	( v2466 == 3'd1) ? In_register_ECX : 
	( v2466 == 3'd2) ? In_register_EDX : 
	( v2466 == 3'd3) ? In_register_EBX : 
	( v2466 == 3'd4) ? In_register_EAX : 
	( v2466 == 3'd5) ? In_register_ECX : 
	( v2466 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2468 = { v320 };
wire v2469 = v2468 == vb;
wire v246a = v2468 == v9;
wire v246b = v2469 | v246a;
wire v246c = v2468 == vf;
wire v246d = v246b | v246c;
wire v246e = v2468 == v11;
wire v246f = v246d | v246e;
wire [31:0] v2470 = ( v246f == 1'd0) ? v15 : v31;
wire [31:0] v2471 = v2467 >> v2470;
wire [31:0] v2472 = v2471 & v32;
wire [31:0] v2474 = v2472;
wire [7:0] v2475 = v2474[7:0];
wire [7:0] v2476 = v2465 + v2475;
wire [7:0] v2477 = v65f + v2476;
wire [31:0] v2478 = { 24'b000000000000000000000000, v2477 };
wire [31:0] v2479 = v5c8 | v2478;
wire v2482 = v247a == vb;
wire v2483 = v2482;
wire v2484 = v2453 & v2483;
wire v2485 = v2484;
wire [31:0] v2480 = v2478 << v31;
wire [31:0] v2481 = v752 | v2480;
wire [31:0] v2488 = ( v8 ) ? In_register_EAX : 
	( v247e ) ? v2479 : v2481;
wire [31:0] v248a = v2488;
wire v248b = v248a == Out_register_EAX;
wire [31:0] v248d = In_register_ESI;
wire v248e = v248d == Out_register_ESI;
wire [2:0] v248f_aux = v2477[0] + v2477[1] + v2477[2] + v2477[3] + v2477[4] + v2477[5] + v2477[6] + v2477[7];
wire v248f = { 5'b00000, v248f_aux };
wire [7:0] v2490 = v248f & v18;
wire [7:0] v2491 = v2490 ^ v18;
wire v2492 = v2491[0:0];
wire v2494 = v2492;
wire v2495 = v2494 == Out_register_PF;
wire v2497 = v247a == vd;
wire v2498 = v2497;
wire v2499 = v2453 & v2498;
wire v249a = v2499;
wire [31:0] v2496 = v7b8 | v2478;
wire v249d = v247a == v9;
wire v249e = v249d;
wire v249f = v2453 & v249e;
wire v24a0 = v249f;
wire [31:0] v249c = v7c8 | v2480;
wire [31:0] v24a3 = ( v8 ) ? In_register_EBX : 
	( v249a ) ? v2496 : v249c;
wire [31:0] v24a5 = v24a3;
wire v24a6 = v24a5 == Out_register_EBX;
wire v24a8 = v247a == ve;
wire v24a9 = v24a8;
wire v24aa = v2453 & v24a9;
wire v24ab = v24aa;
wire [31:0] v24a7 = v768 | v2478;
wire v24ae = v247a == v11;
wire v24af = v24ae;
wire v24b0 = v2453 & v24af;
wire v24b1 = v24b0;
wire [31:0] v24ad = v778 | v2480;
wire [31:0] v24b4 = ( v8 ) ? In_register_EDX : 
	( v24ab ) ? v24a7 : v24ad;
wire [31:0] v24b6 = v24b4;
wire v24b7 = v24b6 == Out_register_EDX;
wire [7:0] v24b9 = In_register_DF;
wire v24ba = v24b9 == Out_register_DF;
wire v24bc = v247a == vf;
wire v24bd = v24bc;
wire v24be = v2453 & v24bd;
wire v24bf = v24be;
wire [31:0] v24bb = v790 | v2480;
wire v24c2 = v247a == vc;
wire v24c3 = v24c2;
wire v24c4 = v2453 & v24c3;
wire v24c5 = v24c4;
wire [31:0] v24c1 = v7a0 | v2478;
wire [31:0] v24c8 = ( v8 ) ? In_register_ECX : 
	( v24bf ) ? v24bb : v24c1;
wire [31:0] v24ca = v24c8;
wire v24cb = v24ca == Out_register_ECX;
wire [31:0] v24cd = In_register_ESBASE;
wire v24ce = v24cd == Out_register_ESBASE;
wire [31:0] v24d0 = In_register_FSBASE;
wire v24d1 = v24d0 == Out_register_FSBASE;
wire [31:0] v24d3 = In_register_EDI;
wire v24d4 = v24d3 == Out_register_EDI;
wire [31:0] v24d6 = In_register_EBP;
wire v24d7 = v24d6 == Out_register_EBP;
wire [31:0] v24d9 = In_register_CSBASE;
wire v24da = v24d9 == Out_register_CSBASE;
wire [31:0] v24dc = v1c;
wire [31:0] v24dd = In_register_EIP + v24dc;
wire [31:0] v24df = v24dd;
wire v24e0 = v24df == Out_register_EIP;
wire [31:0] v24e2 = In_register_SSBASE;
wire v24e3 = v24e2 == Out_register_SSBASE;
wire [31:0] v24e5 = In_register_ESP;
wire v24e6 = v24e5 == Out_register_ESP;
wire [31:0] v24e8 = In_register_DSBASE;
wire v24e9 = v24e8 == Out_register_DSBASE;
wire [7:0] v24ea = v2477 ^ v2465;
wire [7:0] v24eb = v24ea ^ v2475;
wire [7:0] v24ec = v24eb >> v1d;
wire [7:0] v24ed = v24ec & v18;
wire v24ee = v24ed[0:0];
wire v24f0 = v24ee;
wire v24f1 = v24f0 == Out_register_AF;
wire [7:0] v24f2 = v2477 ^ v2475;
wire [7:0] v24f3 = v24f2 >> v33;
wire [7:0] v24f4 = v24ea >> v33;
wire [7:0] v24f5 = v24f3 + v24f4;
wire v24f6 = v24f5 == v34;
wire v24f8 = v24f6;
wire v24f9 = v24f8 == Out_register_OF;
wire [31:0] v24fb = In_register_GSBASE;
wire v24fc = v24fb == Out_register_GSBASE;
wire v24fd = v2476 < v2475;
wire v24fe = v2476 < v2465;
wire v24ff = v24fd | v24fe;
wire v2500 = v24ff ^ v8;
wire v2501 = v2477 < v2476;
wire v2502 = v2477 < v65f;
wire v2503 = v2501 | v2502;
wire [7:0] v2504 = { 7'b0000000, v2503 };
wire [7:0] v2505 = ( v2500 == 1'd0) ? v18 : v2504;
wire v2506 = v2505[0:0];
wire v2508 = v2506;
wire v2509 = v2508 == Out_register_CF;
wire v250a = $signed(v2477) < $signed(v2c);
wire v250c = v250a;
wire v250d = v250c == Out_register_SF;
wire v250e = v2477 == v2c;
wire v2510 = v250e;
wire v2511 = v2510 == Out_register_ZF;
wire v2512 = v244f & v2455 & v248b & v248e & v2495 & v24a6 & v24b7 & v24ba & v24cb & v24ce & v24d1 & v24d4 & v24d7 & v24da & v24e0 & v15c & v24e3 & v24e6 & v24e9 & v24f1 & v24f9 & v24fc & v2509 & v250d & v2511;
wire v2515 = v21 == v1eb;
wire v2516 = v35 == v316;
wire v2517 = v14 == v1ef;
wire [2:0] v2518 = { v1fa };
wire v2519 = v2518 == vb;
wire v251a = v2518 == vf;
wire v251b = v2519 | v251a;
wire v251c = v251b ^ v8;
wire [2:0] v251d = { v1fa };
wire v251e = v251d == vb;
wire v251f = v251d == vf;
wire v2520 = v251e | v251f;
wire v2521 = v2520 ^ v8;
wire v2522 = v251c & v2521;
wire v2523 = v2515 & v2516 & v2517 & v2522;
wire v252a = v2523;
wire v252b = v252a;
wire [31:0] v2513 = memory_0[79: 48];
wire [31:0] pad_9492 = (v2513[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v2514 = { pad_9492, v2513 };
wire [31:0] v2525 = v1f7;
wire [31:0] pad_9510 = (v2525[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v2526 = { pad_9510, v2525 };
wire [63:0] v2527 = v2514 * v2526;
wire [63:0] v2528 = v2527 + v22;
wire v2529 = v2528 < v23;
wire v252d = v2529;
wire v252e = v252d == Out_register_CF;
wire [2:0] v2530 = { v320 };
wire v2531 = v2530 == vb;
wire v2532 = v2531;
wire v2533 = v2523 & v2532;
wire v2534 = v2533;
wire [31:0] v252f = v2527[31:0];
wire [31:0] v2537 = ( v8 ) ? In_register_ESP : v252f;
wire [31:0] v2539 = v2537;
wire v253a = v2539 == Out_register_ESP;
wire [2:0] v253b = { v1fa };
wire [31:0] v253c = ( v253b == 3'd0) ? In_register_EAX : 
	( v253b == 3'd1) ? In_register_ECX : 
	( v253b == 3'd2) ? In_register_EDX : 
	( v253b == 3'd3) ? In_register_EBX : 
	( v253b == 3'd4) ? v15 : 
	( v253b == 3'd5) ? v15 : 
	( v253b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v253e = v253c;
wire v253f =  v26 == memory_0[15: 12] && v253e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v2540 = v2530 == v7;
wire v2541 = v2540;
wire v2542 = v2523 & v2541;
wire v2543 = v2542;
wire [31:0] v2546 = ( v8 ) ? In_register_EAX : v252f;
wire [31:0] v2548 = v2546;
wire v2549 = v2548 == Out_register_EAX;
wire v254a = In_error_flag == Out_error_flag;
wire v254b = v2530 == vc;
wire v254c = v254b;
wire v254d = v2523 & v254c;
wire v254e = v254d;
wire [31:0] v2551 = ( v8 ) ? In_register_ECX : v252f;
wire [31:0] v2553 = v2551;
wire v2554 = v2553 == Out_register_ECX;
wire v2555 = v2530 == v9;
wire v2556 = v2555;
wire v2557 = v2523 & v2556;
wire v2558 = v2557;
wire [31:0] v255b = ( v8 ) ? In_register_EDI : v252f;
wire [31:0] v255d = v255b;
wire v255e = v255d == Out_register_EDI;
wire [31:0] v2560 = In_register_GSBASE;
wire v2561 = v2560 == Out_register_GSBASE;
wire v2563 = In_register_PF;
wire v2564 = v2563 == Out_register_PF;
wire [31:0] v2566 = In_register_FSBASE;
wire v2567 = v2566 == Out_register_FSBASE;
wire v2568 = v2530 == ve;
wire v2569 = v2568;
wire v256a = v2523 & v2569;
wire v256b = v256a;
wire [31:0] v256e = ( v8 ) ? In_register_EDX : v252f;
wire [31:0] v2570 = v256e;
wire v2571 = v2570 == Out_register_EDX;
wire [31:0] v2573 = In_register_ESBASE;
wire v2574 = v2573 == Out_register_ESBASE;
wire v2575 = v2530 == vf;
wire v2576 = v2575;
wire v2577 = v2523 & v2576;
wire v2578 = v2577;
wire [31:0] v257b = ( v8 ) ? In_register_EBP : v252f;
wire [31:0] v257d = v257b;
wire v257e = v257d == Out_register_EBP;
wire [31:0] v2580 = In_register_DSBASE;
wire v2581 = v2580 == Out_register_DSBASE;
wire v2583 = In_register_SF;
wire v2584 = v2583 == Out_register_SF;
wire v2585 = v2530 == v11;
wire v2586 = v2585;
wire v2587 = v2523 & v2586;
wire v2588 = v2587;
wire [31:0] v258b = ( v8 ) ? In_register_ESI : v252f;
wire [31:0] v258d = v258b;
wire v258e = v258d == Out_register_ESI;
wire [31:0] v2590 = v16;
wire [31:0] v2591 = In_register_EIP + v2590;
wire [31:0] v2593 = v2591;
wire v2594 = v2593 == Out_register_EIP;
wire [31:0] v2596 = In_register_CSBASE;
wire v2597 = v2596 == Out_register_CSBASE;
wire [7:0] v2599 = In_register_DF;
wire v259a = v2599 == Out_register_DF;
wire v259b = v2530 == vd;
wire v259c = v259b;
wire v259d = v2523 & v259c;
wire v259e = v259d;
wire [31:0] v25a1 = ( v8 ) ? In_register_EBX : v252f;
wire [31:0] v25a3 = v25a1;
wire v25a4 = v25a3 == Out_register_EBX;
wire [31:0] v25a6 = In_register_SSBASE;
wire v25a7 = v25a6 == Out_register_SSBASE;
wire v25a9 = In_register_AF;
wire v25aa = v25a9 == Out_register_AF;
wire v25ab = v2529;
wire v25ac = v25ab == Out_register_OF;
wire v25ae = In_register_ZF;
wire v25af = v25ae == Out_register_ZF;
wire v25b0 = v252e & v15c & v252b & v253a & v253f & v2549 & v254a & v2554 & v255e & v2561 & v2564 & v2567 & v2571 & v2574 & v257e & v2581 & v2584 & v258e & v2594 & v2597 & v259a & v25a4 & v25a7 & v25aa & v25ac & v25af;
wire [7:0] v93 = 8'b11110101;
wire v25b1 = v93 == v1eb;
wire v25b2 = v29 == v59f;
wire v25b3 = v25b1 & v25b2;
wire v25b4 = v25b3;
wire v25b5 = v25b4;
wire [31:0] v25b7 = In_register_EDX;
wire v25b8 = v25b7 == Out_register_EDX;
wire [31:0] v25ba = In_register_EBX;
wire v25bb = v25ba == Out_register_EBX;
wire v25bc = In_error_flag == Out_error_flag;
wire v25bd =  v26 == memory_0[15: 12] && v1b8e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v25bf = In_register_EAX;
wire v25c0 = v25bf == Out_register_EAX;
wire [31:0] v25c2 = In_register_DSBASE;
wire v25c3 = v25c2 == Out_register_DSBASE;
wire [31:0] v25c5 = In_register_ESP;
wire v25c6 = v25c5 == Out_register_ESP;
wire [31:0] v25c8 = v2b;
wire [31:0] v25c9 = In_register_EIP + v25c8;
wire [31:0] v25cb = v25c9;
wire v25cc = v25cb == Out_register_EIP;
wire [31:0] v25cd = memory_0[79: 48];
wire [31:0] v25ce = In_register_EAX - v25cd;
wire [7:0] v25cf = v25ce[7:0];
wire [2:0] v25d0_aux = v25cf[0] + v25cf[1] + v25cf[2] + v25cf[3] + v25cf[4] + v25cf[5] + v25cf[6] + v25cf[7];
wire v25d0 = { 5'b00000, v25d0_aux };
wire [7:0] v25d1 = v25d0 & v18;
wire [7:0] v25d2 = v25d1 ^ v18;
wire v25d3 = v25d2[0:0];
wire v25d5 = v25d3;
wire v25d6 = v25d5 == Out_register_PF;
wire [31:0] v25d8 = In_register_ESI;
wire v25d9 = v25d8 == Out_register_ESI;
wire v25da = In_register_EAX < v25cd;
wire v25dc = v25da;
wire v25dd = v25dc == Out_register_CF;
wire [31:0] v25df = In_register_ECX;
wire v25e0 = v25df == Out_register_ECX;
wire [31:0] v25e2 = v23be;
wire v25e3 = v25e2 == Out_register_EDI;
wire [31:0] v25e5 = In_register_EBP;
wire v25e6 = v25e5 == Out_register_EBP;
wire v25e7 = In_register_EAX == v25cd;
wire v25e9 = v25e7;
wire v25ea = v25e9 == Out_register_ZF;
wire [31:0] v25ec = In_register_CSBASE;
wire v25ed = v25ec == Out_register_CSBASE;
wire [31:0] v25ef = In_register_SSBASE;
wire v25f0 = v25ef == Out_register_SSBASE;
wire [31:0] v25f2 = In_register_ESBASE;
wire v25f3 = v25f2 == Out_register_ESBASE;
wire [31:0] v25f5 = In_register_GSBASE;
wire v25f6 = v25f5 == Out_register_GSBASE;
wire v25f7 = $signed(v25ce) < $signed(v15);
wire v25f9 = v25f7;
wire v25fa = v25f9 == Out_register_SF;
wire [31:0] v25fc = In_register_FSBASE;
wire v25fd = v25fc == Out_register_FSBASE;
wire [31:0] v25fe = v25cd ^ In_register_EAX;
wire [31:0] v25ff = v25fe ^ v25ce;
wire [7:0] v2600 = v25ff[7:0];
wire [7:0] v2601 = v2600 >> v1d;
wire [7:0] v2602 = v2601 & v18;
wire v2603 = v2602[0:0];
wire v2605 = v2603;
wire v2606 = v2605 == Out_register_AF;
wire [31:0] v2607 = v25ce ^ In_register_EAX;
wire [31:0] v2608 = v2607 >> v1e;
wire [31:0] v2609 = v25fe >> v1e;
wire [31:0] v260a = v2608 + v2609;
wire v260b = v260a == v1c;
wire v260d = v260b;
wire v260e = v260d == Out_register_OF;
wire [7:0] v2610 = In_register_DF;
wire v2611 = v2610 == Out_register_DF;
wire v2612 = v25b8 & v25bb & v25bc & v25bd & v25c0 & v25c3 & v25c6 & v25cc & v25d6 & v25d9 & v25dd & v25b5 & v25e0 & v25e3 & v25e6 & v25ea & v25ed & v25f0 & v15c & v25f3 & v25f6 & v25fa & v25fd & v2606 & v260e & v2611;
wire v2613 = v71 == v1eb;
wire [4:0] v94 = 5'b00100;
wire v2614 = v94 == v1ed;
wire v2615 = v1b == v318;
wire [2:0] v2616 = { v1fa };
wire v2617 = v2616 == vb;
wire v2618 = v2616 == vf;
wire v2619 = v2617 | v2618;
wire v261a = v2619 ^ v8;
wire [2:0] v261b = { v1fa };
wire v261c = v261b == vb;
wire v261d = v261b == vf;
wire v261e = v261c | v261d;
wire v261f = v261e ^ v8;
wire v2620 = v261a & v261f;
wire v2621 = v2613 & v2614 & v2615 & v2620;
wire v2622 = v71 == v1eb;
wire v2623 = v8 == v829;
wire [4:0] v95 = 5'b00110;
wire v2624 = v95 == v1ed;
wire v2625 = v4 == v11b;
wire v2626 = v2622 & v2623 & v2624 & v2625;
wire v2627 = v2621 | v2626;
wire v2628 = v2627;
wire v262a = In_register_AF;
wire v262b = v262a == Out_register_AF;
wire [1:0] v262f = { v889 , v888 };
wire [31:0] v2630 = ( v262f == 2'd0) ? In_register_EDX : 
	( v262f == 2'd1) ? In_register_ESI : 
	( v262f == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v2631 = v2630 + v63a;
wire [2:0] v262c = { v1fa };
wire [31:0] v262d = ( v262c == 3'd0) ? In_register_EAX : 
	( v262c == 3'd1) ? In_register_ECX : 
	( v262c == 3'd2) ? In_register_EDX : 
	( v262c == 3'd3) ? In_register_EBX : 
	( v262c == 3'd4) ? v15 : 
	( v262c == 3'd5) ? v15 : 
	( v262c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2633 = ( v2626 ) ? v2631 : v262d;
wire v2634 =  v26 == memory_0[15: 12] && v2633 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2636 = In_register_EBP;
wire v2637 = v2636 == Out_register_EBP;
wire v2638 = In_error_flag == Out_error_flag;
wire [31:0] v263a = In_register_DSBASE;
wire v263b = v263a == Out_register_DSBASE;
wire [31:0] v263d = In_register_GSBASE;
wire v263e = v263d == Out_register_GSBASE;
wire [31:0] v2640 = In_register_EBX;
wire v2641 = v2640 == Out_register_EBX;
wire [31:0] v2643 = In_register_ESP;
wire v2644 = v2643 == Out_register_ESP;
wire [7:0] v2646 = In_register_DF;
wire v2647 = v2646 == Out_register_DF;
wire [31:0] v2649 = In_register_ECX;
wire v264a = v2649 == Out_register_ECX;
wire v264c = In_register_SF;
wire v264d = v264c == Out_register_SF;
wire [31:0] v264e = memory_0[79: 48];
wire [63:0] v264f = { 32'b00000000000000000000000000000000, v264e };
wire [63:0] v2650 = { 32'b00000000000000000000000000000000, In_register_EAX };
wire [63:0] v2651 = v264f * v2650;
wire [63:0] v96 = 64'b0000010000000000000000000000000000000000000000000000000000000000;
wire [63:0] v2652 = v2651 >> v96;
wire [31:0] v2653 = v2652[31:0];
wire [31:0] v2655 = v2653;
wire v2656 = v2655 == Out_register_EDX;
wire [63:0] v97 = 64'b1111111111111111111111111111111100000000000000000000000000000000;
wire v2657 = v2651 > v97;
wire v2659 = v2657;
wire v265a = v2659 == Out_register_CF;
wire [31:0] v265c = In_register_ESI;
wire v265d = v265c == Out_register_ESI;
wire v265e = v2657;
wire v265f = v265e == Out_register_OF;
wire v2661 = In_register_ZF;
wire v2662 = v2661 == Out_register_ZF;
wire [31:0] v2664 = In_register_EDI;
wire v2665 = v2664 == Out_register_EDI;
wire [31:0] v2667 = In_register_CSBASE;
wire v2668 = v2667 == Out_register_CSBASE;
wire [31:0] v266a = In_register_SSBASE;
wire v266b = v266a == Out_register_SSBASE;
wire [31:0] v266d = In_register_FSBASE;
wire v266e = v266d == Out_register_FSBASE;
wire [31:0] v2670 = In_register_ESBASE;
wire v2671 = v2670 == Out_register_ESBASE;
wire [31:0] v2672 = v2651[31:0];
wire [31:0] v2674 = v2672;
wire v2675 = v2674 == Out_register_EAX;
wire v2677 = In_register_PF;
wire v2678 = v2677 == Out_register_PF;
wire [31:0] v267b = ( v2621 ) ? v1c : v10;
wire [31:0] v267c = In_register_EIP + v267b;
wire [31:0] v267e = v267c;
wire v267f = v267e == Out_register_EIP;
wire v2680 = v2628 & v262b & v2634 & v2637 & v2638 & v263b & v263e & v2641 & v2644 & v2647 & v264a & v264d & v2656 & v265a & v15c & v265d & v265f & v2662 & v2665 & v2668 & v266b & v266e & v2671 & v2675 & v2678 & v267f;
wire v2681 = In_error_flag == Out_error_flag;
wire [4:0] v98 = 5'b11101;
wire [4:0] v2682 = instruction_bits[7: 3];
wire v2683 = v98 == v2682;
wire v2684 = v47 == vb69;
wire v2685 = v2683 & v2684;
wire v2686 = v2685;
wire v2687 = v2686;
wire [31:0] v2689 = In_register_GSBASE;
wire v268a = v2689 == Out_register_GSBASE;
wire [2:0] v268d = instruction_bits[2: 0];
wire [2:0] v268e = { v268d };
wire v268f = v268e == ve;
wire v2690 = v268f;
wire v2691 = v2685 & v2690;
wire v2692 = v2691;
wire [31:0] v268c = vb74;
wire [31:0] v2695 = ( v8 ) ? In_register_EDX : v268c;
wire [31:0] v2697 = v2695;
wire v2698 = v2697 == Out_register_EDX;
wire v2699 = v268e == vd;
wire v269a = v2699;
wire v269b = v2685 & v269a;
wire v269c = v269b;
wire [31:0] v269f = ( v8 ) ? In_register_EBX : v268c;
wire [31:0] v26a1 = v269f;
wire v26a2 = v26a1 == Out_register_EBX;
wire v26a4 = In_register_SF;
wire v26a5 = v26a4 == Out_register_SF;
wire v26a6 = v268e == v11;
wire v26a7 = v26a6;
wire v26a8 = v2685 & v26a7;
wire v26a9 = v26a8;
wire [31:0] v26ac = ( v8 ) ? In_register_ESI : v268c;
wire [31:0] v26ae = v26ac;
wire v26af = v26ae == Out_register_ESI;
wire v26b0 = v268e == vc;
wire v26b1 = v26b0;
wire v26b2 = v2685 & v26b1;
wire v26b3 = v26b2;
wire [31:0] v26b6 = ( v8 ) ? In_register_ECX : v268c;
wire [31:0] v26b8 = v26b6;
wire v26b9 = v26b8 == Out_register_ECX;
wire [31:0] v26bb = In_register_DSBASE;
wire v26bc = v26bb == Out_register_DSBASE;
wire v26bd = v268e == v9;
wire v26be = v26bd;
wire v26bf = v2685 & v26be;
wire v26c0 = v26bf;
wire [31:0] v26c3 = ( v8 ) ? In_register_EDI : v268c;
wire [31:0] v26c5 = v26c3;
wire v26c6 = v26c5 == Out_register_EDI;
wire v26c7 = v268e == vf;
wire v26c8 = v26c7;
wire v26c9 = v2685 & v26c8;
wire v26ca = v26c9;
wire [31:0] v26cd = ( v8 ) ? In_register_EBP : v268c;
wire [31:0] v26cf = v26cd;
wire v26d0 = v26cf == Out_register_EBP;
wire [31:0] v26d2 = v48;
wire [31:0] v26d3 = In_register_EIP + v26d2;
wire [31:0] v26d5 = v26d3;
wire v26d6 = v26d5 == Out_register_EIP;
wire [31:0] v26d8 = In_register_SSBASE;
wire v26d9 = v26d8 == Out_register_SSBASE;
wire [31:0] v26db = In_register_CSBASE;
wire v26dc = v26db == Out_register_CSBASE;
wire v26de = In_register_ZF;
wire v26df = v26de == Out_register_ZF;
wire v26e1 = In_register_AF;
wire v26e2 = v26e1 == Out_register_AF;
wire [31:0] v26e4 = In_register_FSBASE;
wire v26e5 = v26e4 == Out_register_FSBASE;
wire v26e6 = v268e == v7;
wire v26e7 = v26e6;
wire v26e8 = v2685 & v26e7;
wire v26e9 = v26e8;
wire [31:0] v26ec = ( v8 ) ? In_register_EAX : v268c;
wire [31:0] v26ee = v26ec;
wire v26ef = v26ee == Out_register_EAX;
wire v26f1 = In_register_CF;
wire v26f2 = v26f1 == Out_register_CF;
wire [7:0] v26f4 = In_register_DF;
wire v26f5 = v26f4 == Out_register_DF;
wire v26f6 = v268e == vb;
wire v26f7 = v26f6;
wire v26f8 = v2685 & v26f7;
wire v26f9 = v26f8;
wire [31:0] v26fc = ( v8 ) ? In_register_ESP : v268c;
wire [31:0] v26fe = v26fc;
wire v26ff = v26fe == Out_register_ESP;
wire v2701 = In_register_OF;
wire v2702 = v2701 == Out_register_OF;
wire v2704 = In_register_PF;
wire v2705 = v2704 == Out_register_PF;
wire [31:0] v2707 = In_register_ESBASE;
wire v2708 = v2707 == Out_register_ESBASE;
wire v2709 = v15c & v2681 & v268a & v2698 & v26a2 & v26a5 & v26af & v26b9 & v26bc & v26c6 & v26d0 & v26d6 & v26d9 & v26dc & v26df & v26e2 & v2687 & v26e5 & v26ef & v26f2 & v26f5 & v26ff & v2702 & v2705 & v2708;
wire [10:0] v99 = 11'b00011100101;
wire v270a = v99 == v6d7;
wire v270b = v35 == v316;
wire v270c = v14 == v1ef;
wire v270d = v270a & v270b & v270c;
wire [10:0] v9a = 11'b00011100001;
wire v270e = v9a == v6d7;
wire v270f = v35 == v316;
wire v2710 = v4 == v11b;
wire [2:0] v2711 = { v13c };
wire v2712 = v2711 == vb;
wire v2713 = v2711 == vf;
wire v2714 = v2712 | v2713;
wire v2715 = v2714 ^ v8;
wire [2:0] v2716 = { v12c };
wire v2717 = v2716 == vb;
wire v2718 = v2717;
wire v2719 = v2718 ^ v8;
wire [2:0] v271a = { v13c };
wire v271b = v271a == vf;
wire v271c = v271b;
wire v271d = v271c ^ v8;
wire v271e = v2715 & v2719 & v271d;
wire v271f = v270e & v270f & v2710 & v271e;
wire v2720 = v270d | v271f;
wire v2721 = v2720;
wire [31:0] v2723 = In_register_EAX;
wire v2724 = v2723 == Out_register_EAX;
wire [31:0] v2726 = In_register_EBX;
wire v2727 = v2726 == Out_register_EBX;
wire [2:0] v2729 = { v13c };
wire [31:0] v272a = ( v2729 == 3'd0) ? In_register_EAX : 
	( v2729 == 3'd1) ? In_register_ECX : 
	( v2729 == 3'd2) ? In_register_EDX : 
	( v2729 == 3'd3) ? In_register_EBX : 
	( v2729 == 3'd4) ? v15 : 
	( v2729 == 3'd5) ? v15 : 
	( v2729 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v272b = { v12c };
wire [31:0] v272c = ( v272b == 3'd0) ? In_register_EAX : 
	( v272b == 3'd1) ? In_register_ECX : 
	( v272b == 3'd2) ? In_register_EDX : 
	( v272b == 3'd3) ? In_register_EBX : 
	( v272b == 3'd4) ? v15 : 
	( v272b == 3'd5) ? In_register_EBP : 
	( v272b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v272d = v272c << v7f4;
wire [31:0] v272e = v272a + v272d;
wire [31:0] v2730 = ( v271f ) ? v272e : v1f7;
wire v2731 =  v2a == memory_0[15: 12] && v2730 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2732 = memory_0[79: 48];
wire [7:0] v2733 = v2732[7:0];
wire [2:0] v2734 = { v320 };
wire [31:0] v2735 = ( v2734 == 3'd0) ? In_register_EAX : 
	( v2734 == 3'd1) ? In_register_ECX : 
	( v2734 == 3'd2) ? In_register_EDX : 
	( v2734 == 3'd3) ? In_register_EBX : 
	( v2734 == 3'd4) ? In_register_EAX : 
	( v2734 == 3'd5) ? In_register_ECX : 
	( v2734 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2736 = { v320 };
wire v2737 = v2736 == vb;
wire v2738 = v2736 == v9;
wire v2739 = v2737 | v2738;
wire v273a = v2736 == vf;
wire v273b = v2739 | v273a;
wire v273c = v2736 == v11;
wire v273d = v273b | v273c;
wire [31:0] v273e = ( v273d == 1'd0) ? v15 : v31;
wire [31:0] v273f = v2735 >> v273e;
wire [31:0] v2740 = v273f & v32;
wire [2:0] v2742 = { v320 };
wire [31:0] v2743 = ( v2742 == 3'd0) ? In_register_EAX : 
	( v2742 == 3'd1) ? In_register_ECX : 
	( v2742 == 3'd2) ? In_register_EDX : 
	( v2742 == 3'd3) ? In_register_EBX : 
	( v2742 == 3'd4) ? In_register_EAX : 
	( v2742 == 3'd5) ? In_register_ECX : 
	( v2742 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2744 = { v320 };
wire v2745 = v2744 == vb;
wire v2746 = v2744 == v9;
wire v2747 = v2745 | v2746;
wire v2748 = v2744 == vf;
wire v2749 = v2747 | v2748;
wire v274a = v2744 == v11;
wire v274b = v2749 | v274a;
wire [31:0] v274c = ( v274b == 1'd0) ? v15 : v31;
wire [31:0] v274d = v2743 >> v274c;
wire [31:0] v274e = v274d & v32;
wire [31:0] v2750 = ( v270d ) ? v2740 : v274e;
wire [7:0] v2751 = v2750[7:0];
wire v2752 = v2733 < v2751;
wire v2754 = v2752;
wire v2755 = v2754 == Out_register_CF;
wire [31:0] v2757 = In_register_ESBASE;
wire v2758 = v2757 == Out_register_ESBASE;
wire [7:0] v275a = In_register_DF;
wire v275b = v275a == Out_register_DF;
wire [7:0] v275c = v2733 ^ v2751;
wire [7:0] v275d = v2733 - v2751;
wire [7:0] v275e = v275c ^ v275d;
wire [7:0] v275f = v275e >> v1d;
wire [7:0] v2760 = v275f & v18;
wire v2761 = v2760[0:0];
wire v2763 = v2761;
wire v2764 = v2763 == Out_register_AF;
wire v2765 = In_error_flag == Out_error_flag;
wire v2766 = $signed(v275d) < $signed(v2c);
wire v2768 = v2766;
wire v2769 = v2768 == Out_register_SF;
wire [31:0] v276b = In_register_DSBASE;
wire v276c = v276b == Out_register_DSBASE;
wire [31:0] v276e = In_register_EDX;
wire v276f = v276e == Out_register_EDX;
wire [31:0] v2771 = In_register_GSBASE;
wire v2772 = v2771 == Out_register_GSBASE;
wire [31:0] v2774 = In_register_ESI;
wire v2775 = v2774 == Out_register_ESI;
wire [31:0] v2777 = In_register_EDI;
wire v2778 = v2777 == Out_register_EDI;
wire [31:0] v277a = In_register_FSBASE;
wire v277b = v277a == Out_register_FSBASE;
wire [31:0] v277d = In_register_ECX;
wire v277e = v277d == Out_register_ECX;
wire [31:0] v2780 = In_register_EBP;
wire v2781 = v2780 == Out_register_EBP;
wire [31:0] v2784 = ( v270d ) ? v16 : v10;
wire [31:0] v2785 = In_register_EIP + v2784;
wire [31:0] v2787 = v2785;
wire v2788 = v2787 == Out_register_EIP;
wire [31:0] v278a = In_register_ESP;
wire v278b = v278a == Out_register_ESP;
wire [2:0] v278c_aux = v275d[0] + v275d[1] + v275d[2] + v275d[3] + v275d[4] + v275d[5] + v275d[6] + v275d[7];
wire v278c = { 5'b00000, v278c_aux };
wire [7:0] v278d = v278c & v18;
wire [7:0] v278e = v278d ^ v18;
wire v278f = v278e[0:0];
wire v2791 = v278f;
wire v2792 = v2791 == Out_register_PF;
wire [7:0] v2793 = v275d ^ v2733;
wire [7:0] v2794 = v2793 >> v33;
wire [7:0] v2795 = v275c >> v33;
wire [7:0] v2796 = v2794 + v2795;
wire v2797 = v2796 == v34;
wire v2799 = v2797;
wire v279a = v2799 == Out_register_OF;
wire [31:0] v279c = In_register_CSBASE;
wire v279d = v279c == Out_register_CSBASE;
wire [31:0] v279f = In_register_SSBASE;
wire v27a0 = v279f == Out_register_SSBASE;
wire v27a1 = v2733 == v2751;
wire v27a3 = v27a1;
wire v27a4 = v27a3 == Out_register_ZF;
wire v27a5 = v2724 & v2727 & v2731 & v2755 & v15c & v2721 & v2758 & v275b & v2764 & v2765 & v2769 & v276c & v276f & v2772 & v2775 & v2778 & v277b & v277e & v2781 & v2788 & v278b & v2792 & v279a & v279d & v27a0 & v27a4;
wire v27a8 = v40 == v1eb;
wire [4:0] v9b = 5'b11011;
wire v27a9 = v9b == v1ed;
wire v27aa = v4 == v11b;
wire v27ab = v27a8 & v27a9 & v27aa;
wire v27b3 = v27ab;
wire v27b4 = v27b3;
wire [2:0] v27a6 = { v1fa };
wire [31:0] v27a7 = ( v27a6 == 3'd0) ? In_register_EAX : 
	( v27a6 == 3'd1) ? In_register_ECX : 
	( v27a6 == 3'd2) ? In_register_EDX : 
	( v27a6 == 3'd3) ? In_register_EBX : 
	( v27a6 == 3'd4) ? In_register_ESP : 
	( v27a6 == 3'd5) ? In_register_EBP : 
	( v27a6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v27ad = v27a7;
wire [31:0] v27af = v63a;
wire [31:0] v27b0 = v27ad - v27af;
wire [31:0] v27b1 = v27b0 - vb11;
wire v27b2 = $signed(v27b1) < $signed(v15);
wire v27b6 = v27b2;
wire v27b7 = v27b6 == Out_register_SF;
wire [31:0] v27b9 = In_register_CSBASE;
wire v27ba = v27b9 == Out_register_CSBASE;
wire [2:0] v27bb = { v1fa };
wire v27bc = v27bb == vb;
wire v27bd = v27bc;
wire v27be = v27ab & v27bd;
wire v27bf = v27be;
wire [31:0] v27c2 = ( v8 ) ? In_register_ESP : v27b1;
wire [31:0] v27c4 = v27c2;
wire v27c5 = v27c4 == Out_register_ESP;
wire v27c6 = v27ad < v27af;
wire v27c7 = v27b0 < vb11;
wire [7:0] v27c8 = { 7'b0000000, v27c7 };
wire [7:0] v27c9 = ( v27c6 == 1'd0) ? v27c8 : v18;
wire v27ca = v27c9[0:0];
wire v27cc = v27ca;
wire v27cd = v27cc == Out_register_CF;
wire v27ce = v27bb == vd;
wire v27cf = v27ce;
wire v27d0 = v27ab & v27cf;
wire v27d1 = v27d0;
wire [31:0] v27d4 = ( v8 ) ? In_register_EBX : v27b1;
wire [31:0] v27d6 = v27d4;
wire v27d7 = v27d6 == Out_register_EBX;
wire [31:0] v27d8 = v27b1 ^ v27ad;
wire [31:0] v27d9 = v27d8 >> v1e;
wire [31:0] v27da = v27af ^ v27ad;
wire [31:0] v27db = v27da >> v1e;
wire [31:0] v27dc = v27d9 + v27db;
wire v27dd = v27dc == v1c;
wire v27df = v27dd;
wire v27e0 = v27df == Out_register_OF;
wire v27e1 = v27bb == v9;
wire v27e2 = v27e1;
wire v27e3 = v27ab & v27e2;
wire v27e4 = v27e3;
wire [31:0] v27e7 = ( v8 ) ? In_register_EDI : v27b1;
wire [31:0] v27e9 = v27e7;
wire v27ea = v27e9 == Out_register_EDI;
wire [31:0] v27ec = In_register_FSBASE;
wire v27ed = v27ec == Out_register_FSBASE;
wire [31:0] v27ee = v27b1 ^ v27da;
wire [7:0] v27ef = v27ee[7:0];
wire [7:0] v27f0 = v27ef >> v1d;
wire [7:0] v27f1 = v27f0 & v18;
wire v27f2 = v27f1[0:0];
wire v27f4 = v27f2;
wire v27f5 = v27f4 == Out_register_AF;
wire v27f6 = v27bb == vc;
wire v27f7 = v27f6;
wire v27f8 = v27ab & v27f7;
wire v27f9 = v27f8;
wire [31:0] v27fc = ( v8 ) ? In_register_ECX : v27b1;
wire [31:0] v27fe = v27fc;
wire v27ff = v27fe == Out_register_ECX;
wire v2800 = v27bb == ve;
wire v2801 = v2800;
wire v2802 = v27ab & v2801;
wire v2803 = v2802;
wire [31:0] v2806 = ( v8 ) ? In_register_EDX : v27b1;
wire [31:0] v2808 = v2806;
wire v2809 = v2808 == Out_register_EDX;
wire [7:0] v280a = v27b1[7:0];
wire [2:0] v280b_aux = v280a[0] + v280a[1] + v280a[2] + v280a[3] + v280a[4] + v280a[5] + v280a[6] + v280a[7];
wire v280b = { 5'b00000, v280b_aux };
wire [7:0] v280c = v280b & v18;
wire [7:0] v280d = v280c ^ v18;
wire v280e = v280d[0:0];
wire v2810 = v280e;
wire v2811 = v2810 == Out_register_PF;
wire v2812 = v27bb == v11;
wire v2813 = v2812;
wire v2814 = v27ab & v2813;
wire v2815 = v2814;
wire [31:0] v2818 = ( v8 ) ? In_register_ESI : v27b1;
wire [31:0] v281a = v2818;
wire v281b = v281a == Out_register_ESI;
wire v281c = v27bb == v7;
wire v281d = v281c;
wire v281e = v27ab & v281d;
wire v281f = v281e;
wire [31:0] v2822 = ( v8 ) ? In_register_EAX : v27b1;
wire [31:0] v2824 = v2822;
wire v2825 = v2824 == Out_register_EAX;
wire [31:0] v2827 = v10;
wire [31:0] v2828 = In_register_EIP + v2827;
wire [31:0] v282a = v2828;
wire v282b = v282a == Out_register_EIP;
wire [31:0] v282d = In_register_SSBASE;
wire v282e = v282d == Out_register_SSBASE;
wire [31:0] v2830 = In_register_ESBASE;
wire v2831 = v2830 == Out_register_ESBASE;
wire v2832 = In_error_flag == Out_error_flag;
wire v2833 = v27bb == vf;
wire v2834 = v2833;
wire v2835 = v27ab & v2834;
wire v2836 = v2835;
wire [31:0] v2839 = ( v8 ) ? In_register_EBP : v27b1;
wire [31:0] v283b = v2839;
wire v283c = v283b == Out_register_EBP;
wire [31:0] v283e = In_register_GSBASE;
wire v283f = v283e == Out_register_GSBASE;
wire [31:0] v2841 = In_register_DSBASE;
wire v2842 = v2841 == Out_register_DSBASE;
wire [7:0] v2844 = In_register_DF;
wire v2845 = v2844 == Out_register_DF;
wire v2846 = v27b0 == vb11;
wire v2848 = v2846;
wire v2849 = v2848 == Out_register_ZF;
wire v284a = v27b7 & v27ba & v27c5 & v27cd & v27d7 & v27e0 & v27ea & v27ed & v15c & v27f5 & v27ff & v2809 & v2811 & v281b & v2825 & v282b & v282e & v2831 & v2832 & v283c & v283f & v27b4 & v2842 & v2845 & v2849;
wire [15:0] v9c = 16'b0010011001101111;
wire v284b = v9c == v117;
wire v284c = v92 == v20a0;
wire v284d = v4 == v11b;
wire v284e = v284b & v284c & v284d;
wire v284f = v284e;
wire v2850 = v284f;
wire [31:0] v2852 = In_register_ESI;
wire v2853 = v2852 == Out_register_ESI;
wire [2:0] v2854 = { v13c };
wire [31:0] v2855 = ( v2854 == 3'd0) ? In_register_EAX : 
	( v2854 == 3'd1) ? In_register_ECX : 
	( v2854 == 3'd2) ? In_register_EDX : 
	( v2854 == 3'd3) ? In_register_EBX : 
	( v2854 == 3'd4) ? In_register_EAX : 
	( v2854 == 3'd5) ? In_register_ECX : 
	( v2854 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2856 = { v13c };
wire v2857 = v2856 == vb;
wire v2858 = v2856 == v9;
wire v2859 = v2857 | v2858;
wire v285a = v2856 == vf;
wire v285b = v2859 | v285a;
wire v285c = v2856 == v11;
wire v285d = v285b | v285c;
wire [31:0] v285e = ( v285d == 1'd0) ? v15 : v31;
wire [31:0] v285f = v2855 >> v285e;
wire [31:0] v2860 = v285f & v32;
wire [31:0] v2862 = v2860;
wire [31:0] v2863 = v2862 & v32;
wire v2864 = v2863 == v15;
wire v2865 = v2864 ^ v8;
wire [15:0] v2866 = In_register_EAX[15:0];
wire [15:0] pad_10343 = (v2866[15:15] == 1'b1) ?16'b1111111111111111 : 16'b0000000000000000;
wire [31:0] v2867 = { pad_10343, v2866 };
wire [31:0] v9d = 32'b00011000000000000000000000000000;
wire [31:0] v2868 = v2862 << v9d;
wire [31:0] v2869 = v2868 >>> v9d;
wire [31:0] v286a = $signed(v2867) / $signed(v2869);
wire [15:0] v286b = v286a[15:0];
wire [7:0] v286c = v286a[7:0];
wire [7:0] pad_10349 = (v286c[7:7] == 1'b1) ?8'b11111111 : 8'b00000000;
wire [15:0] v286d = { pad_10349, v286c };
wire v286e = v286b == v286d;
wire v286f = v2865 & v286e;
wire [7:0] v2870 = { 7'b0000000, In_register_AF };
wire pad_10353 = (In_register_AF == 1'b1) ?7'b1111111 : 7'b0000000;
wire [7:0] v2871 = { pad_10353, In_register_AF };
wire [7:0] v2872 = ( v286f == 1'd0) ? v2870 : v2871;
wire v2873 = v2872[0:0];
wire v2875 = v2873;
wire v2876 = v2875 == Out_register_AF;
wire v2877 = In_error_flag == Out_error_flag;
wire [31:0] v2879 = v10;
wire [31:0] v287a = In_register_EIP + v2879;
wire [31:0] v287c = v287a;
wire [31:0] v287e = v287c;
wire v287f = v287e == Out_register_EIP;
wire [31:0] v2881 = In_register_EBX;
wire v2882 = v2881 == Out_register_EBX;
wire [31:0] v2884 = In_register_EDI;
wire v2885 = v2884 == Out_register_EDI;
wire [31:0] v2887 = In_register_ESP;
wire v2888 = v2887 == Out_register_ESP;
wire [31:0] v288a = In_register_EBP;
wire v288b = v288a == Out_register_EBP;
wire [7:0] v288c = ( v286f == 1'd0) ? vf4a : v286c;
wire [31:0] v288d = { 24'b000000000000000000000000, v288c };
wire [31:0] v288e = v5c8 | v288d;
wire [31:0] v288f = v288e & v3a;
wire [31:0] v2890 = v288e >> v31;
wire [7:0] v2891 = v2890[7:0];
wire [31:0] v2892 = $signed(v2867) % $signed(v2869);
wire [7:0] v2893 = v2892[7:0];
wire [7:0] v2894 = ( v286f == 1'd0) ? v2891 : v2893;
wire [31:0] v2895 = { 24'b000000000000000000000000, v2894 };
wire [31:0] v2896 = v2895 << v31;
wire [31:0] v2897 = v288f | v2896;
wire [31:0] v2899 = v2897;
wire v289a = v2899 == Out_register_EAX;
wire [7:0] v289b = { 7'b0000000, In_register_ZF };
wire pad_10396 = (In_register_ZF == 1'b1) ?7'b1111111 : 7'b0000000;
wire [7:0] v289c = { pad_10396, In_register_ZF };
wire [7:0] v289d = ( v286f == 1'd0) ? v289b : v289c;
wire v289e = v289d[0:0];
wire v28a0 = v289e;
wire v28a1 = v28a0 == Out_register_ZF;
wire [31:0] v28a3 = In_register_EDX;
wire v28a4 = v28a3 == Out_register_EDX;
wire [31:0] v28a6 = In_register_SSBASE;
wire v28a7 = v28a6 == Out_register_SSBASE;
wire pad_10408 = (In_register_CF == 1'b1) ?7'b1111111 : 7'b0000000;
wire [7:0] v28a8 = { pad_10408, In_register_CF };
wire [7:0] v28a9 = ( v286f == 1'd0) ? v65f : v28a8;
wire v28aa = v28a9[0:0];
wire v28ac = v28aa;
wire v28ad = v28ac == Out_register_CF;
wire [31:0] v28af = In_register_DSBASE;
wire v28b0 = v28af == Out_register_DSBASE;
wire [31:0] v28b2 = In_register_ECX;
wire v28b3 = v28b2 == Out_register_ECX;
wire [7:0] v28b5 = In_register_DF;
wire v28b6 = v28b5 == Out_register_DF;
wire [31:0] v28b8 = In_register_CSBASE;
wire v28b9 = v28b8 == Out_register_CSBASE;
wire [31:0] v28bb = In_register_GSBASE;
wire v28bc = v28bb == Out_register_GSBASE;
wire [31:0] v28be = In_register_ESBASE;
wire v28bf = v28be == Out_register_ESBASE;
wire [31:0] v28c1 = In_register_FSBASE;
wire v28c2 = v28c1 == Out_register_FSBASE;
wire [7:0] v28c3 = { 7'b0000000, In_register_OF };
wire pad_10436 = (In_register_OF == 1'b1) ?7'b1111111 : 7'b0000000;
wire [7:0] v28c4 = { pad_10436, In_register_OF };
wire [7:0] v28c5 = ( v286f == 1'd0) ? v28c3 : v28c4;
wire v28c6 = v28c5[0:0];
wire v28c8 = v28c6;
wire v28c9 = v28c8 == Out_register_OF;
wire pad_10442 = (In_register_PF == 1'b1) ?7'b1111111 : 7'b0000000;
wire [7:0] v28ca = { pad_10442, In_register_PF };
wire [7:0] v28cb = ( v286f == 1'd0) ? vd06 : v28ca;
wire v28cc = v28cb[0:0];
wire v28ce = v28cc;
wire v28cf = v28ce == Out_register_PF;
wire pad_10448 = (In_register_SF == 1'b1) ? 7'b1111111 : 7'b0000000;
wire [7:0] v28d0 = { pad_10448, In_register_SF };
wire [7:0] v28d1 = ( v286f == 1'd0) ? v1d85 : v28d0;
wire v28d2 = v28d1[0:0];
wire v28d4 = v28d2;
wire v28d5 = v28d4 == Out_register_SF;
wire v28d6 = v2850 & v2853 & v2876 & v15c & v2877 & v287f & v2882 & v2885 & v2888 & v288b & v289a & v28a1 & v28a4 & v28a7 & v28ad & v28b0 & v28b3 & v28b6 & v28b9 & v28bc & v28bf & v28c2 & v28c9 & v28cf & v28d5;
wire v28d7 = v86 == v117;
wire [4:0] v9e = 5'b11110;
wire v28d8 = v9e == v20a0;
wire v28d9 = v47 == vb69;
wire [2:0] v28da = { v13c };
wire v28db = v28da == vb;
wire v28dc = v28db;
wire v28dd = v28dc ^ v8;
wire [2:0] v28de = { v13c };
wire v28df = v28de == vb;
wire v28e0 = v28df;
wire v28e1 = v28e0 ^ v8;
wire v28e2 = v28dd & v28e1;
wire v28e3 = v28d7 & v28d8 & v28d9 & v28e2;
wire v28e4 = v28e3;
wire v28e5 = v28e4;
wire [3:0] v9f = 4'b0100;
wire [2:0] v28e6 = { v13c };
wire [31:0] v28e7 = ( v28e6 == 3'd0) ? In_register_EAX : 
	( v28e6 == 3'd1) ? In_register_ECX : 
	( v28e6 == 3'd2) ? In_register_EDX : 
	( v28e6 == 3'd3) ? In_register_EBX : 
	( v28e6 == 3'd4) ? v15 : 
	( v28e6 == 3'd5) ? In_register_EBP : 
	( v28e6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v28e8 = v28e7 + v7f8;
wire [31:0] v28ea = v28e8;
wire v28eb =  v9f == memory_0[15: 12] && v28ea == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v28ec = memory_0[79: 48];
wire [15:0] v28ed = v28ec[15:0];
wire [31:0] v28ef = v176b;
wire [15:0] v28f0 = v28ef[15:0];
wire [15:0] v28f1 = v28ed ^ v28f0;
wire [15:0] v28f2 = v28ed - v28f0;
wire [15:0] v28f3 = v28f1 ^ v28f2;
wire [7:0] v28f4 = v28f3[7:0];
wire [7:0] v28f5 = v28f4 >> v1d;
wire [7:0] v28f6 = v28f5 & v18;
wire v28f7 = v28f6[0:0];
wire v28f9 = v28f7;
wire v28fa = v28f9 == Out_register_AF;
wire v28fb = In_error_flag == Out_error_flag;
wire [31:0] v28fd = In_register_ECX;
wire v28fe = v28fd == Out_register_ECX;
wire [31:0] v2900 = In_register_EBP;
wire v2901 = v2900 == Out_register_EBP;
wire [7:0] v2902 = v28f2[7:0];
wire [2:0] v2903_aux = v2902[0] + v2902[1] + v2902[2] + v2902[3] + v2902[4] + v2902[5] + v2902[6] + v2902[7];
wire v2903 = { 5'b00000, v2903_aux };
wire [7:0] v2904 = v2903 & v18;
wire [7:0] v2905 = v2904 ^ v18;
wire v2906 = v2905[0:0];
wire v2908 = v2906;
wire v2909 = v2908 == Out_register_PF;
wire [31:0] v290b = In_register_ESI;
wire v290c = v290b == Out_register_ESI;
wire [31:0] v290e = In_register_SSBASE;
wire v290f = v290e == Out_register_SSBASE;
wire [31:0] v2911 = In_register_EAX;
wire v2912 = v2911 == Out_register_EAX;
wire [15:0] v2913 = v28f2 ^ v28ed;
wire [15:0] v2914 = v2913 >> v88;
wire [15:0] v2915 = v28f1 >> v88;
wire [15:0] v2916 = v2914 + v2915;
wire v2917 = v2916 == v89;
wire v2919 = v2917;
wire v291a = v2919 == Out_register_OF;
wire [31:0] v291c = In_register_EDX;
wire v291d = v291c == Out_register_EDX;
wire [31:0] v291f = In_register_EBX;
wire v2920 = v291f == Out_register_EBX;
wire [31:0] v2922 = In_register_ESP;
wire v2923 = v2922 == Out_register_ESP;
wire [7:0] v2925 = In_register_DF;
wire v2926 = v2925 == Out_register_DF;
wire [31:0] v2928 = v48;
wire [31:0] v2929 = In_register_EIP + v2928;
wire [31:0] v292b = v2929;
wire v292c = v292b == Out_register_EIP;
wire [31:0] v292e = In_register_ESBASE;
wire v292f = v292e == Out_register_ESBASE;
wire [31:0] v2931 = In_register_EDI;
wire v2932 = v2931 == Out_register_EDI;
wire v2933 = v28ed == v28f0;
wire v2935 = v2933;
wire v2936 = v2935 == Out_register_ZF;
wire [31:0] v2938 = In_register_DSBASE;
wire v2939 = v2938 == Out_register_DSBASE;
wire v293a = $signed(v28f2) < $signed(v87);
wire v293c = v293a;
wire v293d = v293c == Out_register_SF;
wire [31:0] v293f = In_register_GSBASE;
wire v2940 = v293f == Out_register_GSBASE;
wire [31:0] v2942 = In_register_FSBASE;
wire v2943 = v2942 == Out_register_FSBASE;
wire [31:0] v2945 = In_register_CSBASE;
wire v2946 = v2945 == Out_register_CSBASE;
wire v2947 = v28ed < v28f0;
wire v2949 = v2947;
wire v294a = v2949 == Out_register_CF;
wire v294b = v28e5 & v28eb & v15c & v28fa & v28fb & v28fe & v2901 & v2909 & v290c & v290f & v2912 & v291a & v291d & v2920 & v2923 & v2926 & v292c & v292f & v2932 & v2936 & v2939 & v293d & v2940 & v2943 & v2946 & v294a;
wire v294c = v12 == v1eb;
wire v294d = v92 == v1ed;
wire v294e = v14 == v1ef;
wire v294f = v294c & v294d & v294e;
wire v2950 = v294f;
wire v2951 = v2950;
wire v2952 = In_error_flag == Out_error_flag;
wire [31:0] v2954 = In_register_ESBASE;
wire v2955 = v2954 == Out_register_ESBASE;
wire [31:0] v2957 = In_register_ESP;
wire v2958 = v2957 == Out_register_ESP;
wire [31:0] v295a = In_register_EBX;
wire v295b = v295a == Out_register_EBX;
wire [31:0] v295d = In_register_EAX;
wire v295e = v295d == Out_register_EAX;
wire [31:0] v2960 = v16;
wire [31:0] v2961 = In_register_EIP + v2960;
wire [31:0] v2963 = v2961;
wire v2964 = v2963 == Out_register_EIP;
wire [31:0] v2966 = In_register_EDX;
wire v2967 = v2966 == Out_register_EDX;
wire [31:0] v2969 = In_register_ESI;
wire v296a = v2969 == Out_register_ESI;
wire [31:0] v296c = In_register_DSBASE;
wire v296d = v296c == Out_register_DSBASE;
wire [31:0] v296f = In_register_EBP;
wire v2970 = v296f == Out_register_EBP;
wire [31:0] v2972 = In_register_SSBASE;
wire v2973 = v2972 == Out_register_SSBASE;
wire [31:0] v2975 = In_register_FSBASE;
wire v2976 = v2975 == Out_register_FSBASE;
wire [31:0] v2978 = In_register_GSBASE;
wire v2979 = v2978 == Out_register_GSBASE;
wire [2:0] v297a = { v1fa };
wire [31:0] v297b = ( v297a == 3'd0) ? In_register_EAX : 
	( v297a == 3'd1) ? In_register_ECX : 
	( v297a == 3'd2) ? In_register_EDX : 
	( v297a == 3'd3) ? In_register_EBX : 
	( v297a == 3'd4) ? In_register_ESP : 
	( v297a == 3'd5) ? In_register_EBP : 
	( v297a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v297d = v297b;
wire [31:0] v297f = v1f7;
wire [31:0] v2980 = v297d - v297f;
wire [31:0] v2981 = v2980 ^ v297d;
wire [31:0] v2982 = v2981 >> v1e;
wire [31:0] v2983 = v297f ^ v297d;
wire [31:0] v2984 = v2983 >> v1e;
wire [31:0] v2985 = v2982 + v2984;
wire v2986 = v2985 == v1c;
wire v2988 = v2986;
wire v2989 = v2988 == Out_register_OF;
wire [31:0] v298b = In_register_EDI;
wire v298c = v298b == Out_register_EDI;
wire v298d = $signed(v2980) < $signed(v15);
wire v298f = v298d;
wire v2990 = v298f == Out_register_SF;
wire [31:0] v2992 = In_register_ECX;
wire v2993 = v2992 == Out_register_ECX;
wire [31:0] v2994 = v2983 ^ v2980;
wire [7:0] v2995 = v2994[7:0];
wire [7:0] v2996 = v2995 >> v1d;
wire [7:0] v2997 = v2996 & v18;
wire v2998 = v2997[0:0];
wire v299a = v2998;
wire v299b = v299a == Out_register_AF;
wire v299c = v297d < v297f;
wire v299e = v299c;
wire v299f = v299e == Out_register_CF;
wire [7:0] v29a0 = v2980[7:0];
wire [2:0] v29a1_aux = v29a0[0] + v29a0[1] + v29a0[2] + v29a0[3] + v29a0[4] + v29a0[5] + v29a0[6] + v29a0[7];
wire v29a1 = { 5'b00000, v29a1_aux };
wire [7:0] v29a2 = v29a1 & v18;
wire [7:0] v29a3 = v29a2 ^ v18;
wire v29a4 = v29a3[0:0];
wire v29a6 = v29a4;
wire v29a7 = v29a6 == Out_register_PF;
wire [7:0] v29a9 = In_register_DF;
wire v29aa = v29a9 == Out_register_DF;
wire [31:0] v29ac = In_register_CSBASE;
wire v29ad = v29ac == Out_register_CSBASE;
wire v29ae = v297d == v297f;
wire v29b0 = v29ae;
wire v29b1 = v29b0 == Out_register_ZF;
wire v29b2 = v2951 & v2952 & v2955 & v2958 & v295b & v295e & v2964 & v2967 & v15c & v296a & v296d & v2970 & v2973 & v2976 & v2979 & v2989 & v298c & v2990 & v2993 & v299b & v299f & v29a7 & v29aa & v29ad & v29b1;
wire v29b3 = v4e == v1eb;
wire v29b4 = v4b == v1ed;
wire v29b5 = v14 == v1ef;
wire [2:0] v29b6 = { v1fa };
wire v29b7 = v29b6 == vb;
wire v29b8 = v29b6 == vf;
wire v29b9 = v29b7 | v29b8;
wire v29ba = v29b9 ^ v8;
wire [2:0] v29bb = { v1fa };
wire v29bc = v29bb == vb;
wire v29bd = v29bc;
wire v29be = v29bd ^ v8;
wire v29bf = v29ba & v29be;
wire v29c0 = v29b3 & v29b4 & v29b5 & v29bf;
wire v29c1 = v4e == v1eb;
wire v29c2 = v8 == v829;
wire v29c3 = v95 == v1ed;
wire v29c4 = v4 == v11b;
wire v29c5 = v29c1 & v29c2 & v29c3 & v29c4;
wire v29c6 = v4e == v1eb;
wire v29c7 = v94 == v1ed;
wire v29c8 = v1b == v318;
wire [2:0] v29c9 = { v1fa };
wire v29ca = v29c9 == vb;
wire v29cb = v29c9 == vf;
wire v29cc = v29ca | v29cb;
wire v29cd = v29cc ^ v8;
wire [2:0] v29ce = { v1fa };
wire v29cf = v29ce == vb;
wire v29d0 = v29ce == vf;
wire v29d1 = v29cf | v29d0;
wire v29d2 = v29d1 ^ v8;
wire v29d3 = v29cd & v29d2;
wire v29d4 = v29c6 & v29c7 & v29c8 & v29d3;
wire [15:0] va0 = 16'b1111111110100100;
wire v29d5 = va0 == v117;
wire v29d6 = v14 == v1ef;
wire v29d7 = v29d5 & v29d6;
wire v29d8 = v29c0 | v29c5 | v29d4 | v29d7;
wire v29d9 = v29d8;
wire [31:0] v29db = In_register_FSBASE;
wire v29dc = v29db == Out_register_FSBASE;
wire [31:0] v29de = In_register_ESI;
wire v29df = v29de == Out_register_ESI;
wire [31:0] v29e1 = In_register_ESBASE;
wire v29e2 = v29e1 == Out_register_ESBASE;
wire v29e3 = In_error_flag == Out_error_flag;
wire [2:0] v29ec = { v1fa };
wire [31:0] v29ed = ( v29ec == 3'd0) ? In_register_EAX : 
	( v29ec == 3'd1) ? In_register_ECX : 
	( v29ec == 3'd2) ? In_register_EDX : 
	( v29ec == 3'd3) ? In_register_EBX : 
	( v29ec == 3'd4) ? v15 : 
	( v29ec == 3'd5) ? v15 : 
	( v29ec == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v29e4 = { v1fa };
wire [31:0] v29e5 = ( v29e4 == 3'd0) ? In_register_EAX : 
	( v29e4 == 3'd1) ? In_register_ECX : 
	( v29e4 == 3'd2) ? In_register_EDX : 
	( v29e4 == 3'd3) ? In_register_EBX : 
	( v29e4 == 3'd4) ? v15 : 
	( v29e4 == 3'd5) ? v15 : 
	( v29e4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v29e6 = v29e5 + v1f7;
wire [1:0] v29e8 = { v889 , v888 };
wire [31:0] v29e9 = ( v29e8 == 2'd0) ? In_register_EDX : 
	( v29e8 == 2'd1) ? In_register_ESI : 
	( v29e8 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v29ea = v29e9 + v63a;
wire [31:0] v29f0 = ( v29d4 ) ? v29ed : 
	( v29c0 ) ? v29e6 : 
	( v29c5 ) ? v29ea : v1f7;
wire v29f1 =  v26 == memory_0[15: 12] && v29f0 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v29f3 = In_register_CSBASE;
wire v29f4 = v29f3 == Out_register_CSBASE;
wire [31:0] v29f6 = In_register_EAX;
wire v29f7 = v29f6 == Out_register_EAX;
wire [31:0] v29f9 = In_register_EBX;
wire v29fa = v29f9 == Out_register_EBX;
wire [31:0] v29fc = In_register_EDI;
wire v29fd = v29fc == Out_register_EDI;
wire [31:0] v29ff = In_register_EBP;
wire v2a00 = v29ff == Out_register_EBP;
wire [7:0] v2a02 = In_register_DF;
wire v2a03 = v2a02 == Out_register_DF;
wire [31:0] v2a05 = In_register_EDX;
wire v2a06 = v2a05 == Out_register_EDX;
wire [31:0] v2a07 = memory_0[79: 48];
wire [31:0] v2a0a = v2a07;
wire [31:0] v2a0c = v2a0a;
wire v2a0d = v2a0c == Out_register_EIP;
wire [31:0] v2a0f = In_register_GSBASE;
wire v2a10 = v2a0f == Out_register_GSBASE;
wire [31:0] v2a12 = In_register_SSBASE;
wire v2a13 = v2a12 == Out_register_SSBASE;
wire [31:0] v2a15 = In_register_DSBASE;
wire v2a16 = v2a15 == Out_register_DSBASE;
wire [31:0] v2a18 = In_register_ESP;
wire v2a19 = v2a18 == Out_register_ESP;
wire v2a1b = In_register_PF;
wire v2a1c = v2a1b == Out_register_PF;
wire v2a1e = In_register_AF;
wire v2a1f = v2a1e == Out_register_AF;
wire v2a21 = In_register_CF;
wire v2a22 = v2a21 == Out_register_CF;
wire v2a24 = In_register_OF;
wire v2a25 = v2a24 == Out_register_OF;
wire [31:0] v2a27 = In_register_ECX;
wire v2a28 = v2a27 == Out_register_ECX;
wire v2a2a = In_register_SF;
wire v2a2b = v2a2a == Out_register_SF;
wire v2a2d = In_register_ZF;
wire v2a2e = v2a2d == Out_register_ZF;
wire v2a2f = v29d9 & v29dc & v29df & v29e2 & v29e3 & v29f1 & v29f4 & v29f7 & v29fa & v29fd & v2a00 & v2a03 & v2a06 & v2a0d & v2a10 & v2a13 & v2a16 & v2a19 & v15c & v2a1c & v2a1f & v2a22 & v2a25 & v2a28 & v2a2b & v2a2e;
wire v2a30 = v12 == v1eb;
wire [4:0] va1 = 5'b11100;
wire v2a31 = va1 == v1ed;
wire v2a32 = v14 == v1ef;
wire [2:0] v2a33 = { v1fa };
wire v2a34 = v2a33 == vb;
wire v2a35 = v2a33 == vf;
wire v2a36 = v2a34 | v2a35;
wire v2a37 = v2a36 ^ v8;
wire [2:0] v2a38 = { v1fa };
wire v2a39 = v2a38 == vb;
wire v2a3a = v2a38 == vf;
wire v2a3b = v2a39 | v2a3a;
wire v2a3c = v2a3b ^ v8;
wire v2a3d = v2a37 & v2a3c;
wire v2a3e = v2a30 & v2a31 & v2a32 & v2a3d;
wire v2a3f = v12 == v1eb;
wire v2a40 = v9e == v1ed;
wire v2a41 = v43 == vab3;
wire [2:0] v2a42 = { v1fa };
wire v2a43 = v2a42 == vb;
wire v2a44 = v2a43;
wire v2a45 = v2a44 ^ v8;
wire [2:0] v2a46 = { v1fa };
wire v2a47 = v2a46 == vb;
wire v2a48 = v2a47;
wire v2a49 = v2a48 ^ v8;
wire v2a4a = v2a45 & v2a49;
wire v2a4b = v2a3f & v2a40 & v2a41 & v2a4a;
wire v2a4c = v2a3e | v2a4b;
wire v2a4d = v2a4c;
wire [31:0] v2a4f = In_register_EBP;
wire v2a50 = v2a4f == Out_register_EBP;
wire [2:0] v2a54 = { v1fa };
wire [31:0] v2a55 = ( v2a54 == 3'd0) ? In_register_EAX : 
	( v2a54 == 3'd1) ? In_register_ECX : 
	( v2a54 == 3'd2) ? In_register_EDX : 
	( v2a54 == 3'd3) ? In_register_EBX : 
	( v2a54 == 3'd4) ? v15 : 
	( v2a54 == 3'd5) ? In_register_EBP : 
	( v2a54 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2a56 = v2a55 + v63a;
wire [2:0] v2a51 = { v1fa };
wire [31:0] v2a52 = ( v2a51 == 3'd0) ? In_register_EAX : 
	( v2a51 == 3'd1) ? In_register_ECX : 
	( v2a51 == 3'd2) ? In_register_EDX : 
	( v2a51 == 3'd3) ? In_register_EBX : 
	( v2a51 == 3'd4) ? v15 : 
	( v2a51 == 3'd5) ? v15 : 
	( v2a51 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2a58 = ( v2a4b ) ? v2a56 : v2a52;
wire v2a59 =  v26 == memory_0[15: 12] && v2a58 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] v2a5b = In_register_DF;
wire v2a5c = v2a5b == Out_register_DF;
wire [31:0] v2a5e = In_register_EAX;
wire v2a5f = v2a5e == Out_register_EAX;
wire [31:0] v2a61 = In_register_ESP;
wire v2a62 = v2a61 == Out_register_ESP;
wire [31:0] v2a64 = In_register_SSBASE;
wire v2a65 = v2a64 == Out_register_SSBASE;
wire [31:0] v2a67 = In_register_EDX;
wire v2a68 = v2a67 == Out_register_EDX;
wire [31:0] v2a6a = In_register_EBX;
wire v2a6b = v2a6a == Out_register_EBX;
wire [31:0] v2a6d = In_register_FSBASE;
wire v2a6e = v2a6d == Out_register_FSBASE;
wire [31:0] v2a70 = In_register_EDI;
wire v2a71 = v2a70 == Out_register_EDI;
wire [31:0] v2a73 = In_register_ECX;
wire v2a74 = v2a73 == Out_register_ECX;
wire [31:0] v2a76 = In_register_ESBASE;
wire v2a77 = v2a76 == Out_register_ESBASE;
wire [31:0] v2a7a = ( v2a4b ) ? v45 : v16;
wire [31:0] v2a7b = In_register_EIP + v2a7a;
wire [31:0] v2a7d = v2a7b;
wire v2a7e = v2a7d == Out_register_EIP;
wire [31:0] v2a80 = In_register_CSBASE;
wire v2a81 = v2a80 == Out_register_CSBASE;
wire [31:0] v2a83 = In_register_GSBASE;
wire v2a84 = v2a83 == Out_register_GSBASE;
wire [31:0] v2a85 = memory_0[79: 48];
wire [31:0] v2a88 = ( v2a4b ) ? vc2d : v1f7;
wire [31:0] v2a89 = v2a85 - v2a88;
wire [31:0] v2a8a = v2a89 ^ v2a85;
wire [31:0] v2a8b = v2a8a >> v1e;
wire [31:0] v2a8c = v2a85 ^ v2a88;
wire [31:0] v2a8d = v2a8c >> v1e;
wire [31:0] v2a8e = v2a8b + v2a8d;
wire v2a8f = v2a8e == v1c;
wire v2a91 = v2a8f;
wire v2a92 = v2a91 == Out_register_OF;
wire [31:0] v2a94 = In_register_DSBASE;
wire v2a95 = v2a94 == Out_register_DSBASE;
wire [31:0] v2a96 = v2a8c ^ v2a89;
wire [7:0] v2a97 = v2a96[7:0];
wire [7:0] v2a98 = v2a97 >> v1d;
wire [7:0] v2a99 = v2a98 & v18;
wire v2a9a = v2a99[0:0];
wire v2a9c = v2a9a;
wire v2a9d = v2a9c == Out_register_AF;
wire v2a9e = v2a85 < v2a88;
wire v2aa0 = v2a9e;
wire v2aa1 = v2aa0 == Out_register_CF;
wire [7:0] v2aa2 = v2a89[7:0];
wire [2:0] v2aa3_aux = v2aa2[0] + v2aa2[1] + v2aa2[2] + v2aa2[3] + v2aa2[4] + v2aa2[5] + v2aa2[6] + v2aa2[7];
wire v2aa3 = { 5'b00000, v2aa3_aux };
wire [7:0] v2aa4 = v2aa3 & v18;
wire [7:0] v2aa5 = v2aa4 ^ v18;
wire v2aa6 = v2aa5[0:0];
wire v2aa8 = v2aa6;
wire v2aa9 = v2aa8 == Out_register_PF;
wire v2aaa = In_error_flag == Out_error_flag;
wire [31:0] v2aac = In_register_ESI;
wire v2aad = v2aac == Out_register_ESI;
wire v2aae = $signed(v2a89) < $signed(v15);
wire v2ab0 = v2aae;
wire v2ab1 = v2ab0 == Out_register_SF;
wire v2ab2 = v2a85 == v2a88;
wire v2ab4 = v2ab2;
wire v2ab5 = v2ab4 == Out_register_ZF;
wire v2ab6 = v2a50 & v15c & v2a59 & v2a5c & v2a5f & v2a62 & v2a65 & v2a68 & v2a6b & v2a6e & v2a71 & v2a74 & v2a77 & v2a7e & v2a81 & v2a84 & v2a4d & v2a92 & v2a95 & v2a9d & v2aa1 & v2aa9 & v2aaa & v2aad & v2ab1 & v2ab5;
wire [7:0] va2 = 8'b10000100;
wire v2ab7 = va2 == v1eb;
wire v2ab8 = v3 == v316;
wire v2ab9 = v1b == v318;
wire v2aba = v2ab7 & v2ab8 & v2ab9;
wire v2abb = v2aba;
wire v2abc = v2abb;
wire v2abd = In_error_flag == Out_error_flag;
wire [7:0] v2abf = In_register_DF;
wire v2ac0 = v2abf == Out_register_DF;
wire [2:0] v2ac1 = { v320 };
wire [31:0] v2ac2 = ( v2ac1 == 3'd0) ? In_register_EAX : 
	( v2ac1 == 3'd1) ? In_register_ECX : 
	( v2ac1 == 3'd2) ? In_register_EDX : 
	( v2ac1 == 3'd3) ? In_register_EBX : 
	( v2ac1 == 3'd4) ? In_register_ESP : 
	( v2ac1 == 3'd5) ? In_register_EBP : 
	( v2ac1 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2ac4 = v2ac2;
wire [2:0] v2ac5 = { v1fa };
wire [31:0] v2ac6 = ( v2ac5 == 3'd0) ? In_register_EAX : 
	( v2ac5 == 3'd1) ? In_register_ECX : 
	( v2ac5 == 3'd2) ? In_register_EDX : 
	( v2ac5 == 3'd3) ? In_register_EBX : 
	( v2ac5 == 3'd4) ? In_register_ESP : 
	( v2ac5 == 3'd5) ? In_register_EBP : 
	( v2ac5 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2ac8 = v2ac6;
wire [31:0] v2ac9 = v2ac4 & v2ac8;
wire v2aca = $signed(v2ac9) < $signed(v15);
wire v2acc = v2aca;
wire v2acd = v2acc == Out_register_SF;
wire v2acf = v17;
wire v2ad0 = v2acf == Out_register_AF;
wire [2:0] v2ad1 = { v1fa };
wire v2ad2 = v2ad1 == vc;
wire v2ad3 = v2ad2;
wire v2ad4 = v2aba & v2ad3;
wire v2ad5 = v2ad4;
wire [31:0] v2ad8 = ( v8 ) ? In_register_ECX : v2ac9;
wire [31:0] v2ada = v2ad8;
wire v2adb = v2ada == Out_register_ECX;
wire v2adc = v2ad1 == v7;
wire v2add = v2adc;
wire v2ade = v2aba & v2add;
wire v2adf = v2ade;
wire [31:0] v2ae2 = ( v8 ) ? In_register_EAX : v2ac9;
wire [31:0] v2ae4 = v2ae2;
wire v2ae5 = v2ae4 == Out_register_EAX;
wire v2ae6 = v2ad1 == vb;
wire v2ae7 = v2ae6;
wire v2ae8 = v2aba & v2ae7;
wire v2ae9 = v2ae8;
wire [31:0] v2aec = ( v8 ) ? In_register_ESP : v2ac9;
wire [31:0] v2aee = v2aec;
wire v2aef = v2aee == Out_register_ESP;
wire v2af0 = v17;
wire v2af1 = v2af0 == Out_register_CF;
wire [31:0] v2af3 = v1c;
wire [31:0] v2af4 = In_register_EIP + v2af3;
wire [31:0] v2af6 = v2af4;
wire v2af7 = v2af6 == Out_register_EIP;
wire v2af8 = v2ad1 == vd;
wire v2af9 = v2af8;
wire v2afa = v2aba & v2af9;
wire v2afb = v2afa;
wire [31:0] v2afe = ( v8 ) ? In_register_EBX : v2ac9;
wire [31:0] v2b00 = v2afe;
wire v2b01 = v2b00 == Out_register_EBX;
wire v2b02 = v2ad1 == ve;
wire v2b03 = v2b02;
wire v2b04 = v2aba & v2b03;
wire v2b05 = v2b04;
wire [31:0] v2b08 = ( v8 ) ? In_register_EDX : v2ac9;
wire [31:0] v2b0a = v2b08;
wire v2b0b = v2b0a == Out_register_EDX;
wire v2b0c = v2ad1 == v11;
wire v2b0d = v2b0c;
wire v2b0e = v2aba & v2b0d;
wire v2b0f = v2b0e;
wire [31:0] v2b12 = ( v8 ) ? In_register_ESI : v2ac9;
wire [31:0] v2b14 = v2b12;
wire v2b15 = v2b14 == Out_register_ESI;
wire v2b16 = v2ad1 == v9;
wire v2b17 = v2b16;
wire v2b18 = v2aba & v2b17;
wire v2b19 = v2b18;
wire [31:0] v2b1c = ( v8 ) ? In_register_EDI : v2ac9;
wire [31:0] v2b1e = v2b1c;
wire v2b1f = v2b1e == Out_register_EDI;
wire [31:0] v2b21 = In_register_CSBASE;
wire v2b22 = v2b21 == Out_register_CSBASE;
wire [31:0] v2b24 = In_register_SSBASE;
wire v2b25 = v2b24 == Out_register_SSBASE;
wire v2b26 = v2ad1 == vf;
wire v2b27 = v2b26;
wire v2b28 = v2aba & v2b27;
wire v2b29 = v2b28;
wire [31:0] v2b2c = ( v8 ) ? In_register_EBP : v2ac9;
wire [31:0] v2b2e = v2b2c;
wire v2b2f = v2b2e == Out_register_EBP;
wire [31:0] v2b31 = In_register_ESBASE;
wire v2b32 = v2b31 == Out_register_ESBASE;
wire [31:0] v2b34 = In_register_DSBASE;
wire v2b35 = v2b34 == Out_register_DSBASE;
wire [31:0] v2b37 = In_register_GSBASE;
wire v2b38 = v2b37 == Out_register_GSBASE;
wire [7:0] v2b39 = v2ac9[7:0];
wire [2:0] v2b3a_aux = v2b39[0] + v2b39[1] + v2b39[2] + v2b39[3] + v2b39[4] + v2b39[5] + v2b39[6] + v2b39[7];
wire v2b3a = { 5'b00000, v2b3a_aux };
wire [7:0] v2b3b = v2b3a & v18;
wire [7:0] v2b3c = v2b3b ^ v18;
wire v2b3d = v2b3c[0:0];
wire v2b3f = v2b3d;
wire v2b40 = v2b3f == Out_register_PF;
wire v2b41 = v17;
wire v2b42 = v2b41 == Out_register_OF;
wire [31:0] v2b44 = In_register_FSBASE;
wire v2b45 = v2b44 == Out_register_FSBASE;
wire v2b46 = v2ac9 == v15;
wire v2b48 = v2b46;
wire v2b49 = v2b48 == Out_register_ZF;
wire v2b4a = v2abc & v15c & v2abd & v2ac0 & v2acd & v2ad0 & v2adb & v2ae5 & v2aef & v2af1 & v2af7 & v2b01 & v2b0b & v2b15 & v2b1f & v2b22 & v2b25 & v2b2f & v2b32 & v2b35 & v2b38 & v2b40 & v2b42 & v2b45 & v2b49;
wire [10:0] va3 = 11'b10100001001;
wire v2b4b = va3 == v6d7;
wire v2b4c = v35 == v316;
wire v2b4d = v4 == v11b;
wire [2:0] v2b4e = { v13c };
wire v2b4f = v2b4e == vb;
wire v2b50 = v2b4e == vf;
wire v2b51 = v2b4f | v2b50;
wire v2b52 = v2b51 ^ v8;
wire [2:0] v2b53 = { v12c };
wire v2b54 = v2b53 == vb;
wire v2b55 = v2b54;
wire v2b56 = v2b55 ^ v8;
wire [2:0] v2b57 = { v13c };
wire v2b58 = v2b57 == vf;
wire v2b59 = v2b58;
wire v2b5a = v2b59 ^ v8;
wire v2b5b = v2b52 & v2b56 & v2b5a;
wire v2b5c = v2b4b & v2b4c & v2b4d & v2b5b;
wire [10:0] va4 = 11'b10100001101;
wire v2b5d = va4 == v6d7;
wire v2b5e = v35 == v316;
wire v2b5f = v14 == v1ef;
wire v2b60 = v2b5d & v2b5e & v2b5f;
wire v2b61 = v2b5c | v2b60;
wire v2b62 = v2b61;
wire [31:0] v2b64 = In_register_ECX;
wire v2b65 = v2b64 == Out_register_ECX;
wire [31:0] v2b67 = In_register_EDX;
wire v2b68 = v2b67 == Out_register_EDX;
wire [2:0] v2b69 = { v13c };
wire [31:0] v2b6a = ( v2b69 == 3'd0) ? In_register_EAX : 
	( v2b69 == 3'd1) ? In_register_ECX : 
	( v2b69 == 3'd2) ? In_register_EDX : 
	( v2b69 == 3'd3) ? In_register_EBX : 
	( v2b69 == 3'd4) ? v15 : 
	( v2b69 == 3'd5) ? v15 : 
	( v2b69 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v2b6b = { v12c };
wire [31:0] v2b6c = ( v2b6b == 3'd0) ? In_register_EAX : 
	( v2b6b == 3'd1) ? In_register_ECX : 
	( v2b6b == 3'd2) ? In_register_EDX : 
	( v2b6b == 3'd3) ? In_register_EBX : 
	( v2b6b == 3'd4) ? v15 : 
	( v2b6b == 3'd5) ? In_register_EBP : 
	( v2b6b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2b6d = v2b6c << v7f4;
wire [31:0] v2b6e = v2b6a + v2b6d;
wire [31:0] v2b71 = ( v2b5c ) ? v2b6e : v1f7;
wire v2b72 =  v26 == memory_0[15: 12] && v2b71 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2b74 = In_register_EBP;
wire v2b75 = v2b74 == Out_register_EBP;
wire [31:0] v2b77 = In_register_EBX;
wire v2b78 = v2b77 == Out_register_EBX;
wire [31:0] v2b7a = In_register_EAX;
wire v2b7b = v2b7a == Out_register_EAX;
wire [31:0] v2b7e = ( v2b60 ) ? v16 : v10;
wire [31:0] v2b7f = In_register_EIP + v2b7e;
wire [31:0] v2b81 = v2b7f;
wire v2b82 = v2b81 == Out_register_EIP;
wire [31:0] v2b83 = memory_0[79: 48];
wire [2:0] v2b84 = { v320 };
wire [31:0] v2b85 = ( v2b84 == 3'd0) ? In_register_EAX : 
	( v2b84 == 3'd1) ? In_register_ECX : 
	( v2b84 == 3'd2) ? In_register_EDX : 
	( v2b84 == 3'd3) ? In_register_EBX : 
	( v2b84 == 3'd4) ? In_register_ESP : 
	( v2b84 == 3'd5) ? In_register_EBP : 
	( v2b84 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v2b87 = { v320 };
wire [31:0] v2b88 = ( v2b87 == 3'd0) ? In_register_EAX : 
	( v2b87 == 3'd1) ? In_register_ECX : 
	( v2b87 == 3'd2) ? In_register_EDX : 
	( v2b87 == 3'd3) ? In_register_EBX : 
	( v2b87 == 3'd4) ? In_register_ESP : 
	( v2b87 == 3'd5) ? In_register_EBP : 
	( v2b87 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2b8a = ( v2b5c ) ? v2b85 : v2b88;
wire [31:0] v2b8b = v2b83 & v2b8a;
wire v2b8c = v2b8b == v15;
wire v2b8e = v2b8c;
wire v2b8f = v2b8e == Out_register_ZF;
wire v2b90 = $signed(v2b8b) < $signed(v15);
wire v2b92 = v2b90;
wire v2b93 = v2b92 == Out_register_SF;
wire v2b94 = In_error_flag == Out_error_flag;
wire [31:0] v2b96 = In_register_ESP;
wire v2b97 = v2b96 == Out_register_ESP;
wire [31:0] v2b99 = In_register_ESI;
wire v2b9a = v2b99 == Out_register_ESI;
wire [31:0] v2b9c = In_register_CSBASE;
wire v2b9d = v2b9c == Out_register_CSBASE;
wire [31:0] v2b9f = In_register_EDI;
wire v2ba0 = v2b9f == Out_register_EDI;
wire [31:0] v2ba2 = In_register_SSBASE;
wire v2ba3 = v2ba2 == Out_register_SSBASE;
wire [31:0] v2ba5 = In_register_FSBASE;
wire v2ba6 = v2ba5 == Out_register_FSBASE;
wire [31:0] v2ba8 = In_register_GSBASE;
wire v2ba9 = v2ba8 == Out_register_GSBASE;
wire v2bab = In_register_AF;
wire v2bac = v2bab == Out_register_AF;
wire [31:0] v2bae = In_register_DSBASE;
wire v2baf = v2bae == Out_register_DSBASE;
wire v2bb1 = v17;
wire v2bb2 = v2bb1 == Out_register_CF;
wire v2bb3 = v17;
wire v2bb4 = v2bb3 == Out_register_OF;
wire [7:0] v2bb6 = In_register_DF;
wire v2bb7 = v2bb6 == Out_register_DF;
wire [7:0] v2bb8 = v2b8b[7:0];
wire [2:0] v2bb9_aux = v2bb8[0] + v2bb8[1] + v2bb8[2] + v2bb8[3] + v2bb8[4] + v2bb8[5] + v2bb8[6] + v2bb8[7];
wire v2bb9 = { 5'b00000, v2bb9_aux };
wire [7:0] v2bba = v2bb9 & v18;
wire [7:0] v2bbb = v2bba ^ v18;
wire v2bbc = v2bbb[0:0];
wire v2bbe = v2bbc;
wire v2bbf = v2bbe == Out_register_PF;
wire [31:0] v2bc1 = In_register_ESBASE;
wire v2bc2 = v2bc1 == Out_register_ESBASE;
wire v2bc3 = v2b62 & v15c & v2b65 & v2b68 & v2b72 & v2b75 & v2b78 & v2b7b & v2b82 & v2b8f & v2b93 & v2b94 & v2b97 & v2b9a & v2b9d & v2ba0 & v2ba3 & v2ba6 & v2ba9 & v2bac & v2baf & v2bb2 & v2bb4 & v2bb7 & v2bbf & v2bc2;
wire [7:0] va5 = 8'b10111100;
wire v2bc4 = va5 == v1eb;
wire v2bc5 = v47 == vb69;
wire v2bc6 = v2bc4 & v2bc5;
wire v2bc7 = v2bc6;
wire v2bc8 = v2bc7;
wire [31:0] v2bca = In_register_EAX;
wire v2bcb = v2bca == Out_register_EAX;
wire [31:0] v2bcd = In_register_EBX;
wire v2bce = v2bcd == Out_register_EBX;
wire [31:0] v2bd0 = In_register_ESP;
wire v2bd1 = v2bd0 == Out_register_ESP;
wire [31:0] v2bd3 = In_register_EBP;
wire v2bd4 = v2bd3 == Out_register_EBP;
wire [31:0] v2bd6 = In_register_EDX;
wire v2bd7 = v2bd6 == Out_register_EDX;
wire [31:0] v2bd9 = In_register_EAX;
wire [31:0] v2bdb = vb74;
wire v2bdc = v2bd9 < v2bdb;
wire v2bde = v2bdc;
wire v2bdf = v2bde == Out_register_CF;
wire [31:0] v2be1 = In_register_ESI;
wire v2be2 = v2be1 == Out_register_ESI;
wire v2be3 = In_error_flag == Out_error_flag;
wire [31:0] v2be5 = In_register_EDI;
wire v2be6 = v2be5 == Out_register_EDI;
wire [31:0] v2be8 = v48;
wire [31:0] v2be9 = In_register_EIP + v2be8;
wire [31:0] v2beb = v2be9;
wire v2bec = v2beb == Out_register_EIP;
wire [31:0] v2bee = In_register_ECX;
wire v2bef = v2bee == Out_register_ECX;
wire [31:0] v2bf1 = In_register_CSBASE;
wire v2bf2 = v2bf1 == Out_register_CSBASE;
wire [31:0] v2bf4 = In_register_DSBASE;
wire v2bf5 = v2bf4 == Out_register_DSBASE;
wire [31:0] v2bf6 = v2bd9 - v2bdb;
wire [31:0] v2bf7 = v2bf6 ^ v2bd9;
wire [31:0] v2bf8 = v2bf7 >> v1e;
wire [31:0] v2bf9 = v2bdb ^ v2bd9;
wire [31:0] v2bfa = v2bf9 >> v1e;
wire [31:0] v2bfb = v2bf8 + v2bfa;
wire v2bfc = v2bfb == v1c;
wire v2bfe = v2bfc;
wire v2bff = v2bfe == Out_register_OF;
wire v2c00 = $signed(v2bf6) < $signed(v15);
wire v2c02 = v2c00;
wire v2c03 = v2c02 == Out_register_SF;
wire [31:0] v2c05 = In_register_ESBASE;
wire v2c06 = v2c05 == Out_register_ESBASE;
wire [31:0] v2c08 = In_register_FSBASE;
wire v2c09 = v2c08 == Out_register_FSBASE;
wire [31:0] v2c0a = v2bf9 ^ v2bf6;
wire [7:0] v2c0b = v2c0a[7:0];
wire [7:0] v2c0c = v2c0b >> v1d;
wire [7:0] v2c0d = v2c0c & v18;
wire v2c0e = v2c0d[0:0];
wire v2c10 = v2c0e;
wire v2c11 = v2c10 == Out_register_AF;
wire [7:0] v2c13 = In_register_DF;
wire v2c14 = v2c13 == Out_register_DF;
wire [31:0] v2c16 = In_register_SSBASE;
wire v2c17 = v2c16 == Out_register_SSBASE;
wire [7:0] v2c18 = v2bf6[7:0];
wire [2:0] v2c19_aux = v2c18[0] + v2c18[1] + v2c18[2] + v2c18[3] + v2c18[4] + v2c18[5] + v2c18[6] + v2c18[7];
wire v2c19 = { 5'b00000, v2c19_aux };
wire [7:0] v2c1a = v2c19 & v18;
wire [7:0] v2c1b = v2c1a ^ v18;
wire v2c1c = v2c1b[0:0];
wire v2c1e = v2c1c;
wire v2c1f = v2c1e == Out_register_PF;
wire [31:0] v2c21 = In_register_GSBASE;
wire v2c22 = v2c21 == Out_register_GSBASE;
wire v2c23 = v2bd9 == v2bdb;
wire v2c25 = v2c23;
wire v2c26 = v2c25 == Out_register_ZF;
wire v2c27 = v2bc8 & v2bcb & v2bce & v2bd1 & v2bd4 & v2bd7 & v2bdf & v15c & v2be2 & v2be3 & v2be6 & v2bec & v2bef & v2bf2 & v2bf5 & v2bff & v2c03 & v2c06 & v2c09 & v2c11 & v2c14 & v2c17 & v2c1f & v2c22 & v2c26;
wire [10:0] va6 = 11'b11010000001;
wire v2c2b = va6 == v6d7;
wire v2c2c = v35 == v316;
wire v2c2d = v4 == v11b;
wire [2:0] v2c2e = { v13c };
wire v2c2f = v2c2e == vb;
wire v2c30 = v2c2e == vf;
wire v2c31 = v2c2f | v2c30;
wire v2c32 = v2c31 ^ v8;
wire [2:0] v2c33 = { v12c };
wire v2c34 = v2c33 == vb;
wire v2c35 = v2c34;
wire v2c36 = v2c35 ^ v8;
wire [2:0] v2c37 = { v13c };
wire v2c38 = v2c37 == vf;
wire v2c39 = v2c38;
wire v2c3a = v2c39 ^ v8;
wire v2c3b = v2c32 & v2c36 & v2c3a;
wire v2c3c = v2c2b & v2c2c & v2c2d & v2c3b;
wire v2c48 = v2c3c;
wire v2c49 = v2c48;
wire [2:0] v2c40 = { v320 };
wire v2c41 = v2c40 == vf;
wire v2c42 = v2c41;
wire v2c43 = v2c3c & v2c42;
wire v2c44 = v2c43;
wire [31:0] v2c28 = memory_0[79: 48];
wire [2:0] v2c29 = { v320 };
wire [31:0] v2c2a = ( v2c29 == 3'd0) ? In_register_EAX : 
	( v2c29 == 3'd1) ? In_register_ECX : 
	( v2c29 == 3'd2) ? In_register_EDX : 
	( v2c29 == 3'd3) ? In_register_EBX : 
	( v2c29 == 3'd4) ? In_register_ESP : 
	( v2c29 == 3'd5) ? In_register_EBP : 
	( v2c29 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2c3e = v2c2a;
wire [31:0] v2c3f = v2c28 | v2c3e;
wire [31:0] v2c47 = ( v8 ) ? In_register_EBP : v2c3f;
wire [31:0] v2c4b = v2c47;
wire v2c4c = v2c4b == Out_register_EBP;
wire v2c4d = In_error_flag == Out_error_flag;
wire v2c4f = v17;
wire v2c50 = v2c4f == Out_register_OF;
wire [7:0] v2c52 = In_register_DF;
wire v2c53 = v2c52 == Out_register_DF;
wire v2c54 = v2c40 == ve;
wire v2c55 = v2c54;
wire v2c56 = v2c3c & v2c55;
wire v2c57 = v2c56;
wire [31:0] v2c5a = ( v8 ) ? In_register_EDX : v2c3f;
wire [31:0] v2c5c = v2c5a;
wire v2c5d = v2c5c == Out_register_EDX;
wire v2c5f = In_register_AF;
wire v2c60 = v2c5f == Out_register_AF;
wire [31:0] v2c62 = In_register_GSBASE;
wire v2c63 = v2c62 == Out_register_GSBASE;
wire [2:0] v2c64 = { v13c };
wire [31:0] v2c65 = ( v2c64 == 3'd0) ? In_register_EAX : 
	( v2c64 == 3'd1) ? In_register_ECX : 
	( v2c64 == 3'd2) ? In_register_EDX : 
	( v2c64 == 3'd3) ? In_register_EBX : 
	( v2c64 == 3'd4) ? v15 : 
	( v2c64 == 3'd5) ? v15 : 
	( v2c64 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v2c66 = { v12c };
wire [31:0] v2c67 = ( v2c66 == 3'd0) ? In_register_EAX : 
	( v2c66 == 3'd1) ? In_register_ECX : 
	( v2c66 == 3'd2) ? In_register_EDX : 
	( v2c66 == 3'd3) ? In_register_EBX : 
	( v2c66 == 3'd4) ? v15 : 
	( v2c66 == 3'd5) ? In_register_EBP : 
	( v2c66 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2c68 = v2c67 << v7f4;
wire [31:0] v2c69 = v2c65 + v2c68;
wire [31:0] v2c6b = v2c69;
wire v2c6c =  v26 == memory_0[15: 12] && v2c6b == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v2c6e = In_register_FSBASE;
wire v2c6f = v2c6e == Out_register_FSBASE;
wire [31:0] v2c71 = In_register_ESBASE;
wire v2c72 = v2c71 == Out_register_ESBASE;
wire v2c73 = v2c40 == v7;
wire v2c74 = v2c73;
wire v2c75 = v2c3c & v2c74;
wire v2c76 = v2c75;
wire [31:0] v2c79 = ( v8 ) ? In_register_EAX : v2c3f;
wire [31:0] v2c7b = v2c79;
wire v2c7c = v2c7b == Out_register_EAX;
wire [31:0] v2c7e = In_register_CSBASE;
wire v2c7f = v2c7e == Out_register_CSBASE;
wire v2c80 = v2c40 == vb;
wire v2c81 = v2c80;
wire v2c82 = v2c3c & v2c81;
wire v2c83 = v2c82;
wire [31:0] v2c86 = ( v8 ) ? In_register_ESP : v2c3f;
wire [31:0] v2c88 = v2c86;
wire v2c89 = v2c88 == Out_register_ESP;
wire v2c8a = $signed(v2c3f) < $signed(v15);
wire v2c8c = v2c8a;
wire v2c8d = v2c8c == Out_register_SF;
wire v2c8e = v2c40 == vc;
wire v2c8f = v2c8e;
wire v2c90 = v2c3c & v2c8f;
wire v2c91 = v2c90;
wire [31:0] v2c94 = ( v8 ) ? In_register_ECX : v2c3f;
wire [31:0] v2c96 = v2c94;
wire v2c97 = v2c96 == Out_register_ECX;
wire v2c98 = v2c40 == v9;
wire v2c99 = v2c98;
wire v2c9a = v2c3c & v2c99;
wire v2c9b = v2c9a;
wire [31:0] v2c9e = ( v8 ) ? In_register_EDI : v2c3f;
wire [31:0] v2ca0 = v2c9e;
wire v2ca1 = v2ca0 == Out_register_EDI;
wire [31:0] v2ca3 = In_register_DSBASE;
wire v2ca4 = v2ca3 == Out_register_DSBASE;
wire v2ca5 = v2c40 == vd;
wire v2ca6 = v2ca5;
wire v2ca7 = v2c3c & v2ca6;
wire v2ca8 = v2ca7;
wire [31:0] v2cab = ( v8 ) ? In_register_EBX : v2c3f;
wire [31:0] v2cad = v2cab;
wire v2cae = v2cad == Out_register_EBX;
wire [7:0] v2caf = v2c3f[7:0];
wire [2:0] v2cb0_aux = v2caf[0] + v2caf[1] + v2caf[2] + v2caf[3] + v2caf[4] + v2caf[5] + v2caf[6] + v2caf[7];
wire v2cb0 = { 5'b00000, v2cb0_aux };
wire [7:0] v2cb1 = v2cb0 & v18;
wire [7:0] v2cb2 = v2cb1 ^ v18;
wire v2cb3 = v2cb2[0:0];
wire v2cb5 = v2cb3;
wire v2cb6 = v2cb5 == Out_register_PF;
wire v2cb7 = v2c40 == v11;
wire v2cb8 = v2cb7;
wire v2cb9 = v2c3c & v2cb8;
wire v2cba = v2cb9;
wire [31:0] v2cbd = ( v8 ) ? In_register_ESI : v2c3f;
wire [31:0] v2cbf = v2cbd;
wire v2cc0 = v2cbf == Out_register_ESI;
wire [31:0] v2cc2 = v10;
wire [31:0] v2cc3 = In_register_EIP + v2cc2;
wire [31:0] v2cc5 = v2cc3;
wire v2cc6 = v2cc5 == Out_register_EIP;
wire [31:0] v2cc8 = In_register_SSBASE;
wire v2cc9 = v2cc8 == Out_register_SSBASE;
wire v2cca = v17;
wire v2ccb = v2cca == Out_register_CF;
wire v2ccc = v2c3f == v15;
wire v2cce = v2ccc;
wire v2ccf = v2cce == Out_register_ZF;
wire v2cd0 = v2c4c & v2c4d & v2c49 & v2c50 & v2c53 & v2c5d & v2c60 & v15c & v2c63 & v2c6c & v2c6f & v2c72 & v2c7c & v2c7f & v2c89 & v2c8d & v2c97 & v2ca1 & v2ca4 & v2cae & v2cb6 & v2cc0 & v2cc6 & v2cc9 & v2ccb & v2ccf;
wire [7:0] va7 = 8'b01000100;
wire v2cde = va7 == v1eb;
wire v2cdf = v3 == v316;
wire v2ce0 = v1b == v318;
wire v2ce1 = v2cde & v2cdf & v2ce0;
wire v2cf6 = v2ce1;
wire v2cf7 = v2cf6;
wire [2:0] v2cd1 = { v1fa };
wire [31:0] v2cd2 = ( v2cd1 == 3'd0) ? In_register_EAX : 
	( v2cd1 == 3'd1) ? In_register_ECX : 
	( v2cd1 == 3'd2) ? In_register_EDX : 
	( v2cd1 == 3'd3) ? In_register_EBX : 
	( v2cd1 == 3'd4) ? In_register_EAX : 
	( v2cd1 == 3'd5) ? In_register_ECX : 
	( v2cd1 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2cd3 = { v1fa };
wire v2cd4 = v2cd3 == vb;
wire v2cd5 = v2cd3 == v9;
wire v2cd6 = v2cd4 | v2cd5;
wire v2cd7 = v2cd3 == vf;
wire v2cd8 = v2cd6 | v2cd7;
wire v2cd9 = v2cd3 == v11;
wire v2cda = v2cd8 | v2cd9;
wire [31:0] v2cdb = ( v2cda == 1'd0) ? v15 : v31;
wire [31:0] v2cdc = v2cd2 >> v2cdb;
wire [31:0] v2cdd = v2cdc & v32;
wire [31:0] v2ce3 = v2cdd;
wire [2:0] v2ce4 = { v320 };
wire [31:0] v2ce5 = ( v2ce4 == 3'd0) ? In_register_EAX : 
	( v2ce4 == 3'd1) ? In_register_ECX : 
	( v2ce4 == 3'd2) ? In_register_EDX : 
	( v2ce4 == 3'd3) ? In_register_EBX : 
	( v2ce4 == 3'd4) ? In_register_EAX : 
	( v2ce4 == 3'd5) ? In_register_ECX : 
	( v2ce4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2ce6 = { v320 };
wire v2ce7 = v2ce6 == vb;
wire v2ce8 = v2ce6 == v9;
wire v2ce9 = v2ce7 | v2ce8;
wire v2cea = v2ce6 == vf;
wire v2ceb = v2ce9 | v2cea;
wire v2cec = v2ce6 == v11;
wire v2ced = v2ceb | v2cec;
wire [31:0] v2cee = ( v2ced == 1'd0) ? v15 : v31;
wire [31:0] v2cef = v2ce5 >> v2cee;
wire [31:0] v2cf0 = v2cef & v32;
wire [31:0] v2cf2 = v2cf0;
wire [31:0] v2cf3 = v2ce3 & v2cf2;
wire [7:0] v2cf4 = v2cf3[7:0];
wire v2cf5 = v2cf4 == v2c;
wire v2cf9 = v2cf5;
wire v2cfa = v2cf9 == Out_register_ZF;
wire v2cfb = In_error_flag == Out_error_flag;
wire [31:0] v2cfd = In_register_EBP;
wire v2cfe = v2cfd == Out_register_EBP;
wire [31:0] v2d00 = In_register_EDI;
wire v2d01 = v2d00 == Out_register_EDI;
wire v2d03 = v17;
wire v2d04 = v2d03 == Out_register_AF;
wire [2:0] v2d07 = { v320 };
wire v2d08 = v2d07 == vd;
wire v2d09 = v2d08;
wire v2d0a = v2ce1 & v2d09;
wire v2d0b = v2d0a;
wire [31:0] v2d05 = { 24'b000000000000000000000000, v2cf4 };
wire [31:0] v2d06 = v7b8 | v2d05;
wire v2d0f = v2d07 == v9;
wire v2d10 = v2d0f;
wire v2d11 = v2ce1 & v2d10;
wire v2d12 = v2d11;
wire [31:0] v2d0d = v2d05 << v31;
wire [31:0] v2d0e = v7c8 | v2d0d;
wire [31:0] v2d15 = ( v8 ) ? In_register_EBX : 
	( v2d0b ) ? v2d06 : v2d0e;
wire [31:0] v2d17 = v2d15;
wire v2d18 = v2d17 == Out_register_EBX;
wire [7:0] v2d1a = In_register_DF;
wire v2d1b = v2d1a == Out_register_DF;
wire [31:0] v2d1d = In_register_DSBASE;
wire v2d1e = v2d1d == Out_register_DSBASE;
wire v2d20 = v2d07 == v7;
wire v2d21 = v2d20;
wire v2d22 = v2ce1 & v2d21;
wire v2d23 = v2d22;
wire [31:0] v2d1f = v5c8 | v2d05;
wire v2d26 = v2d07 == vb;
wire v2d27 = v2d26;
wire v2d28 = v2ce1 & v2d27;
wire v2d29 = v2d28;
wire [31:0] v2d25 = v752 | v2d0d;
wire [31:0] v2d2c = ( v8 ) ? In_register_EAX : 
	( v2d23 ) ? v2d1f : v2d25;
wire [31:0] v2d2e = v2d2c;
wire v2d2f = v2d2e == Out_register_EAX;
wire [31:0] v2d31 = In_register_FSBASE;
wire v2d32 = v2d31 == Out_register_FSBASE;
wire [31:0] v2d34 = In_register_ESP;
wire v2d35 = v2d34 == Out_register_ESP;
wire v2d36 = v17;
wire v2d37 = v2d36 == Out_register_CF;
wire [31:0] v2d39 = v1c;
wire [31:0] v2d3a = In_register_EIP + v2d39;
wire [31:0] v2d3c = v2d3a;
wire v2d3d = v2d3c == Out_register_EIP;
wire v2d3e = v17;
wire v2d3f = v2d3e == Out_register_OF;
wire v2d41 = v2d07 == vf;
wire v2d42 = v2d41;
wire v2d43 = v2ce1 & v2d42;
wire v2d44 = v2d43;
wire [31:0] v2d40 = v790 | v2d0d;
wire v2d47 = v2d07 == vc;
wire v2d48 = v2d47;
wire v2d49 = v2ce1 & v2d48;
wire v2d4a = v2d49;
wire [31:0] v2d46 = v7a0 | v2d05;
wire [31:0] v2d4d = ( v8 ) ? In_register_ECX : 
	( v2d44 ) ? v2d40 : v2d46;
wire [31:0] v2d4f = v2d4d;
wire v2d50 = v2d4f == Out_register_ECX;
wire [31:0] v2d52 = In_register_ESI;
wire v2d53 = v2d52 == Out_register_ESI;
wire [31:0] v2d55 = In_register_CSBASE;
wire v2d56 = v2d55 == Out_register_CSBASE;
wire v2d57 = $signed(v2cf4) < $signed(v2c);
wire v2d59 = v2d57;
wire v2d5a = v2d59 == Out_register_SF;
wire [31:0] v2d5c = In_register_SSBASE;
wire v2d5d = v2d5c == Out_register_SSBASE;
wire [31:0] v2d5f = In_register_ESBASE;
wire v2d60 = v2d5f == Out_register_ESBASE;
wire [31:0] v2d62 = In_register_GSBASE;
wire v2d63 = v2d62 == Out_register_GSBASE;
wire v2d65 = v2d07 == ve;
wire v2d66 = v2d65;
wire v2d67 = v2ce1 & v2d66;
wire v2d68 = v2d67;
wire [31:0] v2d64 = v768 | v2d05;
wire v2d6b = v2d07 == v11;
wire v2d6c = v2d6b;
wire v2d6d = v2ce1 & v2d6c;
wire v2d6e = v2d6d;
wire [31:0] v2d6a = v778 | v2d0d;
wire [31:0] v2d71 = ( v8 ) ? In_register_EDX : 
	( v2d68 ) ? v2d64 : v2d6a;
wire [31:0] v2d73 = v2d71;
wire v2d74 = v2d73 == Out_register_EDX;
wire [2:0] v2d75_aux = v2cf4[0] + v2cf4[1] + v2cf4[2] + v2cf4[3] + v2cf4[4] + v2cf4[5] + v2cf4[6] + v2cf4[7];
wire v2d75 = { 5'b00000, v2d75_aux };
wire [7:0] v2d76 = v2d75 & v18;
wire [7:0] v2d77 = v2d76 ^ v18;
wire v2d78 = v2d77[0:0];
wire v2d7a = v2d78;
wire v2d7b = v2d7a == Out_register_PF;
wire v2d7c = v2cfa & v2cfb & v2cfe & v2d01 & v15c & v2d04 & v2d18 & v2d1b & v2d1e & v2d2f & v2d32 & v2d35 & v2d37 & v2d3d & v2d3f & v2d50 & v2d53 & v2cf7 & v2d56 & v2d5a & v2d5d & v2d60 & v2d63 & v2d74 & v2d7b;
wire v2d7d = In_error_flag == Out_error_flag;
wire v2d8b = v81 == v1eb;
wire [4:0] va8 = 5'b10111;
wire v2d8c = va8 == v1ed;
wire v2d8d = v1b == v318;
wire v2d8e = v2d8b & v2d8c & v2d8d;
wire v2d97 = v2d8e;
wire v2d98 = v2d97;
wire [2:0] v2d7e = { v1fa };
wire [31:0] v2d7f = ( v2d7e == 3'd0) ? In_register_EAX : 
	( v2d7e == 3'd1) ? In_register_ECX : 
	( v2d7e == 3'd2) ? In_register_EDX : 
	( v2d7e == 3'd3) ? In_register_EBX : 
	( v2d7e == 3'd4) ? In_register_EAX : 
	( v2d7e == 3'd5) ? In_register_ECX : 
	( v2d7e == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2d80 = { v1fa };
wire v2d81 = v2d80 == vb;
wire v2d82 = v2d80 == v9;
wire v2d83 = v2d81 | v2d82;
wire v2d84 = v2d80 == vf;
wire v2d85 = v2d83 | v2d84;
wire v2d86 = v2d80 == v11;
wire v2d87 = v2d85 | v2d86;
wire [31:0] v2d88 = ( v2d87 == 1'd0) ? v15 : v31;
wire [31:0] v2d89 = v2d7f >> v2d88;
wire [31:0] v2d8a = v2d89 & v32;
wire [31:0] v2d90 = v2d8a;
wire [15:0] v2d91 = v2d90[15:0];
wire [15:0] v2d92 = v2d91 << v83;
wire [15:0] v2d93 = v2d92 >>> v83;
wire [15:0] v2d94 = v2d93 * v204f;
wire [15:0] v2d95 = v2d94 + v84;
wire v2d96 = v2d95 < v85;
wire v2d9a = v2d96;
wire v2d9b = v2d9a == Out_register_OF;
wire v2d9d = In_register_ZF;
wire v2d9e = v2d9d == Out_register_ZF;
wire v2da0 = In_register_PF;
wire v2da1 = v2da0 == Out_register_PF;
wire [31:0] v2da3 = In_register_ESI;
wire v2da4 = v2da3 == Out_register_ESI;
wire [31:0] v2da6 = In_register_ECX;
wire v2da7 = v2da6 == Out_register_ECX;
wire [31:0] v2da9 = In_register_EDX;
wire v2daa = v2da9 == Out_register_EDX;
wire [31:0] v2dac = In_register_EDI;
wire v2dad = v2dac == Out_register_EDI;
wire [31:0] v2daf = In_register_EBP;
wire v2db0 = v2daf == Out_register_EBP;
wire [31:0] v2db2 = v1c;
wire [31:0] v2db3 = In_register_EIP + v2db2;
wire [31:0] v2db5 = v2db3;
wire v2db6 = v2db5 == Out_register_EIP;
wire [31:0] v2db8 = In_register_CSBASE;
wire v2db9 = v2db8 == Out_register_CSBASE;
wire [31:0] v2dbb = In_register_SSBASE;
wire v2dbc = v2dbb == Out_register_SSBASE;
wire [31:0] v2dbe = In_register_ESBASE;
wire v2dbf = v2dbe == Out_register_ESBASE;
wire [7:0] v2dc0 = v2d94[7:0];
wire [31:0] v2dc1 = { 24'b000000000000000000000000, v2dc0 };
wire [31:0] v2dc2 = v5c8 | v2dc1;
wire [31:0] v2dc3 = v2dc2 & v3a;
wire [15:0] v2dc4 = v2d94 >> v83;
wire [7:0] v2dc5 = v2dc4[7:0];
wire [31:0] v2dc6 = { 24'b000000000000000000000000, v2dc5 };
wire [31:0] v2dc7 = v2dc6 << v31;
wire [31:0] v2dc8 = v2dc3 | v2dc7;
wire [31:0] v2dca = v2dc8;
wire v2dcb = v2dca == Out_register_EAX;
wire [31:0] v2dcd = In_register_DSBASE;
wire v2dce = v2dcd == Out_register_DSBASE;
wire [31:0] v2dd0 = In_register_GSBASE;
wire v2dd1 = v2dd0 == Out_register_GSBASE;
wire [31:0] v2dd3 = In_register_FSBASE;
wire v2dd4 = v2dd3 == Out_register_FSBASE;
wire v2dd6 = In_register_AF;
wire v2dd7 = v2dd6 == Out_register_AF;
wire [31:0] v2dd9 = In_register_EBX;
wire v2dda = v2dd9 == Out_register_EBX;
wire [7:0] v2ddc = In_register_DF;
wire v2ddd = v2ddc == Out_register_DF;
wire [31:0] v2ddf = In_register_ESP;
wire v2de0 = v2ddf == Out_register_ESP;
wire v2de1 = v2d96;
wire v2de2 = v2de1 == Out_register_CF;
wire v2de4 = In_register_SF;
wire v2de5 = v2de4 == Out_register_SF;
wire v2de6 = v15c & v2d7d & v2d9b & v2d98 & v2d9e & v2da1 & v2da4 & v2da7 & v2daa & v2dad & v2db0 & v2db6 & v2db9 & v2dbc & v2dbf & v2dcb & v2dce & v2dd1 & v2dd4 & v2dd7 & v2dda & v2ddd & v2de0 & v2de2 & v2de5;
wire [7:0] va9 = 8'b11010110;
wire v2de7 = va9 == v1eb;
wire v2de8 = v3 == v316;
wire v2de9 = v4 == v11b;
wire v2dea = v2de7 & v2de8 & v2de9;
wire v2dfd = v2dea;
wire v2dfe = v2dfd;
wire [2:0] v2df5 = { v320 };
wire v2df6 = v2df5 == vc;
wire v2df7 = v2df6;
wire v2df8 = v2dea & v2df7;
wire v2df9 = v2df8;
wire [31:0] v2dec = v63a;
wire [31:0] pad_11757 = (v2dec[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v2ded = { pad_11757, v2dec };
wire [2:0] v2dee = { v1fa };
wire [31:0] v2def = ( v2dee == 3'd0) ? In_register_EAX : 
	( v2dee == 3'd1) ? In_register_ECX : 
	( v2dee == 3'd2) ? In_register_EDX : 
	( v2dee == 3'd3) ? In_register_EBX : 
	( v2dee == 3'd4) ? In_register_ESP : 
	( v2dee == 3'd5) ? In_register_EBP : 
	( v2dee == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2df1 = v2def;
wire [31:0] pad_11762 = (v2df1[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v2df2 = { pad_11762, v2df1 };
wire [63:0] v2df3 = v2ded * v2df2;
wire [31:0] v2df4 = v2df3[31:0];
wire [31:0] v2dfc = ( v8 ) ? In_register_ECX : v2df4;
wire [31:0] v2e00 = v2dfc;
wire v2e01 = v2e00 == Out_register_ECX;
wire [31:0] v2e03 = In_register_SSBASE;
wire v2e04 = v2e03 == Out_register_SSBASE;
wire [31:0] v2e06 = v10;
wire [31:0] v2e07 = In_register_EIP + v2e06;
wire [31:0] v2e09 = v2e07;
wire v2e0a = v2e09 == Out_register_EIP;
wire [31:0] v2e0c = In_register_CSBASE;
wire v2e0d = v2e0c == Out_register_CSBASE;
wire v2e0e = v2df5 == vb;
wire v2e0f = v2e0e;
wire v2e10 = v2dea & v2e0f;
wire v2e11 = v2e10;
wire [31:0] v2e14 = ( v8 ) ? In_register_ESP : v2df4;
wire [31:0] v2e16 = v2e14;
wire v2e17 = v2e16 == Out_register_ESP;
wire v2e18 = In_error_flag == Out_error_flag;
wire v2e19 = v2df5 == v7;
wire v2e1a = v2e19;
wire v2e1b = v2dea & v2e1a;
wire v2e1c = v2e1b;
wire [31:0] v2e1f = ( v8 ) ? In_register_EAX : v2df4;
wire [31:0] v2e21 = v2e1f;
wire v2e22 = v2e21 == Out_register_EAX;
wire [31:0] v2e24 = In_register_FSBASE;
wire v2e25 = v2e24 == Out_register_FSBASE;
wire v2e26 = v2df5 == ve;
wire v2e27 = v2e26;
wire v2e28 = v2dea & v2e27;
wire v2e29 = v2e28;
wire [31:0] v2e2c = ( v8 ) ? In_register_EDX : v2df4;
wire [31:0] v2e2e = v2e2c;
wire v2e2f = v2e2e == Out_register_EDX;
wire v2e30 = v2df5 == vf;
wire v2e31 = v2e30;
wire v2e32 = v2dea & v2e31;
wire v2e33 = v2e32;
wire [31:0] v2e36 = ( v8 ) ? In_register_EBP : v2df4;
wire [31:0] v2e38 = v2e36;
wire v2e39 = v2e38 == Out_register_EBP;
wire v2e3a = v2df5 == vd;
wire v2e3b = v2e3a;
wire v2e3c = v2dea & v2e3b;
wire v2e3d = v2e3c;
wire [31:0] v2e40 = ( v8 ) ? In_register_EBX : v2df4;
wire [31:0] v2e42 = v2e40;
wire v2e43 = v2e42 == Out_register_EBX;
wire v2e44 = v2df5 == v11;
wire v2e45 = v2e44;
wire v2e46 = v2dea & v2e45;
wire v2e47 = v2e46;
wire [31:0] v2e4a = ( v8 ) ? In_register_ESI : v2df4;
wire [31:0] v2e4c = v2e4a;
wire v2e4d = v2e4c == Out_register_ESI;
wire v2e4f = In_register_SF;
wire v2e50 = v2e4f == Out_register_SF;
wire [31:0] v2e52 = In_register_ESBASE;
wire v2e53 = v2e52 == Out_register_ESBASE;
wire [31:0] v2e55 = In_register_GSBASE;
wire v2e56 = v2e55 == Out_register_GSBASE;
wire v2e57 = v2df5 == v9;
wire v2e58 = v2e57;
wire v2e59 = v2dea & v2e58;
wire v2e5a = v2e59;
wire [31:0] v2e5d = ( v8 ) ? In_register_EDI : v2df4;
wire [31:0] v2e5f = v2e5d;
wire v2e60 = v2e5f == Out_register_EDI;
wire [63:0] v2e61 = v2df3 + v22;
wire v2e62 = v2e61 < v23;
wire v2e64 = v2e62;
wire v2e65 = v2e64 == Out_register_OF;
wire v2e67 = In_register_AF;
wire v2e68 = v2e67 == Out_register_AF;
wire v2e69 = v2e62;
wire v2e6a = v2e69 == Out_register_CF;
wire [31:0] v2e6c = In_register_DSBASE;
wire v2e6d = v2e6c == Out_register_DSBASE;
wire [7:0] v2e6f = In_register_DF;
wire v2e70 = v2e6f == Out_register_DF;
wire v2e72 = In_register_PF;
wire v2e73 = v2e72 == Out_register_PF;
wire v2e75 = In_register_ZF;
wire v2e76 = v2e75 == Out_register_ZF;
wire v2e77 = v15c & v2e01 & v2e04 & v2dfe & v2e0a & v2e0d & v2e17 & v2e18 & v2e22 & v2e25 & v2e2f & v2e39 & v2e43 & v2e4d & v2e50 & v2e53 & v2e56 & v2e60 & v2e65 & v2e68 & v2e6a & v2e6d & v2e70 & v2e73 & v2e76;
wire [7:0] vaa = 8'b10010101;
wire v2e78 = vaa == v1eb;
wire v2e79 = v47 == vb69;
wire v2e7a = v2e78 & v2e79;
wire v2e7b = v2e7a;
wire v2e7c = v2e7b;
wire [31:0] v2e7e = In_register_ECX;
wire v2e7f = v2e7e == Out_register_ECX;
wire [31:0] v2e81 = In_register_EDX;
wire v2e82 = v2e81 == Out_register_EDX;
wire v2e83 = In_error_flag == Out_error_flag;
wire v2e85 = v17;
wire v2e86 = v2e85 == Out_register_CF;
wire [31:0] v2e88 = In_register_EDI;
wire v2e89 = v2e88 == Out_register_EDI;
wire [31:0] v2e8b = In_register_DSBASE;
wire v2e8c = v2e8b == Out_register_DSBASE;
wire [31:0] v2e8e = In_register_EBX;
wire v2e8f = v2e8e == Out_register_EBX;
wire [31:0] v2e91 = In_register_EBP;
wire v2e92 = v2e91 == Out_register_EBP;
wire [31:0] v2e94 = In_register_ESP;
wire v2e95 = v2e94 == Out_register_ESP;
wire [7:0] v2e97 = In_register_DF;
wire v2e98 = v2e97 == Out_register_DF;
wire [31:0] v2e9a = v48;
wire [31:0] v2e9b = In_register_EIP + v2e9a;
wire [31:0] v2e9d = v2e9b;
wire v2e9e = v2e9d == Out_register_EIP;
wire [31:0] v2ea0 = In_register_ESI;
wire v2ea1 = v2ea0 == Out_register_ESI;
wire [31:0] v2ea3 = In_register_EAX;
wire v2ea4 = v2ea3 == Out_register_EAX;
wire [31:0] v2ea6 = In_register_CSBASE;
wire v2ea7 = v2ea6 == Out_register_CSBASE;
wire [31:0] v2ea9 = In_register_FSBASE;
wire v2eaa = v2ea9 == Out_register_FSBASE;
wire [31:0] v2eac = In_register_ESBASE;
wire v2ead = v2eac == Out_register_ESBASE;
wire [31:0] v2eaf = In_register_GSBASE;
wire v2eb0 = v2eaf == Out_register_GSBASE;
wire v2eb2 = In_register_AF;
wire v2eb3 = v2eb2 == Out_register_AF;
wire v2eb4 = v17;
wire v2eb5 = v2eb4 == Out_register_OF;
wire [31:0] v2eb7 = In_register_SSBASE;
wire v2eb8 = v2eb7 == Out_register_SSBASE;
wire [31:0] v2eba = vb74;
wire [31:0] v2ebc = In_register_EAX;
wire [31:0] v2ebd = v2eba & v2ebc;
wire [7:0] v2ebe = v2ebd[7:0];
wire [2:0] v2ebf_aux = v2ebe[0] + v2ebe[1] + v2ebe[2] + v2ebe[3] + v2ebe[4] + v2ebe[5] + v2ebe[6] + v2ebe[7];
wire v2ebf = { 5'b00000, v2ebf_aux };
wire [7:0] v2ec0 = v2ebf & v18;
wire [7:0] v2ec1 = v2ec0 ^ v18;
wire v2ec2 = v2ec1[0:0];
wire v2ec4 = v2ec2;
wire v2ec5 = v2ec4 == Out_register_PF;
wire v2ec6 = $signed(v2ebd) < $signed(v15);
wire v2ec8 = v2ec6;
wire v2ec9 = v2ec8 == Out_register_SF;
wire v2eca = v2ebd == v15;
wire v2ecc = v2eca;
wire v2ecd = v2ecc == Out_register_ZF;
wire v2ece = v2e7f & v2e82 & v2e83 & v2e86 & v2e89 & v2e8c & v15c & v2e7c & v2e8f & v2e92 & v2e95 & v2e98 & v2e9e & v2ea1 & v2ea4 & v2ea7 & v2eaa & v2ead & v2eb0 & v2eb3 & v2eb5 & v2eb8 & v2ec5 & v2ec9 & v2ecd;
wire [7:0] vab = 8'b11100011;
wire v2ecf = vab == v1eb;
wire v2ed0 = v68 == v1ed;
wire v2ed1 = v43 == vab3;
wire [2:0] v2ed2 = { v1fa };
wire v2ed3 = v2ed2 == vb;
wire v2ed4 = v2ed3;
wire v2ed5 = v2ed4 ^ v8;
wire [2:0] v2ed6 = { v1fa };
wire v2ed7 = v2ed6 == vb;
wire v2ed8 = v2ed7;
wire v2ed9 = v2ed8 ^ v8;
wire v2eda = v2ed5 & v2ed9;
wire v2edb = v2ecf & v2ed0 & v2ed1 & v2eda;
wire [15:0] vac = 16'b1110001100100010;
wire v2edc = vac == v117;
wire v2edd = v94 == v20a0;
wire v2ede = v51 == vdfc;
wire [2:0] v2edf = { v13c };
wire v2ee0 = v2edf == v7;
wire v2ee1 = v2edf == vc;
wire v2ee2 = v2edf == ve;
wire v2ee3 = v2edf == vd;
wire v2ee4 = v2edf == v11;
wire v2ee5 = v2edf == v9;
wire v2ee6 = v2ee0 | v2ee1 | v2ee2 | v2ee3 | v2ee4 | v2ee5;
wire v2ee7 = v2ee6 ^ v8;
wire v2ee8 = v2ee7;
wire v2ee9 = v2edc & v2edd & v2ede & v2ee8;
wire v2eea = vab == v1eb;
wire v2eeb = v25 == v1ed;
wire v2eec = v14 == v1ef;
wire [2:0] v2eed = { v1fa };
wire v2eee = v2eed == vb;
wire v2eef = v2eed == vf;
wire v2ef0 = v2eee | v2eef;
wire v2ef1 = v2ef0 ^ v8;
wire [2:0] v2ef2 = { v1fa };
wire v2ef3 = v2ef2 == vb;
wire v2ef4 = v2ef2 == vf;
wire v2ef5 = v2ef3 | v2ef4;
wire v2ef6 = v2ef5 ^ v8;
wire v2ef7 = v2ef1 & v2ef6;
wire v2ef8 = v2eea & v2eeb & v2eec & v2ef7;
wire [15:0] vad = 16'b1110001100100000;
wire v2ef9 = vad == v117;
wire v2efa = v43 == vab3;
wire [2:0] v2efb = { v13c };
wire v2efc = v2efb == vb;
wire v2efd = v2efb == vf;
wire v2efe = v2efc | v2efd;
wire v2eff = v2efe ^ v8;
wire [2:0] v2f00 = { v12c };
wire v2f01 = v2f00 == vb;
wire v2f02 = v2f01;
wire v2f03 = v2f02 ^ v8;
wire [2:0] v2f04 = { v13c };
wire v2f05 = v2f04 == vf;
wire v2f06 = v2f05;
wire v2f07 = v2f06 ^ v8;
wire v2f08 = v2eff & v2f03 & v2f07;
wire v2f09 = v2ef9 & v2efa & v2f08;
wire [15:0] vae = 16'b1110001110100000;
wire v2f0a = vae == v117;
wire [39:0] vaf = 40'b0000000000000000000000000000000000000000;
wire [39:0] v2f0b = instruction_bits[119: 80];
wire v2f0c = vaf == v2f0b;
wire v2f0d = v2f0a & v2f0c;
wire v2f0e = vad == v117;
wire v2f0f = v94 == v20a0;
wire v2f10 = v43 == vab3;
wire [2:0] v2f11 = { v13c };
wire v2f12 = v2f11 == vf;
wire v2f13 = v2f12;
wire v2f14 = v2f13 ^ v8;
wire [2:0] v2f15 = { v13c };
wire v2f16 = v2f15 == vf;
wire v2f17 = v2f16;
wire v2f18 = v2f17 ^ v8;
wire v2f19 = v2f14 & v2f18;
wire v2f1a = v2f0e & v2f0f & v2f10 & v2f19;
wire [18:0] vb0 = 19'b1110001100100000101;
wire v2f1b = vb0 == vdfa;
wire [31:0] v2f1c = instruction_bits[119: 88];
wire v2f1d = v15 == v2f1c;
wire v2f1e = v2f1b & v2f1d;
wire v2f1f = vab == v1eb;
wire v2f20 = v6a == v1ed;
wire v2f21 = vaf == v2f0b;
wire [2:0] v2f22 = { v1fa };
wire v2f23 = v2f22 == vb;
wire v2f24 = v2f23;
wire v2f25 = v2f24 ^ v8;
wire [2:0] v2f26 = { v1fa };
wire v2f27 = v2f26 == vb;
wire v2f28 = v2f27;
wire v2f29 = v2f28 ^ v8;
wire v2f2a = v2f25 & v2f29;
wire v2f2b = v2f1f & v2f20 & v2f21 & v2f2a;
wire [15:0] vb1 = 16'b1110001100100001;
wire v2f2c = vb1 == v117;
wire v2f2d = v15 == v2f1c;
wire [2:0] v2f2e = { v13c };
wire v2f2f = v2f2e == v7;
wire v2f30 = v2f2e == vc;
wire v2f31 = v2f2e == ve;
wire v2f32 = v2f2e == vd;
wire v2f33 = v2f2e == v11;
wire v2f34 = v2f2e == v9;
wire v2f35 = v2f2f | v2f30 | v2f31 | v2f32 | v2f33 | v2f34;
wire v2f36 = v2f35 ^ v8;
wire [2:0] v2f37 = { v12c };
wire v2f38 = v2f37 == vb;
wire v2f39 = v2f38;
wire v2f3a = v2f39 ^ v8;
wire v2f3b = v2f36 & v2f3a;
wire v2f3c = v2f2c & v2f2d & v2f3b;
wire v2f3d = v2edb | v2ee9 | v2ef8 | v2f09 | v2f0d | v2f1a | v2f1e | v2f2b | v2f3c;
wire v2f3e = v2f3d;
wire [31:0] v2f40 = In_register_ESBASE;
wire v2f41 = v2f40 == Out_register_ESBASE;
wire [31:0] v2f43 = In_register_SSBASE;
wire v2f44 = v2f43 == Out_register_SSBASE;
wire [31:0] v2f46 = In_register_EAX;
wire v2f47 = v2f46 == Out_register_EAX;
wire v2f48 = In_error_flag == Out_error_flag;
wire [31:0] v2f4a = In_register_ESI;
wire v2f4b = v2f4a == Out_register_ESI;
wire v2f4d = In_register_OF;
wire v2f4e = v2f4d == Out_register_OF;
wire [31:0] v2f50 = In_register_GSBASE;
wire v2f51 = v2f50 == Out_register_GSBASE;
wire [31:0] v2f53 = In_register_EBX;
wire v2f54 = v2f53 == Out_register_EBX;
wire v2f56 = In_register_ZF;
wire v2f57 = v2f56 == Out_register_ZF;
wire [31:0] vb3 = 32'b11010000000000000000000000000000;
wire [31:0] vb2 = 32'b01010000000000000000000000000000;
wire [31:0] v2f61 = ( v2edb | v2f09 | v2f1a ) ? v45 : 
	( v2ee9 ) ? v31 : 
	( v2ef8 ) ? v16 : 
	( v2f1e | v2f3c ) ? vb3 : vb2;
wire [31:0] v2f62 = In_register_EIP + v2f61;
wire [31:0] v2f64 = v2f62;
wire v2f65 = v2f64 == Out_register_EIP;
wire [31:0] v2f67 = In_register_FSBASE;
wire v2f68 = v2f67 == Out_register_FSBASE;
wire [31:0] v2f6a = In_register_ESP;
wire v2f6b = v2f6a == Out_register_ESP;
wire [31:0] v2f6d = In_register_ECX;
wire v2f6e = v2f6d == Out_register_ECX;
wire [31:0] v2f70 = In_register_DSBASE;
wire v2f71 = v2f70 == Out_register_DSBASE;
wire [31:0] v2f73 = In_register_EDI;
wire v2f74 = v2f73 == Out_register_EDI;
wire v2f76 = In_register_CF;
wire v2f77 = v2f76 == Out_register_CF;
wire [31:0] v2f79 = In_register_EDX;
wire v2f7a = v2f79 == Out_register_EDX;
wire v2f7c = In_register_PF;
wire v2f7d = v2f7c == Out_register_PF;
wire [31:0] v2f7f = In_register_EBP;
wire v2f80 = v2f7f == Out_register_EBP;
wire [2:0] v2f81 = { v1fa };
wire [31:0] v2f82 = ( v2f81 == 3'd0) ? In_register_EAX : 
	( v2f81 == 3'd1) ? In_register_ECX : 
	( v2f81 == 3'd2) ? In_register_EDX : 
	( v2f81 == 3'd3) ? In_register_EBX : 
	( v2f81 == 3'd4) ? v15 : 
	( v2f81 == 3'd5) ? In_register_EBP : 
	( v2f81 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2f83 = v2f82 + v63a;
wire [2:0] v2f85 = { v13c };
wire [31:0] v2f86 = ( v2f85 == 3'd0) ? v15 : 
	( v2f85 == 3'd1) ? v15 : 
	( v2f85 == 3'd2) ? v15 : 
	( v2f85 == 3'd3) ? v15 : 
	( v2f85 == 3'd4) ? In_register_ESP : 
	( v2f85 == 3'd5) ? In_register_EBP : 
	( v2f85 == 3'd6) ? v15 : v15;
wire [31:0] v2f87 = v2f86 + v7f8;
wire [2:0] v2f8c = { v13c };
wire [31:0] v2f8d = ( v2f8c == 3'd0) ? In_register_EAX : 
	( v2f8c == 3'd1) ? In_register_ECX : 
	( v2f8c == 3'd2) ? In_register_EDX : 
	( v2f8c == 3'd3) ? In_register_EBX : 
	( v2f8c == 3'd4) ? v15 : 
	( v2f8c == 3'd5) ? v15 : 
	( v2f8c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v2f8e = { v12c };
wire [31:0] v2f8f = ( v2f8e == 3'd0) ? In_register_EAX : 
	( v2f8e == 3'd1) ? In_register_ECX : 
	( v2f8e == 3'd2) ? In_register_EDX : 
	( v2f8e == 3'd3) ? In_register_EBX : 
	( v2f8e == 3'd4) ? v15 : 
	( v2f8e == 3'd5) ? In_register_EBP : 
	( v2f8e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2f90 = v2f8f << v7f4;
wire [31:0] v2f91 = v2f8d + v2f90;
wire [2:0] v2f97 = { v12c };
wire [31:0] v2f98 = ( v2f97 == 3'd0) ? In_register_EAX : 
	( v2f97 == 3'd1) ? In_register_ECX : 
	( v2f97 == 3'd2) ? In_register_EDX : 
	( v2f97 == 3'd3) ? In_register_EBX : 
	( v2f97 == 3'd4) ? v15 : 
	( v2f97 == 3'd5) ? In_register_EBP : 
	( v2f97 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2f99 = v2f98 << v7f4;
wire [31:0] v2f9a = v2f99 + vc2d;
wire [2:0] v2f9c = { v1fa };
wire [31:0] v2f9d = ( v2f9c == 3'd0) ? In_register_EAX : 
	( v2f9c == 3'd1) ? In_register_ECX : 
	( v2f9c == 3'd2) ? In_register_EDX : 
	( v2f9c == 3'd3) ? In_register_EBX : 
	( v2f9c == 3'd4) ? v15 : 
	( v2f9c == 3'd5) ? In_register_EBP : 
	( v2f9c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2f9e = v2f9d + v1f7;
wire [2:0] v2fa0 = { v13c };
wire [31:0] v2fa1 = ( v2fa0 == 3'd0) ? v15 : 
	( v2fa0 == 3'd1) ? v15 : 
	( v2fa0 == 3'd2) ? v15 : 
	( v2fa0 == 3'd3) ? v15 : 
	( v2fa0 == 3'd4) ? In_register_ESP : 
	( v2fa0 == 3'd5) ? In_register_EBP : 
	( v2fa0 == 3'd6) ? v15 : v15;
wire [2:0] v2fa2 = { v12c };
wire [31:0] v2fa3 = ( v2fa2 == 3'd0) ? In_register_EAX : 
	( v2fa2 == 3'd1) ? In_register_ECX : 
	( v2fa2 == 3'd2) ? In_register_EDX : 
	( v2fa2 == 3'd3) ? In_register_EBX : 
	( v2fa2 == 3'd4) ? v15 : 
	( v2fa2 == 3'd5) ? In_register_EBP : 
	( v2fa2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2fa4 = v2fa3 << v7f4;
wire [31:0] v2fa5 = v2fa1 + v2fa4;
wire [31:0] v2fa6 = v2fa5 + vc2d;
wire [2:0] v2f94 = { v13c };
wire [31:0] v2f95 = ( v2f94 == 3'd0) ? In_register_EAX : 
	( v2f94 == 3'd1) ? In_register_ECX : 
	( v2f94 == 3'd2) ? In_register_EDX : 
	( v2f94 == 3'd3) ? In_register_EBX : 
	( v2f94 == 3'd4) ? In_register_ESP : 
	( v2f94 == 3'd5) ? v15 : 
	( v2f94 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v2f89 = { v1fa };
wire [31:0] v2f8a = ( v2f89 == 3'd0) ? In_register_EAX : 
	( v2f89 == 3'd1) ? In_register_ECX : 
	( v2f89 == 3'd2) ? In_register_EDX : 
	( v2f89 == 3'd3) ? In_register_EBX : 
	( v2f89 == 3'd4) ? v15 : 
	( v2f89 == 3'd5) ? v15 : 
	( v2f89 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v2fa8 = ( v2edb ) ? v2f83 : 
	( v2ee9 ) ? v2f87 : 
	( v2f09 ) ? v2f91 : 
	( v2f1e ) ? v2f9a : 
	( v2f2b ) ? v2f9e : 
	( v2f3c ) ? v2fa6 : 
	( v2f1a ) ? v2f95 : 
	( v2ef8 ) ? v2f8a : v1f7;
wire [31:0] v2faa = instruction_bits[63: 32];
wire [31:0] v2fb1 = instruction_bits[87: 56];
wire [31:0] v2fae = instruction_bits[79: 48];
wire [31:0] v2fb5 = ( v2edb | v2f09 | v2f1a ) ? vc2d : 
	( v2ee9 ) ? v2faa : 
	( v2f1e | v2f3c ) ? v2fb1 : 
	( v2f0d | v2f2b ) ? v2fae : v1f7;
wire v2fb6 =  v26 == memory_0[15: 12] && v2fa8 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v2fb5 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] v2fb8 = In_register_CSBASE;
wire v2fb9 = v2fb8 == Out_register_CSBASE;
wire [7:0] v2fbb = In_register_DF;
wire v2fbc = v2fbb == Out_register_DF;
wire v2fbe = In_register_AF;
wire v2fbf = v2fbe == Out_register_AF;
wire v2fc1 = In_register_SF;
wire v2fc2 = v2fc1 == Out_register_SF;
wire v2fc3 = v2f3e & v2f41 & v2f44 & v2f47 & v2f48 & v2f4b & v15c & v2f4e & v2f51 & v2f54 & v2f57 & v2f65 & v2f68 & v2f6b & v2f6e & v2f71 & v2f74 & v2f77 & v2f7a & v2f7d & v2f80 & v2fb6 & v2fb9 & v2fbc & v2fbf & v2fc2;
wire [7:0] vb4 = 8'b01001100;
wire v2fd1 = vb4 == v1eb;
wire v2fd2 = v3 == v316;
wire v2fd3 = v1b == v318;
wire v2fd4 = v2fd1 & v2fd2 & v2fd3;
wire v2fe9 = v2fd4;
wire v2fea = v2fe9;
wire [2:0] v2fc4 = { v1fa };
wire [31:0] v2fc5 = ( v2fc4 == 3'd0) ? In_register_EAX : 
	( v2fc4 == 3'd1) ? In_register_ECX : 
	( v2fc4 == 3'd2) ? In_register_EDX : 
	( v2fc4 == 3'd3) ? In_register_EBX : 
	( v2fc4 == 3'd4) ? In_register_EAX : 
	( v2fc4 == 3'd5) ? In_register_ECX : 
	( v2fc4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2fc6 = { v1fa };
wire v2fc7 = v2fc6 == vb;
wire v2fc8 = v2fc6 == v9;
wire v2fc9 = v2fc7 | v2fc8;
wire v2fca = v2fc6 == vf;
wire v2fcb = v2fc9 | v2fca;
wire v2fcc = v2fc6 == v11;
wire v2fcd = v2fcb | v2fcc;
wire [31:0] v2fce = ( v2fcd == 1'd0) ? v15 : v31;
wire [31:0] v2fcf = v2fc5 >> v2fce;
wire [31:0] v2fd0 = v2fcf & v32;
wire [31:0] v2fd6 = v2fd0;
wire [2:0] v2fd7 = { v320 };
wire [31:0] v2fd8 = ( v2fd7 == 3'd0) ? In_register_EAX : 
	( v2fd7 == 3'd1) ? In_register_ECX : 
	( v2fd7 == 3'd2) ? In_register_EDX : 
	( v2fd7 == 3'd3) ? In_register_EBX : 
	( v2fd7 == 3'd4) ? In_register_EAX : 
	( v2fd7 == 3'd5) ? In_register_ECX : 
	( v2fd7 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v2fd9 = { v320 };
wire v2fda = v2fd9 == vb;
wire v2fdb = v2fd9 == v9;
wire v2fdc = v2fda | v2fdb;
wire v2fdd = v2fd9 == vf;
wire v2fde = v2fdc | v2fdd;
wire v2fdf = v2fd9 == v11;
wire v2fe0 = v2fde | v2fdf;
wire [31:0] v2fe1 = ( v2fe0 == 1'd0) ? v15 : v31;
wire [31:0] v2fe2 = v2fd8 >> v2fe1;
wire [31:0] v2fe3 = v2fe2 & v32;
wire [31:0] v2fe5 = v2fe3;
wire [31:0] v2fe6 = v2fd6 ^ v2fe5;
wire [7:0] v2fe7 = v2fe6[7:0];
wire v2fe8 = $signed(v2fe7) < $signed(v2c);
wire v2fec = v2fe8;
wire v2fed = v2fec == Out_register_SF;
wire [31:0] v2fef = In_register_FSBASE;
wire v2ff0 = v2fef == Out_register_FSBASE;
wire [2:0] v2ff3 = { v320 };
wire v2ff4 = v2ff3 == v7;
wire v2ff5 = v2ff4;
wire v2ff6 = v2fd4 & v2ff5;
wire v2ff7 = v2ff6;
wire [31:0] v2ff1 = { 24'b000000000000000000000000, v2fe7 };
wire [31:0] v2ff2 = v5c8 | v2ff1;
wire v2ffb = v2ff3 == vb;
wire v2ffc = v2ffb;
wire v2ffd = v2fd4 & v2ffc;
wire v2ffe = v2ffd;
wire [31:0] v2ff9 = v2ff1 << v31;
wire [31:0] v2ffa = v752 | v2ff9;
wire [31:0] v3001 = ( v8 ) ? In_register_EAX : 
	( v2ff7 ) ? v2ff2 : v2ffa;
wire [31:0] v3003 = v3001;
wire v3004 = v3003 == Out_register_EAX;
wire [31:0] v3006 = In_register_EDI;
wire v3007 = v3006 == Out_register_EDI;
wire v3009 = v17;
wire v300a = v3009 == Out_register_CF;
wire v300c = v2ff3 == vd;
wire v300d = v300c;
wire v300e = v2fd4 & v300d;
wire v300f = v300e;
wire [31:0] v300b = v7b8 | v2ff1;
wire v3012 = v2ff3 == v9;
wire v3013 = v3012;
wire v3014 = v2fd4 & v3013;
wire v3015 = v3014;
wire [31:0] v3011 = v7c8 | v2ff9;
wire [31:0] v3018 = ( v8 ) ? In_register_EBX : 
	( v300f ) ? v300b : v3011;
wire [31:0] v301a = v3018;
wire v301b = v301a == Out_register_EBX;
wire [31:0] v301d = In_register_DSBASE;
wire v301e = v301d == Out_register_DSBASE;
wire [7:0] v3020 = In_register_DF;
wire v3021 = v3020 == Out_register_DF;
wire v3022 = v17;
wire v3023 = v3022 == Out_register_OF;
wire v3025 = v2ff3 == ve;
wire v3026 = v3025;
wire v3027 = v2fd4 & v3026;
wire v3028 = v3027;
wire [31:0] v3024 = v768 | v2ff1;
wire v302b = v2ff3 == v11;
wire v302c = v302b;
wire v302d = v2fd4 & v302c;
wire v302e = v302d;
wire [31:0] v302a = v778 | v2ff9;
wire [31:0] v3031 = ( v8 ) ? In_register_EDX : 
	( v3028 ) ? v3024 : v302a;
wire [31:0] v3033 = v3031;
wire v3034 = v3033 == Out_register_EDX;
wire [31:0] v3036 = In_register_ESI;
wire v3037 = v3036 == Out_register_ESI;
wire [31:0] v3039 = v1c;
wire [31:0] v303a = In_register_EIP + v3039;
wire [31:0] v303c = v303a;
wire v303d = v303c == Out_register_EIP;
wire [31:0] v303f = In_register_ESP;
wire v3040 = v303f == Out_register_ESP;
wire [31:0] v3042 = In_register_SSBASE;
wire v3043 = v3042 == Out_register_SSBASE;
wire [31:0] v3045 = In_register_CSBASE;
wire v3046 = v3045 == Out_register_CSBASE;
wire [31:0] v3048 = In_register_ESBASE;
wire v3049 = v3048 == Out_register_ESBASE;
wire v304b = v2ff3 == vf;
wire v304c = v304b;
wire v304d = v2fd4 & v304c;
wire v304e = v304d;
wire [31:0] v304a = v790 | v2ff9;
wire v3051 = v2ff3 == vc;
wire v3052 = v3051;
wire v3053 = v2fd4 & v3052;
wire v3054 = v3053;
wire [31:0] v3050 = v7a0 | v2ff1;
wire [31:0] v3057 = ( v8 ) ? In_register_ECX : 
	( v304e ) ? v304a : v3050;
wire [31:0] v3059 = v3057;
wire v305a = v3059 == Out_register_ECX;
wire [31:0] v305c = In_register_GSBASE;
wire v305d = v305c == Out_register_GSBASE;
wire [31:0] v305f = In_register_EBP;
wire v3060 = v305f == Out_register_EBP;
wire v3062 = In_register_AF;
wire v3063 = v3062 == Out_register_AF;
wire v3064 = In_error_flag == Out_error_flag;
wire [2:0] v3065_aux = v2fe7[0] + v2fe7[1] + v2fe7[2] + v2fe7[3] + v2fe7[4] + v2fe7[5] + v2fe7[6] + v2fe7[7];
wire v3065 = { 5'b00000, v3065_aux };
wire [7:0] v3066 = v3065 & v18;
wire [7:0] v3067 = v3066 ^ v18;
wire v3068 = v3067[0:0];
wire v306a = v3068;
wire v306b = v306a == Out_register_PF;
wire v306c = v2fe7 == v2c;
wire v306e = v306c;
wire v306f = v306e == Out_register_ZF;
wire v3070 = v2fed & v15c & v2ff0 & v3004 & v2fea & v3007 & v300a & v301b & v301e & v3021 & v3023 & v3034 & v3037 & v303d & v3040 & v3043 & v3046 & v3049 & v305a & v305d & v3060 & v3063 & v3064 & v306b & v306f;
wire [7:0] vb5 = 8'b00010101;
wire v3071 = vb5 == v1eb;
wire v3072 = v1b == v318;
wire v3073 = v3071 & v3072;
wire v3074 = v3073;
wire v3075 = v3074;
wire [31:0] v3077 = In_register_EAX;
wire v3078 = v3077 == Out_register_EAX;
wire [31:0] v307a = In_register_EDI;
wire v307b = v307a == Out_register_EDI;
wire [31:0] v307d = v1c;
wire [31:0] v307e = In_register_EIP + v307d;
wire [31:0] v3080 = v307e;
wire v3081 = v3080 == Out_register_EIP;
wire [31:0] v3083 = In_register_EBX;
wire v3084 = v3083 == Out_register_EBX;
wire v3085 = In_error_flag == Out_error_flag;
wire v3087 = In_register_AF;
wire v3088 = v3087 == Out_register_AF;
wire [31:0] v308a = In_register_ESP;
wire v308b = v308a == Out_register_ESP;
wire [31:0] v308d = In_register_EDX;
wire v308e = v308d == Out_register_EDX;
wire [31:0] v3090 = In_register_EBP;
wire v3091 = v3090 == Out_register_EBP;
wire [31:0] v3093 = In_register_ESI;
wire v3094 = v3093 == Out_register_ESI;
wire [31:0] v3096 = In_register_ECX;
wire v3097 = v3096 == Out_register_ECX;
wire [31:0] v3099 = In_register_CSBASE;
wire v309a = v3099 == Out_register_CSBASE;
wire [31:0] v309c = In_register_SSBASE;
wire v309d = v309c == Out_register_SSBASE;
wire [31:0] v309f = In_register_ESBASE;
wire v30a0 = v309f == Out_register_ESBASE;
wire [31:0] v30a2 = In_register_GSBASE;
wire v30a3 = v30a2 == Out_register_GSBASE;
wire [31:0] v30a5 = In_register_DSBASE;
wire v30a6 = v30a5 == Out_register_DSBASE;
wire [31:0] v30a8 = In_register_FSBASE;
wire v30a9 = v30a8 == Out_register_FSBASE;
wire [31:0] v30ab = v477;
wire [31:0] v30ad = vf4b;
wire [31:0] v30ae = v30ab & v30ad;
wire [7:0] v30af = v30ae[7:0];
wire v30b0 = v30af == v2c;
wire v30b2 = v30b0;
wire v30b3 = v30b2 == Out_register_ZF;
wire v30b5 = v17;
wire v30b6 = v30b5 == Out_register_CF;
wire [7:0] v30b8 = In_register_DF;
wire v30b9 = v30b8 == Out_register_DF;
wire v30ba = v17;
wire v30bb = v30ba == Out_register_OF;
wire v30bc = $signed(v30af) < $signed(v2c);
wire v30be = v30bc;
wire v30bf = v30be == Out_register_SF;
wire [2:0] v30c0_aux = v30af[0] + v30af[1] + v30af[2] + v30af[3] + v30af[4] + v30af[5] + v30af[6] + v30af[7];
wire v30c0 = { 5'b00000, v30c0_aux };
wire [7:0] v30c1 = v30c0 & v18;
wire [7:0] v30c2 = v30c1 ^ v18;
wire v30c3 = v30c2[0:0];
wire v30c5 = v30c3;
wire v30c6 = v30c5 == Out_register_PF;
wire v30c7 = v3075 & v3078 & v307b & v3081 & v3084 & v3085 & v15c & v3088 & v308b & v308e & v3091 & v3094 & v3097 & v309a & v309d & v30a0 & v30a3 & v30a6 & v30a9 & v30b3 & v30b6 & v30b9 & v30bb & v30bf & v30c6;
wire v30c8 = v71 == v1eb;
wire [4:0] vb6 = 5'b01110;
wire v30c9 = vb6 == v1ed;
wire v30ca = v4 == v11b;
wire [2:0] v30cb = { v1fa };
wire v30cc = v30cb == vb;
wire v30cd = v30cc;
wire v30ce = v30cd ^ v8;
wire [2:0] v30cf = { v1fa };
wire v30d0 = v30cf == vb;
wire v30d1 = v30d0;
wire v30d2 = v30d1 ^ v8;
wire v30d3 = v30ce & v30d2;
wire v30d4 = v30c8 & v30c9 & v30ca & v30d3;
wire v30d5 = v71 == v1eb;
wire [4:0] vb7 = 5'b01100;
wire v30d6 = vb7 == v1ed;
wire v30d7 = v1b == v318;
wire [2:0] v30d8 = { v1fa };
wire v30d9 = v30d8 == vb;
wire v30da = v30d8 == vf;
wire v30db = v30d9 | v30da;
wire v30dc = v30db ^ v8;
wire [2:0] v30dd = { v1fa };
wire v30de = v30dd == vb;
wire v30df = v30dd == vf;
wire v30e0 = v30de | v30df;
wire v30e1 = v30e0 ^ v8;
wire v30e2 = v30dc & v30e1;
wire v30e3 = v30d5 & v30d6 & v30d7 & v30e2;
wire v30e4 = v30d4 | v30e3;
wire v30e5 = v30e4;
wire v30e6 = In_error_flag == Out_error_flag;
wire [31:0] v30e7 = memory_0[79: 48];
wire v30e8 = v30e7 == v15;
wire v30e9 = v30e8 ^ v8;
wire [63:0] v30ea = { 32'b00000000000000000000000000000000, In_register_EDX };
wire [63:0] v30eb = v30ea << v96;
wire [63:0] v30ec = v30eb | v2650;
wire [63:0] v30ed = { 32'b00000000000000000000000000000000, v30e7 };
wire [63:0] v30ee = v30ec / v30ed;
wire [63:0] vb8 = 64'b0000000000000000000000000000000010000000000000000000000000000000;
wire v30ef = v30ee < vb8;
wire v30f0 = v30e9 & v30ef;
wire [31:0] v30f1 = v30ee[31:0];
wire [31:0] v30f2 = ( v30f0 == 1'd0) ? In_register_EAX : v30f1;
wire [31:0] v30f4 = v30f2;
wire v30f5 = v30f4 == Out_register_EAX;
wire [31:0] v30f7 = In_register_DSBASE;
wire v30f8 = v30f7 == Out_register_DSBASE;
wire [31:0] v30fa = In_register_EBX;
wire v30fb = v30fa == Out_register_EBX;
wire [63:0] v30fc = v30ec % v30ed;
wire [31:0] v30fd = v30fc[31:0];
wire [31:0] v30fe = ( v30f0 == 1'd0) ? In_register_EDX : v30fd;
wire [31:0] v3100 = v30fe;
wire v3101 = v3100 == Out_register_EDX;
wire [31:0] v3103 = In_register_ESP;
wire v3104 = v3103 == Out_register_ESP;
wire [31:0] v3106 = In_register_ESI;
wire v3107 = v3106 == Out_register_ESI;
wire [31:0] v3109 = In_register_ECX;
wire v310a = v3109 == Out_register_ECX;
wire [7:0] v310b = ( v30f0 == 1'd0) ? v65f : v28a8;
wire v310c = v310b[0:0];
wire v310e = v310c;
wire v310f = v310e == Out_register_CF;
wire [31:0] v3111 = In_register_EBP;
wire v3112 = v3111 == Out_register_EBP;
wire [31:0] v3114 = In_register_EDI;
wire v3115 = v3114 == Out_register_EDI;
wire [31:0] v3118 = ( v30e3 ) ? v1c : v10;
wire [31:0] v3119 = In_register_EIP + v3118;
wire [31:0] v311c = v3119;
wire [31:0] v311e = v311c;
wire v311f = v311e == Out_register_EIP;
wire [31:0] v3121 = In_register_CSBASE;
wire v3122 = v3121 == Out_register_CSBASE;
wire [31:0] v3124 = In_register_SSBASE;
wire v3125 = v3124 == Out_register_SSBASE;
wire [31:0] v3127 = In_register_ESBASE;
wire v3128 = v3127 == Out_register_ESBASE;
wire [31:0] v312a = In_register_GSBASE;
wire v312b = v312a == Out_register_GSBASE;
wire [31:0] v312d = In_register_FSBASE;
wire v312e = v312d == Out_register_FSBASE;
wire [7:0] v312f = ( v30f0 == 1'd0) ? v2870 : v2871;
wire v3130 = v312f[0:0];
wire v3132 = v3130;
wire v3133 = v3132 == Out_register_AF;
wire [7:0] v3135 = In_register_DF;
wire v3136 = v3135 == Out_register_DF;
wire [7:0] v3137 = ( v30f0 == 1'd0) ? v28c3 : v28c4;
wire v3138 = v3137[0:0];
wire v313a = v3138;
wire v313b = v313a == Out_register_OF;
wire [2:0] v313c = { v1fa };
wire [31:0] v313d = ( v313c == 3'd0) ? In_register_EAX : 
	( v313c == 3'd1) ? In_register_ECX : 
	( v313c == 3'd2) ? In_register_EDX : 
	( v313c == 3'd3) ? In_register_EBX : 
	( v313c == 3'd4) ? v15 : 
	( v313c == 3'd5) ? In_register_EBP : 
	( v313c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v313e = v313d + v63a;
wire [2:0] v3140 = { v1fa };
wire [31:0] v3141 = ( v3140 == 3'd0) ? In_register_EAX : 
	( v3140 == 3'd1) ? In_register_ECX : 
	( v3140 == 3'd2) ? In_register_EDX : 
	( v3140 == 3'd3) ? In_register_EBX : 
	( v3140 == 3'd4) ? v15 : 
	( v3140 == 3'd5) ? v15 : 
	( v3140 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3143 = ( v30d4 ) ? v313e : v3141;
wire v3144 =  v26 == memory_0[15: 12] && v3143 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] v3145 = ( v30f0 == 1'd0) ? vd06 : v28ca;
wire v3146 = v3145[0:0];
wire v3148 = v3146;
wire v3149 = v3148 == Out_register_PF;
wire [7:0] v314a = ( v30f0 == 1'd0) ? v1d85 : v28d0;
wire v314b = v314a[0:0];
wire v314d = v314b;
wire v314e = v314d == Out_register_SF;
wire [7:0] v314f = ( v30f0 == 1'd0) ? v289b : v289c;
wire v3150 = v314f[0:0];
wire v3152 = v3150;
wire v3153 = v3152 == Out_register_ZF;
wire v3154 = v30e5 & v30e6 & v30f5 & v15c & v30f8 & v30fb & v3101 & v3104 & v3107 & v310a & v310f & v3112 & v3115 & v311f & v3122 & v3125 & v3128 & v312b & v312e & v3133 & v3136 & v313b & v3144 & v3149 & v314e & v3153;
wire [7:0] vb9 = 8'b11001100;
wire v3158 = vb9 == v1eb;
wire v3159 = v30 == v316;
wire v315a = v4 == v11b;
wire [2:0] v315b = { v1fa };
wire v315c = v315b == vb;
wire v315d = v315c;
wire v315e = v315d ^ v8;
wire [2:0] v315f = { v1fa };
wire v3160 = v315f == vb;
wire v3161 = v3160;
wire v3162 = v3161 ^ v8;
wire v3163 = v315e & v3162;
wire v3164 = v3158 & v3159 & v315a & v3163;
wire v3168 = vb9 == v1eb;
wire v3169 = v2f == v316;
wire v316a = v14 == v1ef;
wire [2:0] v316b = { v1fa };
wire v316c = v316b == vb;
wire v316d = v316b == vf;
wire v316e = v316c | v316d;
wire v316f = v316e ^ v8;
wire [2:0] v3170 = { v1fa };
wire v3171 = v3170 == vb;
wire v3172 = v3171;
wire v3173 = v3172 ^ v8;
wire v3174 = v316f & v3173;
wire v3175 = v3168 & v3169 & v316a & v3174;
wire v3185 = v3164 | v3175;
wire v3186 = v3185;
wire [2:0] v3179 = { v320 };
wire v317a = v3179 == vd;
wire v317b = v317a;
wire v317c = v3164 & v317b;
wire [2:0] v317d = { v320 };
wire v317e = v317d == vd;
wire v317f = v317e;
wire v3180 = v3175 & v317f;
wire v3181 = v317c | v3180;
wire [31:0] v3155 = memory_0[79: 48];
wire [2:0] v3156 = { v320 };
wire [31:0] v3157 = ( v3156 == 3'd0) ? In_register_EAX : 
	( v3156 == 3'd1) ? In_register_ECX : 
	( v3156 == 3'd2) ? In_register_EDX : 
	( v3156 == 3'd3) ? In_register_EBX : 
	( v3156 == 3'd4) ? In_register_ESP : 
	( v3156 == 3'd5) ? In_register_EBP : 
	( v3156 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v3166 = { v320 };
wire [31:0] v3167 = ( v3166 == 3'd0) ? In_register_EAX : 
	( v3166 == 3'd1) ? In_register_ECX : 
	( v3166 == 3'd2) ? In_register_EDX : 
	( v3166 == 3'd3) ? In_register_EBX : 
	( v3166 == 3'd4) ? In_register_ESP : 
	( v3166 == 3'd5) ? In_register_EBP : 
	( v3166 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3177 = ( v3164 ) ? v3157 : v3167;
wire [31:0] v3178 = v3155 ^ v3177;
wire [31:0] v3184 = ( v8 ) ? In_register_EBX : v3178;
wire [31:0] v3188 = v3184;
wire v3189 = v3188 == Out_register_EBX;
wire v318a = v3179 == vb;
wire v318b = v318a;
wire v318c = v3164 & v318b;
wire v318d = v317d == vb;
wire v318e = v318d;
wire v318f = v3175 & v318e;
wire v3190 = v318c | v318f;
wire [31:0] v3193 = ( v8 ) ? In_register_ESP : v3178;
wire [31:0] v3195 = v3193;
wire v3196 = v3195 == Out_register_ESP;
wire v3197 = v3179 == v7;
wire v3198 = v3197;
wire v3199 = v3164 & v3198;
wire v319a = v317d == v7;
wire v319b = v319a;
wire v319c = v3175 & v319b;
wire v319d = v3199 | v319c;
wire [31:0] v31a0 = ( v8 ) ? In_register_EAX : v3178;
wire [31:0] v31a2 = v31a0;
wire v31a3 = v31a2 == Out_register_EAX;
wire v31a5 = v17;
wire v31a6 = v31a5 == Out_register_CF;
wire v31a7 = v3179 == vc;
wire v31a8 = v31a7;
wire v31a9 = v3164 & v31a8;
wire v31aa = v317d == vc;
wire v31ab = v31aa;
wire v31ac = v3175 & v31ab;
wire v31ad = v31a9 | v31ac;
wire [31:0] v31b0 = ( v8 ) ? In_register_ECX : v3178;
wire [31:0] v31b2 = v31b0;
wire v31b3 = v31b2 == Out_register_ECX;
wire v31b4 = v3179 == ve;
wire v31b5 = v31b4;
wire v31b6 = v3164 & v31b5;
wire v31b7 = v317d == ve;
wire v31b8 = v31b7;
wire v31b9 = v3175 & v31b8;
wire v31ba = v31b6 | v31b9;
wire [31:0] v31bd = ( v8 ) ? In_register_EDX : v3178;
wire [31:0] v31bf = v31bd;
wire v31c0 = v31bf == Out_register_EDX;
wire [31:0] v31c2 = In_register_ESBASE;
wire v31c3 = v31c2 == Out_register_ESBASE;
wire v31c4 = In_error_flag == Out_error_flag;
wire v31c5 = v3179 == v9;
wire v31c6 = v31c5;
wire v31c7 = v3164 & v31c6;
wire v31c8 = v317d == v9;
wire v31c9 = v31c8;
wire v31ca = v3175 & v31c9;
wire v31cb = v31c7 | v31ca;
wire [31:0] v31ce = ( v8 ) ? In_register_EDI : v3178;
wire [31:0] v31d0 = v31ce;
wire v31d1 = v31d0 == Out_register_EDI;
wire v31d2 = v3179 == vf;
wire v31d3 = v31d2;
wire v31d4 = v3164 & v31d3;
wire v31d5 = v317d == vf;
wire v31d6 = v31d5;
wire v31d7 = v3175 & v31d6;
wire v31d8 = v31d4 | v31d7;
wire [31:0] v31db = ( v8 ) ? In_register_EBP : v3178;
wire [31:0] v31dd = v31db;
wire v31de = v31dd == Out_register_EBP;
wire [2:0] v31df = { v1fa };
wire [31:0] v31e0 = ( v31df == 3'd0) ? In_register_EAX : 
	( v31df == 3'd1) ? In_register_ECX : 
	( v31df == 3'd2) ? In_register_EDX : 
	( v31df == 3'd3) ? In_register_EBX : 
	( v31df == 3'd4) ? v15 : 
	( v31df == 3'd5) ? In_register_EBP : 
	( v31df == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v31e1 = v31e0 + v63a;
wire [2:0] v31e3 = { v1fa };
wire [31:0] v31e4 = ( v31e3 == 3'd0) ? In_register_EAX : 
	( v31e3 == 3'd1) ? In_register_ECX : 
	( v31e3 == 3'd2) ? In_register_EDX : 
	( v31e3 == 3'd3) ? In_register_EBX : 
	( v31e3 == 3'd4) ? v15 : 
	( v31e3 == 3'd5) ? v15 : 
	( v31e3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v31e5 = v31e4 + v1f7;
wire [31:0] v31e7 = ( v3164 ) ? v31e1 : v31e5;
wire v31e8 =  v26 == memory_0[15: 12] && v31e7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v31eb = ( v3175 ) ? v16 : v10;
wire [31:0] v31ec = In_register_EIP + v31eb;
wire [31:0] v31ee = v31ec;
wire v31ef = v31ee == Out_register_EIP;
wire [31:0] v31f1 = In_register_FSBASE;
wire v31f2 = v31f1 == Out_register_FSBASE;
wire [31:0] v31f4 = In_register_CSBASE;
wire v31f5 = v31f4 == Out_register_CSBASE;
wire [31:0] v31f7 = In_register_SSBASE;
wire v31f8 = v31f7 == Out_register_SSBASE;
wire [31:0] v31fa = In_register_DSBASE;
wire v31fb = v31fa == Out_register_DSBASE;
wire v31fd = In_register_AF;
wire v31fe = v31fd == Out_register_AF;
wire v31ff = v3178 == v15;
wire v3201 = v31ff;
wire v3202 = v3201 == Out_register_ZF;
wire [7:0] v3204 = In_register_DF;
wire v3205 = v3204 == Out_register_DF;
wire v3206 = v17;
wire v3207 = v3206 == Out_register_OF;
wire [7:0] v3208 = v3178[7:0];
wire [2:0] v3209_aux = v3208[0] + v3208[1] + v3208[2] + v3208[3] + v3208[4] + v3208[5] + v3208[6] + v3208[7];
wire v3209 = { 5'b00000, v3209_aux };
wire [7:0] v320a = v3209 & v18;
wire [7:0] v320b = v320a ^ v18;
wire v320c = v320b[0:0];
wire v320e = v320c;
wire v320f = v320e == Out_register_PF;
wire [31:0] v3211 = In_register_GSBASE;
wire v3212 = v3211 == Out_register_GSBASE;
wire v3213 = v3179 == v11;
wire v3214 = v3213;
wire v3215 = v3164 & v3214;
wire v3216 = v317d == v11;
wire v3217 = v3216;
wire v3218 = v3175 & v3217;
wire v3219 = v3215 | v3218;
wire [31:0] v321c = ( v8 ) ? In_register_ESI : v3178;
wire [31:0] v321e = v321c;
wire v321f = v321e == Out_register_ESI;
wire v3220 = $signed(v3178) < $signed(v15);
wire v3222 = v3220;
wire v3223 = v3222 == Out_register_SF;
wire v3224 = v3189 & v3196 & v31a3 & v31a6 & v31b3 & v31c0 & v31c3 & v31c4 & v31d1 & v31de & v31e8 & v31ef & v31f2 & v15c & v31f5 & v31f8 & v31fb & v3186 & v31fe & v3202 & v3205 & v3207 & v320f & v3212 & v321f & v3223;
wire v3225 = v71 == v1eb;
wire v3226 = v92 == v1ed;
wire v3227 = v1b == v318;
wire v3228 = v3225 & v3226 & v3227;
wire v3229 = v3228;
wire v322a = v3229;
wire [31:0] v322c = In_register_ESI;
wire v322d = v322c == Out_register_ESI;
wire [31:0] v322f = v1c;
wire [31:0] v3230 = In_register_EIP + v322f;
wire [31:0] v3232 = v3230;
wire [31:0] v3234 = v3232;
wire v3235 = v3234 == Out_register_EIP;
wire [31:0] v3237 = In_register_FSBASE;
wire v3238 = v3237 == Out_register_FSBASE;
wire [31:0] v323a = In_register_EBX;
wire v323b = v323a == Out_register_EBX;
wire [31:0] v323d = In_register_ESP;
wire v323e = v323d == Out_register_ESP;
wire [2:0] v323f = { v1fa };
wire [31:0] v3240 = ( v323f == 3'd0) ? In_register_EAX : 
	( v323f == 3'd1) ? In_register_ECX : 
	( v323f == 3'd2) ? In_register_EDX : 
	( v323f == 3'd3) ? In_register_EBX : 
	( v323f == 3'd4) ? In_register_ESP : 
	( v323f == 3'd5) ? In_register_EBP : 
	( v323f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3242 = v3240;
wire v3243 = v3242 == v15;
wire v3244 = v3243 ^ v8;
wire [31:0] pad_12869 = (v3242[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v3245 = { pad_12869, v3242 };
wire [63:0] v3246 = $signed(v30ec) / $signed(v3245);
wire [63:0] vba = 64'b0000000000000000000000000000000100000000000000000000000000000000;
wire [63:0] v3247 = v3246 + vba;
wire v3248 = v3247 < vb8;
wire v3249 = v3244 & v3248;
wire [63:0] v324a = $signed(v30ec) % $signed(v3245);
wire [31:0] v324b = v324a[31:0];
wire [31:0] v324c = ( v3249 == 1'd0) ? In_register_EDX : v324b;
wire [31:0] v324e = v324c;
wire v324f = v324e == Out_register_EDX;
wire [31:0] v3251 = In_register_GSBASE;
wire v3252 = v3251 == Out_register_GSBASE;
wire [31:0] v3254 = In_register_EDI;
wire v3255 = v3254 == Out_register_EDI;
wire v3256 = In_error_flag == Out_error_flag;
wire [31:0] v3257 = v3246[31:0];
wire [31:0] v3258 = ( v3249 == 1'd0) ? In_register_EAX : v3257;
wire [31:0] v325a = v3258;
wire v325b = v325a == Out_register_EAX;
wire [31:0] v325d = In_register_ECX;
wire v325e = v325d == Out_register_ECX;
wire [31:0] v3260 = In_register_EBP;
wire v3261 = v3260 == Out_register_EBP;
wire [7:0] v3262 = ( v3249 == 1'd0) ? v65f : v28a8;
wire v3263 = v3262[0:0];
wire v3265 = v3263;
wire v3266 = v3265 == Out_register_CF;
wire [31:0] v3268 = In_register_CSBASE;
wire v3269 = v3268 == Out_register_CSBASE;
wire [31:0] v326b = In_register_DSBASE;
wire v326c = v326b == Out_register_DSBASE;
wire [31:0] v326e = In_register_ESBASE;
wire v326f = v326e == Out_register_ESBASE;
wire [7:0] v3270 = ( v3249 == 1'd0) ? v2870 : v2871;
wire v3271 = v3270[0:0];
wire v3273 = v3271;
wire v3274 = v3273 == Out_register_AF;
wire [7:0] v3275 = ( v3249 == 1'd0) ? v28c3 : v28c4;
wire v3276 = v3275[0:0];
wire v3278 = v3276;
wire v3279 = v3278 == Out_register_OF;
wire [7:0] v327b = In_register_DF;
wire v327c = v327b == Out_register_DF;
wire [7:0] v327d = ( v3249 == 1'd0) ? v1d85 : v28d0;
wire v327e = v327d[0:0];
wire v3280 = v327e;
wire v3281 = v3280 == Out_register_SF;
wire [31:0] v3283 = In_register_SSBASE;
wire v3284 = v3283 == Out_register_SSBASE;
wire [7:0] v3285 = ( v3249 == 1'd0) ? vd06 : v28ca;
wire v3286 = v3285[0:0];
wire v3288 = v3286;
wire v3289 = v3288 == Out_register_PF;
wire [7:0] v328a = ( v3249 == 1'd0) ? v289b : v289c;
wire v328b = v328a[0:0];
wire v328d = v328b;
wire v328e = v328d == Out_register_ZF;
wire v328f = v322a & v322d & v3235 & v3238 & v323b & v323e & v324f & v3252 & v15c & v3255 & v3256 & v325b & v325e & v3261 & v3266 & v3269 & v326c & v326f & v3274 & v3279 & v327c & v3281 & v3284 & v3289 & v328e;
wire [7:0] vbb = 8'b10110001;
wire v3290 = vbb == v1eb;
wire v3291 = v2f == v316;
wire v3292 = v14 == v1ef;
wire [2:0] v3293 = { v1fa };
wire v3294 = v3293 == vb;
wire v3295 = v3294;
wire v3296 = v3295 ^ v8;
wire v3297 = v3296;
wire v3298 = v3290 & v3291 & v3292 & v3297;
wire [10:0] vbc = 11'b10110001001;
wire v3299 = vbc == v6d7;
wire v329a = v2f == v316;
wire v329b = v94 == v20a0;
wire v329c = v43 == vab3;
wire v329d = v3299 & v329a & v329b & v329c;
wire v329e = vbc == v6d7;
wire v329f = v30 == v316;
wire v32a0 = v94 == v20a0;
wire v32a1 = v38 == v6da;
wire v32a2 = v329e & v329f & v32a0 & v32a1;
wire [10:0] vbd = 11'b10110001101;
wire v32a3 = vbd == v6d7;
wire v32a4 = v35 == v316;
wire v32a5 = v14 == v1ef;
wire v32a6 = v32a3 & v32a4 & v32a5;
wire v32a7 = vbb == v1eb;
wire v32a8 = v35 == v316;
wire v32a9 = v1b == v318;
wire [2:0] v32aa = { v1fa };
wire v32ab = v32aa == vb;
wire v32ac = v32aa == vf;
wire v32ad = v32ab | v32ac;
wire v32ae = v32ad ^ v8;
wire v32af = v32ae;
wire v32b0 = v32a7 & v32a8 & v32a9 & v32af;
wire v32b1 = vbb == v1eb;
wire v32b2 = v30 == v316;
wire v32b3 = v4 == v11b;
wire [2:0] v32b4 = { v1fa };
wire v32b5 = v32b4 == vb;
wire v32b6 = v32b5;
wire v32b7 = v32b6 ^ v8;
wire v32b8 = v32b7;
wire v32b9 = v32b1 & v32b2 & v32b3 & v32b8;
wire v32ba = vbc == v6d7;
wire v32bb = v35 == v316;
wire v32bc = v4 == v11b;
wire [2:0] v32bd = { v13c };
wire v32be = v32bd == vf;
wire v32bf = v32be;
wire v32c0 = v32bf ^ v8;
wire [2:0] v32c1 = { v12c };
wire v32c2 = v32c1 == vb;
wire v32c3 = v32c2;
wire v32c4 = v32c3 ^ v8;
wire v32c5 = v32c0 & v32c4;
wire v32c6 = v32ba & v32bb & v32bc & v32c5;
wire v32c7 = vbc == v6d7;
wire v32c8 = v30 == v316;
wire v32c9 = v38 == v6da;
wire [2:0] v32ca = { v12c };
wire v32cb = v32ca == vb;
wire v32cc = v32cb;
wire v32cd = v32cc ^ v8;
wire v32ce = v32cd;
wire v32cf = v32c7 & v32c8 & v32c9 & v32ce;
wire v32d0 = vbc == v6d7;
wire v32d1 = v2f == v316;
wire v32d2 = v43 == vab3;
wire [2:0] v32d3 = { v12c };
wire v32d4 = v32d3 == vb;
wire v32d5 = v32d4;
wire v32d6 = v32d5 ^ v8;
wire v32d7 = v32d6;
wire v32d8 = v32d0 & v32d1 & v32d2 & v32d7;
wire v32d9 = v3298 | v329d | v32a2 | v32a6 | v32b0 | v32b9 | v32c6 | v32cf | v32d8;
wire v32da = v32d9;
wire v32dc = In_register_CF;
wire v32dd = v32dc == Out_register_CF;
wire [31:0] v32df = In_register_FSBASE;
wire v32e0 = v32df == Out_register_FSBASE;
wire v32e1 = In_error_flag == Out_error_flag;
wire [2:0] v330e = { v320 };
wire v330f = v330e == vd;
wire v3310 = v330f;
wire v3311 = v3298 & v3310;
wire [2:0] v3312 = { v320 };
wire v3313 = v3312 == vd;
wire v3314 = v3313;
wire v3315 = v329d & v3314;
wire [2:0] v3316 = { v320 };
wire v3317 = v3316 == vd;
wire v3318 = v3317;
wire v3319 = v32a2 & v3318;
wire [2:0] v331a = { v320 };
wire v331b = v331a == vd;
wire v331c = v331b;
wire v331d = v32a6 & v331c;
wire [2:0] v331e = { v320 };
wire v331f = v331e == vd;
wire v3320 = v331f;
wire v3321 = v32b0 & v3320;
wire [2:0] v3322 = { v320 };
wire v3323 = v3322 == vd;
wire v3324 = v3323;
wire v3325 = v32b9 & v3324;
wire [2:0] v3326 = { v320 };
wire v3327 = v3326 == vd;
wire v3328 = v3327;
wire v3329 = v32c6 & v3328;
wire [2:0] v332a = { v320 };
wire v332b = v332a == vd;
wire v332c = v332b;
wire v332d = v32cf & v332c;
wire [2:0] v332e = { v320 };
wire v332f = v332e == vd;
wire v3330 = v332f;
wire v3331 = v32d8 & v3330;
wire v3332 = v3311 | v3315 | v3319 | v331d | v3321 | v3325 | v3329 | v332d | v3331;
wire [2:0] v32ef = { v1fa };
wire [31:0] v32f0 = ( v32ef == 3'd0) ? In_register_EAX : 
	( v32ef == 3'd1) ? In_register_ECX : 
	( v32ef == 3'd2) ? In_register_EDX : 
	( v32ef == 3'd3) ? In_register_EBX : 
	( v32ef == 3'd4) ? v15 : 
	( v32ef == 3'd5) ? v15 : 
	( v32ef == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v32f2 = { v1fa };
wire [31:0] v32f3 = ( v32f2 == 3'd0) ? In_register_EAX : 
	( v32f2 == 3'd1) ? In_register_ECX : 
	( v32f2 == 3'd2) ? In_register_EDX : 
	( v32f2 == 3'd3) ? In_register_EBX : 
	( v32f2 == 3'd4) ? v15 : 
	( v32f2 == 3'd5) ? In_register_EBP : 
	( v32f2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v32f4 = v32f3 + v63a;
wire [2:0] v32f6 = { v13c };
wire [31:0] v32f7 = ( v32f6 == 3'd0) ? In_register_EAX : 
	( v32f6 == 3'd1) ? In_register_ECX : 
	( v32f6 == 3'd2) ? In_register_EDX : 
	( v32f6 == 3'd3) ? In_register_EBX : 
	( v32f6 == 3'd4) ? In_register_ESP : 
	( v32f6 == 3'd5) ? v15 : 
	( v32f6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v32f8 = { v12c };
wire [31:0] v32f9 = ( v32f8 == 3'd0) ? In_register_EAX : 
	( v32f8 == 3'd1) ? In_register_ECX : 
	( v32f8 == 3'd2) ? In_register_EDX : 
	( v32f8 == 3'd3) ? In_register_EBX : 
	( v32f8 == 3'd4) ? v15 : 
	( v32f8 == 3'd5) ? In_register_EBP : 
	( v32f8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v32fa = v32f9 << v7f4;
wire [31:0] v32fb = v32f7 + v32fa;
wire [2:0] v32e2 = { v1fa };
wire [31:0] v32e3 = ( v32e2 == 3'd0) ? In_register_EAX : 
	( v32e2 == 3'd1) ? In_register_ECX : 
	( v32e2 == 3'd2) ? In_register_EDX : 
	( v32e2 == 3'd3) ? In_register_EBX : 
	( v32e2 == 3'd4) ? v15 : 
	( v32e2 == 3'd5) ? In_register_EBP : 
	( v32e2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v32e4 = v32e3 + v1f7;
wire [2:0] v32e6 = { v13c };
wire [31:0] v32e7 = ( v32e6 == 3'd0) ? In_register_EAX : 
	( v32e6 == 3'd1) ? In_register_ECX : 
	( v32e6 == 3'd2) ? In_register_EDX : 
	( v32e6 == 3'd3) ? In_register_EBX : 
	( v32e6 == 3'd4) ? In_register_ESP : 
	( v32e6 == 3'd5) ? In_register_EBP : 
	( v32e6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v32e8 = v32e7 + vc2d;
wire [2:0] v32ea = { v13c };
wire [31:0] v32eb = ( v32ea == 3'd0) ? In_register_EAX : 
	( v32ea == 3'd1) ? In_register_ECX : 
	( v32ea == 3'd2) ? In_register_EDX : 
	( v32ea == 3'd3) ? In_register_EBX : 
	( v32ea == 3'd4) ? In_register_ESP : 
	( v32ea == 3'd5) ? In_register_EBP : 
	( v32ea == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v32ec = v32eb + v7f8;
wire [2:0] v32fd = { v13c };
wire [31:0] v32fe = ( v32fd == 3'd0) ? In_register_EAX : 
	( v32fd == 3'd1) ? In_register_ECX : 
	( v32fd == 3'd2) ? In_register_EDX : 
	( v32fd == 3'd3) ? In_register_EBX : 
	( v32fd == 3'd4) ? In_register_ESP : 
	( v32fd == 3'd5) ? In_register_EBP : 
	( v32fd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v32ff = { v12c };
wire [31:0] v3300 = ( v32ff == 3'd0) ? In_register_EAX : 
	( v32ff == 3'd1) ? In_register_ECX : 
	( v32ff == 3'd2) ? In_register_EDX : 
	( v32ff == 3'd3) ? In_register_EBX : 
	( v32ff == 3'd4) ? v15 : 
	( v32ff == 3'd5) ? In_register_EBP : 
	( v32ff == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3301 = v3300 << v7f4;
wire [31:0] v3302 = v32fe + v3301;
wire [31:0] v3303 = v3302 + v7f8;
wire [2:0] v3305 = { v13c };
wire [31:0] v3306 = ( v3305 == 3'd0) ? In_register_EAX : 
	( v3305 == 3'd1) ? In_register_ECX : 
	( v3305 == 3'd2) ? In_register_EDX : 
	( v3305 == 3'd3) ? In_register_EBX : 
	( v3305 == 3'd4) ? In_register_ESP : 
	( v3305 == 3'd5) ? In_register_EBP : 
	( v3305 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v3307 = { v12c };
wire [31:0] v3308 = ( v3307 == 3'd0) ? In_register_EAX : 
	( v3307 == 3'd1) ? In_register_ECX : 
	( v3307 == 3'd2) ? In_register_EDX : 
	( v3307 == 3'd3) ? In_register_EBX : 
	( v3307 == 3'd4) ? v15 : 
	( v3307 == 3'd5) ? In_register_EBP : 
	( v3307 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3309 = v3308 << v7f4;
wire [31:0] v330a = v3306 + v3309;
wire [31:0] v330b = v330a + vc2d;
wire [31:0] v330d = ( v32b0 ) ? v32f0 : 
	( v32b9 ) ? v32f4 : 
	( v32c6 ) ? v32fb : 
	( v3298 ) ? v32e4 : 
	( v329d ) ? v32e8 : 
	( v32a2 ) ? v32ec : 
	( v32cf ) ? v3303 : 
	( v32d8 ) ? v330b : v1f7;
wire [31:0] v3335 = ( v8 ) ? In_register_EBX : v330d;
wire [31:0] v3337 = v3335;
wire v3338 = v3337 == Out_register_EBX;
wire [31:0] v333a = In_register_GSBASE;
wire v333b = v333a == Out_register_GSBASE;
wire v333c = v330e == vc;
wire v333d = v333c;
wire v333e = v3298 & v333d;
wire v333f = v3312 == vc;
wire v3340 = v333f;
wire v3341 = v329d & v3340;
wire v3342 = v3316 == vc;
wire v3343 = v3342;
wire v3344 = v32a2 & v3343;
wire v3345 = v331a == vc;
wire v3346 = v3345;
wire v3347 = v32a6 & v3346;
wire v3348 = v331e == vc;
wire v3349 = v3348;
wire v334a = v32b0 & v3349;
wire v334b = v3322 == vc;
wire v334c = v334b;
wire v334d = v32b9 & v334c;
wire v334e = v3326 == vc;
wire v334f = v334e;
wire v3350 = v32c6 & v334f;
wire v3351 = v332a == vc;
wire v3352 = v3351;
wire v3353 = v32cf & v3352;
wire v3354 = v332e == vc;
wire v3355 = v3354;
wire v3356 = v32d8 & v3355;
wire v3357 = v333e | v3341 | v3344 | v3347 | v334a | v334d | v3350 | v3353 | v3356;
wire [31:0] v335a = ( v8 ) ? In_register_ECX : v330d;
wire [31:0] v335c = v335a;
wire v335d = v335c == Out_register_ECX;
wire v335e = v330e == v7;
wire v335f = v335e;
wire v3360 = v3298 & v335f;
wire v3361 = v3312 == v7;
wire v3362 = v3361;
wire v3363 = v329d & v3362;
wire v3364 = v3316 == v7;
wire v3365 = v3364;
wire v3366 = v32a2 & v3365;
wire v3367 = v331a == v7;
wire v3368 = v3367;
wire v3369 = v32a6 & v3368;
wire v336a = v331e == v7;
wire v336b = v336a;
wire v336c = v32b0 & v336b;
wire v336d = v3322 == v7;
wire v336e = v336d;
wire v336f = v32b9 & v336e;
wire v3370 = v3326 == v7;
wire v3371 = v3370;
wire v3372 = v32c6 & v3371;
wire v3373 = v332a == v7;
wire v3374 = v3373;
wire v3375 = v32cf & v3374;
wire v3376 = v332e == v7;
wire v3377 = v3376;
wire v3378 = v32d8 & v3377;
wire v3379 = v3360 | v3363 | v3366 | v3369 | v336c | v336f | v3372 | v3375 | v3378;
wire [31:0] v337c = ( v8 ) ? In_register_EAX : v330d;
wire [31:0] v337e = v337c;
wire v337f = v337e == Out_register_EAX;
wire [31:0] v3381 = In_register_ESBASE;
wire v3382 = v3381 == Out_register_ESBASE;
wire v3384 = In_register_PF;
wire v3385 = v3384 == Out_register_PF;
wire [31:0] v338f = ( v329d | v32d8 ) ? v45 : 
	( v32a2 | v32cf ) ? v27 : 
	( v32b0 ) ? v1c : 
	( v3298 | v32a6 ) ? v16 : v10;
wire [31:0] v3390 = In_register_EIP + v338f;
wire [31:0] v3392 = v3390;
wire v3393 = v3392 == Out_register_EIP;
wire v3394 = v330e == v11;
wire v3395 = v3394;
wire v3396 = v3298 & v3395;
wire v3397 = v3312 == v11;
wire v3398 = v3397;
wire v3399 = v329d & v3398;
wire v339a = v3316 == v11;
wire v339b = v339a;
wire v339c = v32a2 & v339b;
wire v339d = v331a == v11;
wire v339e = v339d;
wire v339f = v32a6 & v339e;
wire v33a0 = v331e == v11;
wire v33a1 = v33a0;
wire v33a2 = v32b0 & v33a1;
wire v33a3 = v3322 == v11;
wire v33a4 = v33a3;
wire v33a5 = v32b9 & v33a4;
wire v33a6 = v3326 == v11;
wire v33a7 = v33a6;
wire v33a8 = v32c6 & v33a7;
wire v33a9 = v332a == v11;
wire v33aa = v33a9;
wire v33ab = v32cf & v33aa;
wire v33ac = v332e == v11;
wire v33ad = v33ac;
wire v33ae = v32d8 & v33ad;
wire v33af = v3396 | v3399 | v339c | v339f | v33a2 | v33a5 | v33a8 | v33ab | v33ae;
wire [31:0] v33b2 = ( v8 ) ? In_register_ESI : v330d;
wire [31:0] v33b4 = v33b2;
wire v33b5 = v33b4 == Out_register_ESI;
wire v33b6 = v330e == v9;
wire v33b7 = v33b6;
wire v33b8 = v3298 & v33b7;
wire v33b9 = v3312 == v9;
wire v33ba = v33b9;
wire v33bb = v329d & v33ba;
wire v33bc = v3316 == v9;
wire v33bd = v33bc;
wire v33be = v32a2 & v33bd;
wire v33bf = v331a == v9;
wire v33c0 = v33bf;
wire v33c1 = v32a6 & v33c0;
wire v33c2 = v331e == v9;
wire v33c3 = v33c2;
wire v33c4 = v32b0 & v33c3;
wire v33c5 = v3322 == v9;
wire v33c6 = v33c5;
wire v33c7 = v32b9 & v33c6;
wire v33c8 = v3326 == v9;
wire v33c9 = v33c8;
wire v33ca = v32c6 & v33c9;
wire v33cb = v332a == v9;
wire v33cc = v33cb;
wire v33cd = v32cf & v33cc;
wire v33ce = v332e == v9;
wire v33cf = v33ce;
wire v33d0 = v32d8 & v33cf;
wire v33d1 = v33b8 | v33bb | v33be | v33c1 | v33c4 | v33c7 | v33ca | v33cd | v33d0;
wire [31:0] v33d4 = ( v8 ) ? In_register_EDI : v330d;
wire [31:0] v33d6 = v33d4;
wire v33d7 = v33d6 == Out_register_EDI;
wire v33d8 = v330e == vb;
wire v33d9 = v33d8;
wire v33da = v3298 & v33d9;
wire v33db = v3312 == vb;
wire v33dc = v33db;
wire v33dd = v329d & v33dc;
wire v33de = v3316 == vb;
wire v33df = v33de;
wire v33e0 = v32a2 & v33df;
wire v33e1 = v331a == vb;
wire v33e2 = v33e1;
wire v33e3 = v32a6 & v33e2;
wire v33e4 = v331e == vb;
wire v33e5 = v33e4;
wire v33e6 = v32b0 & v33e5;
wire v33e7 = v3322 == vb;
wire v33e8 = v33e7;
wire v33e9 = v32b9 & v33e8;
wire v33ea = v3326 == vb;
wire v33eb = v33ea;
wire v33ec = v32c6 & v33eb;
wire v33ed = v332a == vb;
wire v33ee = v33ed;
wire v33ef = v32cf & v33ee;
wire v33f0 = v332e == vb;
wire v33f1 = v33f0;
wire v33f2 = v32d8 & v33f1;
wire v33f3 = v33da | v33dd | v33e0 | v33e3 | v33e6 | v33e9 | v33ec | v33ef | v33f2;
wire [31:0] v33f6 = ( v8 ) ? In_register_ESP : v330d;
wire [31:0] v33f8 = v33f6;
wire v33f9 = v33f8 == Out_register_ESP;
wire v33fa = v330e == vf;
wire v33fb = v33fa;
wire v33fc = v3298 & v33fb;
wire v33fd = v3312 == vf;
wire v33fe = v33fd;
wire v33ff = v329d & v33fe;
wire v3400 = v3316 == vf;
wire v3401 = v3400;
wire v3402 = v32a2 & v3401;
wire v3403 = v331a == vf;
wire v3404 = v3403;
wire v3405 = v32a6 & v3404;
wire v3406 = v331e == vf;
wire v3407 = v3406;
wire v3408 = v32b0 & v3407;
wire v3409 = v3322 == vf;
wire v340a = v3409;
wire v340b = v32b9 & v340a;
wire v340c = v3326 == vf;
wire v340d = v340c;
wire v340e = v32c6 & v340d;
wire v340f = v332a == vf;
wire v3410 = v340f;
wire v3411 = v32cf & v3410;
wire v3412 = v332e == vf;
wire v3413 = v3412;
wire v3414 = v32d8 & v3413;
wire v3415 = v33fc | v33ff | v3402 | v3405 | v3408 | v340b | v340e | v3411 | v3414;
wire [31:0] v3418 = ( v8 ) ? In_register_EBP : v330d;
wire [31:0] v341a = v3418;
wire v341b = v341a == Out_register_EBP;
wire [31:0] v341d = In_register_CSBASE;
wire v341e = v341d == Out_register_CSBASE;
wire [7:0] v3420 = In_register_DF;
wire v3421 = v3420 == Out_register_DF;
wire v3422 = v330e == ve;
wire v3423 = v3422;
wire v3424 = v3298 & v3423;
wire v3425 = v3312 == ve;
wire v3426 = v3425;
wire v3427 = v329d & v3426;
wire v3428 = v3316 == ve;
wire v3429 = v3428;
wire v342a = v32a2 & v3429;
wire v342b = v331a == ve;
wire v342c = v342b;
wire v342d = v32a6 & v342c;
wire v342e = v331e == ve;
wire v342f = v342e;
wire v3430 = v32b0 & v342f;
wire v3431 = v3322 == ve;
wire v3432 = v3431;
wire v3433 = v32b9 & v3432;
wire v3434 = v3326 == ve;
wire v3435 = v3434;
wire v3436 = v32c6 & v3435;
wire v3437 = v332a == ve;
wire v3438 = v3437;
wire v3439 = v32cf & v3438;
wire v343a = v332e == ve;
wire v343b = v343a;
wire v343c = v32d8 & v343b;
wire v343d = v3424 | v3427 | v342a | v342d | v3430 | v3433 | v3436 | v3439 | v343c;
wire [31:0] v3440 = ( v8 ) ? In_register_EDX : v330d;
wire [31:0] v3442 = v3440;
wire v3443 = v3442 == Out_register_EDX;
wire [31:0] v3445 = In_register_SSBASE;
wire v3446 = v3445 == Out_register_SSBASE;
wire [31:0] v3448 = In_register_DSBASE;
wire v3449 = v3448 == Out_register_DSBASE;
wire v344b = In_register_AF;
wire v344c = v344b == Out_register_AF;
wire v344e = In_register_OF;
wire v344f = v344e == Out_register_OF;
wire v3451 = In_register_SF;
wire v3452 = v3451 == Out_register_SF;
wire v3454 = In_register_ZF;
wire v3455 = v3454 == Out_register_ZF;
wire v3456 = v32dd & v32e0 & v32e1 & v3338 & v333b & v335d & v337f & v3382 & v3385 & v3393 & v33b5 & v32da & v33d7 & v33f9 & v341b & v341e & v3421 & v3443 & v3446 & v3449 & v344c & v15c & v344f & v3452 & v3455;
wire v3457 = v81 == v1eb;
wire v3458 = va1 == v1ed;
wire v3459 = v1b == v318;
wire [2:0] v345a = { v1fa };
wire v345b = v345a == vb;
wire v345c = v345a == vf;
wire v345d = v345b | v345c;
wire v345e = v345d ^ v8;
wire [2:0] v345f = { v1fa };
wire v3460 = v345f == vb;
wire v3461 = v345f == vf;
wire v3462 = v3460 | v3461;
wire v3463 = v3462 ^ v8;
wire v3464 = v345e & v3463;
wire v3465 = v3457 & v3458 & v3459 & v3464;
wire v3466 = v3465;
wire v3467 = v3466;
wire [2:0] v3468 = { v1fa };
wire [31:0] v3469 = ( v3468 == 3'd0) ? In_register_EAX : 
	( v3468 == 3'd1) ? In_register_ECX : 
	( v3468 == 3'd2) ? In_register_EDX : 
	( v3468 == 3'd3) ? In_register_EBX : 
	( v3468 == 3'd4) ? v15 : 
	( v3468 == 3'd5) ? v15 : 
	( v3468 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v346b = v3469;
wire v346c =  v2a == memory_0[15: 12] && v346b == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v346e = In_register_SSBASE;
wire v346f = v346e == Out_register_SSBASE;
wire [31:0] v3470 = memory_0[79: 48];
wire [7:0] v3471 = v3470[7:0];
wire v3472 = v3471 == v2c;
wire v3473 = v3472 ^ v8;
wire [7:0] pad_13428 = (v3471[7:7] == 1'b1) ?24'b111111111111111111111111 : 24'b000000000000000000000000;
wire [31:0] v3474 = { pad_13428, v3471 };
wire [31:0] v3475 = $signed(v2867) / $signed(v3474);
wire [15:0] v3476 = v3475[15:0];
wire [7:0] v3477 = v3475[7:0];
wire [7:0] pad_13432 = (v3477[7:7] == 1'b1) ?8'b11111111 : 8'b00000000;
wire [15:0] v3478 = { pad_13432, v3477 };
wire v3479 = v3476 == v3478;
wire v347a = v3473 & v3479;
wire [7:0] v347b = ( v347a == 1'd0) ? v65f : v28a8;
wire v347c = v347b[0:0];
wire v347e = v347c;
wire v347f = v347e == Out_register_CF;
wire [31:0] v3481 = In_register_EBX;
wire v3482 = v3481 == Out_register_EBX;
wire [31:0] v3484 = In_register_EDX;
wire v3485 = v3484 == Out_register_EDX;
wire [31:0] v3487 = In_register_EDI;
wire v3488 = v3487 == Out_register_EDI;
wire [31:0] v348a = In_register_DSBASE;
wire v348b = v348a == Out_register_DSBASE;
wire [31:0] v348d = In_register_ESP;
wire v348e = v348d == Out_register_ESP;
wire [31:0] v3490 = In_register_ECX;
wire v3491 = v3490 == Out_register_ECX;
wire [31:0] v3493 = In_register_EBP;
wire v3494 = v3493 == Out_register_EBP;
wire v3495 = In_error_flag == Out_error_flag;
wire [31:0] v3497 = v1c;
wire [31:0] v3498 = In_register_EIP + v3497;
wire [31:0] v349a = v3498;
wire [31:0] v349c = v349a;
wire v349d = v349c == Out_register_EIP;
wire [31:0] v349f = In_register_CSBASE;
wire v34a0 = v349f == Out_register_CSBASE;
wire [7:0] v34a1 = ( v347a == 1'd0) ? vf4a : v3477;
wire [31:0] v34a2 = { 24'b000000000000000000000000, v34a1 };
wire [31:0] v34a3 = v5c8 | v34a2;
wire [31:0] v34a4 = v34a3 & v3a;
wire [31:0] v34a5 = v34a3 >> v31;
wire [7:0] v34a6 = v34a5[7:0];
wire [31:0] v34a7 = $signed(v2867) % $signed(v3474);
wire [7:0] v34a8 = v34a7[7:0];
wire [7:0] v34a9 = ( v347a == 1'd0) ? v34a6 : v34a8;
wire [31:0] v34aa = { 24'b000000000000000000000000, v34a9 };
wire [31:0] v34ab = v34aa << v31;
wire [31:0] v34ac = v34a4 | v34ab;
wire [31:0] v34ae = v34ac;
wire v34af = v34ae == Out_register_EAX;
wire [31:0] v34b1 = In_register_ESBASE;
wire v34b2 = v34b1 == Out_register_ESBASE;
wire [31:0] v34b4 = In_register_GSBASE;
wire v34b5 = v34b4 == Out_register_GSBASE;
wire [31:0] v34b7 = In_register_FSBASE;
wire v34b8 = v34b7 == Out_register_FSBASE;
wire [7:0] v34b9 = ( v347a == 1'd0) ? v2870 : v2871;
wire v34ba = v34b9[0:0];
wire v34bc = v34ba;
wire v34bd = v34bc == Out_register_AF;
wire [7:0] v34bf = In_register_DF;
wire v34c0 = v34bf == Out_register_DF;
wire [31:0] v34c2 = In_register_ESI;
wire v34c3 = v34c2 == Out_register_ESI;
wire [7:0] v34c4 = ( v347a == 1'd0) ? v28c3 : v28c4;
wire v34c5 = v34c4[0:0];
wire v34c7 = v34c5;
wire v34c8 = v34c7 == Out_register_OF;
wire [7:0] v34c9 = ( v347a == 1'd0) ? vd06 : v28ca;
wire v34ca = v34c9[0:0];
wire v34cc = v34ca;
wire v34cd = v34cc == Out_register_PF;
wire [7:0] v34ce = ( v347a == 1'd0) ? v1d85 : v28d0;
wire v34cf = v34ce[0:0];
wire v34d1 = v34cf;
wire v34d2 = v34d1 == Out_register_SF;
wire [7:0] v34d3 = ( v347a == 1'd0) ? v289b : v289c;
wire v34d4 = v34d3[0:0];
wire v34d6 = v34d4;
wire v34d7 = v34d6 == Out_register_ZF;
wire v34d8 = v3467 & v15c & v346c & v346f & v347f & v3482 & v3485 & v3488 & v348b & v348e & v3491 & v3494 & v3495 & v349d & v34a0 & v34af & v34b2 & v34b5 & v34b8 & v34bd & v34c0 & v34c3 & v34c8 & v34cd & v34d2 & v34d7;
wire v34db = va9 == v1eb;
wire v34dc = v30 == v316;
wire v34dd = v38 == v6da;
wire [2:0] v34de = { v1fa };
wire v34df = v34de == vb;
wire v34e0 = v34df;
wire v34e1 = v34e0 ^ v8;
wire [2:0] v34e2 = { v1fa };
wire v34e3 = v34e2 == vb;
wire v34e4 = v34e3;
wire v34e5 = v34e4 ^ v8;
wire v34e6 = v34e1 & v34e5;
wire v34e7 = v34db & v34dc & v34dd & v34e6;
wire v34e9 = va9 == v1eb;
wire v34ea = v35 == v316;
wire v34eb = v4 == v11b;
wire [2:0] v34ec = { v1fa };
wire v34ed = v34ec == vb;
wire v34ee = v34ec == vf;
wire v34ef = v34ed | v34ee;
wire v34f0 = v34ef ^ v8;
wire [2:0] v34f1 = { v1fa };
wire v34f2 = v34f1 == vb;
wire v34f3 = v34f1 == vf;
wire v34f4 = v34f2 | v34f3;
wire v34f5 = v34f4 ^ v8;
wire v34f6 = v34f0 & v34f5;
wire v34f7 = v34e9 & v34ea & v34eb & v34f6;
wire v34f9 = va9 == v1eb;
wire v34fa = v2f == v316;
wire v34fb = v43 == vab3;
wire [2:0] v34fc = { v1fa };
wire v34fd = v34fc == vb;
wire v34fe = v34fc == vf;
wire v34ff = v34fd | v34fe;
wire v3500 = v34ff ^ v8;
wire [2:0] v3501 = { v1fa };
wire v3502 = v3501 == vb;
wire v3503 = v3502;
wire v3504 = v3503 ^ v8;
wire v3505 = v3500 & v3504;
wire v3506 = v34f9 & v34fa & v34fb & v3505;
wire [10:0] vbe = 11'b11010110001;
wire v3508 = vbe == v6d7;
wire v3509 = v35 == v316;
wire v350a = v38 == v6da;
wire [2:0] v350b = { v13c };
wire v350c = v350b == vb;
wire v350d = v350b == vf;
wire v350e = v350c | v350d;
wire v350f = v350e ^ v8;
wire [2:0] v3510 = { v12c };
wire v3511 = v3510 == vb;
wire v3512 = v3511;
wire v3513 = v3512 ^ v8;
wire [2:0] v3514 = { v13c };
wire v3515 = v3514 == vf;
wire v3516 = v3515;
wire v3517 = v3516 ^ v8;
wire v3518 = v350f & v3513 & v3517;
wire v3519 = v3508 & v3509 & v350a & v3518;
wire v3533 = v34e7 | v34f7 | v3506 | v3519;
wire v3534 = v3533;
wire [2:0] v351f = { v320 };
wire v3520 = v351f == vb;
wire v3521 = v3520;
wire v3522 = v34e7 & v3521;
wire [2:0] v3523 = { v320 };
wire v3524 = v3523 == vb;
wire v3525 = v3524;
wire v3526 = v34f7 & v3525;
wire [2:0] v3527 = { v320 };
wire v3528 = v3527 == vb;
wire v3529 = v3528;
wire v352a = v3506 & v3529;
wire [2:0] v352b = { v320 };
wire v352c = v352b == vb;
wire v352d = v352c;
wire v352e = v3519 & v352d;
wire v352f = v3522 | v3526 | v352a | v352e;
wire [31:0] v34d9 = memory_0[79: 48];
wire [31:0] pad_13530 = (v34d9[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v34da = { pad_13530, v34d9 };
wire [31:0] v351b = ( v34e7 | v3519 ) ? v7f8 : 
	( v3506 ) ? vb0c : v63a;
wire [31:0] pad_13596 = (v351b[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v351c = { pad_13596, v351b };
wire [63:0] v351d = v34da * v351c;
wire [31:0] v351e = v351d[31:0];
wire [31:0] v3532 = ( v8 ) ? In_register_ESP : v351e;
wire [31:0] v3536 = v3532;
wire v3537 = v3536 == Out_register_ESP;
wire v3538 = v351f == vf;
wire v3539 = v3538;
wire v353a = v34e7 & v3539;
wire v353b = v3523 == vf;
wire v353c = v353b;
wire v353d = v34f7 & v353c;
wire v353e = v3527 == vf;
wire v353f = v353e;
wire v3540 = v3506 & v353f;
wire v3541 = v352b == vf;
wire v3542 = v3541;
wire v3543 = v3519 & v3542;
wire v3544 = v353a | v353d | v3540 | v3543;
wire [31:0] v3547 = ( v8 ) ? In_register_EBP : v351e;
wire [31:0] v3549 = v3547;
wire v354a = v3549 == Out_register_EBP;
wire v354c = In_register_AF;
wire v354d = v354c == Out_register_AF;
wire v354e = In_error_flag == Out_error_flag;
wire v354f = v351f == vc;
wire v3550 = v354f;
wire v3551 = v34e7 & v3550;
wire v3552 = v3523 == vc;
wire v3553 = v3552;
wire v3554 = v34f7 & v3553;
wire v3555 = v3527 == vc;
wire v3556 = v3555;
wire v3557 = v3506 & v3556;
wire v3558 = v352b == vc;
wire v3559 = v3558;
wire v355a = v3519 & v3559;
wire v355b = v3551 | v3554 | v3557 | v355a;
wire [31:0] v355e = ( v8 ) ? In_register_ECX : v351e;
wire [31:0] v3560 = v355e;
wire v3561 = v3560 == Out_register_ECX;
wire v3562 = v351f == v11;
wire v3563 = v3562;
wire v3564 = v34e7 & v3563;
wire v3565 = v3523 == v11;
wire v3566 = v3565;
wire v3567 = v34f7 & v3566;
wire v3568 = v3527 == v11;
wire v3569 = v3568;
wire v356a = v3506 & v3569;
wire v356b = v352b == v11;
wire v356c = v356b;
wire v356d = v3519 & v356c;
wire v356e = v3564 | v3567 | v356a | v356d;
wire [31:0] v3571 = ( v8 ) ? In_register_ESI : v351e;
wire [31:0] v3573 = v3571;
wire v3574 = v3573 == Out_register_ESI;
wire v3575 = v351f == ve;
wire v3576 = v3575;
wire v3577 = v34e7 & v3576;
wire v3578 = v3523 == ve;
wire v3579 = v3578;
wire v357a = v34f7 & v3579;
wire v357b = v3527 == ve;
wire v357c = v357b;
wire v357d = v3506 & v357c;
wire v357e = v352b == ve;
wire v357f = v357e;
wire v3580 = v3519 & v357f;
wire v3581 = v3577 | v357a | v357d | v3580;
wire [31:0] v3584 = ( v8 ) ? In_register_EDX : v351e;
wire [31:0] v3586 = v3584;
wire v3587 = v3586 == Out_register_EDX;
wire v3588 = v351f == vd;
wire v3589 = v3588;
wire v358a = v34e7 & v3589;
wire v358b = v3523 == vd;
wire v358c = v358b;
wire v358d = v34f7 & v358c;
wire v358e = v3527 == vd;
wire v358f = v358e;
wire v3590 = v3506 & v358f;
wire v3591 = v352b == vd;
wire v3592 = v3591;
wire v3593 = v3519 & v3592;
wire v3594 = v358a | v358d | v3590 | v3593;
wire [31:0] v3597 = ( v8 ) ? In_register_EBX : v351e;
wire [31:0] v3599 = v3597;
wire v359a = v3599 == Out_register_EBX;
wire [31:0] v359c = In_register_CSBASE;
wire v359d = v359c == Out_register_CSBASE;
wire v359e = v351f == v7;
wire v359f = v359e;
wire v35a0 = v34e7 & v359f;
wire v35a1 = v3523 == v7;
wire v35a2 = v35a1;
wire v35a3 = v34f7 & v35a2;
wire v35a4 = v3527 == v7;
wire v35a5 = v35a4;
wire v35a6 = v3506 & v35a5;
wire v35a7 = v352b == v7;
wire v35a8 = v35a7;
wire v35a9 = v3519 & v35a8;
wire v35aa = v35a0 | v35a3 | v35a6 | v35a9;
wire [31:0] v35ad = ( v8 ) ? In_register_EAX : v351e;
wire [31:0] v35af = v35ad;
wire v35b0 = v35af == Out_register_EAX;
wire v35b1 = v351f == v9;
wire v35b2 = v35b1;
wire v35b3 = v34e7 & v35b2;
wire v35b4 = v3523 == v9;
wire v35b5 = v35b4;
wire v35b6 = v34f7 & v35b5;
wire v35b7 = v3527 == v9;
wire v35b8 = v35b7;
wire v35b9 = v3506 & v35b8;
wire v35ba = v352b == v9;
wire v35bb = v35ba;
wire v35bc = v3519 & v35bb;
wire v35bd = v35b3 | v35b6 | v35b9 | v35bc;
wire [31:0] v35c0 = ( v8 ) ? In_register_EDI : v351e;
wire [31:0] v35c2 = v35c0;
wire v35c3 = v35c2 == Out_register_EDI;
wire [31:0] v35c8 = ( v3506 ) ? v45 : 
	( v34e7 | v3519 ) ? v27 : v10;
wire [31:0] v35c9 = In_register_EIP + v35c8;
wire [31:0] v35cb = v35c9;
wire v35cc = v35cb == Out_register_EIP;
wire [63:0] v35cd = v351d + v22;
wire v35ce = v35cd < v23;
wire v35d0 = v35ce;
wire v35d1 = v35d0 == Out_register_OF;
wire [2:0] v35d2 = { v1fa };
wire [31:0] v35d3 = ( v35d2 == 3'd0) ? In_register_EAX : 
	( v35d2 == 3'd1) ? In_register_ECX : 
	( v35d2 == 3'd2) ? In_register_EDX : 
	( v35d2 == 3'd3) ? In_register_EBX : 
	( v35d2 == 3'd4) ? v15 : 
	( v35d2 == 3'd5) ? In_register_EBP : 
	( v35d2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v35d4 = v35d3 + v63a;
wire [2:0] v35d9 = { v1fa };
wire [31:0] v35da = ( v35d9 == 3'd0) ? In_register_EAX : 
	( v35d9 == 3'd1) ? In_register_ECX : 
	( v35d9 == 3'd2) ? In_register_EDX : 
	( v35d9 == 3'd3) ? In_register_EBX : 
	( v35d9 == 3'd4) ? v15 : 
	( v35d9 == 3'd5) ? v15 : 
	( v35d9 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v35db = v35da + v1f7;
wire [2:0] v35dd = { v13c };
wire [31:0] v35de = ( v35dd == 3'd0) ? In_register_EAX : 
	( v35dd == 3'd1) ? In_register_ECX : 
	( v35dd == 3'd2) ? In_register_EDX : 
	( v35dd == 3'd3) ? In_register_EBX : 
	( v35dd == 3'd4) ? v15 : 
	( v35dd == 3'd5) ? v15 : 
	( v35dd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v35df = { v12c };
wire [31:0] v35e0 = ( v35df == 3'd0) ? In_register_EAX : 
	( v35df == 3'd1) ? In_register_ECX : 
	( v35df == 3'd2) ? In_register_EDX : 
	( v35df == 3'd3) ? In_register_EBX : 
	( v35df == 3'd4) ? v15 : 
	( v35df == 3'd5) ? In_register_EBP : 
	( v35df == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v35e1 = v35e0 << v7f4;
wire [31:0] v35e2 = v35de + v35e1;
wire [2:0] v35d6 = { v1fa };
wire [31:0] v35d7 = ( v35d6 == 3'd0) ? In_register_EAX : 
	( v35d6 == 3'd1) ? In_register_ECX : 
	( v35d6 == 3'd2) ? In_register_EDX : 
	( v35d6 == 3'd3) ? In_register_EBX : 
	( v35d6 == 3'd4) ? v15 : 
	( v35d6 == 3'd5) ? v15 : 
	( v35d6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v35e4 = ( v34e7 ) ? v35d4 : 
	( v3506 ) ? v35db : 
	( v3519 ) ? v35e2 : v35d7;
wire v35e5 =  v26 == memory_0[15: 12] && v35e4 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v35e7 = In_register_SSBASE;
wire v35e8 = v35e7 == Out_register_SSBASE;
wire v35e9 = v35ce;
wire v35ea = v35e9 == Out_register_CF;
wire [7:0] v35ec = In_register_DF;
wire v35ed = v35ec == Out_register_DF;
wire [31:0] v35ef = In_register_ESBASE;
wire v35f0 = v35ef == Out_register_ESBASE;
wire v35f2 = In_register_SF;
wire v35f3 = v35f2 == Out_register_SF;
wire [31:0] v35f5 = In_register_DSBASE;
wire v35f6 = v35f5 == Out_register_DSBASE;
wire [31:0] v35f8 = In_register_GSBASE;
wire v35f9 = v35f8 == Out_register_GSBASE;
wire [31:0] v35fb = In_register_FSBASE;
wire v35fc = v35fb == Out_register_FSBASE;
wire v35fe = In_register_PF;
wire v35ff = v35fe == Out_register_PF;
wire v3601 = In_register_ZF;
wire v3602 = v3601 == Out_register_ZF;
wire v3603 = v3537 & v354a & v15c & v354d & v354e & v3561 & v3574 & v3587 & v3534 & v359a & v359d & v35b0 & v35c3 & v35cc & v35d1 & v35e5 & v35e8 & v35ea & v35ed & v35f0 & v35f3 & v35f6 & v35f9 & v35fc & v35ff & v3602;
wire [7:0] vbf = 8'b11000111;
wire v3604 = vbf == v1eb;
wire v3605 = v1b == v318;
wire v3606 = v3604 & v3605;
wire v3607 = v3606;
wire v3608 = v3607;
wire [31:0] v360a = In_register_ECX;
wire v360b = v360a == Out_register_ECX;
wire [31:0] v360d = In_register_DSBASE;
wire v360e = v360d == Out_register_DSBASE;
wire v3610 = In_register_OF;
wire v3611 = v3610 == Out_register_OF;
wire [31:0] v3613 = In_register_EDX;
wire v3614 = v3613 == Out_register_EDX;
wire v3615 = In_error_flag == Out_error_flag;
wire [31:0] v3617 = In_register_EBX;
wire v3618 = v3617 == Out_register_EBX;
wire [31:0] v361a = In_register_EAX;
wire v361b = v361a == Out_register_EAX;
wire [31:0] v361d = In_register_GSBASE;
wire v361e = v361d == Out_register_GSBASE;
wire [31:0] v3621 = v1c;
wire [31:0] v3622 = In_register_EIP + v3621;
wire v361f = In_register_ECX == v15;
wire [31:0] v3624 = v3622;
wire [31:0] v3625 = v3622 + v477;
wire [31:0] v3627 = v3625;
wire [31:0] v3628 = ( v361f == 1'd0) ? v3624 : v3627;
wire [31:0] v362b = ( v8 ) ? v3622 : v3628;
wire [31:0] v362d = v362b;
wire v362e = v362d == Out_register_EIP;
wire [7:0] v3630 = In_register_DF;
wire v3631 = v3630 == Out_register_DF;
wire [31:0] v3633 = In_register_ESP;
wire v3634 = v3633 == Out_register_ESP;
wire [31:0] v3636 = In_register_EBP;
wire v3637 = v3636 == Out_register_EBP;
wire [31:0] v3639 = In_register_ESI;
wire v363a = v3639 == Out_register_ESI;
wire [31:0] v363c = In_register_SSBASE;
wire v363d = v363c == Out_register_SSBASE;
wire v363f = In_register_CF;
wire v3640 = v363f == Out_register_CF;
wire [31:0] v3642 = In_register_CSBASE;
wire v3643 = v3642 == Out_register_CSBASE;
wire [31:0] v3645 = In_register_ESBASE;
wire v3646 = v3645 == Out_register_ESBASE;
wire [31:0] v3648 = In_register_FSBASE;
wire v3649 = v3648 == Out_register_FSBASE;
wire v364b = In_register_AF;
wire v364c = v364b == Out_register_AF;
wire v364e = In_register_SF;
wire v364f = v364e == Out_register_SF;
wire v3651 = In_register_PF;
wire v3652 = v3651 == Out_register_PF;
wire [31:0] v3654 = In_register_EDI;
wire v3655 = v3654 == Out_register_EDI;
wire v3657 = In_register_ZF;
wire v3658 = v3657 == Out_register_ZF;
wire v3659 = v360b & v360e & v3611 & v3614 & v3615 & v3618 & v361b & v361e & v362e & v3631 & v3634 & v15c & v3637 & v363a & v363d & v3640 & v3643 & v3646 & v3649 & v3608 & v364c & v364f & v3652 & v3655 & v3658;
wire v365a = v81 == v1eb;
wire v365b = v8 == v829;
wire v365c = v74 == v1ed;
wire v365d = v4 == v11b;
wire v365e = v365a & v365b & v365c & v365d;
wire v365f = v81 == v1eb;
wire v3660 = v73 == v1ed;
wire v3661 = v43 == vab3;
wire [2:0] v3662 = { v1fa };
wire v3663 = v3662 == vb;
wire v3664 = v3663;
wire v3665 = v3664 ^ v8;
wire [2:0] v3666 = { v1fa };
wire v3667 = v3666 == vb;
wire v3668 = v3667;
wire v3669 = v3668 ^ v8;
wire v366a = v3665 & v3669;
wire v366b = v365f & v3660 & v3661 & v366a;
wire v366c = v365e | v366b;
wire v366d = v366c;
wire [31:0] v366f = In_register_DSBASE;
wire v3670 = v366f == Out_register_DSBASE;
wire [31:0] v3672 = In_register_ESP;
wire v3673 = v3672 == Out_register_ESP;
wire [31:0] v3675 = In_register_EBP;
wire v3676 = v3675 == Out_register_EBP;
wire [31:0] v3679 = ( v366b ) ? v45 : v10;
wire [31:0] v367a = In_register_EIP + v3679;
wire [31:0] v367c = v367a;
wire v367d = v367c == Out_register_EIP;
wire v367e = In_error_flag == Out_error_flag;
wire [31:0] v3680 = In_register_EAX;
wire v3681 = v3680 == Out_register_EAX;
wire [31:0] v3683 = In_register_ESI;
wire v3684 = v3683 == Out_register_ESI;
wire [2:0] v3688 = { v1fa };
wire [31:0] v3689 = ( v3688 == 3'd0) ? In_register_EAX : 
	( v3688 == 3'd1) ? In_register_ECX : 
	( v3688 == 3'd2) ? In_register_EDX : 
	( v3688 == 3'd3) ? In_register_EBX : 
	( v3688 == 3'd4) ? v15 : 
	( v3688 == 3'd5) ? In_register_EBP : 
	( v3688 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v368a = v3689 + v1f7;
wire [1:0] v3685 = { v889 , v888 };
wire [31:0] v3686 = ( v3685 == 2'd0) ? In_register_EDX : 
	( v3685 == 2'd1) ? In_register_ESI : 
	( v3685 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v368c = ( v366b ) ? v368a : v3686;
wire v368d =  v2a == memory_0[15: 12] && v368c == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v368f = In_register_AF;
wire v3690 = v368f == Out_register_AF;
wire [31:0] v3691 = memory_0[79: 48];
wire [7:0] v3692 = v3691[7:0];
wire [31:0] v3695 = ( v366b ) ? vb0c : v63a;
wire [7:0] v3696 = v3695[7:0];
wire [7:0] v3697 = v3692 & v3696;
wire v3698 = v3697 == v2c;
wire v369a = v3698;
wire v369b = v369a == Out_register_ZF;
wire [31:0] v369d = In_register_EBX;
wire v369e = v369d == Out_register_EBX;
wire [31:0] v36a0 = In_register_EDI;
wire v36a1 = v36a0 == Out_register_EDI;
wire [31:0] v36a3 = In_register_EDX;
wire v36a4 = v36a3 == Out_register_EDX;
wire v36a6 = v17;
wire v36a7 = v36a6 == Out_register_OF;
wire [31:0] v36a9 = In_register_CSBASE;
wire v36aa = v36a9 == Out_register_CSBASE;
wire [2:0] v36ab_aux = v3697[0] + v3697[1] + v3697[2] + v3697[3] + v3697[4] + v3697[5] + v3697[6] + v3697[7];
wire v36ab = { 5'b00000, v36ab_aux };
wire [7:0] v36ac = v36ab & v18;
wire [7:0] v36ad = v36ac ^ v18;
wire v36ae = v36ad[0:0];
wire v36b0 = v36ae;
wire v36b1 = v36b0 == Out_register_PF;
wire [31:0] v36b3 = In_register_SSBASE;
wire v36b4 = v36b3 == Out_register_SSBASE;
wire [31:0] v36b6 = In_register_ESBASE;
wire v36b7 = v36b6 == Out_register_ESBASE;
wire [31:0] v36b9 = In_register_FSBASE;
wire v36ba = v36b9 == Out_register_FSBASE;
wire [31:0] v36bc = In_register_GSBASE;
wire v36bd = v36bc == Out_register_GSBASE;
wire v36be = v17;
wire v36bf = v36be == Out_register_CF;
wire [7:0] v36c1 = In_register_DF;
wire v36c2 = v36c1 == Out_register_DF;
wire [31:0] v36c4 = In_register_ECX;
wire v36c5 = v36c4 == Out_register_ECX;
wire v36c6 = $signed(v3697) < $signed(v2c);
wire v36c8 = v36c6;
wire v36c9 = v36c8 == Out_register_SF;
wire v36ca = v3670 & v15c & v3673 & v3676 & v367d & v367e & v3681 & v3684 & v368d & v3690 & v369b & v369e & v36a1 & v36a4 & v36a7 & v36aa & v36b1 & v366d & v36b4 & v36b7 & v36ba & v36bd & v36bf & v36c2 & v36c5 & v36c9;
wire v36cb = v40 == v1eb;
wire v36cc = v8 == v829;
wire v36cd = v74 == v1ed;
wire v36ce = v4 == v11b;
wire v36cf = v36cb & v36cc & v36cd & v36ce;
wire v36d0 = v36cf;
wire v36d1 = v36d0;
wire [31:0] v36d3 = In_register_EDX;
wire v36d4 = v36d3 == Out_register_EDX;
wire v36d5 = In_error_flag == Out_error_flag;
wire v36d7 = v17;
wire v36d8 = v36d7 == Out_register_CF;
wire [31:0] v36da = In_register_EBP;
wire v36db = v36da == Out_register_EBP;
wire [31:0] v36dd = In_register_ECX;
wire v36de = v36dd == Out_register_ECX;
wire [31:0] v36e0 = In_register_EAX;
wire v36e1 = v36e0 == Out_register_EAX;
wire [31:0] v36e3 = In_register_FSBASE;
wire v36e4 = v36e3 == Out_register_FSBASE;
wire [31:0] v36e6 = In_register_EDI;
wire v36e7 = v36e6 == Out_register_EDI;
wire [31:0] v36e9 = In_register_ESI;
wire v36ea = v36e9 == Out_register_ESI;
wire [31:0] v36ec = v10;
wire [31:0] v36ed = In_register_EIP + v36ec;
wire [31:0] v36ef = v36ed;
wire v36f0 = v36ef == Out_register_EIP;
wire [7:0] v36f2 = In_register_DF;
wire v36f3 = v36f2 == Out_register_DF;
wire v36f4 = v17;
wire v36f5 = v36f4 == Out_register_OF;
wire [31:0] v36f7 = In_register_CSBASE;
wire v36f8 = v36f7 == Out_register_CSBASE;
wire [1:0] v36f9 = { v889 , v888 };
wire [31:0] v36fa = ( v36f9 == 2'd0) ? In_register_EDX : 
	( v36f9 == 2'd1) ? In_register_ESI : 
	( v36f9 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v36fc = v36fa;
wire [31:0] v36fd = memory_0[79: 48];
wire [31:0] v36ff = v63a;
wire [31:0] v3700 = v36fd | v36ff;
wire v3701 =  v26 == memory_1[15: 12] && v36fc == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v3700 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v3703 = In_register_SSBASE;
wire v3704 = v3703 == Out_register_SSBASE;
wire [31:0] v3706 = In_register_ESP;
wire v3707 = v3706 == Out_register_ESP;
wire v3708 = $signed(v3700) < $signed(v15);
wire v370a = v3708;
wire v370b = v370a == Out_register_SF;
wire [31:0] v370d = In_register_ESBASE;
wire v370e = v370d == Out_register_ESBASE;
wire [31:0] v3710 = In_register_EBX;
wire v3711 = v3710 == Out_register_EBX;
wire [31:0] v3713 = In_register_DSBASE;
wire v3714 = v3713 == Out_register_DSBASE;
wire [31:0] v3716 = In_register_GSBASE;
wire v3717 = v3716 == Out_register_GSBASE;
wire [1:0] v3718 = { v889 , v888 };
wire [31:0] v3719 = ( v3718 == 2'd0) ? In_register_EDX : 
	( v3718 == 2'd1) ? In_register_ESI : 
	( v3718 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v371b = v3719;
wire v371c =  v26 == memory_0[15: 12] && v371b == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v371e = In_register_AF;
wire v371f = v371e == Out_register_AF;
wire [7:0] v3720 = v3700[7:0];
wire [2:0] v3721_aux = v3720[0] + v3720[1] + v3720[2] + v3720[3] + v3720[4] + v3720[5] + v3720[6] + v3720[7];
wire v3721 = { 5'b00000, v3721_aux };
wire [7:0] v3722 = v3721 & v18;
wire [7:0] v3723 = v3722 ^ v18;
wire v3724 = v3723[0:0];
wire v3726 = v3724;
wire v3727 = v3726 == Out_register_PF;
wire v3728 = v3700 == v15;
wire v372a = v3728;
wire v372b = v372a == Out_register_ZF;
wire v372c = v36d4 & v36d5 & v36d8 & v36db & v36de & v36e1 & v36e4 & v36e7 & v36ea & v15c & v36d1 & v36f0 & v36f3 & v36f5 & v36f8 & v3701 & v3704 & v3707 & v370b & v370e & v3711 & v3714 & v3717 & v371c & v371f & v3727 & v372b;
wire v372d = v40 == v1eb;
wire v372e = v9e == v1ed;
wire v372f = v38 == v6da;
wire [2:0] v3730 = { v1fa };
wire v3731 = v3730 == vb;
wire v3732 = v3731;
wire v3733 = v3732 ^ v8;
wire [2:0] v3734 = { v1fa };
wire v3735 = v3734 == vb;
wire v3736 = v3735;
wire v3737 = v3736 ^ v8;
wire v3738 = v3733 & v3737;
wire v3739 = v372d & v372e & v372f & v3738;
wire [15:0] vc0 = 16'b1100000100111100;
wire v373a = vc0 == v117;
wire v373b = v38 == v6da;
wire [2:0] v373c = { v13c };
wire v373d = v373c == vb;
wire v373e = v373c == vf;
wire v373f = v373d | v373e;
wire v3740 = v373f ^ v8;
wire [2:0] v3741 = { v12c };
wire v3742 = v3741 == vb;
wire v3743 = v3742;
wire v3744 = v3743 ^ v8;
wire [2:0] v3745 = { v13c };
wire v3746 = v3745 == vf;
wire v3747 = v3746;
wire v3748 = v3747 ^ v8;
wire v3749 = v3740 & v3744 & v3748;
wire v374a = v373a & v373b & v3749;
wire v374b = v40 == v1eb;
wire v374c = va1 == v1ed;
wire v374d = v4 == v11b;
wire [2:0] v374e = { v1fa };
wire v374f = v374e == vb;
wire v3750 = v374e == vf;
wire v3751 = v374f | v3750;
wire v3752 = v3751 ^ v8;
wire [2:0] v3753 = { v1fa };
wire v3754 = v3753 == vb;
wire v3755 = v3753 == vf;
wire v3756 = v3754 | v3755;
wire v3757 = v3756 ^ v8;
wire v3758 = v3752 & v3757;
wire v3759 = v374b & v374c & v374d & v3758;
wire [18:0] vc1 = 19'b1100000100111100101;
wire v375a = vc1 == vdfa;
wire v375b = v51 == vdfc;
wire v375c = v375a & v375b;
wire [15:0] vc2 = 16'b1100000100111101;
wire v375d = vc2 == v117;
wire v375e = v51 == vdfc;
wire [2:0] v375f = { v13c };
wire v3760 = v375f == vb;
wire v3761 = v375f == vf;
wire v3762 = v3760 | v3761;
wire v3763 = v3762 ^ v8;
wire [2:0] v3764 = { v12c };
wire v3765 = v3764 == vb;
wire v3766 = v3765;
wire v3767 = v3766 ^ v8;
wire v3768 = v3763 & v3767;
wire v3769 = v375d & v375e & v3768;
wire v376a = v3739 | v374a | v3759 | v375c | v3769;
wire v376b = v376a;
wire [31:0] v376c = memory_0[79: 48];
wire [31:0] v3772 = ( v3739 | v374a ) ? v7f8 : 
	( v375c | v3769 ) ? ve10 : v63a;
wire [31:0] v3773 = v376c - v3772;
wire v3774 = $signed(v3773) < $signed(v15);
wire v3776 = v3774;
wire v3777 = v3776 == Out_register_SF;
wire [2:0] v3778 = { v1fa };
wire [31:0] v3779 = ( v3778 == 3'd0) ? In_register_EAX : 
	( v3778 == 3'd1) ? In_register_ECX : 
	( v3778 == 3'd2) ? In_register_EDX : 
	( v3778 == 3'd3) ? In_register_EBX : 
	( v3778 == 3'd4) ? v15 : 
	( v3778 == 3'd5) ? In_register_EBP : 
	( v3778 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v377a = v3779 + v63a;
wire [2:0] v377c = { v13c };
wire [31:0] v377d = ( v377c == 3'd0) ? In_register_EAX : 
	( v377c == 3'd1) ? In_register_ECX : 
	( v377c == 3'd2) ? In_register_EDX : 
	( v377c == 3'd3) ? In_register_EBX : 
	( v377c == 3'd4) ? v15 : 
	( v377c == 3'd5) ? v15 : 
	( v377c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v377e = { v12c };
wire [31:0] v377f = ( v377e == 3'd0) ? In_register_EAX : 
	( v377e == 3'd1) ? In_register_ECX : 
	( v377e == 3'd2) ? In_register_EDX : 
	( v377e == 3'd3) ? In_register_EBX : 
	( v377e == 3'd4) ? v15 : 
	( v377e == 3'd5) ? In_register_EBP : 
	( v377e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3780 = v377f << v7f4;
wire [31:0] v3781 = v377d + v3780;
wire [2:0] v3786 = { v12c };
wire [31:0] v3787 = ( v3786 == 3'd0) ? In_register_EAX : 
	( v3786 == 3'd1) ? In_register_ECX : 
	( v3786 == 3'd2) ? In_register_EDX : 
	( v3786 == 3'd3) ? In_register_EBX : 
	( v3786 == 3'd4) ? v15 : 
	( v3786 == 3'd5) ? In_register_EBP : 
	( v3786 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3788 = v3787 << v7f4;
wire [31:0] v3789 = v3788 + vc2d;
wire [2:0] v378b = { v13c };
wire [31:0] v378c = ( v378b == 3'd0) ? In_register_EAX : 
	( v378b == 3'd1) ? In_register_ECX : 
	( v378b == 3'd2) ? In_register_EDX : 
	( v378b == 3'd3) ? In_register_EBX : 
	( v378b == 3'd4) ? v15 : 
	( v378b == 3'd5) ? v15 : 
	( v378b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v378d = { v12c };
wire [31:0] v378e = ( v378d == 3'd0) ? In_register_EAX : 
	( v378d == 3'd1) ? In_register_ECX : 
	( v378d == 3'd2) ? In_register_EDX : 
	( v378d == 3'd3) ? In_register_EBX : 
	( v378d == 3'd4) ? v15 : 
	( v378d == 3'd5) ? In_register_EBP : 
	( v378d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v378f = v378e << v7f4;
wire [31:0] v3790 = v378c + v378f;
wire [31:0] v3791 = v3790 + vc2d;
wire [2:0] v3783 = { v1fa };
wire [31:0] v3784 = ( v3783 == 3'd0) ? In_register_EAX : 
	( v3783 == 3'd1) ? In_register_ECX : 
	( v3783 == 3'd2) ? In_register_EDX : 
	( v3783 == 3'd3) ? In_register_EBX : 
	( v3783 == 3'd4) ? v15 : 
	( v3783 == 3'd5) ? v15 : 
	( v3783 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3793 = ( v3739 ) ? v377a : 
	( v374a ) ? v3781 : 
	( v375c ) ? v3789 : 
	( v3769 ) ? v3791 : v3784;
wire v3794 =  v26 == memory_0[15: 12] && v3793 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v3796 = In_register_EAX;
wire v3797 = v3796 == Out_register_EAX;
wire [31:0] v3799 = In_register_EBX;
wire v379a = v3799 == Out_register_EBX;
wire [31:0] v379c = In_register_EDX;
wire v379d = v379c == Out_register_EDX;
wire [31:0] v379f = In_register_ESP;
wire v37a0 = v379f == Out_register_ESP;
wire [31:0] v37a2 = In_register_ECX;
wire v37a3 = v37a2 == Out_register_ECX;
wire [31:0] v37a5 = In_register_DSBASE;
wire v37a6 = v37a5 == Out_register_DSBASE;
wire [31:0] v37a8 = In_register_CSBASE;
wire v37a9 = v37a8 == Out_register_CSBASE;
wire v37aa = In_error_flag == Out_error_flag;
wire [31:0] v37b0 = ( v375c | v3769 ) ? v31 : 
	( v3739 | v374a ) ? v27 : v10;
wire [31:0] v37b1 = In_register_EIP + v37b0;
wire [31:0] v37b3 = v37b1;
wire v37b4 = v37b3 == Out_register_EIP;
wire [31:0] v37b6 = In_register_EBP;
wire v37b7 = v37b6 == Out_register_EBP;
wire [31:0] v37b9 = In_register_EDI;
wire v37ba = v37b9 == Out_register_EDI;
wire [31:0] v37bc = In_register_SSBASE;
wire v37bd = v37bc == Out_register_SSBASE;
wire [31:0] v37bf = In_register_FSBASE;
wire v37c0 = v37bf == Out_register_FSBASE;
wire [31:0] v37c1 = v3773 ^ v376c;
wire [31:0] v37c2 = v37c1 >> v1e;
wire [31:0] v37c3 = v376c ^ v3772;
wire [31:0] v37c4 = v37c3 >> v1e;
wire [31:0] v37c5 = v37c2 + v37c4;
wire v37c6 = v37c5 == v1c;
wire v37c8 = v37c6;
wire v37c9 = v37c8 == Out_register_OF;
wire [31:0] v37cb = In_register_ESBASE;
wire v37cc = v37cb == Out_register_ESBASE;
wire [31:0] v37cd = v37c3 ^ v3773;
wire [7:0] v37ce = v37cd[7:0];
wire [7:0] v37cf = v37ce >> v1d;
wire [7:0] v37d0 = v37cf & v18;
wire v37d1 = v37d0[0:0];
wire v37d3 = v37d1;
wire v37d4 = v37d3 == Out_register_AF;
wire [7:0] v37d6 = In_register_DF;
wire v37d7 = v37d6 == Out_register_DF;
wire [31:0] v37d9 = In_register_GSBASE;
wire v37da = v37d9 == Out_register_GSBASE;
wire [31:0] v37dc = In_register_ESI;
wire v37dd = v37dc == Out_register_ESI;
wire v37de = v376c < v3772;
wire v37e0 = v37de;
wire v37e1 = v37e0 == Out_register_CF;
wire [7:0] v37e2 = v3773[7:0];
wire [2:0] v37e3_aux = v37e2[0] + v37e2[1] + v37e2[2] + v37e2[3] + v37e2[4] + v37e2[5] + v37e2[6] + v37e2[7];
wire v37e3 = { 5'b00000, v37e3_aux };
wire [7:0] v37e4 = v37e3 & v18;
wire [7:0] v37e5 = v37e4 ^ v18;
wire v37e6 = v37e5[0:0];
wire v37e8 = v37e6;
wire v37e9 = v37e8 == Out_register_PF;
wire v37ea = v376c == v3772;
wire v37ec = v37ea;
wire v37ed = v37ec == Out_register_ZF;
wire v37ee = v376b & v3777 & v3794 & v3797 & v379a & v379d & v37a0 & v15c & v37a3 & v37a6 & v37a9 & v37aa & v37b4 & v37b7 & v37ba & v37bd & v37c0 & v37c9 & v37cc & v37d4 & v37d7 & v37da & v37dd & v37e1 & v37e9 & v37ed;
wire [10:0] vc3 = 11'b10000100001;
wire v37ef = vc3 == v6d7;
wire v37f0 = v35 == v316;
wire v37f1 = v4 == v11b;
wire [2:0] v37f2 = { v13c };
wire v37f3 = v37f2 == vb;
wire v37f4 = v37f2 == vf;
wire v37f5 = v37f3 | v37f4;
wire v37f6 = v37f5 ^ v8;
wire [2:0] v37f7 = { v12c };
wire v37f8 = v37f7 == vb;
wire v37f9 = v37f8;
wire v37fa = v37f9 ^ v8;
wire [2:0] v37fb = { v13c };
wire v37fc = v37fb == vf;
wire v37fd = v37fc;
wire v37fe = v37fd ^ v8;
wire [2:0] v37ff = { v13c };
wire v3800 = v37ff == vb;
wire v3801 = v37ff == vf;
wire v3802 = v3800 | v3801;
wire v3803 = v3802 ^ v8;
wire [2:0] v3804 = { v12c };
wire v3805 = v3804 == vb;
wire v3806 = v3805;
wire v3807 = v3806 ^ v8;
wire [2:0] v3808 = { v13c };
wire v3809 = v3808 == vf;
wire v380a = v3809;
wire v380b = v380a ^ v8;
wire v380c = v37f6 & v37fa & v37fe & v3803 & v3807 & v380b;
wire v380d = v37ef & v37f0 & v37f1 & v380c;
wire v380e = v380d;
wire v380f = v380e;
wire [31:0] v3811 = In_register_EDI;
wire v3812 = v3811 == Out_register_EDI;
wire [31:0] v3814 = In_register_EBX;
wire v3815 = v3814 == Out_register_EBX;
wire [2:0] v3816 = { v13c };
wire [31:0] v3817 = ( v3816 == 3'd0) ? In_register_EAX : 
	( v3816 == 3'd1) ? In_register_ECX : 
	( v3816 == 3'd2) ? In_register_EDX : 
	( v3816 == 3'd3) ? In_register_EBX : 
	( v3816 == 3'd4) ? v15 : 
	( v3816 == 3'd5) ? v15 : 
	( v3816 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v3818 = { v12c };
wire [31:0] v3819 = ( v3818 == 3'd0) ? In_register_EAX : 
	( v3818 == 3'd1) ? In_register_ECX : 
	( v3818 == 3'd2) ? In_register_EDX : 
	( v3818 == 3'd3) ? In_register_EBX : 
	( v3818 == 3'd4) ? v15 : 
	( v3818 == 3'd5) ? In_register_EBP : 
	( v3818 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v381a = v3819 << v7f4;
wire [31:0] v381b = v3817 + v381a;
wire [31:0] v381d = v381b;
wire v381e =  v26 == memory_0[15: 12] && v381d == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v381f = In_error_flag == Out_error_flag;
wire [31:0] v3821 = In_register_ESP;
wire v3822 = v3821 == Out_register_ESP;
wire [31:0] v3824 = In_register_EBP;
wire v3825 = v3824 == Out_register_EBP;
wire [31:0] v3827 = In_register_EAX;
wire v3828 = v3827 == Out_register_EAX;
wire [31:0] v382a = In_register_ECX;
wire v382b = v382a == Out_register_ECX;
wire [31:0] v382d = In_register_ESBASE;
wire v382e = v382d == Out_register_ESBASE;
wire [31:0] v3830 = In_register_DSBASE;
wire v3831 = v3830 == Out_register_DSBASE;
wire [31:0] v3833 = In_register_EDX;
wire v3834 = v3833 == Out_register_EDX;
wire [31:0] v3835 = memory_0[79: 48];
wire [2:0] v3836 = { v320 };
wire [31:0] v3837 = ( v3836 == 3'd0) ? In_register_EAX : 
	( v3836 == 3'd1) ? In_register_ECX : 
	( v3836 == 3'd2) ? In_register_EDX : 
	( v3836 == 3'd3) ? In_register_EBX : 
	( v3836 == 3'd4) ? In_register_ESP : 
	( v3836 == 3'd5) ? In_register_EBP : 
	( v3836 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3839 = v3837;
wire [31:0] v383a = v3835 & v3839;
wire v383b = v383a == v15;
wire v383d = v383b;
wire v383e = v383d == Out_register_ZF;
wire [31:0] v3840 = In_register_ESI;
wire v3841 = v3840 == Out_register_ESI;
wire [2:0] v3842 = { v13c };
wire [31:0] v3843 = ( v3842 == 3'd0) ? In_register_EAX : 
	( v3842 == 3'd1) ? In_register_ECX : 
	( v3842 == 3'd2) ? In_register_EDX : 
	( v3842 == 3'd3) ? In_register_EBX : 
	( v3842 == 3'd4) ? v15 : 
	( v3842 == 3'd5) ? v15 : 
	( v3842 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v3844 = { v12c };
wire [31:0] v3845 = ( v3844 == 3'd0) ? In_register_EAX : 
	( v3844 == 3'd1) ? In_register_ECX : 
	( v3844 == 3'd2) ? In_register_EDX : 
	( v3844 == 3'd3) ? In_register_EBX : 
	( v3844 == 3'd4) ? v15 : 
	( v3844 == 3'd5) ? In_register_EBP : 
	( v3844 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3846 = v3845 << v7f4;
wire [31:0] v3847 = v3843 + v3846;
wire [31:0] v3849 = v3847;
wire v384a =  v26 == memory_1[15: 12] && v3849 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v383a == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v384c = In_register_GSBASE;
wire v384d = v384c == Out_register_GSBASE;
wire [31:0] v384f = v10;
wire [31:0] v3850 = In_register_EIP + v384f;
wire [31:0] v3852 = v3850;
wire v3853 = v3852 == Out_register_EIP;
wire v3855 = v17;
wire v3856 = v3855 == Out_register_AF;
wire [31:0] v3858 = In_register_CSBASE;
wire v3859 = v3858 == Out_register_CSBASE;
wire [31:0] v385b = In_register_SSBASE;
wire v385c = v385b == Out_register_SSBASE;
wire [31:0] v385e = In_register_FSBASE;
wire v385f = v385e == Out_register_FSBASE;
wire [7:0] v3860 = v383a[7:0];
wire [2:0] v3861_aux = v3860[0] + v3860[1] + v3860[2] + v3860[3] + v3860[4] + v3860[5] + v3860[6] + v3860[7];
wire v3861 = { 5'b00000, v3861_aux };
wire [7:0] v3862 = v3861 & v18;
wire [7:0] v3863 = v3862 ^ v18;
wire v3864 = v3863[0:0];
wire v3866 = v3864;
wire v3867 = v3866 == Out_register_PF;
wire v3868 = v17;
wire v3869 = v3868 == Out_register_OF;
wire v386a = v17;
wire v386b = v386a == Out_register_CF;
wire [7:0] v386d = In_register_DF;
wire v386e = v386d == Out_register_DF;
wire v386f = $signed(v383a) < $signed(v15);
wire v3871 = v386f;
wire v3872 = v3871 == Out_register_SF;
wire v3873 = v3812 & v3815 & v381e & v381f & v3822 & v15c & v3825 & v3828 & v382b & v382e & v3831 & v3834 & v383e & v3841 & v384a & v384d & v3853 & v3856 & v3859 & v380f & v385c & v385f & v3867 & v3869 & v386b & v386e & v3872;
wire v3874 = v4e == v1eb;
wire v3875 = v6a == v1ed;
wire v3876 = v14 == v1ef;
wire [2:0] v3877 = { v1fa };
wire v3878 = v3877 == vb;
wire v3879 = v3877 == vf;
wire v387a = v3878 | v3879;
wire v387b = v387a ^ v8;
wire [2:0] v387c = { v1fa };
wire v387d = v387c == vb;
wire v387e = v387d;
wire v387f = v387e ^ v8;
wire [2:0] v3880 = { v1fa };
wire v3881 = v3880 == vb;
wire v3882 = v3880 == vf;
wire v3883 = v3881 | v3882;
wire v3884 = v3883 ^ v8;
wire [2:0] v3885 = { v1fa };
wire v3886 = v3885 == vb;
wire v3887 = v3886;
wire v3888 = v3887 ^ v8;
wire v3889 = v387b & v387f & v3884 & v3888;
wire v388a = v3874 & v3875 & v3876 & v3889;
wire v388b = v4e == v1eb;
wire v388c = v25 == v1ed;
wire v388d = v1b == v318;
wire [2:0] v388e = { v1fa };
wire v388f = v388e == vb;
wire v3890 = v388e == vf;
wire v3891 = v388f | v3890;
wire v3892 = v3891 ^ v8;
wire [2:0] v3893 = { v1fa };
wire v3894 = v3893 == vb;
wire v3895 = v3893 == vf;
wire v3896 = v3894 | v3895;
wire v3897 = v3896 ^ v8;
wire [2:0] v3898 = { v1fa };
wire v3899 = v3898 == vb;
wire v389a = v3898 == vf;
wire v389b = v3899 | v389a;
wire v389c = v389b ^ v8;
wire [2:0] v389d = { v1fa };
wire v389e = v389d == vb;
wire v389f = v389d == vf;
wire v38a0 = v389e | v389f;
wire v38a1 = v38a0 ^ v8;
wire v38a2 = v3892 & v3897 & v389c & v38a1;
wire v38a3 = v388b & v388c & v388d & v38a2;
wire [15:0] vc4 = 16'b1111111110100000;
wire v38a4 = vc4 == v117;
wire v38a5 = v14 == v1ef;
wire v38a6 = v38a4 & v38a5;
wire v38a7 = v388a | v38a3 | v38a6;
wire v38a8 = v38a7;
wire v38a9 = In_error_flag == Out_error_flag;
wire v38ab = In_register_CF;
wire v38ac = v38ab == Out_register_CF;
wire [31:0] v38ad = memory_0[79: 48];
wire [31:0] v38ae = v38ad + v2b;
wire [31:0] v38af = v38ae ^ v38ad;
wire [31:0] v38b0 = v38af >> v1e;
wire [31:0] v38b1 = v38ae >> v1e;
wire [31:0] v38b2 = v38b0 + v38b1;
wire v38b3 = v38b2 == v1c;
wire v38b5 = v38b3;
wire v38b6 = v38b5 == Out_register_OF;
wire [31:0] v38b8 = In_register_ESP;
wire v38b9 = v38b8 == Out_register_ESP;
wire [2:0] v38ba = { v1fa };
wire [31:0] v38bb = ( v38ba == 3'd0) ? In_register_EAX : 
	( v38ba == 3'd1) ? In_register_ECX : 
	( v38ba == 3'd2) ? In_register_EDX : 
	( v38ba == 3'd3) ? In_register_EBX : 
	( v38ba == 3'd4) ? v15 : 
	( v38ba == 3'd5) ? v15 : 
	( v38ba == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v38bc = v38bb + v1f7;
wire [2:0] v38be = { v1fa };
wire [31:0] v38bf = ( v38be == 3'd0) ? In_register_EAX : 
	( v38be == 3'd1) ? In_register_ECX : 
	( v38be == 3'd2) ? In_register_EDX : 
	( v38be == 3'd3) ? In_register_EBX : 
	( v38be == 3'd4) ? v15 : 
	( v38be == 3'd5) ? v15 : 
	( v38be == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v38c2 = ( v388a ) ? v38bc : 
	( v38a3 ) ? v38bf : v1f7;
wire v38c3 =  v26 == memory_1[15: 12] && v38c2 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v38ae == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [2:0] v38c4 = { v1fa };
wire [31:0] v38c5 = ( v38c4 == 3'd0) ? In_register_EAX : 
	( v38c4 == 3'd1) ? In_register_ECX : 
	( v38c4 == 3'd2) ? In_register_EDX : 
	( v38c4 == 3'd3) ? In_register_EBX : 
	( v38c4 == 3'd4) ? v15 : 
	( v38c4 == 3'd5) ? v15 : 
	( v38c4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v38c6 = v38c5 + v1f7;
wire [2:0] v38c8 = { v1fa };
wire [31:0] v38c9 = ( v38c8 == 3'd0) ? In_register_EAX : 
	( v38c8 == 3'd1) ? In_register_ECX : 
	( v38c8 == 3'd2) ? In_register_EDX : 
	( v38c8 == 3'd3) ? In_register_EBX : 
	( v38c8 == 3'd4) ? v15 : 
	( v38c8 == 3'd5) ? v15 : 
	( v38c8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v38cc = ( v388a ) ? v38c6 : 
	( v38a3 ) ? v38c9 : v1f7;
wire v38cd =  v26 == memory_0[15: 12] && v38cc == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v38cf = In_register_EAX;
wire v38d0 = v38cf == Out_register_EAX;
wire [31:0] v38d4 = ( v38a3 ) ? v1c : v16;
wire [31:0] v38d5 = In_register_EIP + v38d4;
wire [31:0] v38d7 = v38d5;
wire v38d8 = v38d7 == Out_register_EIP;
wire [7:0] v38d9 = v38ae[7:0];
wire [2:0] v38da_aux = v38d9[0] + v38d9[1] + v38d9[2] + v38d9[3] + v38d9[4] + v38d9[5] + v38d9[6] + v38d9[7];
wire v38da = { 5'b00000, v38da_aux };
wire [7:0] v38db = v38da & v18;
wire [7:0] v38dc = v38db ^ v18;
wire v38dd = v38dc[0:0];
wire v38df = v38dd;
wire v38e0 = v38df == Out_register_PF;
wire [31:0] v38e2 = In_register_EBX;
wire v38e3 = v38e2 == Out_register_EBX;
wire [31:0] v38e5 = In_register_EDI;
wire v38e6 = v38e5 == Out_register_EDI;
wire [31:0] v38e8 = In_register_DSBASE;
wire v38e9 = v38e8 == Out_register_DSBASE;
wire [7:0] v38eb = In_register_DF;
wire v38ec = v38eb == Out_register_DF;
wire [31:0] v38ee = In_register_ECX;
wire v38ef = v38ee == Out_register_ECX;
wire [31:0] v38f1 = In_register_EDX;
wire v38f2 = v38f1 == Out_register_EDX;
wire [31:0] v38f4 = In_register_ESI;
wire v38f5 = v38f4 == Out_register_ESI;
wire v38f6 = $signed(v38ae) < $signed(v15);
wire v38f8 = v38f6;
wire v38f9 = v38f8 == Out_register_SF;
wire [31:0] v38fb = In_register_EBP;
wire v38fc = v38fb == Out_register_EBP;
wire [31:0] v38fe = In_register_CSBASE;
wire v38ff = v38fe == Out_register_CSBASE;
wire [31:0] v3901 = In_register_ESBASE;
wire v3902 = v3901 == Out_register_ESBASE;
wire [31:0] v3904 = In_register_GSBASE;
wire v3905 = v3904 == Out_register_GSBASE;
wire [31:0] v3907 = In_register_FSBASE;
wire v3908 = v3907 == Out_register_FSBASE;
wire [7:0] v3909 = v38af[7:0];
wire [7:0] v390a = v3909 >> v1d;
wire [7:0] v390b = v390a & v18;
wire v390c = v390b[0:0];
wire v390e = v390c;
wire v390f = v390e == Out_register_AF;
wire [31:0] v3911 = In_register_SSBASE;
wire v3912 = v3911 == Out_register_SSBASE;
wire v3913 = v38ae == v15;
wire v3915 = v3913;
wire v3916 = v3915 == Out_register_ZF;
wire v3917 = v38a8 & v38a9 & v38ac & v38b6 & v38b9 & v38c3 & v38cd & v38d0 & v38d8 & v38e0 & v38e3 & v15c & v38e6 & v38e9 & v38ec & v38ef & v38f2 & v38f5 & v38f9 & v38fc & v38ff & v3902 & v3905 & v3908 & v390f & v3912 & v3916;
wire v3918 = v12 == v1eb;
wire v3919 = v59 == v1ed;
wire v391a = v14 == v1ef;
wire v391b = v3918 & v3919 & v391a;
wire v391c = v391b;
wire v391d = v391c;
wire [2:0] v3925 = { v1fa };
wire v3926 = v3925 == v7;
wire v3927 = v3926;
wire v3928 = v391b & v3927;
wire v3929 = v3928;
wire [31:0] v391f = v1f7;
wire [2:0] v3920 = { v1fa };
wire [31:0] v3921 = ( v3920 == 3'd0) ? In_register_EAX : 
	( v3920 == 3'd1) ? In_register_ECX : 
	( v3920 == 3'd2) ? In_register_EDX : 
	( v3920 == 3'd3) ? In_register_EBX : 
	( v3920 == 3'd4) ? In_register_ESP : 
	( v3920 == 3'd5) ? In_register_EBP : 
	( v3920 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3923 = v3921;
wire [31:0] v3924 = v391f + v3923;
wire [31:0] v392c = ( v8 ) ? In_register_EAX : v3924;
wire [31:0] v392e = v392c;
wire v392f = v392e == Out_register_EAX;
wire v3930 = v3925 == vd;
wire v3931 = v3930;
wire v3932 = v391b & v3931;
wire v3933 = v3932;
wire [31:0] v3936 = ( v8 ) ? In_register_EBX : v3924;
wire [31:0] v3938 = v3936;
wire v3939 = v3938 == Out_register_EBX;
wire v393a = In_error_flag == Out_error_flag;
wire v393b = v3925 == ve;
wire v393c = v393b;
wire v393d = v391b & v393c;
wire v393e = v393d;
wire [31:0] v3941 = ( v8 ) ? In_register_EDX : v3924;
wire [31:0] v3943 = v3941;
wire v3944 = v3943 == Out_register_EDX;
wire [31:0] v3946 = In_register_CSBASE;
wire v3947 = v3946 == Out_register_CSBASE;
wire v3948 = v3924 < v3923;
wire v3949 = v3924 < v391f;
wire v394a = v3948 | v3949;
wire v394c = v394a;
wire v394d = v394c == Out_register_CF;
wire v394e = v3925 == vb;
wire v394f = v394e;
wire v3950 = v391b & v394f;
wire v3951 = v3950;
wire [31:0] v3954 = ( v8 ) ? In_register_ESP : v3924;
wire [31:0] v3956 = v3954;
wire v3957 = v3956 == Out_register_ESP;
wire [31:0] v3959 = v16;
wire [31:0] v395a = In_register_EIP + v3959;
wire [31:0] v395c = v395a;
wire v395d = v395c == Out_register_EIP;
wire v395e = v3925 == vf;
wire v395f = v395e;
wire v3960 = v391b & v395f;
wire v3961 = v3960;
wire [31:0] v3964 = ( v8 ) ? In_register_EBP : v3924;
wire [31:0] v3966 = v3964;
wire v3967 = v3966 == Out_register_EBP;
wire v3968 = v3925 == v11;
wire v3969 = v3968;
wire v396a = v391b & v3969;
wire v396b = v396a;
wire [31:0] v396e = ( v8 ) ? In_register_ESI : v3924;
wire [31:0] v3970 = v396e;
wire v3971 = v3970 == Out_register_ESI;
wire [31:0] v3973 = In_register_SSBASE;
wire v3974 = v3973 == Out_register_SSBASE;
wire v3975 = v3925 == vc;
wire v3976 = v3975;
wire v3977 = v391b & v3976;
wire v3978 = v3977;
wire [31:0] v397b = ( v8 ) ? In_register_ECX : v3924;
wire [31:0] v397d = v397b;
wire v397e = v397d == Out_register_ECX;
wire [31:0] v3980 = In_register_DSBASE;
wire v3981 = v3980 == Out_register_DSBASE;
wire [31:0] v3983 = In_register_ESBASE;
wire v3984 = v3983 == Out_register_ESBASE;
wire [31:0] v3986 = In_register_GSBASE;
wire v3987 = v3986 == Out_register_GSBASE;
wire [31:0] v3988 = v3924 ^ v3923;
wire [31:0] v3989 = v3988 >> v1e;
wire [31:0] v398a = v3924 ^ v391f;
wire [31:0] v398b = v398a >> v1e;
wire [31:0] v398c = v3989 + v398b;
wire v398d = v398c == v1c;
wire v398f = v398d;
wire v3990 = v398f == Out_register_OF;
wire [31:0] v3992 = In_register_FSBASE;
wire v3993 = v3992 == Out_register_FSBASE;
wire [7:0] v3994 = v3924[7:0];
wire [2:0] v3995_aux = v3994[0] + v3994[1] + v3994[2] + v3994[3] + v3994[4] + v3994[5] + v3994[6] + v3994[7];
wire v3995 = { 5'b00000, v3995_aux };
wire [7:0] v3996 = v3995 & v18;
wire [7:0] v3997 = v3996 ^ v18;
wire v3998 = v3997[0:0];
wire v399a = v3998;
wire v399b = v399a == Out_register_PF;
wire [31:0] v399c = v398a ^ v3923;
wire [7:0] v399d = v399c[7:0];
wire [7:0] v399e = v399d >> v1d;
wire [7:0] v399f = v399e & v18;
wire v39a0 = v399f[0:0];
wire v39a2 = v39a0;
wire v39a3 = v39a2 == Out_register_AF;
wire [7:0] v39a5 = In_register_DF;
wire v39a6 = v39a5 == Out_register_DF;
wire v39a7 = $signed(v3924) < $signed(v15);
wire v39a9 = v39a7;
wire v39aa = v39a9 == Out_register_SF;
wire v39ab = v3925 == v9;
wire v39ac = v39ab;
wire v39ad = v391b & v39ac;
wire v39ae = v39ad;
wire [31:0] v39b1 = ( v8 ) ? In_register_EDI : v3924;
wire [31:0] v39b3 = v39b1;
wire v39b4 = v39b3 == Out_register_EDI;
wire v39b5 = v3924 == v15;
wire v39b7 = v39b5;
wire v39b8 = v39b7 == Out_register_ZF;
wire v39b9 = v391d & v392f & v3939 & v393a & v3944 & v3947 & v394d & v3957 & v395d & v3967 & v3971 & v3974 & v397e & v3981 & v3984 & v3987 & v3990 & v3993 & v15c & v399b & v39a3 & v39a6 & v39aa & v39b4 & v39b8;
wire v39ba = v12 == v1eb;
wire v39bb = v9b == v1ed;
wire v39bc = v14 == v1ef;
wire v39bd = v39ba & v39bb & v39bc;
wire v39be = v39bd;
wire v39bf = v39be;
wire [2:0] v39c8 = { v1fa };
wire v39c9 = v39c8 == v7;
wire v39ca = v39c9;
wire v39cb = v39bd & v39ca;
wire v39cc = v39cb;
wire [2:0] v39c0 = { v1fa };
wire [31:0] v39c1 = ( v39c0 == 3'd0) ? In_register_EAX : 
	( v39c0 == 3'd1) ? In_register_ECX : 
	( v39c0 == 3'd2) ? In_register_EDX : 
	( v39c0 == 3'd3) ? In_register_EBX : 
	( v39c0 == 3'd4) ? In_register_ESP : 
	( v39c0 == 3'd5) ? In_register_EBP : 
	( v39c0 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v39c3 = v39c1;
wire [31:0] v39c5 = v1f7;
wire [31:0] v39c6 = v39c3 - v39c5;
wire [31:0] v39c7 = v39c6 - vb11;
wire [31:0] v39cf = ( v8 ) ? In_register_EAX : v39c7;
wire [31:0] v39d1 = v39cf;
wire v39d2 = v39d1 == Out_register_EAX;
wire v39d3 = v39c8 == vc;
wire v39d4 = v39d3;
wire v39d5 = v39bd & v39d4;
wire v39d6 = v39d5;
wire [31:0] v39d9 = ( v8 ) ? In_register_ECX : v39c7;
wire [31:0] v39db = v39d9;
wire v39dc = v39db == Out_register_ECX;
wire v39dd = v39c8 == vf;
wire v39de = v39dd;
wire v39df = v39bd & v39de;
wire v39e0 = v39df;
wire [31:0] v39e3 = ( v8 ) ? In_register_EBP : v39c7;
wire [31:0] v39e5 = v39e3;
wire v39e6 = v39e5 == Out_register_EBP;
wire v39e7 = v39c3 < v39c5;
wire v39e8 = v39c6 < vb11;
wire [7:0] v39e9 = { 7'b0000000, v39e8 };
wire [7:0] v39ea = ( v39e7 == 1'd0) ? v39e9 : v18;
wire v39eb = v39ea[0:0];
wire v39ed = v39eb;
wire v39ee = v39ed == Out_register_CF;
wire v39ef = v39c8 == v11;
wire v39f0 = v39ef;
wire v39f1 = v39bd & v39f0;
wire v39f2 = v39f1;
wire [31:0] v39f5 = ( v8 ) ? In_register_ESI : v39c7;
wire [31:0] v39f7 = v39f5;
wire v39f8 = v39f7 == Out_register_ESI;
wire [31:0] v39f9 = v39c5 ^ v39c3;
wire [31:0] v39fa = v39c7 ^ v39f9;
wire [7:0] v39fb = v39fa[7:0];
wire [7:0] v39fc = v39fb >> v1d;
wire [7:0] v39fd = v39fc & v18;
wire v39fe = v39fd[0:0];
wire v3a00 = v39fe;
wire v3a01 = v3a00 == Out_register_AF;
wire [7:0] v3a03 = In_register_DF;
wire v3a04 = v3a03 == Out_register_DF;
wire [31:0] v3a06 = In_register_FSBASE;
wire v3a07 = v3a06 == Out_register_FSBASE;
wire v3a08 = v39c8 == vd;
wire v3a09 = v3a08;
wire v3a0a = v39bd & v3a09;
wire v3a0b = v3a0a;
wire [31:0] v3a0e = ( v8 ) ? In_register_EBX : v39c7;
wire [31:0] v3a10 = v3a0e;
wire v3a11 = v3a10 == Out_register_EBX;
wire v3a12 = v39c8 == ve;
wire v3a13 = v3a12;
wire v3a14 = v39bd & v3a13;
wire v3a15 = v3a14;
wire [31:0] v3a18 = ( v8 ) ? In_register_EDX : v39c7;
wire [31:0] v3a1a = v3a18;
wire v3a1b = v3a1a == Out_register_EDX;
wire v3a1c = v39c8 == v9;
wire v3a1d = v3a1c;
wire v3a1e = v39bd & v3a1d;
wire v3a1f = v3a1e;
wire [31:0] v3a22 = ( v8 ) ? In_register_EDI : v39c7;
wire [31:0] v3a24 = v3a22;
wire v3a25 = v3a24 == Out_register_EDI;
wire [7:0] v3a26 = v39c7[7:0];
wire [2:0] v3a27_aux = v3a26[0] + v3a26[1] + v3a26[2] + v3a26[3] + v3a26[4] + v3a26[5] + v3a26[6] + v3a26[7];
wire v3a27 = { 5'b00000, v3a27_aux };
wire [7:0] v3a28 = v3a27 & v18;
wire [7:0] v3a29 = v3a28 ^ v18;
wire v3a2a = v3a29[0:0];
wire v3a2c = v3a2a;
wire v3a2d = v3a2c == Out_register_PF;
wire v3a2e = v39c8 == vb;
wire v3a2f = v3a2e;
wire v3a30 = v39bd & v3a2f;
wire v3a31 = v3a30;
wire [31:0] v3a34 = ( v8 ) ? In_register_ESP : v39c7;
wire [31:0] v3a36 = v3a34;
wire v3a37 = v3a36 == Out_register_ESP;
wire v3a38 = v39c6 == vb11;
wire v3a3a = v3a38;
wire v3a3b = v3a3a == Out_register_ZF;
wire [31:0] v3a3d = In_register_CSBASE;
wire v3a3e = v3a3d == Out_register_CSBASE;
wire v3a3f = In_error_flag == Out_error_flag;
wire [31:0] v3a41 = In_register_SSBASE;
wire v3a42 = v3a41 == Out_register_SSBASE;
wire [31:0] v3a44 = v16;
wire [31:0] v3a45 = In_register_EIP + v3a44;
wire [31:0] v3a47 = v3a45;
wire v3a48 = v3a47 == Out_register_EIP;
wire v3a49 = $signed(v39c7) < $signed(v15);
wire v3a4b = v3a49;
wire v3a4c = v3a4b == Out_register_SF;
wire [31:0] v3a4e = In_register_DSBASE;
wire v3a4f = v3a4e == Out_register_DSBASE;
wire [31:0] v3a51 = In_register_GSBASE;
wire v3a52 = v3a51 == Out_register_GSBASE;
wire [31:0] v3a53 = v39c7 ^ v39c3;
wire [31:0] v3a54 = v3a53 >> v1e;
wire [31:0] v3a55 = v39f9 >> v1e;
wire [31:0] v3a56 = v3a54 + v3a55;
wire v3a57 = v3a56 == v1c;
wire v3a59 = v3a57;
wire v3a5a = v3a59 == Out_register_OF;
wire [31:0] v3a5c = In_register_ESBASE;
wire v3a5d = v3a5c == Out_register_ESBASE;
wire v3a5e = v39bf & v39d2 & v39dc & v39e6 & v39ee & v39f8 & v3a01 & v3a04 & v3a07 & v3a11 & v3a1b & v3a25 & v3a2d & v3a37 & v3a3b & v3a3e & v3a3f & v3a42 & v3a48 & v15c & v3a4c & v3a4f & v3a52 & v3a5a & v3a5d;
wire [7:0] vc5 = 8'b01101110;
wire v3a5f = vc5 == v1eb;
wire v3a60 = v1b == v318;
wire v3a61 = v3a5f & v3a60;
wire v3a62 = v3a61;
wire v3a63 = v3a62;
wire v3a64 = In_error_flag == Out_error_flag;
wire [7:0] v3a66 = In_register_DF;
wire v3a67 = v3a66 == Out_register_DF;
wire [31:0] v3a69 = In_register_EBP;
wire v3a6a = v3a69 == Out_register_EBP;
wire [7:0] v3a6b = v289b | v65f;
wire v3a6c = v3a6b != v2c;
wire [31:0] v3a6e = v1c;
wire [31:0] v3a6f = In_register_EIP + v3a6e;
wire [31:0] v3a71 = v3a6f;
wire [31:0] v3a72 = v3a6f + v477;
wire [31:0] v3a74 = v3a72;
wire [31:0] v3a75 = ( v3a6c == 1'd0) ? v3a71 : v3a74;
wire [31:0] v3a78 = ( v3a62 ) ? v3a75 : v3a6f;
wire [31:0] v3a7a = v3a78;
wire v3a7b = v3a7a == Out_register_EIP;
wire v3a7d = In_register_PF;
wire v3a7e = v3a7d == Out_register_PF;
wire [31:0] v3a80 = In_register_GSBASE;
wire v3a81 = v3a80 == Out_register_GSBASE;
wire [31:0] v3a83 = In_register_ESI;
wire v3a84 = v3a83 == Out_register_ESI;
wire [31:0] v3a86 = In_register_EDX;
wire v3a87 = v3a86 == Out_register_EDX;
wire [31:0] v3a89 = In_register_EAX;
wire v3a8a = v3a89 == Out_register_EAX;
wire [31:0] v3a8c = In_register_ESP;
wire v3a8d = v3a8c == Out_register_ESP;
wire [31:0] v3a8f = In_register_SSBASE;
wire v3a90 = v3a8f == Out_register_SSBASE;
wire [31:0] v3a92 = In_register_CSBASE;
wire v3a93 = v3a92 == Out_register_CSBASE;
wire [31:0] v3a95 = In_register_EBX;
wire v3a96 = v3a95 == Out_register_EBX;
wire [31:0] v3a98 = In_register_ECX;
wire v3a99 = v3a98 == Out_register_ECX;
wire [31:0] v3a9b = In_register_ESBASE;
wire v3a9c = v3a9b == Out_register_ESBASE;
wire [31:0] v3a9e = In_register_DSBASE;
wire v3a9f = v3a9e == Out_register_DSBASE;
wire [31:0] v3aa1 = In_register_FSBASE;
wire v3aa2 = v3aa1 == Out_register_FSBASE;
wire [31:0] v3aa4 = In_register_EDI;
wire v3aa5 = v3aa4 == Out_register_EDI;
wire v3aa7 = In_register_CF;
wire v3aa8 = v3aa7 == Out_register_CF;
wire v3aaa = In_register_AF;
wire v3aab = v3aaa == Out_register_AF;
wire v3aad = In_register_OF;
wire v3aae = v3aad == Out_register_OF;
wire v3ab0 = In_register_SF;
wire v3ab1 = v3ab0 == Out_register_SF;
wire v3ab3 = In_register_ZF;
wire v3ab4 = v3ab3 == Out_register_ZF;
wire v3ab5 = v3a63 & v3a64 & v3a67 & v3a6a & v15c & v3a7b & v3a7e & v3a81 & v3a84 & v3a87 & v3a8a & v3a8d & v3a90 & v3a93 & v3a96 & v3a99 & v3a9c & v3a9f & v3aa2 & v3aa5 & v3aa8 & v3aab & v3aae & v3ab1 & v3ab4;
wire [7:0] vc6 = 8'b10010111;
wire v3ab6 = vc6 == v1eb;
wire v3ab7 = v47 == vb69;
wire v3ab8 = v3ab6 & v3ab7;
wire v3ab9 = v3ab8;
wire v3aba = v3ab9;
wire [31:0] v3abc = In_register_EDI;
wire v3abd = v3abc == Out_register_EDI;
wire [31:0] v3abf = In_register_EBX;
wire v3ac0 = v3abf == Out_register_EBX;
wire [7:0] v3ac2 = In_register_DF;
wire v3ac3 = v3ac2 == Out_register_DF;
wire [31:0] v3ac5 = In_register_ECX;
wire v3ac6 = v3ac5 == Out_register_ECX;
wire [31:0] v3ac8 = In_register_GSBASE;
wire v3ac9 = v3ac8 == Out_register_GSBASE;
wire [31:0] v3acb = In_register_EDX;
wire v3acc = v3acb == Out_register_EDX;
wire [31:0] v3ace = In_register_ESI;
wire v3acf = v3ace == Out_register_ESI;
wire v3ad1 = In_register_CF;
wire v3ad2 = v3ad1 == Out_register_CF;
wire [31:0] v3ad4 = In_register_EBP;
wire v3ad5 = v3ad4 == Out_register_EBP;
wire [31:0] v3ad7 = In_register_ESP;
wire v3ad8 = v3ad7 == Out_register_ESP;
wire [31:0] v3ada = v48;
wire [31:0] v3adb = In_register_EIP + v3ada;
wire [31:0] v3adc = v3adb + vb74;
wire [31:0] v3ade = v3adc;
wire [31:0] v3ae1 = v3ade;
wire [31:0] v3ae3 = v3ae1;
wire v3ae4 = v3ae3 == Out_register_EIP;
wire [31:0] v3ae6 = In_register_SSBASE;
wire v3ae7 = v3ae6 == Out_register_SSBASE;
wire v3ae9 = In_register_OF;
wire v3aea = v3ae9 == Out_register_OF;
wire [31:0] v3aec = In_register_EAX;
wire v3aed = v3aec == Out_register_EAX;
wire [31:0] v3aef = In_register_ESBASE;
wire v3af0 = v3aef == Out_register_ESBASE;
wire [31:0] v3af2 = In_register_CSBASE;
wire v3af3 = v3af2 == Out_register_CSBASE;
wire [31:0] v3af5 = In_register_FSBASE;
wire v3af6 = v3af5 == Out_register_FSBASE;
wire v3af7 = In_error_flag == Out_error_flag;
wire [31:0] v3af9 = In_register_DSBASE;
wire v3afa = v3af9 == Out_register_DSBASE;
wire v3afc = In_register_AF;
wire v3afd = v3afc == Out_register_AF;
wire v3aff = In_register_PF;
wire v3b00 = v3aff == Out_register_PF;
wire v3b02 = In_register_SF;
wire v3b03 = v3b02 == Out_register_SF;
wire v3b05 = In_register_ZF;
wire v3b06 = v3b05 == Out_register_ZF;
wire v3b07 = v3abd & v3ac0 & v3ac3 & v3ac6 & v3aba & v15c & v3ac9 & v3acc & v3acf & v3ad2 & v3ad5 & v3ad8 & v3ae4 & v3ae7 & v3aea & v3aed & v3af0 & v3af3 & v3af6 & v3af7 & v3afa & v3afd & v3b00 & v3b03 & v3b06;
wire [7:0] vc7 = 8'b11011100;
wire v3b08 = vc7 == v1eb;
wire v3b09 = v3 == v316;
wire v3b0a = v1b == v318;
wire v3b0b = v3b08 & v3b09 & v3b0a;
wire v3b0c = v3b0b;
wire v3b0d = v3b0c;
wire [31:0] v3b0f = In_register_DSBASE;
wire v3b10 = v3b0f == Out_register_DSBASE;
wire [31:0] v3b12 = In_register_EDI;
wire v3b13 = v3b12 == Out_register_EDI;
wire [31:0] v3b15 = In_register_EAX;
wire v3b16 = v3b15 == Out_register_EAX;
wire [31:0] v3b18 = v1c;
wire [31:0] v3b19 = In_register_EIP + v3b18;
wire [31:0] v3b1b = v3b19;
wire v3b1c = v3b1b == Out_register_EIP;
wire [31:0] v3b1e = In_register_EDX;
wire v3b1f = v3b1e == Out_register_EDX;
wire [31:0] v3b21 = In_register_ESBASE;
wire v3b22 = v3b21 == Out_register_ESBASE;
wire [31:0] v3b24 = In_register_EBX;
wire v3b25 = v3b24 == Out_register_EBX;
wire [31:0] v3b27 = In_register_ECX;
wire v3b28 = v3b27 == Out_register_ECX;
wire [31:0] v3b2a = In_register_EBP;
wire v3b2b = v3b2a == Out_register_EBP;
wire [2:0] v3b2c = { v1fa };
wire [31:0] v3b2d = ( v3b2c == 3'd0) ? In_register_EAX : 
	( v3b2c == 3'd1) ? In_register_ECX : 
	( v3b2c == 3'd2) ? In_register_EDX : 
	( v3b2c == 3'd3) ? In_register_EBX : 
	( v3b2c == 3'd4) ? In_register_ESP : 
	( v3b2c == 3'd5) ? In_register_EBP : 
	( v3b2c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3b2f = v3b2d;
wire [2:0] v3b30 = { v320 };
wire [31:0] v3b31 = ( v3b30 == 3'd0) ? In_register_EAX : 
	( v3b30 == 3'd1) ? In_register_ECX : 
	( v3b30 == 3'd2) ? In_register_EDX : 
	( v3b30 == 3'd3) ? In_register_EBX : 
	( v3b30 == 3'd4) ? In_register_ESP : 
	( v3b30 == 3'd5) ? In_register_EBP : 
	( v3b30 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3b33 = v3b31;
wire [31:0] v3b34 = v3b2f ^ v3b33;
wire [31:0] v3b35 = v3b33 - v3b2f;
wire [31:0] v3b36 = v3b34 ^ v3b35;
wire [7:0] v3b37 = v3b36[7:0];
wire [7:0] v3b38 = v3b37 >> v1d;
wire [7:0] v3b39 = v3b38 & v18;
wire v3b3a = v3b39[0:0];
wire v3b3c = v3b3a;
wire v3b3d = v3b3c == Out_register_AF;
wire [31:0] v3b3f = In_register_SSBASE;
wire v3b40 = v3b3f == Out_register_SSBASE;
wire [7:0] v3b42 = In_register_DF;
wire v3b43 = v3b42 == Out_register_DF;
wire v3b44 = In_error_flag == Out_error_flag;
wire [31:0] v3b46 = In_register_GSBASE;
wire v3b47 = v3b46 == Out_register_GSBASE;
wire [31:0] v3b49 = In_register_ESP;
wire v3b4a = v3b49 == Out_register_ESP;
wire [31:0] v3b4c = In_register_FSBASE;
wire v3b4d = v3b4c == Out_register_FSBASE;
wire [31:0] v3b4f = In_register_ESI;
wire v3b50 = v3b4f == Out_register_ESI;
wire v3b51 = v3b33 < v3b2f;
wire v3b53 = v3b51;
wire v3b54 = v3b53 == Out_register_CF;
wire [31:0] v3b55 = v3b35 ^ v3b33;
wire [31:0] v3b56 = v3b55 >> v1e;
wire [31:0] v3b57 = v3b34 >> v1e;
wire [31:0] v3b58 = v3b56 + v3b57;
wire v3b59 = v3b58 == v1c;
wire v3b5b = v3b59;
wire v3b5c = v3b5b == Out_register_OF;
wire [7:0] v3b5d = v3b35[7:0];
wire [2:0] v3b5e_aux = v3b5d[0] + v3b5d[1] + v3b5d[2] + v3b5d[3] + v3b5d[4] + v3b5d[5] + v3b5d[6] + v3b5d[7];
wire v3b5e = { 5'b00000, v3b5e_aux };
wire [7:0] v3b5f = v3b5e & v18;
wire [7:0] v3b60 = v3b5f ^ v18;
wire v3b61 = v3b60[0:0];
wire v3b63 = v3b61;
wire v3b64 = v3b63 == Out_register_PF;
wire [31:0] v3b66 = In_register_CSBASE;
wire v3b67 = v3b66 == Out_register_CSBASE;
wire v3b68 = $signed(v3b35) < $signed(v15);
wire v3b6a = v3b68;
wire v3b6b = v3b6a == Out_register_SF;
wire v3b6c = v3b33 == v3b2f;
wire v3b6e = v3b6c;
wire v3b6f = v3b6e == Out_register_ZF;
wire v3b70 = v3b10 & v3b13 & v3b16 & v3b1c & v3b1f & v3b22 & v3b25 & v3b28 & v3b2b & v3b0d & v3b3d & v3b40 & v3b43 & v3b44 & v15c & v3b47 & v3b4a & v3b4d & v3b50 & v3b54 & v3b5c & v3b64 & v3b67 & v3b6b & v3b6f;
wire [7:0] vc8 = 8'b11001000;
wire v3b71 = vc8 == v1eb;
wire v3b72 = v30 == v316;
wire v3b73 = v4 == v11b;
wire [2:0] v3b74 = { v1fa };
wire v3b75 = v3b74 == vb;
wire v3b76 = v3b74 == vf;
wire v3b77 = v3b75 | v3b76;
wire v3b78 = v3b77 ^ v8;
wire [2:0] v3b79 = { v1fa };
wire v3b7a = v3b79 == vb;
wire v3b7b = v3b7a;
wire v3b7c = v3b7b ^ v8;
wire v3b7d = v3b78 & v3b7c;
wire v3b7e = v3b71 & v3b72 & v3b73 & v3b7d;
wire v3b7f = v3b7e;
wire v3b80 = v3b7f;
wire [2:0] v3b88 = { v320 };
wire v3b89 = v3b88 == v11;
wire v3b8a = v3b89;
wire v3b8b = v3b7e & v3b8a;
wire v3b8c = v3b8b;
wire [31:0] v3b81 = memory_0[79: 48];
wire [2:0] v3b82 = { v320 };
wire [31:0] v3b83 = ( v3b82 == 3'd0) ? In_register_EAX : 
	( v3b82 == 3'd1) ? In_register_ECX : 
	( v3b82 == 3'd2) ? In_register_EDX : 
	( v3b82 == 3'd3) ? In_register_EBX : 
	( v3b82 == 3'd4) ? In_register_ESP : 
	( v3b82 == 3'd5) ? In_register_EBP : 
	( v3b82 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3b85 = v3b83;
wire [31:0] v3b86 = v3b81 + v3b85;
wire [31:0] v3b87 = v3b86 + vb11;
wire [31:0] v3b8f = ( v8 ) ? In_register_ESI : v3b87;
wire [31:0] v3b91 = v3b8f;
wire v3b92 = v3b91 == Out_register_ESI;
wire v3b93 = v3b88 == v9;
wire v3b94 = v3b93;
wire v3b95 = v3b7e & v3b94;
wire v3b96 = v3b95;
wire [31:0] v3b99 = ( v8 ) ? In_register_EDI : v3b87;
wire [31:0] v3b9b = v3b99;
wire v3b9c = v3b9b == Out_register_EDI;
wire v3b9d = v3b88 == ve;
wire v3b9e = v3b9d;
wire v3b9f = v3b7e & v3b9e;
wire v3ba0 = v3b9f;
wire [31:0] v3ba3 = ( v8 ) ? In_register_EDX : v3b87;
wire [31:0] v3ba5 = v3ba3;
wire v3ba6 = v3ba5 == Out_register_EDX;
wire [31:0] v3ba8 = v10;
wire [31:0] v3ba9 = In_register_EIP + v3ba8;
wire [31:0] v3bab = v3ba9;
wire v3bac = v3bab == Out_register_EIP;
wire [7:0] v3bad = v3b87[7:0];
wire [2:0] v3bae_aux = v3bad[0] + v3bad[1] + v3bad[2] + v3bad[3] + v3bad[4] + v3bad[5] + v3bad[6] + v3bad[7];
wire v3bae = { 5'b00000, v3bae_aux };
wire [7:0] v3baf = v3bae & v18;
wire [7:0] v3bb0 = v3baf ^ v18;
wire v3bb1 = v3bb0[0:0];
wire v3bb3 = v3bb1;
wire v3bb4 = v3bb3 == Out_register_PF;
wire v3bb5 = v3b88 == vb;
wire v3bb6 = v3bb5;
wire v3bb7 = v3b7e & v3bb6;
wire v3bb8 = v3bb7;
wire [31:0] v3bbb = ( v8 ) ? In_register_ESP : v3b87;
wire [31:0] v3bbd = v3bbb;
wire v3bbe = v3bbd == Out_register_ESP;
wire v3bbf = v3b88 == vd;
wire v3bc0 = v3bbf;
wire v3bc1 = v3b7e & v3bc0;
wire v3bc2 = v3bc1;
wire [31:0] v3bc5 = ( v8 ) ? In_register_EBX : v3b87;
wire [31:0] v3bc7 = v3bc5;
wire v3bc8 = v3bc7 == Out_register_EBX;
wire v3bc9 = v3b88 == vc;
wire v3bca = v3bc9;
wire v3bcb = v3b7e & v3bca;
wire v3bcc = v3bcb;
wire [31:0] v3bcf = ( v8 ) ? In_register_ECX : v3b87;
wire [31:0] v3bd1 = v3bcf;
wire v3bd2 = v3bd1 == Out_register_ECX;
wire [2:0] v3bd3 = { v1fa };
wire [31:0] v3bd4 = ( v3bd3 == 3'd0) ? In_register_EAX : 
	( v3bd3 == 3'd1) ? In_register_ECX : 
	( v3bd3 == 3'd2) ? In_register_EDX : 
	( v3bd3 == 3'd3) ? In_register_EBX : 
	( v3bd3 == 3'd4) ? v15 : 
	( v3bd3 == 3'd5) ? v15 : 
	( v3bd3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3bd5 = v3bd4 + v63a;
wire [31:0] v3bd7 = v3bd5;
wire v3bd8 =  v26 == memory_0[15: 12] && v3bd7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v3bd9 = v3b88 == v7;
wire v3bda = v3bd9;
wire v3bdb = v3b7e & v3bda;
wire v3bdc = v3bdb;
wire [31:0] v3bdf = ( v8 ) ? In_register_EAX : v3b87;
wire [31:0] v3be1 = v3bdf;
wire v3be2 = v3be1 == Out_register_EAX;
wire v3be3 = v3b88 == vf;
wire v3be4 = v3be3;
wire v3be5 = v3b7e & v3be4;
wire v3be6 = v3be5;
wire [31:0] v3be9 = ( v8 ) ? In_register_EBP : v3b87;
wire [31:0] v3beb = v3be9;
wire v3bec = v3beb == Out_register_EBP;
wire v3bed = v3b86 < v3b85;
wire v3bee = v3b86 < v3b81;
wire v3bef = v3bed | v3bee;
wire v3bf0 = v3b87 < v3b86;
wire v3bf1 = v3b87 < vb11;
wire v3bf2 = v3bf0 | v3bf1;
wire [7:0] v3bf3 = { 7'b0000000, v3bf2 };
wire [7:0] v3bf4 = ( v3bef == 1'd0) ? v3bf3 : v18;
wire v3bf5 = v3bf4[0:0];
wire v3bf7 = v3bf5;
wire v3bf8 = v3bf7 == Out_register_CF;
wire [31:0] v3bfa = In_register_CSBASE;
wire v3bfb = v3bfa == Out_register_CSBASE;
wire [31:0] v3bfc = v3b87 ^ v3b81;
wire [31:0] v3bfd = v3bfc ^ v3b85;
wire [7:0] v3bfe = v3bfd[7:0];
wire [7:0] v3bff = v3bfe >> v1d;
wire [7:0] v3c00 = v3bff & v18;
wire v3c01 = v3c00[0:0];
wire v3c03 = v3c01;
wire v3c04 = v3c03 == Out_register_AF;
wire [31:0] v3c05 = v3b87 ^ v3b85;
wire [31:0] v3c06 = v3c05 >> v1e;
wire [31:0] v3c07 = v3bfc >> v1e;
wire [31:0] v3c08 = v3c06 + v3c07;
wire v3c09 = v3c08 == v1c;
wire v3c0b = v3c09;
wire v3c0c = v3c0b == Out_register_OF;
wire [31:0] v3c0e = In_register_ESBASE;
wire v3c0f = v3c0e == Out_register_ESBASE;
wire [31:0] v3c11 = In_register_GSBASE;
wire v3c12 = v3c11 == Out_register_GSBASE;
wire [31:0] v3c14 = In_register_FSBASE;
wire v3c15 = v3c14 == Out_register_FSBASE;
wire [31:0] v3c17 = In_register_DSBASE;
wire v3c18 = v3c17 == Out_register_DSBASE;
wire [7:0] v3c1a = In_register_DF;
wire v3c1b = v3c1a == Out_register_DF;
wire [31:0] v3c1d = In_register_SSBASE;
wire v3c1e = v3c1d == Out_register_SSBASE;
wire v3c1f = In_error_flag == Out_error_flag;
wire v3c20 = $signed(v3b87) < $signed(v15);
wire v3c22 = v3c20;
wire v3c23 = v3c22 == Out_register_SF;
wire v3c24 = v3b87 == v15;
wire v3c26 = v3c24;
wire v3c27 = v3c26 == Out_register_ZF;
wire v3c28 = v3b80 & v3b92 & v3b9c & v15c & v3ba6 & v3bac & v3bb4 & v3bbe & v3bc8 & v3bd2 & v3bd8 & v3be2 & v3bec & v3bf8 & v3bfb & v3c04 & v3c0c & v3c0f & v3c12 & v3c15 & v3c18 & v3c1b & v3c1e & v3c1f & v3c23 & v3c27;
wire v3c29 = v3b == v1eb;
wire v3c2a = v3 == v316;
wire v3c2b = v1b == v318;
wire v3c2c = v3c29 & v3c2a & v3c2b;
wire v3c2d = v3c2c;
wire v3c2e = v3c2d;
wire [31:0] v3c30 = In_register_SSBASE;
wire v3c31 = v3c30 == Out_register_SSBASE;
wire [31:0] v3c33 = In_register_ESP;
wire v3c34 = v3c33 == Out_register_ESP;
wire [2:0] v3c35 = { v1fa };
wire [31:0] v3c36 = ( v3c35 == 3'd0) ? In_register_EAX : 
	( v3c35 == 3'd1) ? In_register_ECX : 
	( v3c35 == 3'd2) ? In_register_EDX : 
	( v3c35 == 3'd3) ? In_register_EBX : 
	( v3c35 == 3'd4) ? In_register_ESP : 
	( v3c35 == 3'd5) ? In_register_EBP : 
	( v3c35 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3c38 = v3c36;
wire [2:0] v3c39 = { v320 };
wire [31:0] v3c3a = ( v3c39 == 3'd0) ? In_register_EAX : 
	( v3c39 == 3'd1) ? In_register_ECX : 
	( v3c39 == 3'd2) ? In_register_EDX : 
	( v3c39 == 3'd3) ? In_register_EBX : 
	( v3c39 == 3'd4) ? In_register_ESP : 
	( v3c39 == 3'd5) ? In_register_EBP : 
	( v3c39 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3c3c = v3c3a;
wire [31:0] v3c3d = v3c38 - v3c3c;
wire v3c3e = $signed(v3c3d) < $signed(v15);
wire v3c40 = v3c3e;
wire v3c41 = v3c40 == Out_register_SF;
wire [31:0] v3c43 = In_register_EBX;
wire v3c44 = v3c43 == Out_register_EBX;
wire v3c45 = In_error_flag == Out_error_flag;
wire [31:0] v3c47 = In_register_EAX;
wire v3c48 = v3c47 == Out_register_EAX;
wire [31:0] v3c4a = In_register_GSBASE;
wire v3c4b = v3c4a == Out_register_GSBASE;
wire [31:0] v3c4d = In_register_ESI;
wire v3c4e = v3c4d == Out_register_ESI;
wire [31:0] v3c50 = In_register_EDX;
wire v3c51 = v3c50 == Out_register_EDX;
wire [31:0] v3c52 = v3c3d ^ v3c38;
wire [31:0] v3c53 = v3c52 >> v1e;
wire [31:0] v3c54 = v3c3c ^ v3c38;
wire [31:0] v3c55 = v3c54 >> v1e;
wire [31:0] v3c56 = v3c53 + v3c55;
wire v3c57 = v3c56 == v1c;
wire v3c59 = v3c57;
wire v3c5a = v3c59 == Out_register_OF;
wire [31:0] v3c5c = In_register_EBP;
wire v3c5d = v3c5c == Out_register_EBP;
wire v3c5e = v3c38 == v3c3c;
wire v3c60 = v3c5e;
wire v3c61 = v3c60 == Out_register_ZF;
wire [31:0] v3c63 = v1c;
wire [31:0] v3c64 = In_register_EIP + v3c63;
wire [31:0] v3c66 = v3c64;
wire v3c67 = v3c66 == Out_register_EIP;
wire [7:0] v3c68 = v3c3d[7:0];
wire [2:0] v3c69_aux = v3c68[0] + v3c68[1] + v3c68[2] + v3c68[3] + v3c68[4] + v3c68[5] + v3c68[6] + v3c68[7];
wire v3c69 = { 5'b00000, v3c69_aux };
wire [7:0] v3c6a = v3c69 & v18;
wire [7:0] v3c6b = v3c6a ^ v18;
wire v3c6c = v3c6b[0:0];
wire v3c6e = v3c6c;
wire v3c6f = v3c6e == Out_register_PF;
wire [31:0] v3c71 = In_register_CSBASE;
wire v3c72 = v3c71 == Out_register_CSBASE;
wire [31:0] v3c74 = In_register_ESBASE;
wire v3c75 = v3c74 == Out_register_ESBASE;
wire [31:0] v3c77 = In_register_DSBASE;
wire v3c78 = v3c77 == Out_register_DSBASE;
wire [31:0] v3c7a = In_register_FSBASE;
wire v3c7b = v3c7a == Out_register_FSBASE;
wire [31:0] v3c7c = v3c54 ^ v3c3d;
wire [7:0] v3c7d = v3c7c[7:0];
wire [7:0] v3c7e = v3c7d >> v1d;
wire [7:0] v3c7f = v3c7e & v18;
wire v3c80 = v3c7f[0:0];
wire v3c82 = v3c80;
wire v3c83 = v3c82 == Out_register_AF;
wire [31:0] v3c85 = In_register_EDI;
wire v3c86 = v3c85 == Out_register_EDI;
wire [31:0] v3c88 = In_register_ECX;
wire v3c89 = v3c88 == Out_register_ECX;
wire v3c8a = v3c38 < v3c3c;
wire v3c8c = v3c8a;
wire v3c8d = v3c8c == Out_register_CF;
wire [7:0] v3c8f = In_register_DF;
wire v3c90 = v3c8f == Out_register_DF;
wire v3c91 = v15c & v3c31 & v3c2e & v3c34 & v3c41 & v3c44 & v3c45 & v3c48 & v3c4b & v3c4e & v3c51 & v3c5a & v3c5d & v3c61 & v3c67 & v3c6f & v3c72 & v3c75 & v3c78 & v3c7b & v3c83 & v3c86 & v3c89 & v3c8d & v3c90;
wire [7:0] vc9 = 8'b10010100;
wire v3c92 = vc9 == v1eb;
wire v3c93 = v3 == v316;
wire v3c94 = v1b == v318;
wire v3c95 = v3c92 & v3c93 & v3c94;
wire v3c96 = v3c95;
wire v3c97 = v3c96;
wire [31:0] v3c99 = v1c;
wire [31:0] v3c9a = In_register_EIP + v3c99;
wire [31:0] v3c9c = v3c9a;
wire v3c9d = v3c9c == Out_register_EIP;
wire [2:0] v3ca7 = { v1fa };
wire v3ca8 = v3ca7 == vd;
wire v3ca9 = v3ca8;
wire v3caa = v3c95 & v3ca9;
wire v3cab = v3caa;
wire [2:0] v3c9e = { v1fa };
wire [31:0] v3c9f = ( v3c9e == 3'd0) ? In_register_EAX : 
	( v3c9e == 3'd1) ? In_register_ECX : 
	( v3c9e == 3'd2) ? In_register_EDX : 
	( v3c9e == 3'd3) ? In_register_EBX : 
	( v3c9e == 3'd4) ? In_register_ESP : 
	( v3c9e == 3'd5) ? In_register_EBP : 
	( v3c9e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3ca1 = v3c9f;
wire [2:0] v3ca2 = { v320 };
wire [31:0] v3ca3 = ( v3ca2 == 3'd0) ? In_register_EAX : 
	( v3ca2 == 3'd1) ? In_register_ECX : 
	( v3ca2 == 3'd2) ? In_register_EDX : 
	( v3ca2 == 3'd3) ? In_register_EBX : 
	( v3ca2 == 3'd4) ? In_register_ESP : 
	( v3ca2 == 3'd5) ? In_register_EBP : 
	( v3ca2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3ca5 = v3ca3;
wire [31:0] v3ca6 = v3ca1 - v3ca5;
wire [31:0] v3cae = ( v8 ) ? In_register_EBX : v3ca6;
wire [31:0] v3cb0 = v3cae;
wire v3cb1 = v3cb0 == Out_register_EBX;
wire v3cb2 = v3ca7 == ve;
wire v3cb3 = v3cb2;
wire v3cb4 = v3c95 & v3cb3;
wire v3cb5 = v3cb4;
wire [31:0] v3cb8 = ( v8 ) ? In_register_EDX : v3ca6;
wire [31:0] v3cba = v3cb8;
wire v3cbb = v3cba == Out_register_EDX;
wire v3cbc = In_error_flag == Out_error_flag;
wire v3cbd = $signed(v3ca6) < $signed(v15);
wire v3cbf = v3cbd;
wire v3cc0 = v3cbf == Out_register_SF;
wire v3cc1 = v3ca1 < v3ca5;
wire v3cc3 = v3cc1;
wire v3cc4 = v3cc3 == Out_register_CF;
wire [31:0] v3cc5 = v3ca6 ^ v3ca1;
wire [31:0] v3cc6 = v3cc5 >> v1e;
wire [31:0] v3cc7 = v3ca5 ^ v3ca1;
wire [31:0] v3cc8 = v3cc7 >> v1e;
wire [31:0] v3cc9 = v3cc6 + v3cc8;
wire v3cca = v3cc9 == v1c;
wire v3ccc = v3cca;
wire v3ccd = v3ccc == Out_register_OF;
wire v3cce = v3ca7 == v9;
wire v3ccf = v3cce;
wire v3cd0 = v3c95 & v3ccf;
wire v3cd1 = v3cd0;
wire [31:0] v3cd4 = ( v8 ) ? In_register_EDI : v3ca6;
wire [31:0] v3cd6 = v3cd4;
wire v3cd7 = v3cd6 == Out_register_EDI;
wire v3cd8 = v3ca7 == vf;
wire v3cd9 = v3cd8;
wire v3cda = v3c95 & v3cd9;
wire v3cdb = v3cda;
wire [31:0] v3cde = ( v8 ) ? In_register_EBP : v3ca6;
wire [31:0] v3ce0 = v3cde;
wire v3ce1 = v3ce0 == Out_register_EBP;
wire v3ce2 = v3ca1 == v3ca5;
wire v3ce4 = v3ce2;
wire v3ce5 = v3ce4 == Out_register_ZF;
wire v3ce6 = v3ca7 == vc;
wire v3ce7 = v3ce6;
wire v3ce8 = v3c95 & v3ce7;
wire v3ce9 = v3ce8;
wire [31:0] v3cec = ( v8 ) ? In_register_ECX : v3ca6;
wire [31:0] v3cee = v3cec;
wire v3cef = v3cee == Out_register_ECX;
wire [31:0] v3cf1 = In_register_SSBASE;
wire v3cf2 = v3cf1 == Out_register_SSBASE;
wire v3cf3 = v3ca7 == vb;
wire v3cf4 = v3cf3;
wire v3cf5 = v3c95 & v3cf4;
wire v3cf6 = v3cf5;
wire [31:0] v3cf9 = ( v8 ) ? In_register_ESP : v3ca6;
wire [31:0] v3cfb = v3cf9;
wire v3cfc = v3cfb == Out_register_ESP;
wire [31:0] v3cfe = In_register_GSBASE;
wire v3cff = v3cfe == Out_register_GSBASE;
wire [31:0] v3d01 = In_register_CSBASE;
wire v3d02 = v3d01 == Out_register_CSBASE;
wire [7:0] v3d03 = v3ca6[7:0];
wire [2:0] v3d04_aux = v3d03[0] + v3d03[1] + v3d03[2] + v3d03[3] + v3d03[4] + v3d03[5] + v3d03[6] + v3d03[7];
wire v3d04 = { 5'b00000, v3d04_aux };
wire [7:0] v3d05 = v3d04 & v18;
wire [7:0] v3d06 = v3d05 ^ v18;
wire v3d07 = v3d06[0:0];
wire v3d09 = v3d07;
wire v3d0a = v3d09 == Out_register_PF;
wire [31:0] v3d0c = In_register_DSBASE;
wire v3d0d = v3d0c == Out_register_DSBASE;
wire v3d0e = v3ca7 == v11;
wire v3d0f = v3d0e;
wire v3d10 = v3c95 & v3d0f;
wire v3d11 = v3d10;
wire [31:0] v3d14 = ( v8 ) ? In_register_ESI : v3ca6;
wire [31:0] v3d16 = v3d14;
wire v3d17 = v3d16 == Out_register_ESI;
wire [31:0] v3d19 = In_register_FSBASE;
wire v3d1a = v3d19 == Out_register_FSBASE;
wire v3d1b = v3ca7 == v7;
wire v3d1c = v3d1b;
wire v3d1d = v3c95 & v3d1c;
wire v3d1e = v3d1d;
wire [31:0] v3d21 = ( v8 ) ? In_register_EAX : v3ca6;
wire [31:0] v3d23 = v3d21;
wire v3d24 = v3d23 == Out_register_EAX;
wire [31:0] v3d25 = v3cc7 ^ v3ca6;
wire [7:0] v3d26 = v3d25[7:0];
wire [7:0] v3d27 = v3d26 >> v1d;
wire [7:0] v3d28 = v3d27 & v18;
wire v3d29 = v3d28[0:0];
wire v3d2b = v3d29;
wire v3d2c = v3d2b == Out_register_AF;
wire [31:0] v3d2e = In_register_ESBASE;
wire v3d2f = v3d2e == Out_register_ESBASE;
wire [7:0] v3d31 = In_register_DF;
wire v3d32 = v3d31 == Out_register_DF;
wire v3d33 = v3c97 & v3c9d & v3cb1 & v3cbb & v3cbc & v3cc0 & v3cc4 & v3ccd & v15c & v3cd7 & v3ce1 & v3ce5 & v3cef & v3cf2 & v3cfc & v3cff & v3d02 & v3d0a & v3d0d & v3d17 & v3d1a & v3d24 & v3d2c & v3d2f & v3d32;
wire [15:0] vca = 16'b0110011011010001;
wire v3d37 = vca == v117;
wire v3d38 = v2f == v119;
wire v3d39 = v43 == vab3;
wire [2:0] v3d3a = { v13c };
wire v3d3b = v3d3a == vb;
wire v3d3c = v3d3a == vf;
wire v3d3d = v3d3b | v3d3c;
wire v3d3e = v3d3d ^ v8;
wire [2:0] v3d3f = { v13c };
wire v3d40 = v3d3f == vb;
wire v3d41 = v3d40;
wire v3d42 = v3d41 ^ v8;
wire v3d43 = v3d3e & v3d42;
wire v3d44 = v3d37 & v3d38 & v3d39 & v3d43;
wire [2:0] v3d34 = { v13c };
wire [31:0] v3d35 = ( v3d34 == 3'd0) ? In_register_EAX : 
	( v3d34 == 3'd1) ? In_register_ECX : 
	( v3d34 == 3'd2) ? In_register_EDX : 
	( v3d34 == 3'd3) ? In_register_EBX : 
	( v3d34 == 3'd4) ? v15 : 
	( v3d34 == 3'd5) ? v15 : 
	( v3d34 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3d36 = v3d35 + vc2d;
wire [18:0] vcb = 19'b0110011011010001001;
wire v3d5f = vcb == vdfa;
wire [4:0] v3d60 = instruction_bits[26: 22];
wire v3d61 = v4b == v3d60;
wire v3d62 = v51 == vdfc;
wire v3d63 = v3d5f & v3d61 & v3d62;
wire [2:0] v3d58 = instruction_bits[29: 27];
wire [2:0] v3d59 = { v3d58 };
wire [31:0] v3d5a = ( v3d59 == 3'd0) ? In_register_EAX : 
	( v3d59 == 3'd1) ? In_register_ECX : 
	( v3d59 == 3'd2) ? In_register_EDX : 
	( v3d59 == 3'd3) ? In_register_EBX : 
	( v3d59 == 3'd4) ? v15 : 
	( v3d59 == 3'd5) ? In_register_EBP : 
	( v3d59 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [1:0] v3d5b = instruction_bits[31: 30];
wire [31:0] v3d5c = { 30'b000000000000000000000000000000, v3d5b };
wire [31:0] v3d5d = v3d5a << v3d5c;
wire [31:0] v3d5e = v3d5d + v2faa;
wire v3d48 = vca == v117;
wire v3d49 = v35 == v119;
wire v3d4a = v4 == v11b;
wire [2:0] v3d4b = { v13c };
wire v3d4c = v3d4b == vb;
wire v3d4d = v3d4b == vf;
wire v3d4e = v3d4c | v3d4d;
wire v3d4f = v3d4e ^ v8;
wire [2:0] v3d50 = { v13c };
wire v3d51 = v3d50 == vb;
wire v3d52 = v3d50 == vf;
wire v3d53 = v3d51 | v3d52;
wire v3d54 = v3d53 ^ v8;
wire v3d55 = v3d4f & v3d54;
wire v3d56 = v3d48 & v3d49 & v3d4a & v3d55;
wire [2:0] v3d46 = { v13c };
wire [31:0] v3d47 = ( v3d46 == 3'd0) ? In_register_EAX : 
	( v3d46 == 3'd1) ? In_register_ECX : 
	( v3d46 == 3'd2) ? In_register_EDX : 
	( v3d46 == 3'd3) ? In_register_EBX : 
	( v3d46 == 3'd4) ? v15 : 
	( v3d46 == 3'd5) ? v15 : 
	( v3d46 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3d65 = ( v3d44 ) ? v3d36 : 
	( v3d63 ) ? v3d5e : v3d47;
wire v3d66 =  v9f == memory_0[15: 12] && v3d65 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v3d7b = v3d44 | v3d56 | v3d63;
wire v3d7c = v3d7b;
wire [2:0] v3d6b = { v12c };
wire v3d6c = v3d6b == vd;
wire v3d6d = v3d6c;
wire v3d6e = v3d44 & v3d6d;
wire [2:0] v3d6f = { v12c };
wire v3d70 = v3d6f == vd;
wire v3d71 = v3d70;
wire v3d72 = v3d56 & v3d71;
wire [2:0] v3d73 = { v12c };
wire v3d74 = v3d73 == vd;
wire v3d75 = v3d74;
wire v3d76 = v3d63 & v3d75;
wire v3d77 = v3d6e | v3d72 | v3d76;
wire [31:0] v3d67 = memory_0[79: 48];
wire [15:0] v3d68 = v3d67[15:0];
wire [31:0] v3d69 = { 16'b0000000000000000, v3d68 };
wire [31:0] v3d6a = v17c | v3d69;
wire [31:0] v3d7a = ( v8 ) ? In_register_EBX : v3d6a;
wire [31:0] v3d7e = v3d7a;
wire v3d7f = v3d7e == Out_register_EBX;
wire v3d81 = In_register_ZF;
wire v3d82 = v3d81 == Out_register_ZF;
wire [31:0] v3d86 = ( v3d44 ) ? v45 : 
	( v3d63 ) ? v31 : v10;
wire [31:0] v3d87 = In_register_EIP + v3d86;
wire [31:0] v3d89 = v3d87;
wire v3d8a = v3d89 == Out_register_EIP;
wire v3d8c = v3d6b == v11;
wire v3d8d = v3d8c;
wire v3d8e = v3d44 & v3d8d;
wire v3d8f = v3d6f == v11;
wire v3d90 = v3d8f;
wire v3d91 = v3d56 & v3d90;
wire v3d92 = v3d73 == v11;
wire v3d93 = v3d92;
wire v3d94 = v3d63 & v3d93;
wire v3d95 = v3d8e | v3d91 | v3d94;
wire [31:0] v3d8b = v1d8 | v3d69;
wire [31:0] v3d98 = ( v8 ) ? In_register_ESI : v3d8b;
wire [31:0] v3d9a = v3d98;
wire v3d9b = v3d9a == Out_register_ESI;
wire [31:0] v3d9d = In_register_FSBASE;
wire v3d9e = v3d9d == Out_register_FSBASE;
wire v3da0 = v3d6b == v7;
wire v3da1 = v3da0;
wire v3da2 = v3d44 & v3da1;
wire v3da3 = v3d6f == v7;
wire v3da4 = v3da3;
wire v3da5 = v3d56 & v3da4;
wire v3da6 = v3d73 == v7;
wire v3da7 = v3da6;
wire v3da8 = v3d63 & v3da7;
wire v3da9 = v3da2 | v3da5 | v3da8;
wire [31:0] v3d9f = v12b | v3d69;
wire [31:0] v3dac = ( v8 ) ? In_register_EAX : v3d9f;
wire [31:0] v3dae = v3dac;
wire v3daf = v3dae == Out_register_EAX;
wire v3db1 = In_register_OF;
wire v3db2 = v3db1 == Out_register_OF;
wire v3db4 = v3d6b == ve;
wire v3db5 = v3db4;
wire v3db6 = v3d44 & v3db5;
wire v3db7 = v3d6f == ve;
wire v3db8 = v3db7;
wire v3db9 = v3d56 & v3db8;
wire v3dba = v3d73 == ve;
wire v3dbb = v3dba;
wire v3dbc = v3d63 & v3dbb;
wire v3dbd = v3db6 | v3db9 | v3dbc;
wire [31:0] v3db3 = v189 | v3d69;
wire [31:0] v3dc0 = ( v8 ) ? In_register_EDX : v3db3;
wire [31:0] v3dc2 = v3dc0;
wire v3dc3 = v3dc2 == Out_register_EDX;
wire v3dc5 = v3d6b == vb;
wire v3dc6 = v3dc5;
wire v3dc7 = v3d44 & v3dc6;
wire v3dc8 = v3d6f == vb;
wire v3dc9 = v3dc8;
wire v3dca = v3d56 & v3dc9;
wire v3dcb = v3d73 == vb;
wire v3dcc = v3dcb;
wire v3dcd = v3d63 & v3dcc;
wire v3dce = v3dc7 | v3dca | v3dcd;
wire [31:0] v3dc4 = v15d | v3d69;
wire [31:0] v3dd1 = ( v8 ) ? In_register_ESP : v3dc4;
wire [31:0] v3dd3 = v3dd1;
wire v3dd4 = v3dd3 == Out_register_ESP;
wire v3dd6 = v3d6b == v9;
wire v3dd7 = v3dd6;
wire v3dd8 = v3d44 & v3dd7;
wire v3dd9 = v3d6f == v9;
wire v3dda = v3dd9;
wire v3ddb = v3d56 & v3dda;
wire v3ddc = v3d73 == v9;
wire v3ddd = v3ddc;
wire v3dde = v3d63 & v3ddd;
wire v3ddf = v3dd8 | v3ddb | v3dde;
wire [31:0] v3dd5 = v149 | v3d69;
wire [31:0] v3de2 = ( v8 ) ? In_register_EDI : v3dd5;
wire [31:0] v3de4 = v3de2;
wire v3de5 = v3de4 == Out_register_EDI;
wire v3de7 = v3d6b == vf;
wire v3de8 = v3de7;
wire v3de9 = v3d44 & v3de8;
wire v3dea = v3d6f == vf;
wire v3deb = v3dea;
wire v3dec = v3d56 & v3deb;
wire v3ded = v3d73 == vf;
wire v3dee = v3ded;
wire v3def = v3d63 & v3dee;
wire v3df0 = v3de9 | v3dec | v3def;
wire [31:0] v3de6 = v196 | v3d69;
wire [31:0] v3df3 = ( v8 ) ? In_register_EBP : v3de6;
wire [31:0] v3df5 = v3df3;
wire v3df6 = v3df5 == Out_register_EBP;
wire v3df8 = v3d6b == vc;
wire v3df9 = v3df8;
wire v3dfa = v3d44 & v3df9;
wire v3dfb = v3d6f == vc;
wire v3dfc = v3dfb;
wire v3dfd = v3d56 & v3dfc;
wire v3dfe = v3d73 == vc;
wire v3dff = v3dfe;
wire v3e00 = v3d63 & v3dff;
wire v3e01 = v3dfa | v3dfd | v3e00;
wire [31:0] v3df7 = v16f | v3d69;
wire [31:0] v3e04 = ( v8 ) ? In_register_ECX : v3df7;
wire [31:0] v3e06 = v3e04;
wire v3e07 = v3e06 == Out_register_ECX;
wire v3e08 = In_error_flag == Out_error_flag;
wire [31:0] v3e0a = In_register_SSBASE;
wire v3e0b = v3e0a == Out_register_SSBASE;
wire [31:0] v3e0d = In_register_ESBASE;
wire v3e0e = v3e0d == Out_register_ESBASE;
wire [31:0] v3e10 = In_register_CSBASE;
wire v3e11 = v3e10 == Out_register_CSBASE;
wire [31:0] v3e13 = In_register_DSBASE;
wire v3e14 = v3e13 == Out_register_DSBASE;
wire v3e16 = In_register_AF;
wire v3e17 = v3e16 == Out_register_AF;
wire [31:0] v3e19 = In_register_GSBASE;
wire v3e1a = v3e19 == Out_register_GSBASE;
wire v3e1c = In_register_CF;
wire v3e1d = v3e1c == Out_register_CF;
wire [7:0] v3e1f = In_register_DF;
wire v3e20 = v3e1f == Out_register_DF;
wire v3e22 = In_register_PF;
wire v3e23 = v3e22 == Out_register_PF;
wire v3e25 = In_register_SF;
wire v3e26 = v3e25 == Out_register_SF;
wire v3e27 = v3d66 & v3d7f & v3d82 & v3d8a & v3d9b & v3d9e & v3daf & v3db2 & v3dc3 & v3dd4 & v15c & v3de5 & v3df6 & v3e07 & v3e08 & v3e0b & v3e0e & v3e11 & v3d7c & v3e14 & v3e17 & v3e1a & v3e1d & v3e20 & v3e23 & v3e26;
wire [7:0] vcc = 8'b11111001;
wire v3e28 = vcc == v1eb;
wire v3e29 = v29 == v59f;
wire v3e2a = v3e28 & v3e29;
wire v3e2b = v3e2a;
wire v3e2c = v3e2b;
wire [31:0] v3e2e = In_register_EBP;
wire v3e2f = v3e2e == Out_register_EBP;
wire [31:0] v3e31 = In_register_EDI;
wire v3e32 = v3e31 == Out_register_EDI;
wire v3e34 = In_register_SF;
wire v3e35 = v3e34 == Out_register_SF;
wire v3e36 = In_error_flag == Out_error_flag;
wire [31:0] v3e38 = In_register_FSBASE;
wire v3e39 = v3e38 == Out_register_FSBASE;
wire [31:0] v3e3b = In_register_ECX;
wire v3e3c = v3e3b == Out_register_ECX;
wire [31:0] v3e3e = In_register_ESP;
wire v3e3f = v3e3e == Out_register_ESP;
wire [7:0] v3e41 = In_register_DF;
wire v3e42 = v3e41 == Out_register_DF;
wire [31:0] v3e44 = In_register_EDX;
wire v3e45 = v3e44 == Out_register_EDX;
wire v3e47 = In_register_PF;
wire v3e48 = v3e47 == Out_register_PF;
wire [31:0] v3e4a = In_register_ESI;
wire v3e4b = v3e4a == Out_register_ESI;
wire [31:0] v3e4d = v2b;
wire [31:0] v3e4e = In_register_EIP + v3e4d;
wire [31:0] v3e50 = v3e4e;
wire v3e51 = v3e50 == Out_register_EIP;
wire [31:0] v3e53 = In_register_EBX;
wire v3e54 = v3e53 == Out_register_EBX;
wire [7:0] v3e55 = v65f & v18;
wire [7:0] v3e56 = vd06 << v34;
wire [7:0] v3e57 = v3e56 & v1d;
wire [7:0] v3e58 = v3e55 | v3e57;
wire [7:0] v3e59 = v2870 << v1d;
wire [7:0] v3e5a = v3e59 & v70;
wire [7:0] v3e5b = v3e58 | v3e5a;
wire [7:0] vcd = 8'b01100000;
wire [7:0] v3e5c = v289b << vcd;
wire [7:0] vce = 8'b00000010;
wire [7:0] v3e5d = v3e5c & vce;
wire [7:0] v3e5e = v3e5b | v3e5d;
wire [7:0] v3e5f = v1d85 << v33;
wire [7:0] v3e60 = v3e5e | v3e5f;
wire [7:0] v3e61 = v3e60 | v34;
wire [31:0] v3e62 = { 24'b000000000000000000000000, v3e61 };
wire [31:0] v3e63 = v3e62 << v31;
wire [31:0] v3e64 = v752 | v3e63;
wire [31:0] v3e66 = v3e64;
wire v3e67 = v3e66 == Out_register_EAX;
wire [31:0] v3e69 = In_register_ESBASE;
wire v3e6a = v3e69 == Out_register_ESBASE;
wire [31:0] v3e6c = In_register_CSBASE;
wire v3e6d = v3e6c == Out_register_CSBASE;
wire [31:0] v3e6f = In_register_SSBASE;
wire v3e70 = v3e6f == Out_register_SSBASE;
wire [31:0] v3e72 = In_register_DSBASE;
wire v3e73 = v3e72 == Out_register_DSBASE;
wire [31:0] v3e75 = In_register_GSBASE;
wire v3e76 = v3e75 == Out_register_GSBASE;
wire v3e78 = In_register_OF;
wire v3e79 = v3e78 == Out_register_OF;
wire v3e7b = In_register_AF;
wire v3e7c = v3e7b == Out_register_AF;
wire v3e7e = In_register_CF;
wire v3e7f = v3e7e == Out_register_CF;
wire v3e81 = In_register_ZF;
wire v3e82 = v3e81 == Out_register_ZF;
wire v3e83 = v15c & v3e2f & v3e32 & v3e35 & v3e36 & v3e2c & v3e39 & v3e3c & v3e3f & v3e42 & v3e45 & v3e48 & v3e4b & v3e51 & v3e54 & v3e67 & v3e6a & v3e6d & v3e70 & v3e73 & v3e76 & v3e79 & v3e7c & v3e7f & v3e82;
wire [7:0] vcf = 8'b01010000;
wire v3e84 = vcf == v1eb;
wire v3e85 = v8 == v829;
wire v3e86 = v35 == v316;
wire v3e87 = v1b == v318;
wire v3e88 = v3e84 & v3e85 & v3e86 & v3e87;
wire v3e89 = vcf == v1eb;
wire v3e8a = v30 == v316;
wire v3e8b = v4 == v11b;
wire [2:0] v3e8c = { v1fa };
wire v3e8d = v3e8c == vb;
wire v3e8e = v3e8c == vf;
wire v3e8f = v3e8d | v3e8e;
wire v3e90 = v3e8f ^ v8;
wire [2:0] v3e91 = { v1fa };
wire v3e92 = v3e91 == vb;
wire v3e93 = v3e92;
wire v3e94 = v3e93 ^ v8;
wire v3e95 = v3e90 & v3e94;
wire v3e96 = v3e89 & v3e8a & v3e8b & v3e95;
wire v3e97 = vcf == v1eb;
wire v3e98 = v2f == v316;
wire v3e99 = v14 == v1ef;
wire [2:0] v3e9a = { v1fa };
wire v3e9b = v3e9a == vb;
wire v3e9c = v3e9a == vf;
wire v3e9d = v3e9b | v3e9c;
wire v3e9e = v3e9d ^ v8;
wire [2:0] v3e9f = { v1fa };
wire v3ea0 = v3e9f == vb;
wire v3ea1 = v3ea0;
wire v3ea2 = v3ea1 ^ v8;
wire v3ea3 = v3e9e & v3ea2;
wire v3ea4 = v3e97 & v3e98 & v3e99 & v3ea3;
wire v3ea5 = v3e88 | v3e96 | v3ea4;
wire v3ea6 = v3ea5;
wire [31:0] v3ea8 = In_register_DSBASE;
wire v3ea9 = v3ea8 == Out_register_DSBASE;
wire [2:0] v3edb = { v320 };
wire v3edc = v3edb == v7;
wire v3edd = v3edc;
wire v3ede = v3e88 & v3edd;
wire [2:0] v3edf = { v320 };
wire v3ee0 = v3edf == v7;
wire v3ee1 = v3ee0;
wire v3ee2 = v3e96 & v3ee1;
wire [2:0] v3ee3 = { v320 };
wire v3ee4 = v3ee3 == v7;
wire v3ee5 = v3ee4;
wire v3ee6 = v3ea4 & v3ee5;
wire v3ee7 = v3ede | v3ee2 | v3ee6;
wire [31:0] v3eaa = memory_0[79: 48];
wire [7:0] v3eab = v3eaa[7:0];
wire [2:0] v3eac = { v320 };
wire [31:0] v3ead = ( v3eac == 3'd0) ? In_register_EAX : 
	( v3eac == 3'd1) ? In_register_ECX : 
	( v3eac == 3'd2) ? In_register_EDX : 
	( v3eac == 3'd3) ? In_register_EBX : 
	( v3eac == 3'd4) ? In_register_EAX : 
	( v3eac == 3'd5) ? In_register_ECX : 
	( v3eac == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v3eae = { v320 };
wire v3eaf = v3eae == vb;
wire v3eb0 = v3eae == v9;
wire v3eb1 = v3eaf | v3eb0;
wire v3eb2 = v3eae == vf;
wire v3eb3 = v3eb1 | v3eb2;
wire v3eb4 = v3eae == v11;
wire v3eb5 = v3eb3 | v3eb4;
wire [31:0] v3eb6 = ( v3eb5 == 1'd0) ? v15 : v31;
wire [31:0] v3eb7 = v3ead >> v3eb6;
wire [31:0] v3eb8 = v3eb7 & v32;
wire [2:0] v3eba = { v320 };
wire [31:0] v3ebb = ( v3eba == 3'd0) ? In_register_EAX : 
	( v3eba == 3'd1) ? In_register_ECX : 
	( v3eba == 3'd2) ? In_register_EDX : 
	( v3eba == 3'd3) ? In_register_EBX : 
	( v3eba == 3'd4) ? In_register_EAX : 
	( v3eba == 3'd5) ? In_register_ECX : 
	( v3eba == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v3ebc = { v320 };
wire v3ebd = v3ebc == vb;
wire v3ebe = v3ebc == v9;
wire v3ebf = v3ebd | v3ebe;
wire v3ec0 = v3ebc == vf;
wire v3ec1 = v3ebf | v3ec0;
wire v3ec2 = v3ebc == v11;
wire v3ec3 = v3ec1 | v3ec2;
wire [31:0] v3ec4 = ( v3ec3 == 1'd0) ? v15 : v31;
wire [31:0] v3ec5 = v3ebb >> v3ec4;
wire [31:0] v3ec6 = v3ec5 & v32;
wire [2:0] v3ec8 = { v320 };
wire [31:0] v3ec9 = ( v3ec8 == 3'd0) ? In_register_EAX : 
	( v3ec8 == 3'd1) ? In_register_ECX : 
	( v3ec8 == 3'd2) ? In_register_EDX : 
	( v3ec8 == 3'd3) ? In_register_EBX : 
	( v3ec8 == 3'd4) ? In_register_EAX : 
	( v3ec8 == 3'd5) ? In_register_ECX : 
	( v3ec8 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v3eca = { v320 };
wire v3ecb = v3eca == vb;
wire v3ecc = v3eca == v9;
wire v3ecd = v3ecb | v3ecc;
wire v3ece = v3eca == vf;
wire v3ecf = v3ecd | v3ece;
wire v3ed0 = v3eca == v11;
wire v3ed1 = v3ecf | v3ed0;
wire [31:0] v3ed2 = ( v3ed1 == 1'd0) ? v15 : v31;
wire [31:0] v3ed3 = v3ec9 >> v3ed2;
wire [31:0] v3ed4 = v3ed3 & v32;
wire [31:0] v3ed6 = ( v3e88 ) ? v3eb8 : 
	( v3e96 ) ? v3ec6 : v3ed4;
wire [7:0] v3ed7 = v3ed6[7:0];
wire [7:0] v3ed8 = v3eab | v3ed7;
wire [31:0] v3ed9 = { 24'b000000000000000000000000, v3ed8 };
wire [31:0] v3eda = v5c8 | v3ed9;
wire v3eeb = v3edb == vb;
wire v3eec = v3eeb;
wire v3eed = v3e88 & v3eec;
wire v3eee = v3edf == vb;
wire v3eef = v3eee;
wire v3ef0 = v3e96 & v3eef;
wire v3ef1 = v3ee3 == vb;
wire v3ef2 = v3ef1;
wire v3ef3 = v3ea4 & v3ef2;
wire v3ef4 = v3eed | v3ef0 | v3ef3;
wire [31:0] v3ee9 = v3ed9 << v31;
wire [31:0] v3eea = v752 | v3ee9;
wire [31:0] v3ef7 = ( v8 ) ? In_register_EAX : 
	( v3ee7 ) ? v3eda : v3eea;
wire [31:0] v3ef9 = v3ef7;
wire v3efa = v3ef9 == Out_register_EAX;
wire v3f08 = v3edb == vc;
wire v3f09 = v3f08;
wire v3f0a = v3e88 & v3f09;
wire v3f0b = v3edf == vc;
wire v3f0c = v3f0b;
wire v3f0d = v3e96 & v3f0c;
wire v3f0e = v3ee3 == vc;
wire v3f0f = v3f0e;
wire v3f10 = v3ea4 & v3f0f;
wire v3f11 = v3f0a | v3f0d | v3f10;
wire [31:0] v3f07 = v7a0 | v3ed9;
wire v3efc = v3edb == vf;
wire v3efd = v3efc;
wire v3efe = v3e88 & v3efd;
wire v3eff = v3edf == vf;
wire v3f00 = v3eff;
wire v3f01 = v3e96 & v3f00;
wire v3f02 = v3ee3 == vf;
wire v3f03 = v3f02;
wire v3f04 = v3ea4 & v3f03;
wire v3f05 = v3efe | v3f01 | v3f04;
wire [31:0] v3efb = v790 | v3ee9;
wire [31:0] v3f14 = ( v8 ) ? In_register_ECX : 
	( v3f11 ) ? v3f07 : v3efb;
wire [31:0] v3f16 = v3f14;
wire v3f17 = v3f16 == Out_register_ECX;
wire v3f19 = v3edb == vd;
wire v3f1a = v3f19;
wire v3f1b = v3e88 & v3f1a;
wire v3f1c = v3edf == vd;
wire v3f1d = v3f1c;
wire v3f1e = v3e96 & v3f1d;
wire v3f1f = v3ee3 == vd;
wire v3f20 = v3f1f;
wire v3f21 = v3ea4 & v3f20;
wire v3f22 = v3f1b | v3f1e | v3f21;
wire [31:0] v3f18 = v7b8 | v3ed9;
wire v3f25 = v3edb == v9;
wire v3f26 = v3f25;
wire v3f27 = v3e88 & v3f26;
wire v3f28 = v3edf == v9;
wire v3f29 = v3f28;
wire v3f2a = v3e96 & v3f29;
wire v3f2b = v3ee3 == v9;
wire v3f2c = v3f2b;
wire v3f2d = v3ea4 & v3f2c;
wire v3f2e = v3f27 | v3f2a | v3f2d;
wire [31:0] v3f24 = v7c8 | v3ee9;
wire [31:0] v3f31 = ( v8 ) ? In_register_EBX : 
	( v3f22 ) ? v3f18 : v3f24;
wire [31:0] v3f33 = v3f31;
wire v3f34 = v3f33 == Out_register_EBX;
wire v3f36 = v17;
wire v3f37 = v3f36 == Out_register_OF;
wire [31:0] v3f3b = ( v3e88 ) ? v1c : 
	( v3ea4 ) ? v16 : v10;
wire [31:0] v3f3c = In_register_EIP + v3f3b;
wire [31:0] v3f3e = v3f3c;
wire v3f3f = v3f3e == Out_register_EIP;
wire [31:0] v3f41 = In_register_ESI;
wire v3f42 = v3f41 == Out_register_ESI;
wire v3f44 = In_register_AF;
wire v3f45 = v3f44 == Out_register_AF;
wire v3f47 = v3edb == ve;
wire v3f48 = v3f47;
wire v3f49 = v3e88 & v3f48;
wire v3f4a = v3edf == ve;
wire v3f4b = v3f4a;
wire v3f4c = v3e96 & v3f4b;
wire v3f4d = v3ee3 == ve;
wire v3f4e = v3f4d;
wire v3f4f = v3ea4 & v3f4e;
wire v3f50 = v3f49 | v3f4c | v3f4f;
wire [31:0] v3f46 = v768 | v3ed9;
wire v3f53 = v3edb == v11;
wire v3f54 = v3f53;
wire v3f55 = v3e88 & v3f54;
wire v3f56 = v3edf == v11;
wire v3f57 = v3f56;
wire v3f58 = v3e96 & v3f57;
wire v3f59 = v3ee3 == v11;
wire v3f5a = v3f59;
wire v3f5b = v3ea4 & v3f5a;
wire v3f5c = v3f55 | v3f58 | v3f5b;
wire [31:0] v3f52 = v778 | v3ee9;
wire [31:0] v3f5f = ( v8 ) ? In_register_EDX : 
	( v3f50 ) ? v3f46 : v3f52;
wire [31:0] v3f61 = v3f5f;
wire v3f62 = v3f61 == Out_register_EDX;
wire [1:0] v3f63 = { v889 , v888 };
wire [31:0] v3f64 = ( v3f63 == 2'd0) ? In_register_EDX : 
	( v3f63 == 2'd1) ? In_register_ESI : 
	( v3f63 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v3f66 = { v1fa };
wire [31:0] v3f67 = ( v3f66 == 3'd0) ? In_register_EAX : 
	( v3f66 == 3'd1) ? In_register_ECX : 
	( v3f66 == 3'd2) ? In_register_EDX : 
	( v3f66 == 3'd3) ? In_register_EBX : 
	( v3f66 == 3'd4) ? v15 : 
	( v3f66 == 3'd5) ? v15 : 
	( v3f66 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3f68 = v3f67 + v63a;
wire [2:0] v3f6a = { v1fa };
wire [31:0] v3f6b = ( v3f6a == 3'd0) ? In_register_EAX : 
	( v3f6a == 3'd1) ? In_register_ECX : 
	( v3f6a == 3'd2) ? In_register_EDX : 
	( v3f6a == 3'd3) ? In_register_EBX : 
	( v3f6a == 3'd4) ? v15 : 
	( v3f6a == 3'd5) ? v15 : 
	( v3f6a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v3f6c = v3f6b + v1f7;
wire [31:0] v3f6e = ( v3e88 ) ? v3f64 : 
	( v3e96 ) ? v3f68 : v3f6c;
wire v3f6f =  v2a == memory_0[15: 12] && v3f6e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v3f71 = In_register_EBP;
wire v3f72 = v3f71 == Out_register_EBP;
wire [31:0] v3f74 = In_register_ESP;
wire v3f75 = v3f74 == Out_register_ESP;
wire [31:0] v3f77 = In_register_CSBASE;
wire v3f78 = v3f77 == Out_register_CSBASE;
wire [31:0] v3f7a = In_register_SSBASE;
wire v3f7b = v3f7a == Out_register_SSBASE;
wire [31:0] v3f7d = In_register_ESBASE;
wire v3f7e = v3f7d == Out_register_ESBASE;
wire v3f7f = In_error_flag == Out_error_flag;
wire [31:0] v3f81 = In_register_GSBASE;
wire v3f82 = v3f81 == Out_register_GSBASE;
wire [31:0] v3f84 = In_register_FSBASE;
wire v3f85 = v3f84 == Out_register_FSBASE;
wire v3f86 = v17;
wire v3f87 = v3f86 == Out_register_CF;
wire [7:0] v3f89 = In_register_DF;
wire v3f8a = v3f89 == Out_register_DF;
wire [31:0] v3f8c = In_register_EDI;
wire v3f8d = v3f8c == Out_register_EDI;
wire [2:0] v3f8e_aux = v3ed8[0] + v3ed8[1] + v3ed8[2] + v3ed8[3] + v3ed8[4] + v3ed8[5] + v3ed8[6] + v3ed8[7];
wire v3f8e = { 5'b00000, v3f8e_aux };
wire [7:0] v3f8f = v3f8e & v18;
wire [7:0] v3f90 = v3f8f ^ v18;
wire v3f91 = v3f90[0:0];
wire v3f93 = v3f91;
wire v3f94 = v3f93 == Out_register_PF;
wire v3f95 = $signed(v3ed8) < $signed(v2c);
wire v3f97 = v3f95;
wire v3f98 = v3f97 == Out_register_SF;
wire v3f99 = v3ed8 == v2c;
wire v3f9b = v3f99;
wire v3f9c = v3f9b == Out_register_ZF;
wire v3f9d = v15c & v3ea9 & v3efa & v3f17 & v3f34 & v3f37 & v3ea6 & v3f3f & v3f42 & v3f45 & v3f62 & v3f6f & v3f72 & v3f75 & v3f78 & v3f7b & v3f7e & v3f7f & v3f82 & v3f85 & v3f87 & v3f8a & v3f8d & v3f94 & v3f98 & v3f9c;
wire [7:0] vd0 = 8'b00100101;
wire v3f9e = vd0 == v1eb;
wire v3f9f = v29 == v59f;
wire v3fa0 = v3f9e & v3f9f;
wire v3fa1 = v3fa0;
wire v3fa2 = v3fa1;
wire [31:0] v3fa4 = v2b;
wire [31:0] v3fa5 = In_register_EIP + v3fa4;
wire [31:0] v3fa7 = v3fa5;
wire v3fa8 = v3fa7 == Out_register_EIP;
wire v3fa9 =  v2a == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v3fab = In_register_EDX;
wire v3fac = v3fab == Out_register_EDX;
wire [31:0] v3fae = v5c1;
wire v3faf = v3fae == Out_register_ESI;
wire [31:0] v3fb1 = In_register_DSBASE;
wire v3fb2 = v3fb1 == Out_register_DSBASE;
wire [31:0] v3fb4 = In_register_GSBASE;
wire v3fb5 = v3fb4 == Out_register_GSBASE;
wire [31:0] v3fb7 = In_register_ECX;
wire v3fb8 = v3fb7 == Out_register_ECX;
wire [31:0] v3fb9 = memory_0[79: 48];
wire [7:0] v3fba = v3fb9[7:0];
wire v3fbb =  v2a == memory_1[15: 12] && v1b8e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v3fba == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v3fbd = In_register_ESP;
wire v3fbe = v3fbd == Out_register_ESP;
wire [31:0] v3fc0 = v1b5d;
wire v3fc1 = v3fc0 == Out_register_EDI;
wire v3fc3 = In_register_PF;
wire v3fc4 = v3fc3 == Out_register_PF;
wire v3fc5 = In_error_flag == Out_error_flag;
wire [31:0] v3fc7 = In_register_EAX;
wire v3fc8 = v3fc7 == Out_register_EAX;
wire [31:0] v3fca = In_register_EBP;
wire v3fcb = v3fca == Out_register_EBP;
wire [31:0] v3fcd = In_register_SSBASE;
wire v3fce = v3fcd == Out_register_SSBASE;
wire [31:0] v3fd0 = In_register_ESBASE;
wire v3fd1 = v3fd0 == Out_register_ESBASE;
wire v3fd3 = In_register_CF;
wire v3fd4 = v3fd3 == Out_register_CF;
wire v3fd6 = In_register_AF;
wire v3fd7 = v3fd6 == Out_register_AF;
wire [31:0] v3fd9 = In_register_FSBASE;
wire v3fda = v3fd9 == Out_register_FSBASE;
wire [31:0] v3fdc = In_register_CSBASE;
wire v3fdd = v3fdc == Out_register_CSBASE;
wire [7:0] v3fdf = In_register_DF;
wire v3fe0 = v3fdf == Out_register_DF;
wire v3fe2 = In_register_OF;
wire v3fe3 = v3fe2 == Out_register_OF;
wire [31:0] v3fe5 = In_register_EBX;
wire v3fe6 = v3fe5 == Out_register_EBX;
wire v3fe8 = In_register_SF;
wire v3fe9 = v3fe8 == Out_register_SF;
wire v3feb = In_register_ZF;
wire v3fec = v3feb == Out_register_ZF;
wire v3fed = v3fa2 & v3fa8 & v3fa9 & v3fac & v15c & v3faf & v3fb2 & v3fb5 & v3fb8 & v3fbb & v3fbe & v3fc1 & v3fc4 & v3fc5 & v3fc8 & v3fcb & v3fce & v3fd1 & v3fd4 & v3fd7 & v3fda & v3fdd & v3fe0 & v3fe3 & v3fe6 & v3fe9 & v3fec;
wire [7:0] vd1 = 8'b11100101;
wire v3fee = vd1 == v1eb;
wire v3fef = v29 == v59f;
wire v3ff0 = v3fee & v3fef;
wire v3ff1 = v3ff0;
wire v3ff2 = v3ff1;
wire [31:0] v3ff4 = In_register_ECX;
wire v3ff5 = v3ff4 == Out_register_ECX;
wire [31:0] v3ff7 = In_register_ESBASE;
wire v3ff8 = v3ff7 == Out_register_ESBASE;
wire [31:0] v3ffa = In_register_ESP;
wire v3ffb = v3ffa == Out_register_ESP;
wire v3ffc =  v26 == memory_1[15: 12] && v1b8e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b0 == memory_1[1: 1];
wire [31:0] v3ffe = v2b;
wire [31:0] v3fff = In_register_EIP + v3ffe;
wire [31:0] v4001 = v3fff;
wire v4002 = v4001 == Out_register_EIP;
wire [31:0] v4004 = In_register_EDX;
wire v4005 = v4004 == Out_register_EDX;
wire [31:0] v4007 = In_register_CSBASE;
wire v4008 = v4007 == Out_register_CSBASE;
wire [31:0] v4009 = memory_0[79: 48];
wire [31:0] v400a = memory_1[79: 48];
wire v400b = v4009 < v400a;
wire v400d = v400b;
wire v400e = v400d == Out_register_CF;
wire [31:0] v4010 = In_register_EBX;
wire v4011 = v4010 == Out_register_EBX;
wire [31:0] v4013 = v8cd;
wire v4014 = v4013 == Out_register_ESI;
wire v4015 = In_error_flag == Out_error_flag;
wire [31:0] v4017 = In_register_GSBASE;
wire v4018 = v4017 == Out_register_GSBASE;
wire [31:0] v401a = In_register_FSBASE;
wire v401b = v401a == Out_register_FSBASE;
wire [31:0] v401d = v23be;
wire v401e = v401d == Out_register_EDI;
wire [31:0] v4020 = In_register_EAX;
wire v4021 = v4020 == Out_register_EAX;
wire [31:0] v4023 = In_register_EBP;
wire v4024 = v4023 == Out_register_EBP;
wire [31:0] v4026 = In_register_SSBASE;
wire v4027 = v4026 == Out_register_SSBASE;
wire v4028 =  v26 == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v402a = In_register_DSBASE;
wire v402b = v402a == Out_register_DSBASE;
wire [31:0] v402c = v4009 - v400a;
wire [31:0] v402d = v402c ^ v4009;
wire [31:0] v402e = v402d >> v1e;
wire [31:0] v402f = v400a ^ v4009;
wire [31:0] v4030 = v402f >> v1e;
wire [31:0] v4031 = v402e + v4030;
wire v4032 = v4031 == v1c;
wire v4034 = v4032;
wire v4035 = v4034 == Out_register_OF;
wire [31:0] v4036 = v402f ^ v402c;
wire [7:0] v4037 = v4036[7:0];
wire [7:0] v4038 = v4037 >> v1d;
wire [7:0] v4039 = v4038 & v18;
wire v403a = v4039[0:0];
wire v403c = v403a;
wire v403d = v403c == Out_register_AF;
wire [7:0] v403f = In_register_DF;
wire v4040 = v403f == Out_register_DF;
wire v4041 = $signed(v402c) < $signed(v15);
wire v4043 = v4041;
wire v4044 = v4043 == Out_register_SF;
wire [7:0] v4045 = v402c[7:0];
wire [2:0] v4046_aux = v4045[0] + v4045[1] + v4045[2] + v4045[3] + v4045[4] + v4045[5] + v4045[6] + v4045[7];
wire v4046 = { 5'b00000, v4046_aux };
wire [7:0] v4047 = v4046 & v18;
wire [7:0] v4048 = v4047 ^ v18;
wire v4049 = v4048[0:0];
wire v404b = v4049;
wire v404c = v404b == Out_register_PF;
wire v404d = v4009 == v400a;
wire v404f = v404d;
wire v4050 = v404f == Out_register_ZF;
wire v4051 = v3ff5 & v15c & v3ff8 & v3ffb & v3ffc & v4002 & v4005 & v4008 & v400e & v4011 & v4014 & v4015 & v4018 & v401b & v401e & v4021 & v4024 & v4027 & v4028 & v402b & v3ff2 & v4035 & v403d & v4040 & v4044 & v404c & v4050;
wire [7:0] vd2 = 8'b01010001;
wire v4052 = vd2 == v1eb;
wire v4053 = v3 == v316;
wire v4054 = v1b == v318;
wire v4055 = v4052 & v4053 & v4054;
wire v4056 = v4055;
wire v4057 = v4056;
wire [31:0] v4059 = In_register_DSBASE;
wire v405a = v4059 == Out_register_DSBASE;
wire [31:0] v405c = In_register_SSBASE;
wire v405d = v405c == Out_register_SSBASE;
wire [2:0] v4070 = { v320 };
wire v4071 = v4070 == vd;
wire v4072 = v4071;
wire v4073 = v4055 & v4072;
wire v4074 = v4073;
wire [2:0] v405e = { v1fa };
wire [31:0] v405f = ( v405e == 3'd0) ? In_register_EAX : 
	( v405e == 3'd1) ? In_register_ECX : 
	( v405e == 3'd2) ? In_register_EDX : 
	( v405e == 3'd3) ? In_register_EBX : 
	( v405e == 3'd4) ? In_register_EAX : 
	( v405e == 3'd5) ? In_register_ECX : 
	( v405e == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4060 = { v1fa };
wire v4061 = v4060 == vb;
wire v4062 = v4060 == v9;
wire v4063 = v4061 | v4062;
wire v4064 = v4060 == vf;
wire v4065 = v4063 | v4064;
wire v4066 = v4060 == v11;
wire v4067 = v4065 | v4066;
wire [31:0] v4068 = ( v4067 == 1'd0) ? v15 : v31;
wire [31:0] v4069 = v405f >> v4068;
wire [31:0] v406a = v4069 & v32;
wire [31:0] v406c = v406a;
wire [7:0] v406d = v406c[7:0];
wire [31:0] v406e = { 24'b000000000000000000000000, v406d };
wire [31:0] v406f = v7b8 | v406e;
wire v4078 = v4070 == v9;
wire v4079 = v4078;
wire v407a = v4055 & v4079;
wire v407b = v407a;
wire [31:0] v4076 = v406e << v31;
wire [31:0] v4077 = v7c8 | v4076;
wire [31:0] v407e = ( v8 ) ? In_register_EBX : 
	( v4074 ) ? v406f : v4077;
wire [31:0] v4080 = v407e;
wire v4081 = v4080 == Out_register_EBX;
wire v4083 = In_register_CF;
wire v4084 = v4083 == Out_register_CF;
wire v4085 = In_error_flag == Out_error_flag;
wire [31:0] v4087 = In_register_ESP;
wire v4088 = v4087 == Out_register_ESP;
wire v408a = v4070 == v7;
wire v408b = v408a;
wire v408c = v4055 & v408b;
wire v408d = v408c;
wire [31:0] v4089 = v5c8 | v406e;
wire v4090 = v4070 == vb;
wire v4091 = v4090;
wire v4092 = v4055 & v4091;
wire v4093 = v4092;
wire [31:0] v408f = v752 | v4076;
wire [31:0] v4096 = ( v8 ) ? In_register_EAX : 
	( v408d ) ? v4089 : v408f;
wire [31:0] v4098 = v4096;
wire v4099 = v4098 == Out_register_EAX;
wire [31:0] v409b = In_register_GSBASE;
wire v409c = v409b == Out_register_GSBASE;
wire v409e = v4070 == ve;
wire v409f = v409e;
wire v40a0 = v4055 & v409f;
wire v40a1 = v40a0;
wire [31:0] v409d = v768 | v406e;
wire v40a4 = v4070 == v11;
wire v40a5 = v40a4;
wire v40a6 = v4055 & v40a5;
wire v40a7 = v40a6;
wire [31:0] v40a3 = v778 | v4076;
wire [31:0] v40aa = ( v8 ) ? In_register_EDX : 
	( v40a1 ) ? v409d : v40a3;
wire [31:0] v40ac = v40aa;
wire v40ad = v40ac == Out_register_EDX;
wire v40af = In_register_ZF;
wire v40b0 = v40af == Out_register_ZF;
wire [31:0] v40b2 = In_register_EBP;
wire v40b3 = v40b2 == Out_register_EBP;
wire [31:0] v40b5 = In_register_EDI;
wire v40b6 = v40b5 == Out_register_EDI;
wire [31:0] v40b8 = In_register_ESI;
wire v40b9 = v40b8 == Out_register_ESI;
wire [31:0] v40bb = In_register_FSBASE;
wire v40bc = v40bb == Out_register_FSBASE;
wire v40be = v4070 == vf;
wire v40bf = v40be;
wire v40c0 = v4055 & v40bf;
wire v40c1 = v40c0;
wire [31:0] v40bd = v790 | v4076;
wire v40c4 = v4070 == vc;
wire v40c5 = v40c4;
wire v40c6 = v4055 & v40c5;
wire v40c7 = v40c6;
wire [31:0] v40c3 = v7a0 | v406e;
wire [31:0] v40ca = ( v8 ) ? In_register_ECX : 
	( v40c1 ) ? v40bd : v40c3;
wire [31:0] v40cc = v40ca;
wire v40cd = v40cc == Out_register_ECX;
wire v40cf = In_register_AF;
wire v40d0 = v40cf == Out_register_AF;
wire [31:0] v40d2 = v1c;
wire [31:0] v40d3 = In_register_EIP + v40d2;
wire [31:0] v40d5 = v40d3;
wire v40d6 = v40d5 == Out_register_EIP;
wire [31:0] v40d8 = In_register_CSBASE;
wire v40d9 = v40d8 == Out_register_CSBASE;
wire [31:0] v40db = In_register_ESBASE;
wire v40dc = v40db == Out_register_ESBASE;
wire v40de = In_register_PF;
wire v40df = v40de == Out_register_PF;
wire [7:0] v40e1 = In_register_DF;
wire v40e2 = v40e1 == Out_register_DF;
wire v40e4 = In_register_OF;
wire v40e5 = v40e4 == Out_register_OF;
wire v40e7 = In_register_SF;
wire v40e8 = v40e7 == Out_register_SF;
wire v40e9 = v405a & v405d & v4081 & v4084 & v4085 & v4057 & v4088 & v4099 & v409c & v40ad & v40b0 & v15c & v40b3 & v40b6 & v40b9 & v40bc & v40cd & v40d0 & v40d6 & v40d9 & v40dc & v40df & v40e2 & v40e5 & v40e8;
wire [7:0] vd3 = 8'b10100001;
wire v40ea = vd3 == v1eb;
wire v40eb = v3 == v316;
wire v40ec = v1b == v318;
wire v40ed = v40ea & v40eb & v40ec;
wire v40ee = v40ed;
wire v40ef = v40ee;
wire [31:0] v40f1 = In_register_ESP;
wire v40f2 = v40f1 == Out_register_ESP;
wire v40f3 = In_error_flag == Out_error_flag;
wire [2:0] v40f4 = { v320 };
wire [31:0] v40f5 = ( v40f4 == 3'd0) ? In_register_EAX : 
	( v40f4 == 3'd1) ? In_register_ECX : 
	( v40f4 == 3'd2) ? In_register_EDX : 
	( v40f4 == 3'd3) ? In_register_EBX : 
	( v40f4 == 3'd4) ? In_register_ESP : 
	( v40f4 == 3'd5) ? In_register_EBP : 
	( v40f4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v40f7 = v40f5;
wire [2:0] v40f8 = { v1fa };
wire [31:0] v40f9 = ( v40f8 == 3'd0) ? In_register_EAX : 
	( v40f8 == 3'd1) ? In_register_ECX : 
	( v40f8 == 3'd2) ? In_register_EDX : 
	( v40f8 == 3'd3) ? In_register_EBX : 
	( v40f8 == 3'd4) ? In_register_ESP : 
	( v40f8 == 3'd5) ? In_register_EBP : 
	( v40f8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v40fb = v40f9;
wire [31:0] v40fc = v40f7 & v40fb;
wire v40fd = $signed(v40fc) < $signed(v15);
wire v40ff = v40fd;
wire v4100 = v40ff == Out_register_SF;
wire [31:0] v4102 = In_register_ECX;
wire v4103 = v4102 == Out_register_ECX;
wire [31:0] v4105 = In_register_EDX;
wire v4106 = v4105 == Out_register_EDX;
wire [31:0] v4108 = In_register_ESI;
wire v4109 = v4108 == Out_register_ESI;
wire [31:0] v410b = In_register_EDI;
wire v410c = v410b == Out_register_EDI;
wire [31:0] v410e = In_register_EBP;
wire v410f = v410e == Out_register_EBP;
wire [31:0] v4111 = In_register_EAX;
wire v4112 = v4111 == Out_register_EAX;
wire [31:0] v4114 = In_register_EBX;
wire v4115 = v4114 == Out_register_EBX;
wire v4117 = v17;
wire v4118 = v4117 == Out_register_CF;
wire [31:0] v411a = In_register_CSBASE;
wire v411b = v411a == Out_register_CSBASE;
wire [31:0] v411d = In_register_SSBASE;
wire v411e = v411d == Out_register_SSBASE;
wire [31:0] v4120 = In_register_GSBASE;
wire v4121 = v4120 == Out_register_GSBASE;
wire [31:0] v4123 = In_register_FSBASE;
wire v4124 = v4123 == Out_register_FSBASE;
wire [31:0] v4126 = In_register_ESBASE;
wire v4127 = v4126 == Out_register_ESBASE;
wire v4128 = v17;
wire v4129 = v4128 == Out_register_OF;
wire [31:0] v412b = In_register_DSBASE;
wire v412c = v412b == Out_register_DSBASE;
wire v412e = In_register_AF;
wire v412f = v412e == Out_register_AF;
wire [7:0] v4131 = In_register_DF;
wire v4132 = v4131 == Out_register_DF;
wire [31:0] v4134 = v1c;
wire [31:0] v4135 = In_register_EIP + v4134;
wire [31:0] v4137 = v4135;
wire v4138 = v4137 == Out_register_EIP;
wire v4139 = v40fc == v15;
wire v413b = v4139;
wire v413c = v413b == Out_register_ZF;
wire [7:0] v413d = v40fc[7:0];
wire [2:0] v413e_aux = v413d[0] + v413d[1] + v413d[2] + v413d[3] + v413d[4] + v413d[5] + v413d[6] + v413d[7];
wire v413e = { 5'b00000, v413e_aux };
wire [7:0] v413f = v413e & v18;
wire [7:0] v4140 = v413f ^ v18;
wire v4141 = v4140[0:0];
wire v4143 = v4141;
wire v4144 = v4143 == Out_register_PF;
wire v4145 = v40f2 & v40f3 & v4100 & v40ef & v4103 & v4106 & v4109 & v410c & v410f & v4112 & v4115 & v4118 & v411b & v411e & v4121 & v4124 & v15c & v4127 & v4129 & v412c & v412f & v4132 & v4138 & v413c & v4144;
wire v4146 = v40 == v1eb;
wire v4147 = v8 == v829;
wire v4148 = vb7 == v1ed;
wire v4149 = v4 == v11b;
wire v414a = v4146 & v4147 & v4148 & v4149;
wire v414b = v40 == v1eb;
wire v414c = vb6 == v1ed;
wire v414d = v38 == v6da;
wire [2:0] v414e = { v1fa };
wire v414f = v414e == vb;
wire v4150 = v414e == vf;
wire v4151 = v414f | v4150;
wire v4152 = v4151 ^ v8;
wire [2:0] v4153 = { v1fa };
wire v4154 = v4153 == vb;
wire v4155 = v4154;
wire v4156 = v4155 ^ v8;
wire [2:0] v4157 = { v1fa };
wire v4158 = v4157 == vb;
wire v4159 = v4157 == vf;
wire v415a = v4158 | v4159;
wire v415b = v415a ^ v8;
wire [2:0] v415c = { v1fa };
wire v415d = v415c == vb;
wire v415e = v415d;
wire v415f = v415e ^ v8;
wire v4160 = v4152 & v4156 & v415b & v415f;
wire v4161 = v414b & v414c & v414d & v4160;
wire [15:0] vd4 = 16'b1100000100101100;
wire v4162 = vd4 == v117;
wire v4163 = v38 == v6da;
wire [2:0] v4164 = { v13c };
wire v4165 = v4164 == vb;
wire v4166 = v4164 == vf;
wire v4167 = v4165 | v4166;
wire v4168 = v4167 ^ v8;
wire [2:0] v4169 = { v12c };
wire v416a = v4169 == vb;
wire v416b = v416a;
wire v416c = v416b ^ v8;
wire [2:0] v416d = { v13c };
wire v416e = v416d == vf;
wire v416f = v416e;
wire v4170 = v416f ^ v8;
wire [2:0] v4171 = { v13c };
wire v4172 = v4171 == vb;
wire v4173 = v4171 == vf;
wire v4174 = v4172 | v4173;
wire v4175 = v4174 ^ v8;
wire [2:0] v4176 = { v12c };
wire v4177 = v4176 == vb;
wire v4178 = v4177;
wire v4179 = v4178 ^ v8;
wire [2:0] v417a = { v13c };
wire v417b = v417a == vf;
wire v417c = v417b;
wire v417d = v417c ^ v8;
wire v417e = v4168 & v416c & v4170 & v4175 & v4179 & v417d;
wire v417f = v4162 & v4163 & v417e;
wire v4180 = v40 == v1eb;
wire [4:0] vd5 = 5'b01101;
wire v4181 = vd5 == v1ed;
wire v4182 = v43 == vab3;
wire [2:0] v4183 = { v1fa };
wire v4184 = v4183 == vb;
wire v4185 = v4184;
wire v4186 = v4185 ^ v8;
wire [2:0] v4187 = { v1fa };
wire v4188 = v4187 == vb;
wire v4189 = v4188;
wire v418a = v4189 ^ v8;
wire [2:0] v418b = { v1fa };
wire v418c = v418b == vb;
wire v418d = v418c;
wire v418e = v418d ^ v8;
wire [2:0] v418f = { v1fa };
wire v4190 = v418f == vb;
wire v4191 = v4190;
wire v4192 = v4191 ^ v8;
wire v4193 = v4186 & v418a & v418e & v4192;
wire v4194 = v4180 & v4181 & v4182 & v4193;
wire [15:0] vd6 = 16'b1100000100101101;
wire v4195 = vd6 == v117;
wire v4196 = v51 == vdfc;
wire [2:0] v4197 = { v13c };
wire v4198 = v4197 == vb;
wire v4199 = v4197 == vf;
wire v419a = v4198 | v4199;
wire v419b = v419a ^ v8;
wire [2:0] v419c = { v12c };
wire v419d = v419c == vb;
wire v419e = v419d;
wire v419f = v419e ^ v8;
wire [2:0] v41a0 = { v13c };
wire v41a1 = v41a0 == vb;
wire v41a2 = v41a0 == vf;
wire v41a3 = v41a1 | v41a2;
wire v41a4 = v41a3 ^ v8;
wire [2:0] v41a5 = { v12c };
wire v41a6 = v41a5 == vb;
wire v41a7 = v41a6;
wire v41a8 = v41a7 ^ v8;
wire v41a9 = v419b & v419f & v41a4 & v41a8;
wire v41aa = v4195 & v4196 & v41a9;
wire v41ab = v414a | v4161 | v417f | v4194 | v41aa;
wire v41ac = v41ab;
wire [31:0] v41ae = In_register_ECX;
wire v41af = v41ae == Out_register_ECX;
wire [2:0] v41b3 = { v1fa };
wire [31:0] v41b4 = ( v41b3 == 3'd0) ? In_register_EAX : 
	( v41b3 == 3'd1) ? In_register_ECX : 
	( v41b3 == 3'd2) ? In_register_EDX : 
	( v41b3 == 3'd3) ? In_register_EBX : 
	( v41b3 == 3'd4) ? v15 : 
	( v41b3 == 3'd5) ? v15 : 
	( v41b3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v41b5 = v41b4 + v63a;
wire [2:0] v41b7 = { v13c };
wire [31:0] v41b8 = ( v41b7 == 3'd0) ? In_register_EAX : 
	( v41b7 == 3'd1) ? In_register_ECX : 
	( v41b7 == 3'd2) ? In_register_EDX : 
	( v41b7 == 3'd3) ? In_register_EBX : 
	( v41b7 == 3'd4) ? v15 : 
	( v41b7 == 3'd5) ? v15 : 
	( v41b7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v41b9 = { v12c };
wire [31:0] v41ba = ( v41b9 == 3'd0) ? In_register_EAX : 
	( v41b9 == 3'd1) ? In_register_ECX : 
	( v41b9 == 3'd2) ? In_register_EDX : 
	( v41b9 == 3'd3) ? In_register_EBX : 
	( v41b9 == 3'd4) ? v15 : 
	( v41b9 == 3'd5) ? In_register_EBP : 
	( v41b9 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v41bb = v41ba << v7f4;
wire [31:0] v41bc = v41b8 + v41bb;
wire [2:0] v41be = { v1fa };
wire [31:0] v41bf = ( v41be == 3'd0) ? In_register_EAX : 
	( v41be == 3'd1) ? In_register_ECX : 
	( v41be == 3'd2) ? In_register_EDX : 
	( v41be == 3'd3) ? In_register_EBX : 
	( v41be == 3'd4) ? v15 : 
	( v41be == 3'd5) ? In_register_EBP : 
	( v41be == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v41c0 = v41bf + v1f7;
wire [2:0] v41c2 = { v13c };
wire [31:0] v41c3 = ( v41c2 == 3'd0) ? In_register_EAX : 
	( v41c2 == 3'd1) ? In_register_ECX : 
	( v41c2 == 3'd2) ? In_register_EDX : 
	( v41c2 == 3'd3) ? In_register_EBX : 
	( v41c2 == 3'd4) ? v15 : 
	( v41c2 == 3'd5) ? v15 : 
	( v41c2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v41c4 = { v12c };
wire [31:0] v41c5 = ( v41c4 == 3'd0) ? In_register_EAX : 
	( v41c4 == 3'd1) ? In_register_ECX : 
	( v41c4 == 3'd2) ? In_register_EDX : 
	( v41c4 == 3'd3) ? In_register_EBX : 
	( v41c4 == 3'd4) ? v15 : 
	( v41c4 == 3'd5) ? In_register_EBP : 
	( v41c4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v41c6 = v41c5 << v7f4;
wire [31:0] v41c7 = v41c3 + v41c6;
wire [31:0] v41c8 = v41c7 + vc2d;
wire [1:0] v41b0 = { v889 , v888 };
wire [31:0] v41b1 = ( v41b0 == 2'd0) ? In_register_EDX : 
	( v41b0 == 2'd1) ? In_register_ESI : 
	( v41b0 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v41ca = ( v4161 ) ? v41b5 : 
	( v417f ) ? v41bc : 
	( v4194 ) ? v41c0 : 
	( v41aa ) ? v41c8 : v41b1;
wire [31:0] v41cb = memory_0[79: 48];
wire [31:0] v41d1 = ( v4161 | v417f ) ? v7f8 : 
	( v4194 ) ? vb0c : 
	( v41aa ) ? ve10 : v63a;
wire [31:0] v41d2 = v41cb ^ v41d1;
wire v41d3 =  v26 == memory_1[15: 12] && v41ca == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v41d2 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v41d4 = In_error_flag == Out_error_flag;
wire [31:0] v41d6 = In_register_EDI;
wire v41d7 = v41d6 == Out_register_EDI;
wire [31:0] v41d9 = In_register_FSBASE;
wire v41da = v41d9 == Out_register_FSBASE;
wire [31:0] v41dc = In_register_EBX;
wire v41dd = v41dc == Out_register_EBX;
wire [31:0] v41df = In_register_EBP;
wire v41e0 = v41df == Out_register_EBP;
wire [31:0] v41e2 = In_register_EAX;
wire v41e3 = v41e2 == Out_register_EAX;
wire [31:0] v41e5 = In_register_ESI;
wire v41e6 = v41e5 == Out_register_ESI;
wire [31:0] v41e8 = In_register_ESP;
wire v41e9 = v41e8 == Out_register_ESP;
wire [31:0] v41ef = ( v4194 ) ? v45 : 
	( v41aa ) ? v31 : 
	( v4161 | v417f ) ? v27 : v10;
wire [31:0] v41f0 = In_register_EIP + v41ef;
wire [31:0] v41f2 = v41f0;
wire v41f3 = v41f2 == Out_register_EIP;
wire v41f5 = In_register_AF;
wire v41f6 = v41f5 == Out_register_AF;
wire [31:0] v41f8 = In_register_CSBASE;
wire v41f9 = v41f8 == Out_register_CSBASE;
wire [7:0] v41fb = In_register_DF;
wire v41fc = v41fb == Out_register_DF;
wire [31:0] v41fe = In_register_SSBASE;
wire v41ff = v41fe == Out_register_SSBASE;
wire [31:0] v4201 = In_register_GSBASE;
wire v4202 = v4201 == Out_register_GSBASE;
wire [31:0] v4204 = In_register_ESBASE;
wire v4205 = v4204 == Out_register_ESBASE;
wire [2:0] v4209 = { v1fa };
wire [31:0] v420a = ( v4209 == 3'd0) ? In_register_EAX : 
	( v4209 == 3'd1) ? In_register_ECX : 
	( v4209 == 3'd2) ? In_register_EDX : 
	( v4209 == 3'd3) ? In_register_EBX : 
	( v4209 == 3'd4) ? v15 : 
	( v4209 == 3'd5) ? v15 : 
	( v4209 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v420b = v420a + v63a;
wire [2:0] v420d = { v13c };
wire [31:0] v420e = ( v420d == 3'd0) ? In_register_EAX : 
	( v420d == 3'd1) ? In_register_ECX : 
	( v420d == 3'd2) ? In_register_EDX : 
	( v420d == 3'd3) ? In_register_EBX : 
	( v420d == 3'd4) ? v15 : 
	( v420d == 3'd5) ? v15 : 
	( v420d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v420f = { v12c };
wire [31:0] v4210 = ( v420f == 3'd0) ? In_register_EAX : 
	( v420f == 3'd1) ? In_register_ECX : 
	( v420f == 3'd2) ? In_register_EDX : 
	( v420f == 3'd3) ? In_register_EBX : 
	( v420f == 3'd4) ? v15 : 
	( v420f == 3'd5) ? In_register_EBP : 
	( v420f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4211 = v4210 << v7f4;
wire [31:0] v4212 = v420e + v4211;
wire [2:0] v4214 = { v1fa };
wire [31:0] v4215 = ( v4214 == 3'd0) ? In_register_EAX : 
	( v4214 == 3'd1) ? In_register_ECX : 
	( v4214 == 3'd2) ? In_register_EDX : 
	( v4214 == 3'd3) ? In_register_EBX : 
	( v4214 == 3'd4) ? v15 : 
	( v4214 == 3'd5) ? In_register_EBP : 
	( v4214 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4216 = v4215 + v1f7;
wire [2:0] v4218 = { v13c };
wire [31:0] v4219 = ( v4218 == 3'd0) ? In_register_EAX : 
	( v4218 == 3'd1) ? In_register_ECX : 
	( v4218 == 3'd2) ? In_register_EDX : 
	( v4218 == 3'd3) ? In_register_EBX : 
	( v4218 == 3'd4) ? v15 : 
	( v4218 == 3'd5) ? v15 : 
	( v4218 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v421a = { v12c };
wire [31:0] v421b = ( v421a == 3'd0) ? In_register_EAX : 
	( v421a == 3'd1) ? In_register_ECX : 
	( v421a == 3'd2) ? In_register_EDX : 
	( v421a == 3'd3) ? In_register_EBX : 
	( v421a == 3'd4) ? v15 : 
	( v421a == 3'd5) ? In_register_EBP : 
	( v421a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v421c = v421b << v7f4;
wire [31:0] v421d = v4219 + v421c;
wire [31:0] v421e = v421d + vc2d;
wire [1:0] v4206 = { v889 , v888 };
wire [31:0] v4207 = ( v4206 == 2'd0) ? In_register_EDX : 
	( v4206 == 2'd1) ? In_register_ESI : 
	( v4206 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v4220 = ( v4161 ) ? v420b : 
	( v417f ) ? v4212 : 
	( v4194 ) ? v4216 : 
	( v41aa ) ? v421e : v4207;
wire v4221 =  v26 == memory_0[15: 12] && v4220 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v4223 = v17;
wire v4224 = v4223 == Out_register_OF;
wire [31:0] v4226 = In_register_DSBASE;
wire v4227 = v4226 == Out_register_DSBASE;
wire [31:0] v4229 = In_register_EDX;
wire v422a = v4229 == Out_register_EDX;
wire v422b = v17;
wire v422c = v422b == Out_register_CF;
wire [7:0] v422d = v41d2[7:0];
wire [2:0] v422e_aux = v422d[0] + v422d[1] + v422d[2] + v422d[3] + v422d[4] + v422d[5] + v422d[6] + v422d[7];
wire v422e = { 5'b00000, v422e_aux };
wire [7:0] v422f = v422e & v18;
wire [7:0] v4230 = v422f ^ v18;
wire v4231 = v4230[0:0];
wire v4233 = v4231;
wire v4234 = v4233 == Out_register_PF;
wire v4235 = $signed(v41d2) < $signed(v15);
wire v4237 = v4235;
wire v4238 = v4237 == Out_register_SF;
wire v4239 = v41d2 == v15;
wire v423b = v4239;
wire v423c = v423b == Out_register_ZF;
wire v423d = v41af & v41d3 & v41d4 & v41d7 & v41ac & v41da & v41dd & v15c & v41e0 & v41e3 & v41e6 & v41e9 & v41f3 & v41f6 & v41f9 & v41fc & v41ff & v4202 & v4205 & v4221 & v4224 & v4227 & v422a & v422c & v4234 & v4238 & v423c;
wire [10:0] vd7 = 11'b11010001001;
wire v423e = vd7 == v6d7;
wire v423f = v35 == v316;
wire v4240 = v94 == v20a0;
wire v4241 = v4 == v11b;
wire [2:0] v4242 = { v13c };
wire v4243 = v4242 == vf;
wire v4244 = v4243;
wire v4245 = v4244 ^ v8;
wire [2:0] v4246 = { v13c };
wire v4247 = v4246 == vf;
wire v4248 = v4247;
wire v4249 = v4248 ^ v8;
wire v424a = v4245 & v4249;
wire v424b = v423e & v423f & v4240 & v4241 & v424a;
wire [10:0] vd8 = 11'b11010001101;
wire v424c = vd8 == v6d7;
wire v424d = v35 == v316;
wire v424e = v14 == v1ef;
wire v424f = v424c & v424d & v424e;
wire v4250 = vd7 == v6d7;
wire v4251 = v35 == v316;
wire v4252 = v4 == v11b;
wire [2:0] v4253 = { v13c };
wire v4254 = v4253 == vb;
wire v4255 = v4253 == vf;
wire v4256 = v4254 | v4255;
wire v4257 = v4256 ^ v8;
wire [2:0] v4258 = { v12c };
wire v4259 = v4258 == vb;
wire v425a = v4259;
wire v425b = v425a ^ v8;
wire [2:0] v425c = { v13c };
wire v425d = v425c == vf;
wire v425e = v425d;
wire v425f = v425e ^ v8;
wire v4260 = v4257 & v425b & v425f;
wire v4261 = v4250 & v4251 & v4252 & v4260;
wire [7:0] vd9 = 8'b11010001;
wire v4262 = vd9 == v1eb;
wire v4263 = v35 == v316;
wire v4264 = v1b == v318;
wire [2:0] v4265 = { v1fa };
wire v4266 = v4265 == vb;
wire v4267 = v4265 == vf;
wire v4268 = v4266 | v4267;
wire v4269 = v4268 ^ v8;
wire [2:0] v426a = { v1fa };
wire v426b = v426a == vb;
wire v426c = v426a == vf;
wire v426d = v426b | v426c;
wire v426e = v426d ^ v8;
wire v426f = v4269 & v426e;
wire v4270 = v4262 & v4263 & v4264 & v426f;
wire v4271 = vd7 == v6d7;
wire v4272 = v4b == vc0c;
wire v4273 = v43 == vab3;
wire v4274 = v4271 & v4272 & v4273;
wire v4275 = vd9 == v1eb;
wire v4276 = v2f == v316;
wire v4277 = v14 == v1ef;
wire [2:0] v4278 = { v1fa };
wire v4279 = v4278 == vb;
wire v427a = v4279;
wire v427b = v427a ^ v8;
wire [2:0] v427c = { v1fa };
wire v427d = v427c == vb;
wire v427e = v427d;
wire v427f = v427e ^ v8;
wire v4280 = v427b & v427f;
wire v4281 = v4275 & v4276 & v4277 & v4280;
wire [15:0] vda = 16'b1010011011010001;
wire v4282 = vda == v117;
wire v4283 = v30 == v119;
wire v4284 = v38 == v6da;
wire [2:0] v4285 = { v13c };
wire v4286 = v4285 == vb;
wire v4287 = v4286;
wire v4288 = v4287 ^ v8;
wire [2:0] v4289 = { v13c };
wire v428a = v4289 == vb;
wire v428b = v428a;
wire v428c = v428b ^ v8;
wire v428d = v4288 & v428c;
wire v428e = v4282 & v4283 & v4284 & v428d;
wire v428f = vd7 == v6d7;
wire v4290 = v30 == v316;
wire v4291 = v94 == v20a0;
wire v4292 = v38 == v6da;
wire [2:0] v4293 = { v13c };
wire v4294 = v4293 == v7;
wire v4295 = v4293 == vc;
wire v4296 = v4293 == ve;
wire v4297 = v4293 == vd;
wire v4298 = v4293 == v11;
wire v4299 = v4293 == v9;
wire v429a = v4294 | v4295 | v4296 | v4297 | v4298 | v4299;
wire v429b = v429a ^ v8;
wire v429c = v429b;
wire v429d = v428f & v4290 & v4291 & v4292 & v429c;
wire v429e = v424b | v424f | v4261 | v4270 | v4274 | v4281 | v428e | v429d;
wire v429f = v429e;
wire [31:0] v42a1 = In_register_SSBASE;
wire v42a2 = v42a1 == Out_register_SSBASE;
wire v42a3 = In_error_flag == Out_error_flag;
wire [2:0] v42a8 = { v13c };
wire [31:0] v42a9 = ( v42a8 == 3'd0) ? In_register_EAX : 
	( v42a8 == 3'd1) ? In_register_ECX : 
	( v42a8 == 3'd2) ? In_register_EDX : 
	( v42a8 == 3'd3) ? In_register_EBX : 
	( v42a8 == 3'd4) ? v15 : 
	( v42a8 == 3'd5) ? v15 : 
	( v42a8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v42aa = { v12c };
wire [31:0] v42ab = ( v42aa == 3'd0) ? In_register_EAX : 
	( v42aa == 3'd1) ? In_register_ECX : 
	( v42aa == 3'd2) ? In_register_EDX : 
	( v42aa == 3'd3) ? In_register_EBX : 
	( v42aa == 3'd4) ? v15 : 
	( v42aa == 3'd5) ? In_register_EBP : 
	( v42aa == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v42ac = v42ab << v7f4;
wire [31:0] v42ad = v42a9 + v42ac;
wire [2:0] v42b2 = { v12c };
wire [31:0] v42b3 = ( v42b2 == 3'd0) ? In_register_EAX : 
	( v42b2 == 3'd1) ? In_register_ECX : 
	( v42b2 == 3'd2) ? In_register_EDX : 
	( v42b2 == 3'd3) ? In_register_EBX : 
	( v42b2 == 3'd4) ? v15 : 
	( v42b2 == 3'd5) ? In_register_EBP : 
	( v42b2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v42b4 = v42b3 << v7f4;
wire [31:0] v42b5 = v42b4 + vc2d;
wire [2:0] v42b7 = { v1fa };
wire [31:0] v42b8 = ( v42b7 == 3'd0) ? In_register_EAX : 
	( v42b7 == 3'd1) ? In_register_ECX : 
	( v42b7 == 3'd2) ? In_register_EDX : 
	( v42b7 == 3'd3) ? In_register_EBX : 
	( v42b7 == 3'd4) ? v15 : 
	( v42b7 == 3'd5) ? In_register_EBP : 
	( v42b7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v42b9 = v42b8 + v1f7;
wire [2:0] v42bb = { v13c };
wire [31:0] v42bc = ( v42bb == 3'd0) ? In_register_EAX : 
	( v42bb == 3'd1) ? In_register_ECX : 
	( v42bb == 3'd2) ? In_register_EDX : 
	( v42bb == 3'd3) ? In_register_EBX : 
	( v42bb == 3'd4) ? v15 : 
	( v42bb == 3'd5) ? In_register_EBP : 
	( v42bb == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v42bd = v42bc + v7f8;
wire [2:0] v42bf = { v13c };
wire [31:0] v42c0 = ( v42bf == 3'd0) ? v15 : 
	( v42bf == 3'd1) ? v15 : 
	( v42bf == 3'd2) ? v15 : 
	( v42bf == 3'd3) ? v15 : 
	( v42bf == 3'd4) ? In_register_ESP : 
	( v42bf == 3'd5) ? In_register_EBP : 
	( v42bf == 3'd6) ? v15 : v15;
wire [31:0] v42c1 = v42c0 + v7f8;
wire [2:0] v42af = { v1fa };
wire [31:0] v42b0 = ( v42af == 3'd0) ? In_register_EAX : 
	( v42af == 3'd1) ? In_register_ECX : 
	( v42af == 3'd2) ? In_register_EDX : 
	( v42af == 3'd3) ? In_register_EBX : 
	( v42af == 3'd4) ? v15 : 
	( v42af == 3'd5) ? v15 : 
	( v42af == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v42a4 = { v13c };
wire [31:0] v42a5 = ( v42a4 == 3'd0) ? In_register_EAX : 
	( v42a4 == 3'd1) ? In_register_ECX : 
	( v42a4 == 3'd2) ? In_register_EDX : 
	( v42a4 == 3'd3) ? In_register_EBX : 
	( v42a4 == 3'd4) ? In_register_ESP : 
	( v42a4 == 3'd5) ? v15 : 
	( v42a4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v42c3 = ( v4261 ) ? v42ad : 
	( v4274 ) ? v42b5 : 
	( v4281 ) ? v42b9 : 
	( v428e ) ? v42bd : 
	( v429d ) ? v42c1 : 
	( v4270 ) ? v42b0 : 
	( v424b ) ? v42a5 : v1f7;
wire v42c4 =  v26 == memory_0[15: 12] && v42c3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v42cd = ( v4274 ) ? v45 : 
	( v428e | v429d ) ? v27 : 
	( v4270 ) ? v1c : 
	( v424f | v4281 ) ? v16 : v10;
wire [31:0] v42ce = In_register_EIP + v42cd;
wire [31:0] v42d0 = v42ce;
wire v42d1 = v42d0 == Out_register_EIP;
wire [2:0] v42d3 = { v320 };
wire v42d4 = v42d3 == v7;
wire v42d5 = v42d4;
wire v42d6 = v424b & v42d5;
wire [2:0] v42d7 = { v320 };
wire v42d8 = v42d7 == v7;
wire v42d9 = v42d8;
wire v42da = v424f & v42d9;
wire [2:0] v42db = { v320 };
wire v42dc = v42db == v7;
wire v42dd = v42dc;
wire v42de = v4261 & v42dd;
wire [2:0] v42df = { v320 };
wire v42e0 = v42df == v7;
wire v42e1 = v42e0;
wire v42e2 = v4270 & v42e1;
wire [2:0] v42e3 = { v320 };
wire v42e4 = v42e3 == v7;
wire v42e5 = v42e4;
wire v42e6 = v4274 & v42e5;
wire [2:0] v42e7 = { v320 };
wire v42e8 = v42e7 == v7;
wire v42e9 = v42e8;
wire v42ea = v4281 & v42e9;
wire [2:0] v42eb = { v12c };
wire v42ec = v42eb == v7;
wire v42ed = v42ec;
wire v42ee = v428e & v42ed;
wire [2:0] v42ef = { v320 };
wire v42f0 = v42ef == v7;
wire v42f1 = v42f0;
wire v42f2 = v429d & v42f1;
wire v42f3 = v42d6 | v42da | v42de | v42e2 | v42e6 | v42ea | v42ee | v42f2;
wire [31:0] v42d2 = memory_0[79: 48];
wire [31:0] v42f6 = ( v8 ) ? In_register_EAX : v42d2;
wire [31:0] v42f8 = v42f6;
wire v42f9 = v42f8 == Out_register_EAX;
wire v42fa = v42d3 == vf;
wire v42fb = v42fa;
wire v42fc = v424b & v42fb;
wire v42fd = v42d7 == vf;
wire v42fe = v42fd;
wire v42ff = v424f & v42fe;
wire v4300 = v42db == vf;
wire v4301 = v4300;
wire v4302 = v4261 & v4301;
wire v4303 = v42df == vf;
wire v4304 = v4303;
wire v4305 = v4270 & v4304;
wire v4306 = v42e3 == vf;
wire v4307 = v4306;
wire v4308 = v4274 & v4307;
wire v4309 = v42e7 == vf;
wire v430a = v4309;
wire v430b = v4281 & v430a;
wire v430c = v42eb == vf;
wire v430d = v430c;
wire v430e = v428e & v430d;
wire v430f = v42ef == vf;
wire v4310 = v430f;
wire v4311 = v429d & v4310;
wire v4312 = v42fc | v42ff | v4302 | v4305 | v4308 | v430b | v430e | v4311;
wire [31:0] v4315 = ( v8 ) ? In_register_EBP : v42d2;
wire [31:0] v4317 = v4315;
wire v4318 = v4317 == Out_register_EBP;
wire v431a = In_register_ZF;
wire v431b = v431a == Out_register_ZF;
wire v431c = v42d3 == ve;
wire v431d = v431c;
wire v431e = v424b & v431d;
wire v431f = v42d7 == ve;
wire v4320 = v431f;
wire v4321 = v424f & v4320;
wire v4322 = v42db == ve;
wire v4323 = v4322;
wire v4324 = v4261 & v4323;
wire v4325 = v42df == ve;
wire v4326 = v4325;
wire v4327 = v4270 & v4326;
wire v4328 = v42e3 == ve;
wire v4329 = v4328;
wire v432a = v4274 & v4329;
wire v432b = v42e7 == ve;
wire v432c = v432b;
wire v432d = v4281 & v432c;
wire v432e = v42eb == ve;
wire v432f = v432e;
wire v4330 = v428e & v432f;
wire v4331 = v42ef == ve;
wire v4332 = v4331;
wire v4333 = v429d & v4332;
wire v4334 = v431e | v4321 | v4324 | v4327 | v432a | v432d | v4330 | v4333;
wire [31:0] v4337 = ( v8 ) ? In_register_EDX : v42d2;
wire [31:0] v4339 = v4337;
wire v433a = v4339 == Out_register_EDX;
wire [31:0] v433c = In_register_GSBASE;
wire v433d = v433c == Out_register_GSBASE;
wire [7:0] v433f = In_register_DF;
wire v4340 = v433f == Out_register_DF;
wire v4341 = v42d3 == v11;
wire v4342 = v4341;
wire v4343 = v424b & v4342;
wire v4344 = v42d7 == v11;
wire v4345 = v4344;
wire v4346 = v424f & v4345;
wire v4347 = v42db == v11;
wire v4348 = v4347;
wire v4349 = v4261 & v4348;
wire v434a = v42df == v11;
wire v434b = v434a;
wire v434c = v4270 & v434b;
wire v434d = v42e3 == v11;
wire v434e = v434d;
wire v434f = v4274 & v434e;
wire v4350 = v42e7 == v11;
wire v4351 = v4350;
wire v4352 = v4281 & v4351;
wire v4353 = v42eb == v11;
wire v4354 = v4353;
wire v4355 = v428e & v4354;
wire v4356 = v42ef == v11;
wire v4357 = v4356;
wire v4358 = v429d & v4357;
wire v4359 = v4343 | v4346 | v4349 | v434c | v434f | v4352 | v4355 | v4358;
wire [31:0] v435c = ( v8 ) ? In_register_ESI : v42d2;
wire [31:0] v435e = v435c;
wire v435f = v435e == Out_register_ESI;
wire v4361 = In_register_PF;
wire v4362 = v4361 == Out_register_PF;
wire [31:0] v4364 = In_register_CSBASE;
wire v4365 = v4364 == Out_register_CSBASE;
wire v4366 = v42d3 == vb;
wire v4367 = v4366;
wire v4368 = v424b & v4367;
wire v4369 = v42d7 == vb;
wire v436a = v4369;
wire v436b = v424f & v436a;
wire v436c = v42db == vb;
wire v436d = v436c;
wire v436e = v4261 & v436d;
wire v436f = v42df == vb;
wire v4370 = v436f;
wire v4371 = v4270 & v4370;
wire v4372 = v42e3 == vb;
wire v4373 = v4372;
wire v4374 = v4274 & v4373;
wire v4375 = v42e7 == vb;
wire v4376 = v4375;
wire v4377 = v4281 & v4376;
wire v4378 = v42eb == vb;
wire v4379 = v4378;
wire v437a = v428e & v4379;
wire v437b = v42ef == vb;
wire v437c = v437b;
wire v437d = v429d & v437c;
wire v437e = v4368 | v436b | v436e | v4371 | v4374 | v4377 | v437a | v437d;
wire [31:0] v4381 = ( v8 ) ? In_register_ESP : v42d2;
wire [31:0] v4383 = v4381;
wire v4384 = v4383 == Out_register_ESP;
wire [31:0] v4386 = In_register_ESBASE;
wire v4387 = v4386 == Out_register_ESBASE;
wire [31:0] v4389 = In_register_DSBASE;
wire v438a = v4389 == Out_register_DSBASE;
wire [31:0] v438c = In_register_FSBASE;
wire v438d = v438c == Out_register_FSBASE;
wire v438f = In_register_OF;
wire v4390 = v438f == Out_register_OF;
wire v4391 = v42d3 == vc;
wire v4392 = v4391;
wire v4393 = v424b & v4392;
wire v4394 = v42d7 == vc;
wire v4395 = v4394;
wire v4396 = v424f & v4395;
wire v4397 = v42db == vc;
wire v4398 = v4397;
wire v4399 = v4261 & v4398;
wire v439a = v42df == vc;
wire v439b = v439a;
wire v439c = v4270 & v439b;
wire v439d = v42e3 == vc;
wire v439e = v439d;
wire v439f = v4274 & v439e;
wire v43a0 = v42e7 == vc;
wire v43a1 = v43a0;
wire v43a2 = v4281 & v43a1;
wire v43a3 = v42eb == vc;
wire v43a4 = v43a3;
wire v43a5 = v428e & v43a4;
wire v43a6 = v42ef == vc;
wire v43a7 = v43a6;
wire v43a8 = v429d & v43a7;
wire v43a9 = v4393 | v4396 | v4399 | v439c | v439f | v43a2 | v43a5 | v43a8;
wire [31:0] v43ac = ( v8 ) ? In_register_ECX : v42d2;
wire [31:0] v43ae = v43ac;
wire v43af = v43ae == Out_register_ECX;
wire v43b1 = In_register_AF;
wire v43b2 = v43b1 == Out_register_AF;
wire v43b3 = v42d3 == vd;
wire v43b4 = v43b3;
wire v43b5 = v424b & v43b4;
wire v43b6 = v42d7 == vd;
wire v43b7 = v43b6;
wire v43b8 = v424f & v43b7;
wire v43b9 = v42db == vd;
wire v43ba = v43b9;
wire v43bb = v4261 & v43ba;
wire v43bc = v42df == vd;
wire v43bd = v43bc;
wire v43be = v4270 & v43bd;
wire v43bf = v42e3 == vd;
wire v43c0 = v43bf;
wire v43c1 = v4274 & v43c0;
wire v43c2 = v42e7 == vd;
wire v43c3 = v43c2;
wire v43c4 = v4281 & v43c3;
wire v43c5 = v42eb == vd;
wire v43c6 = v43c5;
wire v43c7 = v428e & v43c6;
wire v43c8 = v42ef == vd;
wire v43c9 = v43c8;
wire v43ca = v429d & v43c9;
wire v43cb = v43b5 | v43b8 | v43bb | v43be | v43c1 | v43c4 | v43c7 | v43ca;
wire [31:0] v43ce = ( v8 ) ? In_register_EBX : v42d2;
wire [31:0] v43d0 = v43ce;
wire v43d1 = v43d0 == Out_register_EBX;
wire v43d3 = In_register_CF;
wire v43d4 = v43d3 == Out_register_CF;
wire v43d5 = v42d3 == v9;
wire v43d6 = v43d5;
wire v43d7 = v424b & v43d6;
wire v43d8 = v42d7 == v9;
wire v43d9 = v43d8;
wire v43da = v424f & v43d9;
wire v43db = v42db == v9;
wire v43dc = v43db;
wire v43dd = v4261 & v43dc;
wire v43de = v42df == v9;
wire v43df = v43de;
wire v43e0 = v4270 & v43df;
wire v43e1 = v42e3 == v9;
wire v43e2 = v43e1;
wire v43e3 = v4274 & v43e2;
wire v43e4 = v42e7 == v9;
wire v43e5 = v43e4;
wire v43e6 = v4281 & v43e5;
wire v43e7 = v42eb == v9;
wire v43e8 = v43e7;
wire v43e9 = v428e & v43e8;
wire v43ea = v42ef == v9;
wire v43eb = v43ea;
wire v43ec = v429d & v43eb;
wire v43ed = v43d7 | v43da | v43dd | v43e0 | v43e3 | v43e6 | v43e9 | v43ec;
wire [31:0] v43f0 = ( v8 ) ? In_register_EDI : v42d2;
wire [31:0] v43f2 = v43f0;
wire v43f3 = v43f2 == Out_register_EDI;
wire v43f5 = In_register_SF;
wire v43f6 = v43f5 == Out_register_SF;
wire v43f7 = v42a2 & v42a3 & v42c4 & v15c & v42d1 & v42f9 & v4318 & v431b & v433a & v433d & v4340 & v435f & v4362 & v4365 & v4384 & v4387 & v429f & v438a & v438d & v4390 & v43af & v43b2 & v43d1 & v43d4 & v43f3 & v43f6;
wire [7:0] vdb = 8'b10111111;
wire v43f8 = vdb == v1eb;
wire v43f9 = v29 == v59f;
wire v43fa = v43f8 & v43f9;
wire v43fb = v43fa;
wire v43fc = v43fb;
wire [31:0] v43fe = In_register_EBX;
wire v43ff = v43fe == Out_register_EBX;
wire [31:0] v4401 = In_register_EDX;
wire v4402 = v4401 == Out_register_EDX;
wire v4404 = In_register_AF;
wire v4405 = v4404 == Out_register_AF;
wire [31:0] v4407 = In_register_ESP;
wire v4408 = v4407 == Out_register_ESP;
wire [31:0] v440a = In_register_ECX;
wire v440b = v440a == Out_register_ECX;
wire [31:0] v440d = v2b;
wire [31:0] v440e = In_register_EIP + v440d;
wire [31:0] v4410 = v440e;
wire v4411 = v4410 == Out_register_EIP;
wire [31:0] v4413 = In_register_EAX;
wire v4414 = v4413 == Out_register_EAX;
wire [31:0] v4416 = In_register_ESBASE;
wire v4417 = v4416 == Out_register_ESBASE;
wire v4419 = In_register_CF;
wire v441a = v4419 == Out_register_CF;
wire [31:0] v441c = In_register_EBP;
wire v441d = v441c == Out_register_EBP;
wire v441e = In_error_flag == Out_error_flag;
wire [31:0] v4420 = In_register_EDI;
wire v4421 = v4420 == Out_register_EDI;
wire [31:0] v4423 = In_register_CSBASE;
wire v4424 = v4423 == Out_register_CSBASE;
wire [31:0] v4426 = In_register_SSBASE;
wire v4427 = v4426 == Out_register_SSBASE;
wire v4429 = In_register_SF;
wire v442a = v4429 == Out_register_SF;
wire [31:0] v442c = In_register_DSBASE;
wire v442d = v442c == Out_register_DSBASE;
wire [31:0] v442f = In_register_GSBASE;
wire v4430 = v442f == Out_register_GSBASE;
wire [31:0] v4432 = In_register_FSBASE;
wire v4433 = v4432 == Out_register_FSBASE;
wire [7:0] v4435 = v18;
wire v4436 = v4435 == Out_register_DF;
wire v4438 = In_register_OF;
wire v4439 = v4438 == Out_register_OF;
wire v443b = In_register_PF;
wire v443c = v443b == Out_register_PF;
wire [31:0] v443e = In_register_ESI;
wire v443f = v443e == Out_register_ESI;
wire v4441 = In_register_ZF;
wire v4442 = v4441 == Out_register_ZF;
wire v4443 = v43fc & v43ff & v4402 & v4405 & v4408 & v15c & v440b & v4411 & v4414 & v4417 & v441a & v441d & v441e & v4421 & v4424 & v4427 & v442a & v442d & v4430 & v4433 & v4436 & v4439 & v443c & v443f & v4442;
wire [15:0] vdc = 16'b0110011000001001;
wire v4444 = vdc == v117;
wire v4445 = v1b == v318;
wire v4446 = v4444 & v4445;
wire [7:0] vdd = 8'b00001001;
wire v4447 = vdd == v1eb;
wire v4448 = v29 == v59f;
wire v4449 = v4447 & v4448;
wire v444a = v4446 | v4449;
wire v444b = v444a;
wire [31:0] v444d = In_register_CSBASE;
wire v444e = v444d == Out_register_CSBASE;
wire [31:0] v4450 = In_register_EBX;
wire v4451 = v4450 == Out_register_EBX;
wire [7:0] v4453 = In_register_DF;
wire v4454 = v4453 == Out_register_DF;
wire [31:0] v4456 = In_register_FSBASE;
wire v4457 = v4456 == Out_register_FSBASE;
wire [31:0] v4459 = In_register_ESP;
wire v445a = v4459 == Out_register_ESP;
wire v445c = In_register_PF;
wire v445d = v445c == Out_register_PF;
wire [31:0] v445f = In_register_ESI;
wire v4460 = v445f == Out_register_ESI;
wire [31:0] v4462 = In_register_EAX;
wire v4463 = v4462 == Out_register_EAX;
wire [31:0] v4465 = In_register_EDI;
wire v4466 = v4465 == Out_register_EDI;
wire [31:0] v4468 = In_register_EBP;
wire v4469 = v4468 == Out_register_EBP;
wire [31:0] v446c = ( v4449 ) ? v2b : v1c;
wire [31:0] v446d = In_register_EIP + v446c;
wire [31:0] v446f = v446d;
wire v4470 = v446f == Out_register_EIP;
wire [31:0] v4472 = In_register_SSBASE;
wire v4473 = v4472 == Out_register_SSBASE;
wire [31:0] v4475 = In_register_ESBASE;
wire v4476 = v4475 == Out_register_ESBASE;
wire [31:0] v4478 = In_register_GSBASE;
wire v4479 = v4478 == Out_register_GSBASE;
wire v447b = In_register_SF;
wire v447c = v447b == Out_register_SF;
wire v447d = In_error_flag == Out_error_flag;
wire v447f = In_register_ZF;
wire v4480 = v447f == Out_register_ZF;
wire [31:0] v4482 = In_register_ECX;
wire v4483 = v4482 == Out_register_ECX;
wire v4485 = In_register_AF;
wire v4486 = v4485 == Out_register_AF;
wire [31:0] v4488 = In_register_EDX;
wire v4489 = v4488 == Out_register_EDX;
wire v448b = In_register_CF;
wire v448c = v448b == Out_register_CF;
wire v448e = In_register_OF;
wire v448f = v448e == Out_register_OF;
wire [31:0] v4491 = In_register_DSBASE;
wire v4492 = v4491 == Out_register_DSBASE;
wire v4493 = v444e & v4451 & v4454 & v4457 & v445a & v445d & v444b & v4460 & v15c & v4463 & v4466 & v4469 & v4470 & v4473 & v4476 & v4479 & v447c & v447d & v4480 & v4483 & v4486 & v4489 & v448c & v448f & v4492;
wire [15:0] vde = 16'b0110011011100011;
wire v4494 = vde == v117;
wire v4495 = v68 == v20a0;
wire v4496 = v14 == v1ef;
wire [2:0] v4497 = { v13c };
wire v4498 = v4497 == vb;
wire v4499 = v4498;
wire v449a = v4499 ^ v8;
wire [2:0] v449b = { v13c };
wire v449c = v449b == vb;
wire v449d = v449c;
wire v449e = v449d ^ v8;
wire v449f = v449a & v449e;
wire v44a0 = v4494 & v4495 & v4496 & v449f;
wire [23:0] vdf = 24'b011001101110001110100000;
wire [23:0] v44a1 = instruction_bits[23: 0];
wire v44a2 = vdf == v44a1;
wire [47:0] ve0 = 48'b000000000000000000000000000000000000000000000000;
wire [47:0] v44a3 = instruction_bits[119: 72];
wire v44a4 = ve0 == v44a3;
wire v44a5 = v44a2 & v44a4;
wire v44a6 = vde == v117;
wire v44a7 = v25 == v20a0;
wire v44a8 = v47 == vb69;
wire [2:0] v44a9 = { v13c };
wire v44aa = v44a9 == vb;
wire v44ab = v44a9 == vf;
wire v44ac = v44aa | v44ab;
wire v44ad = v44ac ^ v8;
wire [2:0] v44ae = { v13c };
wire v44af = v44ae == vb;
wire v44b0 = v44ae == vf;
wire v44b1 = v44af | v44b0;
wire v44b2 = v44b1 ^ v8;
wire v44b3 = v44ad & v44b2;
wire v44b4 = v44a6 & v44a7 & v44a8 & v44b3;
wire v44b5 = v44a0 | v44a5 | v44b4;
wire v44b6 = v44b5;
wire [31:0] v44b8 = In_register_EBP;
wire v44b9 = v44b8 == Out_register_EBP;
wire [31:0] v44bb = In_register_GSBASE;
wire v44bc = v44bb == Out_register_GSBASE;
wire [2:0] v44bd = { v13c };
wire [31:0] v44be = ( v44bd == 3'd0) ? In_register_EAX : 
	( v44bd == 3'd1) ? In_register_ECX : 
	( v44bd == 3'd2) ? In_register_EDX : 
	( v44bd == 3'd3) ? In_register_EBX : 
	( v44bd == 3'd4) ? v15 : 
	( v44bd == 3'd5) ? In_register_EBP : 
	( v44bd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v44bf = v44be + v7f8;
wire [2:0] v44c2 = { v13c };
wire [31:0] v44c3 = ( v44c2 == 3'd0) ? In_register_EAX : 
	( v44c2 == 3'd1) ? In_register_ECX : 
	( v44c2 == 3'd2) ? In_register_EDX : 
	( v44c2 == 3'd3) ? In_register_EBX : 
	( v44c2 == 3'd4) ? v15 : 
	( v44c2 == 3'd5) ? v15 : 
	( v44c2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v44c5 = ( v44a5 ) ? vc2d : 
	( v44a0 ) ? v44bf : v44c3;
wire [15:0] v44c6 = instruction_bits[47: 32];
wire [15:0] pad_17607 = (v44c6[15:15] == 1'b1) ?16'b1111111111111111 : 16'b0000000000000000;
wire [31:0] v44c7 = { pad_17607, v44c6 };
wire [15:0] v44c9 = instruction_bits[71: 56];
wire [15:0] pad_17610 = (v44c9[15:15] == 1'b1) ?16'b1111111111111111 : 16'b0000000000000000;
wire [31:0] v44ca = { pad_17610, v44c9 };
wire [15:0] v44cc = instruction_bits[39: 24];
wire [15:0] pad_17613 = (v44cc[15:15] == 1'b1) ?16'b1111111111111111 : 16'b0000000000000000;
wire [31:0] v44cd = { pad_17613, v44cc };
wire [31:0] v44cf = ( v44a0 ) ? v44c7 : 
	( v44a5 ) ? v44ca : v44cd;
wire [15:0] v44d0 = v44cf[15:0];
wire v44d1 =  v9f == memory_0[15: 12] && v44c5 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v44d0 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] v44d3 = In_register_DSBASE;
wire v44d4 = v44d3 == Out_register_DSBASE;
wire [31:0] v44d6 = In_register_EBX;
wire v44d7 = v44d6 == Out_register_EBX;
wire [31:0] v44d9 = In_register_ECX;
wire v44da = v44d9 == Out_register_ECX;
wire [31:0] v44dc = In_register_CSBASE;
wire v44dd = v44dc == Out_register_CSBASE;
wire [31:0] v44df = In_register_EDX;
wire v44e0 = v44df == Out_register_EDX;
wire [31:0] v44e2 = In_register_EAX;
wire v44e3 = v44e2 == Out_register_EAX;
wire [31:0] v44e5 = In_register_ESI;
wire v44e6 = v44e5 == Out_register_ESI;
wire [31:0] v44e8 = In_register_EDI;
wire v44e9 = v44e8 == Out_register_EDI;
wire v44ea = In_error_flag == Out_error_flag;
wire [31:0] v44ec = In_register_ESP;
wire v44ed = v44ec == Out_register_ESP;
wire [31:0] ve1 = 32'b10010000000000000000000000000000;
wire [31:0] v44f1 = ( v44b4 ) ? v48 : 
	( v44a0 ) ? v16 : ve1;
wire [31:0] v44f2 = In_register_EIP + v44f1;
wire [31:0] v44f4 = v44f2;
wire v44f5 = v44f4 == Out_register_EIP;
wire [31:0] v44f7 = In_register_SSBASE;
wire v44f8 = v44f7 == Out_register_SSBASE;
wire [31:0] v44fa = In_register_ESBASE;
wire v44fb = v44fa == Out_register_ESBASE;
wire [31:0] v44fd = In_register_FSBASE;
wire v44fe = v44fd == Out_register_FSBASE;
wire v4500 = In_register_CF;
wire v4501 = v4500 == Out_register_CF;
wire [7:0] v4503 = In_register_DF;
wire v4504 = v4503 == Out_register_DF;
wire v4506 = In_register_OF;
wire v4507 = v4506 == Out_register_OF;
wire v4509 = In_register_AF;
wire v450a = v4509 == Out_register_AF;
wire v450c = In_register_PF;
wire v450d = v450c == Out_register_PF;
wire v450f = In_register_SF;
wire v4510 = v450f == Out_register_SF;
wire v4512 = In_register_ZF;
wire v4513 = v4512 == Out_register_ZF;
wire v4514 = v44b9 & v44bc & v44d1 & v44d4 & v44d7 & v44da & v44dd & v44e0 & v44b6 & v44e3 & v44e6 & v44e9 & v44ea & v44ed & v44f5 & v44f8 & v15c & v44fb & v44fe & v4501 & v4504 & v4507 & v450a & v450d & v4510 & v4513;
wire v4515 = vcf == v1eb;
wire v4516 = v3 == v316;
wire v4517 = v1b == v318;
wire v4518 = v4515 & v4516 & v4517;
wire v4519 = v4518;
wire v451a = v4519;
wire [31:0] v451c = In_register_GSBASE;
wire v451d = v451c == Out_register_GSBASE;
wire [31:0] v451f = In_register_ESP;
wire v4520 = v451f == Out_register_ESP;
wire [31:0] v4522 = In_register_SSBASE;
wire v4523 = v4522 == Out_register_SSBASE;
wire v4524 = In_error_flag == Out_error_flag;
wire [2:0] v4547 = { v320 };
wire v4548 = v4547 == v7;
wire v4549 = v4548;
wire v454a = v4518 & v4549;
wire v454b = v454a;
wire [2:0] v4525 = { v1fa };
wire [31:0] v4526 = ( v4525 == 3'd0) ? In_register_EAX : 
	( v4525 == 3'd1) ? In_register_ECX : 
	( v4525 == 3'd2) ? In_register_EDX : 
	( v4525 == 3'd3) ? In_register_EBX : 
	( v4525 == 3'd4) ? In_register_EAX : 
	( v4525 == 3'd5) ? In_register_ECX : 
	( v4525 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4527 = { v1fa };
wire v4528 = v4527 == vb;
wire v4529 = v4527 == v9;
wire v452a = v4528 | v4529;
wire v452b = v4527 == vf;
wire v452c = v452a | v452b;
wire v452d = v4527 == v11;
wire v452e = v452c | v452d;
wire [31:0] v452f = ( v452e == 1'd0) ? v15 : v31;
wire [31:0] v4530 = v4526 >> v452f;
wire [31:0] v4531 = v4530 & v32;
wire [31:0] v4533 = v4531;
wire [2:0] v4534 = { v320 };
wire [31:0] v4535 = ( v4534 == 3'd0) ? In_register_EAX : 
	( v4534 == 3'd1) ? In_register_ECX : 
	( v4534 == 3'd2) ? In_register_EDX : 
	( v4534 == 3'd3) ? In_register_EBX : 
	( v4534 == 3'd4) ? In_register_EAX : 
	( v4534 == 3'd5) ? In_register_ECX : 
	( v4534 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4536 = { v320 };
wire v4537 = v4536 == vb;
wire v4538 = v4536 == v9;
wire v4539 = v4537 | v4538;
wire v453a = v4536 == vf;
wire v453b = v4539 | v453a;
wire v453c = v4536 == v11;
wire v453d = v453b | v453c;
wire [31:0] v453e = ( v453d == 1'd0) ? v15 : v31;
wire [31:0] v453f = v4535 >> v453e;
wire [31:0] v4540 = v453f & v32;
wire [31:0] v4542 = v4540;
wire [31:0] v4543 = v4533 | v4542;
wire [7:0] v4544 = v4543[7:0];
wire [31:0] v4545 = { 24'b000000000000000000000000, v4544 };
wire [31:0] v4546 = v5c8 | v4545;
wire v454f = v4547 == vb;
wire v4550 = v454f;
wire v4551 = v4518 & v4550;
wire v4552 = v4551;
wire [31:0] v454d = v4545 << v31;
wire [31:0] v454e = v752 | v454d;
wire [31:0] v4555 = ( v8 ) ? In_register_EAX : 
	( v454b ) ? v4546 : v454e;
wire [31:0] v4557 = v4555;
wire v4558 = v4557 == Out_register_EAX;
wire v455a = v4547 == vd;
wire v455b = v455a;
wire v455c = v4518 & v455b;
wire v455d = v455c;
wire [31:0] v4559 = v7b8 | v4545;
wire v4560 = v4547 == v9;
wire v4561 = v4560;
wire v4562 = v4518 & v4561;
wire v4563 = v4562;
wire [31:0] v455f = v7c8 | v454d;
wire [31:0] v4566 = ( v8 ) ? In_register_EBX : 
	( v455d ) ? v4559 : v455f;
wire [31:0] v4568 = v4566;
wire v4569 = v4568 == Out_register_EBX;
wire v456b = v4547 == vf;
wire v456c = v456b;
wire v456d = v4518 & v456c;
wire v456e = v456d;
wire [31:0] v456a = v790 | v454d;
wire v4571 = v4547 == vc;
wire v4572 = v4571;
wire v4573 = v4518 & v4572;
wire v4574 = v4573;
wire [31:0] v4570 = v7a0 | v4545;
wire [31:0] v4577 = ( v8 ) ? In_register_ECX : 
	( v456e ) ? v456a : v4570;
wire [31:0] v4579 = v4577;
wire v457a = v4579 == Out_register_ECX;
wire v4582 = v4547 == v11;
wire v4583 = v4582;
wire v4584 = v4518 & v4583;
wire v4585 = v4584;
wire [31:0] v4581 = v778 | v454d;
wire v457c = v4547 == ve;
wire v457d = v457c;
wire v457e = v4518 & v457d;
wire v457f = v457e;
wire [31:0] v457b = v768 | v4545;
wire [31:0] v4588 = ( v8 ) ? In_register_EDX : 
	( v4585 ) ? v4581 : v457b;
wire [31:0] v458a = v4588;
wire v458b = v458a == Out_register_EDX;
wire [31:0] v458d = In_register_EBP;
wire v458e = v458d == Out_register_EBP;
wire [31:0] v4590 = In_register_ESBASE;
wire v4591 = v4590 == Out_register_ESBASE;
wire [31:0] v4593 = v1c;
wire [31:0] v4594 = In_register_EIP + v4593;
wire [31:0] v4596 = v4594;
wire v4597 = v4596 == Out_register_EIP;
wire [31:0] v4599 = In_register_CSBASE;
wire v459a = v4599 == Out_register_CSBASE;
wire [31:0] v459c = In_register_DSBASE;
wire v459d = v459c == Out_register_DSBASE;
wire v459e = v4544 == v2c;
wire v45a0 = v459e;
wire v45a1 = v45a0 == Out_register_ZF;
wire v45a3 = In_register_AF;
wire v45a4 = v45a3 == Out_register_AF;
wire [31:0] v45a6 = In_register_FSBASE;
wire v45a7 = v45a6 == Out_register_FSBASE;
wire v45a9 = v17;
wire v45aa = v45a9 == Out_register_CF;
wire [31:0] v45ac = In_register_EDI;
wire v45ad = v45ac == Out_register_EDI;
wire [7:0] v45af = In_register_DF;
wire v45b0 = v45af == Out_register_DF;
wire v45b1 = v17;
wire v45b2 = v45b1 == Out_register_OF;
wire [2:0] v45b3_aux = v4544[0] + v4544[1] + v4544[2] + v4544[3] + v4544[4] + v4544[5] + v4544[6] + v4544[7];
wire v45b3 = { 5'b00000, v45b3_aux };
wire [7:0] v45b4 = v45b3 & v18;
wire [7:0] v45b5 = v45b4 ^ v18;
wire v45b6 = v45b5[0:0];
wire v45b8 = v45b6;
wire v45b9 = v45b8 == Out_register_PF;
wire v45ba = $signed(v4544) < $signed(v2c);
wire v45bc = v45ba;
wire v45bd = v45bc == Out_register_SF;
wire [31:0] v45bf = In_register_ESI;
wire v45c0 = v45bf == Out_register_ESI;
wire v45c1 = v451a & v451d & v4520 & v4523 & v4524 & v4558 & v15c & v4569 & v457a & v458b & v458e & v4591 & v4597 & v459a & v459d & v45a1 & v45a4 & v45a7 & v45aa & v45ad & v45b0 & v45b2 & v45b9 & v45bd & v45c0;
wire [7:0] ve2 = 8'b10111000;
wire v45c2 = ve2 == v1eb;
wire v45c3 = v47 == vb69;
wire v45c4 = v45c2 & v45c3;
wire v45d1 = v45c4;
wire v45d2 = v45d1;
wire [31:0] v45c6 = In_register_EAX;
wire [31:0] v45c8 = vb74;
wire [31:0] v45c9 = v45c6 - v45c8;
wire [31:0] v45ca = v45c9 - vb11;
wire [31:0] v45cb = v45ca ^ v45c6;
wire [31:0] v45cc = v45cb >> v1e;
wire [31:0] v45cd = v45c8 ^ v45c6;
wire [31:0] v45ce = v45cd >> v1e;
wire [31:0] v45cf = v45cc + v45ce;
wire v45d0 = v45cf == v1c;
wire v45d4 = v45d0;
wire v45d5 = v45d4 == Out_register_OF;
wire [31:0] v45d7 = In_register_EBX;
wire v45d8 = v45d7 == Out_register_EBX;
wire v45d9 = v45c9 == vb11;
wire v45db = v45d9;
wire v45dc = v45db == Out_register_ZF;
wire [7:0] v45dd = v45ca[7:0];
wire [2:0] v45de_aux = v45dd[0] + v45dd[1] + v45dd[2] + v45dd[3] + v45dd[4] + v45dd[5] + v45dd[6] + v45dd[7];
wire v45de = { 5'b00000, v45de_aux };
wire [7:0] v45df = v45de & v18;
wire [7:0] v45e0 = v45df ^ v18;
wire v45e1 = v45e0[0:0];
wire v45e3 = v45e1;
wire v45e4 = v45e3 == Out_register_PF;
wire v45e5 = In_error_flag == Out_error_flag;
wire [31:0] v45e7 = In_register_CSBASE;
wire v45e8 = v45e7 == Out_register_CSBASE;
wire [31:0] v45ea = In_register_ESI;
wire v45eb = v45ea == Out_register_ESI;
wire [31:0] v45ed = In_register_EDX;
wire v45ee = v45ed == Out_register_EDX;
wire [7:0] v45f0 = In_register_DF;
wire v45f1 = v45f0 == Out_register_DF;
wire [31:0] v45f3 = In_register_ECX;
wire v45f4 = v45f3 == Out_register_ECX;
wire [31:0] v45f6 = In_register_EDI;
wire v45f7 = v45f6 == Out_register_EDI;
wire v45f8 = $signed(v45ca) < $signed(v15);
wire v45fa = v45f8;
wire v45fb = v45fa == Out_register_SF;
wire [31:0] v45fd = In_register_EBP;
wire v45fe = v45fd == Out_register_EBP;
wire [31:0] v4601 = ( v8 ) ? In_register_EAX : v45ca;
wire [31:0] v4603 = v4601;
wire v4604 = v4603 == Out_register_EAX;
wire [31:0] v4606 = In_register_ESP;
wire v4607 = v4606 == Out_register_ESP;
wire [31:0] v4609 = v48;
wire [31:0] v460a = In_register_EIP + v4609;
wire [31:0] v460c = v460a;
wire v460d = v460c == Out_register_EIP;
wire v460e = v45c6 < v45c8;
wire v460f = v45c9 < vb11;
wire [7:0] v4610 = { 7'b0000000, v460f };
wire [7:0] v4611 = ( v460e == 1'd0) ? v4610 : v18;
wire v4612 = v4611[0:0];
wire v4614 = v4612;
wire v4615 = v4614 == Out_register_CF;
wire [31:0] v4617 = In_register_SSBASE;
wire v4618 = v4617 == Out_register_SSBASE;
wire [31:0] v461a = In_register_ESBASE;
wire v461b = v461a == Out_register_ESBASE;
wire [31:0] v461d = In_register_DSBASE;
wire v461e = v461d == Out_register_DSBASE;
wire [31:0] v4620 = In_register_GSBASE;
wire v4621 = v4620 == Out_register_GSBASE;
wire [31:0] v4622 = v45ca ^ v45cd;
wire [7:0] v4623 = v4622[7:0];
wire [7:0] v4624 = v4623 >> v1d;
wire [7:0] v4625 = v4624 & v18;
wire v4626 = v4625[0:0];
wire v4628 = v4626;
wire v4629 = v4628 == Out_register_AF;
wire [31:0] v462b = In_register_FSBASE;
wire v462c = v462b == Out_register_FSBASE;
wire v462d = v45d5 & v45d8 & v45dc & v45e4 & v45e5 & v15c & v45e8 & v45eb & v45ee & v45f1 & v45f4 & v45f7 & v45d2 & v45fb & v45fe & v4604 & v4607 & v460d & v4615 & v4618 & v461b & v461e & v4621 & v4629 & v462c;
wire [10:0] ve3 = 11'b10001100001;
wire v4634 = ve3 == v6d7;
wire v4635 = v35 == v316;
wire v4636 = v4 == v11b;
wire [2:0] v4637 = { v13c };
wire v4638 = v4637 == vb;
wire v4639 = v4637 == vf;
wire v463a = v4638 | v4639;
wire v463b = v463a ^ v8;
wire [2:0] v463c = { v12c };
wire v463d = v463c == vb;
wire v463e = v463d;
wire v463f = v463e ^ v8;
wire [2:0] v4640 = { v13c };
wire v4641 = v4640 == vf;
wire v4642 = v4641;
wire v4643 = v4642 ^ v8;
wire [2:0] v4644 = { v13c };
wire v4645 = v4644 == vb;
wire v4646 = v4644 == vf;
wire v4647 = v4645 | v4646;
wire v4648 = v4647 ^ v8;
wire [2:0] v4649 = { v12c };
wire v464a = v4649 == vb;
wire v464b = v464a;
wire v464c = v464b ^ v8;
wire [2:0] v464d = { v13c };
wire v464e = v464d == vf;
wire v464f = v464e;
wire v4650 = v464f ^ v8;
wire v4651 = v463b & v463f & v4643 & v4648 & v464c & v4650;
wire v4652 = v4634 & v4635 & v4636 & v4651;
wire [2:0] v462e = { v13c };
wire [31:0] v462f = ( v462e == 3'd0) ? In_register_EAX : 
	( v462e == 3'd1) ? In_register_ECX : 
	( v462e == 3'd2) ? In_register_EDX : 
	( v462e == 3'd3) ? In_register_EBX : 
	( v462e == 3'd4) ? v15 : 
	( v462e == 3'd5) ? v15 : 
	( v462e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4630 = { v12c };
wire [31:0] v4631 = ( v4630 == 3'd0) ? In_register_EAX : 
	( v4630 == 3'd1) ? In_register_ECX : 
	( v4630 == 3'd2) ? In_register_EDX : 
	( v4630 == 3'd3) ? In_register_EBX : 
	( v4630 == 3'd4) ? v15 : 
	( v4630 == 3'd5) ? In_register_EBP : 
	( v4630 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4632 = v4631 << v7f4;
wire [31:0] v4633 = v462f + v4632;
wire [31:0] v4654 = v4633;
wire [31:0] v4655 = memory_0[79: 48];
wire [2:0] v4656 = { v320 };
wire [31:0] v4657 = ( v4656 == 3'd0) ? In_register_EAX : 
	( v4656 == 3'd1) ? In_register_ECX : 
	( v4656 == 3'd2) ? In_register_EDX : 
	( v4656 == 3'd3) ? In_register_EBX : 
	( v4656 == 3'd4) ? In_register_ESP : 
	( v4656 == 3'd5) ? In_register_EBP : 
	( v4656 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4659 = v4657;
wire [31:0] v465a = v4655 ^ v4659;
wire v465b =  v26 == memory_1[15: 12] && v4654 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v465a == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v465c = v4652;
wire v465d = v465c;
wire [31:0] v465f = In_register_EAX;
wire v4660 = v465f == Out_register_EAX;
wire [31:0] v4662 = In_register_SSBASE;
wire v4663 = v4662 == Out_register_SSBASE;
wire [2:0] v4664 = { v13c };
wire [31:0] v4665 = ( v4664 == 3'd0) ? In_register_EAX : 
	( v4664 == 3'd1) ? In_register_ECX : 
	( v4664 == 3'd2) ? In_register_EDX : 
	( v4664 == 3'd3) ? In_register_EBX : 
	( v4664 == 3'd4) ? v15 : 
	( v4664 == 3'd5) ? v15 : 
	( v4664 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4666 = { v12c };
wire [31:0] v4667 = ( v4666 == 3'd0) ? In_register_EAX : 
	( v4666 == 3'd1) ? In_register_ECX : 
	( v4666 == 3'd2) ? In_register_EDX : 
	( v4666 == 3'd3) ? In_register_EBX : 
	( v4666 == 3'd4) ? v15 : 
	( v4666 == 3'd5) ? In_register_EBP : 
	( v4666 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4668 = v4667 << v7f4;
wire [31:0] v4669 = v4665 + v4668;
wire [31:0] v466b = v4669;
wire v466c =  v26 == memory_0[15: 12] && v466b == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v466e = In_register_ECX;
wire v466f = v466e == Out_register_ECX;
wire v4670 = In_error_flag == Out_error_flag;
wire v4672 = v17;
wire v4673 = v4672 == Out_register_OF;
wire [31:0] v4675 = In_register_ESBASE;
wire v4676 = v4675 == Out_register_ESBASE;
wire [31:0] v4678 = In_register_EBX;
wire v4679 = v4678 == Out_register_EBX;
wire [31:0] v467b = In_register_EDI;
wire v467c = v467b == Out_register_EDI;
wire [31:0] v467e = In_register_EDX;
wire v467f = v467e == Out_register_EDX;
wire [31:0] v4681 = In_register_ESI;
wire v4682 = v4681 == Out_register_ESI;
wire [31:0] v4684 = In_register_DSBASE;
wire v4685 = v4684 == Out_register_DSBASE;
wire [7:0] v4686 = v465a[7:0];
wire [2:0] v4687_aux = v4686[0] + v4686[1] + v4686[2] + v4686[3] + v4686[4] + v4686[5] + v4686[6] + v4686[7];
wire v4687 = { 5'b00000, v4687_aux };
wire [7:0] v4688 = v4687 & v18;
wire [7:0] v4689 = v4688 ^ v18;
wire v468a = v4689[0:0];
wire v468c = v468a;
wire v468d = v468c == Out_register_PF;
wire [31:0] v468f = In_register_ESP;
wire v4690 = v468f == Out_register_ESP;
wire [31:0] v4692 = In_register_EBP;
wire v4693 = v4692 == Out_register_EBP;
wire [31:0] v4695 = v10;
wire [31:0] v4696 = In_register_EIP + v4695;
wire [31:0] v4698 = v4696;
wire v4699 = v4698 == Out_register_EIP;
wire [31:0] v469b = In_register_CSBASE;
wire v469c = v469b == Out_register_CSBASE;
wire [31:0] v469e = In_register_GSBASE;
wire v469f = v469e == Out_register_GSBASE;
wire [31:0] v46a1 = In_register_FSBASE;
wire v46a2 = v46a1 == Out_register_FSBASE;
wire [7:0] v46a4 = In_register_DF;
wire v46a5 = v46a4 == Out_register_DF;
wire v46a7 = In_register_AF;
wire v46a8 = v46a7 == Out_register_AF;
wire v46a9 = v17;
wire v46aa = v46a9 == Out_register_CF;
wire v46ab = $signed(v465a) < $signed(v15);
wire v46ad = v46ab;
wire v46ae = v46ad == Out_register_SF;
wire v46af = v465a == v15;
wire v46b1 = v46af;
wire v46b2 = v46b1 == Out_register_ZF;
wire v46b3 = v465b & v4660 & v4663 & v466c & v466f & v4670 & v4673 & v465d & v4676 & v4679 & v467c & v467f & v4682 & v4685 & v468d & v4690 & v4693 & v15c & v4699 & v469c & v469f & v46a2 & v46a5 & v46a8 & v46aa & v46ae & v46b2;
wire v46b4 = In_error_flag == Out_error_flag;
wire v46b5 = vab == v1eb;
wire v46b6 = v59 == v1ed;
wire v46b7 = v14 == v1ef;
wire v46b8 = v46b5 & v46b6 & v46b7;
wire v46c3 = v46b8;
wire v46c4 = v46c3;
wire [2:0] v46bb = { v1fa };
wire v46bc = v46bb == v11;
wire v46bd = v46bc;
wire v46be = v46b8 & v46bd;
wire v46bf = v46be;
wire [31:0] v46ba = v1f7;
wire [31:0] v46c2 = ( v8 ) ? In_register_ESI : v46ba;
wire [31:0] v46c6 = v46c2;
wire v46c7 = v46c6 == Out_register_ESI;
wire [31:0] v46c9 = In_register_CSBASE;
wire v46ca = v46c9 == Out_register_CSBASE;
wire v46cb = v46bb == v7;
wire v46cc = v46cb;
wire v46cd = v46b8 & v46cc;
wire v46ce = v46cd;
wire [31:0] v46d1 = ( v8 ) ? In_register_EAX : v46ba;
wire [31:0] v46d3 = v46d1;
wire v46d4 = v46d3 == Out_register_EAX;
wire v46d5 = v46bb == vb;
wire v46d6 = v46d5;
wire v46d7 = v46b8 & v46d6;
wire v46d8 = v46d7;
wire [31:0] v46db = ( v8 ) ? In_register_ESP : v46ba;
wire [31:0] v46dd = v46db;
wire v46de = v46dd == Out_register_ESP;
wire v46df = v46bb == vf;
wire v46e0 = v46df;
wire v46e1 = v46b8 & v46e0;
wire v46e2 = v46e1;
wire [31:0] v46e5 = ( v8 ) ? In_register_EBP : v46ba;
wire [31:0] v46e7 = v46e5;
wire v46e8 = v46e7 == Out_register_EBP;
wire v46ea = In_register_AF;
wire v46eb = v46ea == Out_register_AF;
wire v46ec = v46bb == vd;
wire v46ed = v46ec;
wire v46ee = v46b8 & v46ed;
wire v46ef = v46ee;
wire [31:0] v46f2 = ( v8 ) ? In_register_EBX : v46ba;
wire [31:0] v46f4 = v46f2;
wire v46f5 = v46f4 == Out_register_EBX;
wire [7:0] v46f7 = In_register_DF;
wire v46f8 = v46f7 == Out_register_DF;
wire v46f9 = v46bb == vc;
wire v46fa = v46f9;
wire v46fb = v46b8 & v46fa;
wire v46fc = v46fb;
wire [31:0] v46ff = ( v8 ) ? In_register_ECX : v46ba;
wire [31:0] v4701 = v46ff;
wire v4702 = v4701 == Out_register_ECX;
wire v4704 = In_register_CF;
wire v4705 = v4704 == Out_register_CF;
wire v4707 = In_register_OF;
wire v4708 = v4707 == Out_register_OF;
wire v4709 = v46bb == ve;
wire v470a = v4709;
wire v470b = v46b8 & v470a;
wire v470c = v470b;
wire [31:0] v470f = ( v8 ) ? In_register_EDX : v46ba;
wire [31:0] v4711 = v470f;
wire v4712 = v4711 == Out_register_EDX;
wire v4714 = In_register_ZF;
wire v4715 = v4714 == Out_register_ZF;
wire v4716 = v46bb == v9;
wire v4717 = v4716;
wire v4718 = v46b8 & v4717;
wire v4719 = v4718;
wire [31:0] v471c = ( v8 ) ? In_register_EDI : v46ba;
wire [31:0] v471e = v471c;
wire v471f = v471e == Out_register_EDI;
wire [31:0] v4721 = In_register_DSBASE;
wire v4722 = v4721 == Out_register_DSBASE;
wire [31:0] v4724 = In_register_SSBASE;
wire v4725 = v4724 == Out_register_SSBASE;
wire [31:0] v4727 = v16;
wire [31:0] v4728 = In_register_EIP + v4727;
wire [31:0] v472a = v4728;
wire v472b = v472a == Out_register_EIP;
wire [31:0] v472d = In_register_ESBASE;
wire v472e = v472d == Out_register_ESBASE;
wire v4730 = In_register_PF;
wire v4731 = v4730 == Out_register_PF;
wire [31:0] v4733 = In_register_FSBASE;
wire v4734 = v4733 == Out_register_FSBASE;
wire v4736 = In_register_SF;
wire v4737 = v4736 == Out_register_SF;
wire [31:0] v4739 = In_register_GSBASE;
wire v473a = v4739 == Out_register_GSBASE;
wire v473b = v46b4 & v46c7 & v46ca & v46d4 & v15c & v46de & v46e8 & v46eb & v46f5 & v46f8 & v4702 & v4705 & v4708 & v4712 & v4715 & v471f & v46c4 & v4722 & v4725 & v472b & v472e & v4731 & v4734 & v4737 & v473a;
wire [7:0] ve4 = 8'b01010100;
wire v4749 = ve4 == v1eb;
wire v474a = v3 == v316;
wire v474b = v1b == v318;
wire v474c = v4749 & v474a & v474b;
wire v4772 = v474c;
wire v4773 = v4772;
wire [2:0] v4764 = { v320 };
wire v4765 = v4764 == vf;
wire v4766 = v4765;
wire v4767 = v474c & v4766;
wire v4768 = v4767;
wire [2:0] v473c = { v320 };
wire [31:0] v473d = ( v473c == 3'd0) ? In_register_EAX : 
	( v473c == 3'd1) ? In_register_ECX : 
	( v473c == 3'd2) ? In_register_EDX : 
	( v473c == 3'd3) ? In_register_EBX : 
	( v473c == 3'd4) ? In_register_EAX : 
	( v473c == 3'd5) ? In_register_ECX : 
	( v473c == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v473e = { v320 };
wire v473f = v473e == vb;
wire v4740 = v473e == v9;
wire v4741 = v473f | v4740;
wire v4742 = v473e == vf;
wire v4743 = v4741 | v4742;
wire v4744 = v473e == v11;
wire v4745 = v4743 | v4744;
wire [31:0] v4746 = ( v4745 == 1'd0) ? v15 : v31;
wire [31:0] v4747 = v473d >> v4746;
wire [31:0] v4748 = v4747 & v32;
wire [31:0] v474e = v4748;
wire [7:0] v474f = v474e[7:0];
wire [2:0] v4750 = { v1fa };
wire [31:0] v4751 = ( v4750 == 3'd0) ? In_register_EAX : 
	( v4750 == 3'd1) ? In_register_ECX : 
	( v4750 == 3'd2) ? In_register_EDX : 
	( v4750 == 3'd3) ? In_register_EBX : 
	( v4750 == 3'd4) ? In_register_EAX : 
	( v4750 == 3'd5) ? In_register_ECX : 
	( v4750 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4752 = { v1fa };
wire v4753 = v4752 == vb;
wire v4754 = v4752 == v9;
wire v4755 = v4753 | v4754;
wire v4756 = v4752 == vf;
wire v4757 = v4755 | v4756;
wire v4758 = v4752 == v11;
wire v4759 = v4757 | v4758;
wire [31:0] v475a = ( v4759 == 1'd0) ? v15 : v31;
wire [31:0] v475b = v4751 >> v475a;
wire [31:0] v475c = v475b & v32;
wire [31:0] v475e = v475c;
wire [7:0] v475f = v475e[7:0];
wire [7:0] v4760 = v474f - v475f;
wire [31:0] v4761 = { 24'b000000000000000000000000, v4760 };
wire [31:0] v4762 = v4761 << v31;
wire [31:0] v4763 = v790 | v4762;
wire v476b = v4764 == vc;
wire v476c = v476b;
wire v476d = v474c & v476c;
wire v476e = v476d;
wire [31:0] v476a = v7a0 | v4761;
wire [31:0] v4771 = ( v8 ) ? In_register_ECX : 
	( v4768 ) ? v4763 : v476a;
wire [31:0] v4775 = v4771;
wire v4776 = v4775 == Out_register_ECX;
wire [7:0] v4777 = v475f ^ v474f;
wire [7:0] v4778 = v4777 ^ v4760;
wire [7:0] v4779 = v4778 >> v1d;
wire [7:0] v477a = v4779 & v18;
wire v477b = v477a[0:0];
wire v477d = v477b;
wire v477e = v477d == Out_register_AF;
wire v477f = $signed(v4760) < $signed(v2c);
wire v4781 = v477f;
wire v4782 = v4781 == Out_register_SF;
wire [31:0] v4784 = In_register_EDI;
wire v4785 = v4784 == Out_register_EDI;
wire v4786 = In_error_flag == Out_error_flag;
wire v4788 = v4764 == vd;
wire v4789 = v4788;
wire v478a = v474c & v4789;
wire v478b = v478a;
wire [31:0] v4787 = v7b8 | v4761;
wire v478e = v4764 == v9;
wire v478f = v478e;
wire v4790 = v474c & v478f;
wire v4791 = v4790;
wire [31:0] v478d = v7c8 | v4762;
wire [31:0] v4794 = ( v8 ) ? In_register_EBX : 
	( v478b ) ? v4787 : v478d;
wire [31:0] v4796 = v4794;
wire v4797 = v4796 == Out_register_EBX;
wire v4799 = v4764 == ve;
wire v479a = v4799;
wire v479b = v474c & v479a;
wire v479c = v479b;
wire [31:0] v4798 = v768 | v4761;
wire v479f = v4764 == v11;
wire v47a0 = v479f;
wire v47a1 = v474c & v47a0;
wire v47a2 = v47a1;
wire [31:0] v479e = v778 | v4762;
wire [31:0] v47a5 = ( v8 ) ? In_register_EDX : 
	( v479c ) ? v4798 : v479e;
wire [31:0] v47a7 = v47a5;
wire v47a8 = v47a7 == Out_register_EDX;
wire v47aa = v4764 == v7;
wire v47ab = v47aa;
wire v47ac = v474c & v47ab;
wire v47ad = v47ac;
wire [31:0] v47a9 = v5c8 | v4761;
wire v47b0 = v4764 == vb;
wire v47b1 = v47b0;
wire v47b2 = v474c & v47b1;
wire v47b3 = v47b2;
wire [31:0] v47af = v752 | v4762;
wire [31:0] v47b6 = ( v8 ) ? In_register_EAX : 
	( v47ad ) ? v47a9 : v47af;
wire [31:0] v47b8 = v47b6;
wire v47b9 = v47b8 == Out_register_EAX;
wire [31:0] v47bb = In_register_ESP;
wire v47bc = v47bb == Out_register_ESP;
wire [31:0] v47be = v1c;
wire [31:0] v47bf = In_register_EIP + v47be;
wire [31:0] v47c1 = v47bf;
wire v47c2 = v47c1 == Out_register_EIP;
wire [31:0] v47c4 = In_register_ESI;
wire v47c5 = v47c4 == Out_register_ESI;
wire [31:0] v47c7 = In_register_CSBASE;
wire v47c8 = v47c7 == Out_register_CSBASE;
wire [31:0] v47ca = In_register_EBP;
wire v47cb = v47ca == Out_register_EBP;
wire [2:0] v47cc_aux = v4760[0] + v4760[1] + v4760[2] + v4760[3] + v4760[4] + v4760[5] + v4760[6] + v4760[7];
wire v47cc = { 5'b00000, v47cc_aux };
wire [7:0] v47cd = v47cc & v18;
wire [7:0] v47ce = v47cd ^ v18;
wire v47cf = v47ce[0:0];
wire v47d1 = v47cf;
wire v47d2 = v47d1 == Out_register_PF;
wire [31:0] v47d4 = In_register_SSBASE;
wire v47d5 = v47d4 == Out_register_SSBASE;
wire [7:0] v47d7 = In_register_DF;
wire v47d8 = v47d7 == Out_register_DF;
wire [31:0] v47da = In_register_ESBASE;
wire v47db = v47da == Out_register_ESBASE;
wire [31:0] v47dd = In_register_FSBASE;
wire v47de = v47dd == Out_register_FSBASE;
wire [7:0] v47df = v4760 ^ v474f;
wire [7:0] v47e0 = v47df >> v33;
wire [7:0] v47e1 = v4777 >> v33;
wire [7:0] v47e2 = v47e0 + v47e1;
wire v47e3 = v47e2 == v34;
wire v47e5 = v47e3;
wire v47e6 = v47e5 == Out_register_OF;
wire [31:0] v47e8 = In_register_GSBASE;
wire v47e9 = v47e8 == Out_register_GSBASE;
wire v47ea = v474f < v475f;
wire v47ec = v47ea;
wire v47ed = v47ec == Out_register_CF;
wire [31:0] v47ef = In_register_DSBASE;
wire v47f0 = v47ef == Out_register_DSBASE;
wire v47f1 = v474f == v475f;
wire v47f3 = v47f1;
wire v47f4 = v47f3 == Out_register_ZF;
wire v47f5 = v4776 & v477e & v4773 & v4782 & v15c & v4785 & v4786 & v4797 & v47a8 & v47b9 & v47bc & v47c2 & v47c5 & v47c8 & v47cb & v47d2 & v47d5 & v47d8 & v47db & v47de & v47e6 & v47e9 & v47ed & v47f0 & v47f4;
wire v47f6 = v71 == v1eb;
wire v47f7 = v9b == v1ed;
wire v47f8 = v1b == v318;
wire v47f9 = v47f6 & v47f7 & v47f8;
wire v47fa = v47f9;
wire v47fb = v47fa;
wire v47fc = In_error_flag == Out_error_flag;
wire [31:0] v47fe = In_register_ESBASE;
wire v47ff = v47fe == Out_register_ESBASE;
wire [2:0] v4805 = { v1fa };
wire v4806 = v4805 == vb;
wire v4807 = v4806;
wire v4808 = v47f9 & v4807;
wire v4809 = v4808;
wire [2:0] v4800 = { v1fa };
wire [31:0] v4801 = ( v4800 == 3'd0) ? In_register_EAX : 
	( v4800 == 3'd1) ? In_register_ECX : 
	( v4800 == 3'd2) ? In_register_EDX : 
	( v4800 == 3'd3) ? In_register_EBX : 
	( v4800 == 3'd4) ? In_register_ESP : 
	( v4800 == 3'd5) ? In_register_EBP : 
	( v4800 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4803 = v4801;
wire [31:0] v4804 = v15 - v4803;
wire [31:0] v480c = ( v8 ) ? In_register_ESP : v4804;
wire [31:0] v480e = v480c;
wire v480f = v480e == Out_register_ESP;
wire v4810 = v4805 == v11;
wire v4811 = v4810;
wire v4812 = v47f9 & v4811;
wire v4813 = v4812;
wire [31:0] v4816 = ( v8 ) ? In_register_ESI : v4804;
wire [31:0] v4818 = v4816;
wire v4819 = v4818 == Out_register_ESI;
wire v481a = $signed(v4804) < $signed(v15);
wire v481c = v481a;
wire v481d = v481c == Out_register_SF;
wire [31:0] v481f = In_register_DSBASE;
wire v4820 = v481f == Out_register_DSBASE;
wire v4821 = v4805 == vf;
wire v4822 = v4821;
wire v4823 = v47f9 & v4822;
wire v4824 = v4823;
wire [31:0] v4827 = ( v8 ) ? In_register_EBP : v4804;
wire [31:0] v4829 = v4827;
wire v482a = v4829 == Out_register_EBP;
wire [31:0] v482c = v1c;
wire [31:0] v482d = In_register_EIP + v482c;
wire [31:0] v482f = v482d;
wire v4830 = v482f == Out_register_EIP;
wire v4831 = v4805 == vc;
wire v4832 = v4831;
wire v4833 = v47f9 & v4832;
wire v4834 = v4833;
wire [31:0] v4837 = ( v8 ) ? In_register_ECX : v4804;
wire [31:0] v4839 = v4837;
wire v483a = v4839 == Out_register_ECX;
wire [31:0] v483c = In_register_CSBASE;
wire v483d = v483c == Out_register_CSBASE;
wire [31:0] v483f = In_register_SSBASE;
wire v4840 = v483f == Out_register_SSBASE;
wire v4841 = v4805 == v7;
wire v4842 = v4841;
wire v4843 = v47f9 & v4842;
wire v4844 = v4843;
wire [31:0] v4847 = ( v8 ) ? In_register_EAX : v4804;
wire [31:0] v4849 = v4847;
wire v484a = v4849 == Out_register_EAX;
wire [31:0] v484c = In_register_GSBASE;
wire v484d = v484c == Out_register_GSBASE;
wire [31:0] v484e = v4804 >> v1e;
wire [31:0] v484f = v4803 >> v1e;
wire [31:0] v4850 = v484e + v484f;
wire v4851 = v4850 == v1c;
wire v4853 = v4851;
wire v4854 = v4853 == Out_register_OF;
wire v4855 = v4805 == ve;
wire v4856 = v4855;
wire v4857 = v47f9 & v4856;
wire v4858 = v4857;
wire [31:0] v485b = ( v8 ) ? In_register_EDX : v4804;
wire [31:0] v485d = v485b;
wire v485e = v485d == Out_register_EDX;
wire [31:0] v4860 = In_register_FSBASE;
wire v4861 = v4860 == Out_register_FSBASE;
wire v4862 = v4805 == v9;
wire v4863 = v4862;
wire v4864 = v47f9 & v4863;
wire v4865 = v4864;
wire [31:0] v4868 = ( v8 ) ? In_register_EDI : v4804;
wire [31:0] v486a = v4868;
wire v486b = v486a == Out_register_EDI;
wire [31:0] v486c = v4804 ^ v4803;
wire [7:0] v486d = v486c[7:0];
wire [7:0] v486e = v486d >> v1d;
wire [7:0] v486f = v486e & v18;
wire v4870 = v486f[0:0];
wire v4872 = v4870;
wire v4873 = v4872 == Out_register_AF;
wire [7:0] v4874 = v4804[7:0];
wire [2:0] v4875_aux = v4874[0] + v4874[1] + v4874[2] + v4874[3] + v4874[4] + v4874[5] + v4874[6] + v4874[7];
wire v4875 = { 5'b00000, v4875_aux };
wire [7:0] v4876 = v4875 & v18;
wire [7:0] v4877 = v4876 ^ v18;
wire v4878 = v4877[0:0];
wire v487a = v4878;
wire v487b = v487a == Out_register_PF;
wire v487c = v4803 != v15;
wire v487e = v487c;
wire v487f = v487e == Out_register_CF;
wire [7:0] v4881 = In_register_DF;
wire v4882 = v4881 == Out_register_DF;
wire v4883 = v4805 == vd;
wire v4884 = v4883;
wire v4885 = v47f9 & v4884;
wire v4886 = v4885;
wire [31:0] v4889 = ( v8 ) ? In_register_EBX : v4804;
wire [31:0] v488b = v4889;
wire v488c = v488b == Out_register_EBX;
wire v488d = v4803 == v15;
wire v488f = v488d;
wire v4890 = v488f == Out_register_ZF;
wire v4891 = v47fb & v47fc & v47ff & v15c & v480f & v4819 & v481d & v4820 & v482a & v4830 & v483a & v483d & v4840 & v484a & v484d & v4854 & v485e & v4861 & v486b & v4873 & v487b & v487f & v4882 & v488c & v4890;
wire [10:0] ve5 = 11'b10010001001;
wire v4892 = ve5 == v6d7;
wire v4893 = v35 == v316;
wire v4894 = v94 == v20a0;
wire v4895 = v4 == v11b;
wire [2:0] v4896 = { v13c };
wire v4897 = v4896 == vf;
wire v4898 = v4897;
wire v4899 = v4898 ^ v8;
wire [2:0] v489a = { v13c };
wire v489b = v489a == vf;
wire v489c = v489b;
wire v489d = v489c ^ v8;
wire v489e = v4899 & v489d;
wire v489f = v4892 & v4893 & v4894 & v4895 & v489e;
wire [7:0] ve6 = 8'b10010001;
wire v48a0 = ve6 == v1eb;
wire v48a1 = v30 == v316;
wire v48a2 = v4 == v11b;
wire [2:0] v48a3 = { v1fa };
wire v48a4 = v48a3 == vb;
wire v48a5 = v48a4;
wire v48a6 = v48a5 ^ v8;
wire [2:0] v48a7 = { v1fa };
wire v48a8 = v48a7 == vb;
wire v48a9 = v48a8;
wire v48aa = v48a9 ^ v8;
wire v48ab = v48a6 & v48aa;
wire v48ac = v48a0 & v48a1 & v48a2 & v48ab;
wire v48ad = ve5 == v6d7;
wire v48ae = v30 == v316;
wire v48af = v94 == v20a0;
wire v48b0 = v38 == v6da;
wire [2:0] v48b1 = { v13c };
wire v48b2 = v48b1 == v7;
wire v48b3 = v48b1 == vc;
wire v48b4 = v48b1 == ve;
wire v48b5 = v48b1 == vd;
wire v48b6 = v48b1 == v11;
wire v48b7 = v48b1 == v9;
wire v48b8 = v48b2 | v48b3 | v48b4 | v48b5 | v48b6 | v48b7;
wire v48b9 = v48b8 ^ v8;
wire v48ba = v48b9;
wire v48bb = v48ad & v48ae & v48af & v48b0 & v48ba;
wire v48bc = ve5 == v6d7;
wire v48bd = v35 == v316;
wire v48be = v4 == v11b;
wire [2:0] v48bf = { v13c };
wire v48c0 = v48bf == vb;
wire v48c1 = v48bf == vf;
wire v48c2 = v48c0 | v48c1;
wire v48c3 = v48c2 ^ v8;
wire [2:0] v48c4 = { v12c };
wire v48c5 = v48c4 == vb;
wire v48c6 = v48c5;
wire v48c7 = v48c6 ^ v8;
wire [2:0] v48c8 = { v13c };
wire v48c9 = v48c8 == vf;
wire v48ca = v48c9;
wire v48cb = v48ca ^ v8;
wire v48cc = v48c3 & v48c7 & v48cb;
wire v48cd = v48bc & v48bd & v48be & v48cc;
wire v48ce = ve5 == v6d7;
wire v48cf = v4b == vc0c;
wire v48d0 = v43 == vab3;
wire [2:0] v48d1 = { v12c };
wire v48d2 = v48d1 == vb;
wire v48d3 = v48d2;
wire v48d4 = v48d3 ^ v8;
wire v48d5 = v48d4;
wire v48d6 = v48ce & v48cf & v48d0 & v48d5;
wire v48d7 = ve5 == v6d7;
wire v48d8 = v30 == v316;
wire v48d9 = v38 == v6da;
wire [2:0] v48da = { v13c };
wire v48db = v48da == vb;
wire v48dc = v48da == vf;
wire v48dd = v48db | v48dc;
wire v48de = v48dd ^ v8;
wire [2:0] v48df = { v12c };
wire v48e0 = v48df == vb;
wire v48e1 = v48e0;
wire v48e2 = v48e1 ^ v8;
wire v48e3 = v48de & v48e2;
wire v48e4 = v48d7 & v48d8 & v48d9 & v48e3;
wire v48e5 = ve5 == v6d7;
wire v48e6 = v2f == v316;
wire v48e7 = v43 == vab3;
wire [2:0] v48e8 = { v13c };
wire v48e9 = v48e8 == v7;
wire v48ea = v48e8 == vc;
wire v48eb = v48e8 == ve;
wire v48ec = v48e8 == vd;
wire v48ed = v48e8 == v11;
wire v48ee = v48e8 == v9;
wire v48ef = v48e9 | v48ea | v48eb | v48ec | v48ed | v48ee;
wire v48f0 = v48ef ^ v8;
wire [2:0] v48f1 = { v12c };
wire v48f2 = v48f1 == vb;
wire v48f3 = v48f2;
wire v48f4 = v48f3 ^ v8;
wire v48f5 = v48f0 & v48f4;
wire v48f6 = v48e5 & v48e6 & v48e7 & v48f5;
wire v48f7 = v489f | v48ac | v48bb | v48cd | v48d6 | v48e4 | v48f6;
wire v48f8 = v48f7;
wire v48fa = In_register_OF;
wire v48fb = v48fa == Out_register_OF;
wire v48fc = In_error_flag == Out_error_flag;
wire [31:0] v48fe = In_register_EAX;
wire v48ff = v48fe == Out_register_EAX;
wire v4901 = In_register_PF;
wire v4902 = v4901 == Out_register_PF;
wire [31:0] v4904 = In_register_EBX;
wire v4905 = v4904 == Out_register_EBX;
wire [31:0] v4907 = In_register_ECX;
wire v4908 = v4907 == Out_register_ECX;
wire [31:0] v490a = In_register_ESI;
wire v490b = v490a == Out_register_ESI;
wire [7:0] v490d = In_register_DF;
wire v490e = v490d == Out_register_DF;
wire [31:0] v4910 = In_register_EDI;
wire v4911 = v4910 == Out_register_EDI;
wire [31:0] v4913 = In_register_ESP;
wire v4914 = v4913 == Out_register_ESP;
wire [31:0] v4916 = In_register_EDX;
wire v4917 = v4916 == Out_register_EDX;
wire [2:0] v491b = { v1fa };
wire [31:0] v491c = ( v491b == 3'd0) ? In_register_EAX : 
	( v491b == 3'd1) ? In_register_ECX : 
	( v491b == 3'd2) ? In_register_EDX : 
	( v491b == 3'd3) ? In_register_EBX : 
	( v491b == 3'd4) ? v15 : 
	( v491b == 3'd5) ? In_register_EBP : 
	( v491b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v491d = v491c + v63a;
wire [2:0] v491f = { v13c };
wire [31:0] v4920 = ( v491f == 3'd0) ? v15 : 
	( v491f == 3'd1) ? v15 : 
	( v491f == 3'd2) ? v15 : 
	( v491f == 3'd3) ? v15 : 
	( v491f == 3'd4) ? In_register_ESP : 
	( v491f == 3'd5) ? In_register_EBP : 
	( v491f == 3'd6) ? v15 : v15;
wire [31:0] v4921 = v4920 + v7f8;
wire [2:0] v4923 = { v13c };
wire [31:0] v4924 = ( v4923 == 3'd0) ? In_register_EAX : 
	( v4923 == 3'd1) ? In_register_ECX : 
	( v4923 == 3'd2) ? In_register_EDX : 
	( v4923 == 3'd3) ? In_register_EBX : 
	( v4923 == 3'd4) ? v15 : 
	( v4923 == 3'd5) ? v15 : 
	( v4923 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4925 = { v12c };
wire [31:0] v4926 = ( v4925 == 3'd0) ? In_register_EAX : 
	( v4925 == 3'd1) ? In_register_ECX : 
	( v4925 == 3'd2) ? In_register_EDX : 
	( v4925 == 3'd3) ? In_register_EBX : 
	( v4925 == 3'd4) ? v15 : 
	( v4925 == 3'd5) ? In_register_EBP : 
	( v4925 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4927 = v4926 << v7f4;
wire [31:0] v4928 = v4924 + v4927;
wire [2:0] v492a = { v12c };
wire [31:0] v492b = ( v492a == 3'd0) ? In_register_EAX : 
	( v492a == 3'd1) ? In_register_ECX : 
	( v492a == 3'd2) ? In_register_EDX : 
	( v492a == 3'd3) ? In_register_EBX : 
	( v492a == 3'd4) ? v15 : 
	( v492a == 3'd5) ? In_register_EBP : 
	( v492a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v492c = v492b << v7f4;
wire [31:0] v492d = v492c + vc2d;
wire [2:0] v492f = { v13c };
wire [31:0] v4930 = ( v492f == 3'd0) ? In_register_EAX : 
	( v492f == 3'd1) ? In_register_ECX : 
	( v492f == 3'd2) ? In_register_EDX : 
	( v492f == 3'd3) ? In_register_EBX : 
	( v492f == 3'd4) ? v15 : 
	( v492f == 3'd5) ? v15 : 
	( v492f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4931 = { v12c };
wire [31:0] v4932 = ( v4931 == 3'd0) ? In_register_EAX : 
	( v4931 == 3'd1) ? In_register_ECX : 
	( v4931 == 3'd2) ? In_register_EDX : 
	( v4931 == 3'd3) ? In_register_EBX : 
	( v4931 == 3'd4) ? v15 : 
	( v4931 == 3'd5) ? In_register_EBP : 
	( v4931 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4933 = v4932 << v7f4;
wire [31:0] v4934 = v4930 + v4933;
wire [31:0] v4935 = v4934 + v7f8;
wire [2:0] v4937 = { v13c };
wire [31:0] v4938 = ( v4937 == 3'd0) ? v15 : 
	( v4937 == 3'd1) ? v15 : 
	( v4937 == 3'd2) ? v15 : 
	( v4937 == 3'd3) ? v15 : 
	( v4937 == 3'd4) ? In_register_ESP : 
	( v4937 == 3'd5) ? In_register_EBP : 
	( v4937 == 3'd6) ? v15 : v15;
wire [2:0] v4939 = { v12c };
wire [31:0] v493a = ( v4939 == 3'd0) ? In_register_EAX : 
	( v4939 == 3'd1) ? In_register_ECX : 
	( v4939 == 3'd2) ? In_register_EDX : 
	( v4939 == 3'd3) ? In_register_EBX : 
	( v4939 == 3'd4) ? v15 : 
	( v4939 == 3'd5) ? In_register_EBP : 
	( v4939 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v493b = v493a << v7f4;
wire [31:0] v493c = v4938 + v493b;
wire [31:0] v493d = v493c + vc2d;
wire [2:0] v4918 = { v13c };
wire [31:0] v4919 = ( v4918 == 3'd0) ? In_register_EAX : 
	( v4918 == 3'd1) ? In_register_ECX : 
	( v4918 == 3'd2) ? In_register_EDX : 
	( v4918 == 3'd3) ? In_register_EBX : 
	( v4918 == 3'd4) ? In_register_ESP : 
	( v4918 == 3'd5) ? v15 : 
	( v4918 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v493f = ( v48ac ) ? v491d : 
	( v48bb ) ? v4921 : 
	( v48cd ) ? v4928 : 
	( v48d6 ) ? v492d : 
	( v48e4 ) ? v4935 : 
	( v48f6 ) ? v493d : v4919;
wire [2:0] v4940 = { v320 };
wire [31:0] v4941 = ( v4940 == 3'd0) ? In_register_EAX : 
	( v4940 == 3'd1) ? In_register_ECX : 
	( v4940 == 3'd2) ? In_register_EDX : 
	( v4940 == 3'd3) ? In_register_EBX : 
	( v4940 == 3'd4) ? In_register_ESP : 
	( v4940 == 3'd5) ? In_register_EBP : 
	( v4940 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4949 = { v320 };
wire [31:0] v494a = ( v4949 == 3'd0) ? In_register_EAX : 
	( v4949 == 3'd1) ? In_register_ECX : 
	( v4949 == 3'd2) ? In_register_EDX : 
	( v4949 == 3'd3) ? In_register_EBX : 
	( v4949 == 3'd4) ? In_register_ESP : 
	( v4949 == 3'd5) ? In_register_EBP : 
	( v4949 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4943 = { v320 };
wire [31:0] v4944 = ( v4943 == 3'd0) ? In_register_EAX : 
	( v4943 == 3'd1) ? In_register_ECX : 
	( v4943 == 3'd2) ? In_register_EDX : 
	( v4943 == 3'd3) ? In_register_EBX : 
	( v4943 == 3'd4) ? In_register_ESP : 
	( v4943 == 3'd5) ? In_register_EBP : 
	( v4943 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4952 = { v320 };
wire [31:0] v4953 = ( v4952 == 3'd0) ? In_register_EAX : 
	( v4952 == 3'd1) ? In_register_ECX : 
	( v4952 == 3'd2) ? In_register_EDX : 
	( v4952 == 3'd3) ? In_register_EBX : 
	( v4952 == 3'd4) ? In_register_ESP : 
	( v4952 == 3'd5) ? In_register_EBP : 
	( v4952 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v494c = { v320 };
wire [31:0] v494d = ( v494c == 3'd0) ? In_register_EAX : 
	( v494c == 3'd1) ? In_register_ECX : 
	( v494c == 3'd2) ? In_register_EDX : 
	( v494c == 3'd3) ? In_register_EBX : 
	( v494c == 3'd4) ? In_register_ESP : 
	( v494c == 3'd5) ? In_register_EBP : 
	( v494c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4946 = { v320 };
wire [31:0] v4947 = ( v4946 == 3'd0) ? In_register_EAX : 
	( v4946 == 3'd1) ? In_register_ECX : 
	( v4946 == 3'd2) ? In_register_EDX : 
	( v4946 == 3'd3) ? In_register_EBX : 
	( v4946 == 3'd4) ? In_register_ESP : 
	( v4946 == 3'd5) ? In_register_EBP : 
	( v4946 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v494f = { v320 };
wire [31:0] v4950 = ( v494f == 3'd0) ? In_register_EAX : 
	( v494f == 3'd1) ? In_register_ECX : 
	( v494f == 3'd2) ? In_register_EDX : 
	( v494f == 3'd3) ? In_register_EBX : 
	( v494f == 3'd4) ? In_register_ESP : 
	( v494f == 3'd5) ? In_register_EBP : 
	( v494f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4955 = ( v489f ) ? v4941 : 
	( v48cd ) ? v494a : 
	( v48ac ) ? v4944 : 
	( v48f6 ) ? v4953 : 
	( v48d6 ) ? v494d : 
	( v48bb ) ? v4947 : v4950;
wire v4956 =  v26 == memory_0[15: 12] && v493f == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v4955 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] v4958 = In_register_CSBASE;
wire v4959 = v4958 == Out_register_CSBASE;
wire [31:0] v495b = In_register_ESBASE;
wire v495c = v495b == Out_register_ESBASE;
wire [31:0] v495e = In_register_SSBASE;
wire v495f = v495e == Out_register_SSBASE;
wire [31:0] v4961 = In_register_DSBASE;
wire v4962 = v4961 == Out_register_DSBASE;
wire [31:0] v4964 = In_register_EBP;
wire v4965 = v4964 == Out_register_EBP;
wire [31:0] v4967 = In_register_GSBASE;
wire v4968 = v4967 == Out_register_GSBASE;
wire v496a = In_register_CF;
wire v496b = v496a == Out_register_CF;
wire [31:0] v496d = In_register_FSBASE;
wire v496e = v496d == Out_register_FSBASE;
wire v4970 = In_register_AF;
wire v4971 = v4970 == Out_register_AF;
wire [31:0] v4979 = ( v48d6 | v48f6 ) ? v45 : 
	( v48bb | v48e4 ) ? v27 : v10;
wire [31:0] v497a = In_register_EIP + v4979;
wire [31:0] v497c = v497a;
wire v497d = v497c == Out_register_EIP;
wire v497f = In_register_SF;
wire v4980 = v497f == Out_register_SF;
wire v4982 = In_register_ZF;
wire v4983 = v4982 == Out_register_ZF;
wire v4984 = v48f8 & v48fb & v48fc & v15c & v48ff & v4902 & v4905 & v4908 & v490b & v490e & v4911 & v4914 & v4917 & v4956 & v4959 & v495c & v495f & v4962 & v4965 & v4968 & v496b & v496e & v4971 & v497d & v4980 & v4983;
wire v4985 = v3e == v1eb;
wire v4986 = v73 == v1ed;
wire v4987 = v43 == vab3;
wire [2:0] v4988 = { v1fa };
wire v4989 = v4988 == vb;
wire v498a = v4988 == vf;
wire v498b = v4989 | v498a;
wire v498c = v498b ^ v8;
wire [2:0] v498d = { v1fa };
wire v498e = v498d == vb;
wire v498f = v498e;
wire v4990 = v498f ^ v8;
wire [2:0] v4991 = { v1fa };
wire v4992 = v4991 == vb;
wire v4993 = v4991 == vf;
wire v4994 = v4992 | v4993;
wire v4995 = v4994 ^ v8;
wire [2:0] v4996 = { v1fa };
wire v4997 = v4996 == vb;
wire v4998 = v4997;
wire v4999 = v4998 ^ v8;
wire v499a = v498c & v4990 & v4995 & v4999;
wire v499b = v4985 & v4986 & v4987 & v499a;
wire v499c = v499b;
wire v499d = v499c;
wire [31:0] v499f = In_register_EAX;
wire v49a0 = v499f == Out_register_EAX;
wire [31:0] v49a2 = In_register_ECX;
wire v49a3 = v49a2 == Out_register_ECX;
wire [2:0] v49a4 = { v1fa };
wire [31:0] v49a5 = ( v49a4 == 3'd0) ? In_register_EAX : 
	( v49a4 == 3'd1) ? In_register_ECX : 
	( v49a4 == 3'd2) ? In_register_EDX : 
	( v49a4 == 3'd3) ? In_register_EBX : 
	( v49a4 == 3'd4) ? v15 : 
	( v49a4 == 3'd5) ? v15 : 
	( v49a4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v49a6 = v49a5 + v1f7;
wire [31:0] v49a8 = v49a6;
wire v49a9 =  v2a == memory_0[15: 12] && v49a8 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v49aa = In_error_flag == Out_error_flag;
wire [31:0] v49ac = In_register_EBX;
wire v49ad = v49ac == Out_register_EBX;
wire [2:0] v49ae = { v1fa };
wire [31:0] v49af = ( v49ae == 3'd0) ? In_register_EAX : 
	( v49ae == 3'd1) ? In_register_ECX : 
	( v49ae == 3'd2) ? In_register_EDX : 
	( v49ae == 3'd3) ? In_register_EBX : 
	( v49ae == 3'd4) ? v15 : 
	( v49ae == 3'd5) ? v15 : 
	( v49ae == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v49b0 = v49af + v1f7;
wire [31:0] v49b2 = v49b0;
wire [31:0] v49b3 = memory_0[79: 48];
wire [7:0] v49b4 = v49b3[7:0];
wire [31:0] v49b6 = vb0c;
wire [7:0] v49b7 = v49b6[7:0];
wire [7:0] v49b8 = v49b4 | v49b7;
wire v49b9 =  v2a == memory_1[15: 12] && v49b2 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v49b8 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v49bb = In_register_EDX;
wire v49bc = v49bb == Out_register_EDX;
wire [31:0] v49be = In_register_ESP;
wire v49bf = v49be == Out_register_ESP;
wire [31:0] v49c1 = In_register_CSBASE;
wire v49c2 = v49c1 == Out_register_CSBASE;
wire [31:0] v49c4 = In_register_ESI;
wire v49c5 = v49c4 == Out_register_ESI;
wire [31:0] v49c7 = In_register_GSBASE;
wire v49c8 = v49c7 == Out_register_GSBASE;
wire [31:0] v49ca = v45;
wire [31:0] v49cb = In_register_EIP + v49ca;
wire [31:0] v49cd = v49cb;
wire v49ce = v49cd == Out_register_EIP;
wire [31:0] v49d0 = In_register_EDI;
wire v49d1 = v49d0 == Out_register_EDI;
wire [31:0] v49d3 = In_register_FSBASE;
wire v49d4 = v49d3 == Out_register_FSBASE;
wire [31:0] v49d6 = In_register_EBP;
wire v49d7 = v49d6 == Out_register_EBP;
wire [31:0] v49d9 = In_register_ESBASE;
wire v49da = v49d9 == Out_register_ESBASE;
wire [31:0] v49dc = In_register_DSBASE;
wire v49dd = v49dc == Out_register_DSBASE;
wire v49df = In_register_AF;
wire v49e0 = v49df == Out_register_AF;
wire v49e1 = v49b8 == v2c;
wire v49e3 = v49e1;
wire v49e4 = v49e3 == Out_register_ZF;
wire v49e6 = v17;
wire v49e7 = v49e6 == Out_register_OF;
wire v49e8 = v17;
wire v49e9 = v49e8 == Out_register_CF;
wire [7:0] v49eb = In_register_DF;
wire v49ec = v49eb == Out_register_DF;
wire [31:0] v49ee = In_register_SSBASE;
wire v49ef = v49ee == Out_register_SSBASE;
wire [2:0] v49f0_aux = v49b8[0] + v49b8[1] + v49b8[2] + v49b8[3] + v49b8[4] + v49b8[5] + v49b8[6] + v49b8[7];
wire v49f0 = { 5'b00000, v49f0_aux };
wire [7:0] v49f1 = v49f0 & v18;
wire [7:0] v49f2 = v49f1 ^ v18;
wire v49f3 = v49f2[0:0];
wire v49f5 = v49f3;
wire v49f6 = v49f5 == Out_register_PF;
wire v49f7 = $signed(v49b8) < $signed(v2c);
wire v49f9 = v49f7;
wire v49fa = v49f9 == Out_register_SF;
wire v49fb = v15c & v49a0 & v49a3 & v499d & v49a9 & v49aa & v49ad & v49b9 & v49bc & v49bf & v49c2 & v49c5 & v49c8 & v49ce & v49d1 & v49d4 & v49d7 & v49da & v49dd & v49e0 & v49e4 & v49e7 & v49e9 & v49ec & v49ef & v49f6 & v49fa;
wire v49fc = v40 == v1eb;
wire v49fd = v95 == v1ed;
wire v49fe = v38 == v6da;
wire [2:0] v49ff = { v1fa };
wire v4a00 = v49ff == vb;
wire v4a01 = v4a00;
wire v4a02 = v4a01 ^ v8;
wire [2:0] v4a03 = { v1fa };
wire v4a04 = v4a03 == vb;
wire v4a05 = v4a04;
wire v4a06 = v4a05 ^ v8;
wire [2:0] v4a07 = { v1fa };
wire v4a08 = v4a07 == vb;
wire v4a09 = v4a08;
wire v4a0a = v4a09 ^ v8;
wire [2:0] v4a0b = { v1fa };
wire v4a0c = v4a0b == vb;
wire v4a0d = v4a0c;
wire v4a0e = v4a0d ^ v8;
wire v4a0f = v4a02 & v4a06 & v4a0a & v4a0e;
wire v4a10 = v49fc & v49fd & v49fe & v4a0f;
wire v4a11 = v40 == v1eb;
wire v4a12 = v94 == v1ed;
wire v4a13 = v4 == v11b;
wire [2:0] v4a14 = { v1fa };
wire v4a15 = v4a14 == vb;
wire v4a16 = v4a14 == vf;
wire v4a17 = v4a15 | v4a16;
wire v4a18 = v4a17 ^ v8;
wire [2:0] v4a19 = { v1fa };
wire v4a1a = v4a19 == vb;
wire v4a1b = v4a19 == vf;
wire v4a1c = v4a1a | v4a1b;
wire v4a1d = v4a1c ^ v8;
wire [2:0] v4a1e = { v1fa };
wire v4a1f = v4a1e == vb;
wire v4a20 = v4a1e == vf;
wire v4a21 = v4a1f | v4a20;
wire v4a22 = v4a21 ^ v8;
wire [2:0] v4a23 = { v1fa };
wire v4a24 = v4a23 == vb;
wire v4a25 = v4a23 == vf;
wire v4a26 = v4a24 | v4a25;
wire v4a27 = v4a26 ^ v8;
wire v4a28 = v4a18 & v4a1d & v4a22 & v4a27;
wire v4a29 = v4a11 & v4a12 & v4a13 & v4a28;
wire [15:0] ve7 = 16'b1100000110100100;
wire v4a2a = ve7 == v117;
wire v4a2b = v43 == vab3;
wire v4a2c = v4a2a & v4a2b;
wire [15:0] ve8 = 16'b1100000100100100;
wire v4a2d = ve8 == v117;
wire v4a2e = v38 == v6da;
wire [2:0] v4a2f = { v13c };
wire v4a30 = v4a2f == v7;
wire v4a31 = v4a2f == vc;
wire v4a32 = v4a2f == ve;
wire v4a33 = v4a2f == vd;
wire v4a34 = v4a2f == vf;
wire v4a35 = v4a2f == v11;
wire v4a36 = v4a2f == v9;
wire v4a37 = v4a30 | v4a31 | v4a32 | v4a33 | v4a34 | v4a35 | v4a36;
wire v4a38 = v4a37 ^ v8;
wire [2:0] v4a39 = { v12c };
wire v4a3a = v4a39 == vb;
wire v4a3b = v4a3a;
wire v4a3c = v4a3b ^ v8;
wire [2:0] v4a3d = { v13c };
wire v4a3e = v4a3d == vf;
wire v4a3f = v4a3e;
wire v4a40 = v4a3f ^ v8;
wire [2:0] v4a41 = { v13c };
wire v4a42 = v4a41 == v7;
wire v4a43 = v4a41 == vc;
wire v4a44 = v4a41 == ve;
wire v4a45 = v4a41 == vd;
wire v4a46 = v4a41 == vf;
wire v4a47 = v4a41 == v11;
wire v4a48 = v4a41 == v9;
wire v4a49 = v4a42 | v4a43 | v4a44 | v4a45 | v4a46 | v4a47 | v4a48;
wire v4a4a = v4a49 ^ v8;
wire [2:0] v4a4b = { v12c };
wire v4a4c = v4a4b == vb;
wire v4a4d = v4a4c;
wire v4a4e = v4a4d ^ v8;
wire [2:0] v4a4f = { v13c };
wire v4a50 = v4a4f == vf;
wire v4a51 = v4a50;
wire v4a52 = v4a51 ^ v8;
wire v4a53 = v4a38 & v4a3c & v4a40 & v4a4a & v4a4e & v4a52;
wire v4a54 = v4a2d & v4a2e & v4a53;
wire v4a55 = v4a10 | v4a29 | v4a2c | v4a54;
wire v4a56 = v4a55;
wire [31:0] v4a58 = In_register_EBX;
wire v4a59 = v4a58 == Out_register_EBX;
wire v4a5a = In_error_flag == Out_error_flag;
wire [31:0] v4a5c = In_register_SSBASE;
wire v4a5d = v4a5c == Out_register_SSBASE;
wire [31:0] v4a5f = In_register_ESI;
wire v4a60 = v4a5f == Out_register_ESI;
wire [31:0] v4a62 = In_register_GSBASE;
wire v4a63 = v4a62 == Out_register_GSBASE;
wire [31:0] v4a64 = memory_0[79: 48];
wire [31:0] v4a69 = ( v4a10 | v4a54 ) ? v7f8 : 
	( v4a2c ) ? vb0c : v63a;
wire [31:0] v4a6a = v4a64 & v4a69;
wire v4a6b = $signed(v4a6a) < $signed(v15);
wire v4a6d = v4a6b;
wire v4a6e = v4a6d == Out_register_SF;
wire [31:0] v4a70 = In_register_ECX;
wire v4a71 = v4a70 == Out_register_ECX;
wire [31:0] v4a73 = In_register_EAX;
wire v4a74 = v4a73 == Out_register_EAX;
wire [7:0] v4a75 = v4a6a[7:0];
wire [2:0] v4a76_aux = v4a75[0] + v4a75[1] + v4a75[2] + v4a75[3] + v4a75[4] + v4a75[5] + v4a75[6] + v4a75[7];
wire v4a76 = { 5'b00000, v4a76_aux };
wire [7:0] v4a77 = v4a76 & v18;
wire [7:0] v4a78 = v4a77 ^ v18;
wire v4a79 = v4a78[0:0];
wire v4a7b = v4a79;
wire v4a7c = v4a7b == Out_register_PF;
wire [31:0] v4a81 = ( v4a2c ) ? v45 : 
	( v4a10 | v4a54 ) ? v27 : v10;
wire [31:0] v4a82 = In_register_EIP + v4a81;
wire [31:0] v4a84 = v4a82;
wire v4a85 = v4a84 == Out_register_EIP;
wire v4a87 = v17;
wire v4a88 = v4a87 == Out_register_CF;
wire [7:0] v4a8a = In_register_DF;
wire v4a8b = v4a8a == Out_register_DF;
wire [31:0] v4a8d = In_register_EDX;
wire v4a8e = v4a8d == Out_register_EDX;
wire [2:0] v4a8f = { v1fa };
wire [31:0] v4a90 = ( v4a8f == 3'd0) ? In_register_EAX : 
	( v4a8f == 3'd1) ? In_register_ECX : 
	( v4a8f == 3'd2) ? In_register_EDX : 
	( v4a8f == 3'd3) ? In_register_EBX : 
	( v4a8f == 3'd4) ? v15 : 
	( v4a8f == 3'd5) ? In_register_EBP : 
	( v4a8f == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4a91 = v4a90 + v63a;
wire [2:0] v4a97 = { v13c };
wire [31:0] v4a98 = ( v4a97 == 3'd0) ? v15 : 
	( v4a97 == 3'd1) ? v15 : 
	( v4a97 == 3'd2) ? v15 : 
	( v4a97 == 3'd3) ? v15 : 
	( v4a97 == 3'd4) ? In_register_ESP : 
	( v4a97 == 3'd5) ? v15 : 
	( v4a97 == 3'd6) ? v15 : v15;
wire [2:0] v4a99 = { v12c };
wire [31:0] v4a9a = ( v4a99 == 3'd0) ? In_register_EAX : 
	( v4a99 == 3'd1) ? In_register_ECX : 
	( v4a99 == 3'd2) ? In_register_EDX : 
	( v4a99 == 3'd3) ? In_register_EBX : 
	( v4a99 == 3'd4) ? v15 : 
	( v4a99 == 3'd5) ? In_register_EBP : 
	( v4a99 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4a9b = v4a9a << v7f4;
wire [31:0] v4a9c = v4a98 + v4a9b;
wire [2:0] v4a93 = { v1fa };
wire [31:0] v4a94 = ( v4a93 == 3'd0) ? In_register_EAX : 
	( v4a93 == 3'd1) ? In_register_ECX : 
	( v4a93 == 3'd2) ? In_register_EDX : 
	( v4a93 == 3'd3) ? In_register_EBX : 
	( v4a93 == 3'd4) ? v15 : 
	( v4a93 == 3'd5) ? v15 : 
	( v4a93 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4a9e = ( v4a10 ) ? v4a91 : 
	( v4a54 ) ? v4a9c : 
	( v4a29 ) ? v4a94 : v1f7;
wire v4a9f =  v26 == memory_0[15: 12] && v4a9e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v4aa1 = In_register_EDI;
wire v4aa2 = v4aa1 == Out_register_EDI;
wire [2:0] v4aa3 = { v1fa };
wire [31:0] v4aa4 = ( v4aa3 == 3'd0) ? In_register_EAX : 
	( v4aa3 == 3'd1) ? In_register_ECX : 
	( v4aa3 == 3'd2) ? In_register_EDX : 
	( v4aa3 == 3'd3) ? In_register_EBX : 
	( v4aa3 == 3'd4) ? v15 : 
	( v4aa3 == 3'd5) ? In_register_EBP : 
	( v4aa3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4aa5 = v4aa4 + v63a;
wire [2:0] v4aab = { v13c };
wire [31:0] v4aac = ( v4aab == 3'd0) ? v15 : 
	( v4aab == 3'd1) ? v15 : 
	( v4aab == 3'd2) ? v15 : 
	( v4aab == 3'd3) ? v15 : 
	( v4aab == 3'd4) ? In_register_ESP : 
	( v4aab == 3'd5) ? v15 : 
	( v4aab == 3'd6) ? v15 : v15;
wire [2:0] v4aad = { v12c };
wire [31:0] v4aae = ( v4aad == 3'd0) ? In_register_EAX : 
	( v4aad == 3'd1) ? In_register_ECX : 
	( v4aad == 3'd2) ? In_register_EDX : 
	( v4aad == 3'd3) ? In_register_EBX : 
	( v4aad == 3'd4) ? v15 : 
	( v4aad == 3'd5) ? In_register_EBP : 
	( v4aad == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4aaf = v4aae << v7f4;
wire [31:0] v4ab0 = v4aac + v4aaf;
wire [2:0] v4aa7 = { v1fa };
wire [31:0] v4aa8 = ( v4aa7 == 3'd0) ? In_register_EAX : 
	( v4aa7 == 3'd1) ? In_register_ECX : 
	( v4aa7 == 3'd2) ? In_register_EDX : 
	( v4aa7 == 3'd3) ? In_register_EBX : 
	( v4aa7 == 3'd4) ? v15 : 
	( v4aa7 == 3'd5) ? v15 : 
	( v4aa7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4ab2 = ( v4a10 ) ? v4aa5 : 
	( v4a54 ) ? v4ab0 : 
	( v4a2c ) ? v1f7 : v4aa8;
wire v4ab3 =  v26 == memory_1[15: 12] && v4ab2 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v4a6a == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v4ab5 = In_register_CSBASE;
wire v4ab6 = v4ab5 == Out_register_CSBASE;
wire [31:0] v4ab8 = In_register_EBP;
wire v4ab9 = v4ab8 == Out_register_EBP;
wire [31:0] v4abb = In_register_DSBASE;
wire v4abc = v4abb == Out_register_DSBASE;
wire [31:0] v4abe = In_register_ESBASE;
wire v4abf = v4abe == Out_register_ESBASE;
wire [31:0] v4ac1 = In_register_FSBASE;
wire v4ac2 = v4ac1 == Out_register_FSBASE;
wire v4ac3 = v17;
wire v4ac4 = v4ac3 == Out_register_AF;
wire v4ac5 = v17;
wire v4ac6 = v4ac5 == Out_register_OF;
wire [31:0] v4ac8 = In_register_ESP;
wire v4ac9 = v4ac8 == Out_register_ESP;
wire v4aca = v4a6a == v15;
wire v4acc = v4aca;
wire v4acd = v4acc == Out_register_ZF;
wire v4ace = v4a56 & v4a59 & v4a5a & v4a5d & v4a60 & v4a63 & v4a6e & v4a71 & v4a74 & v4a7c & v4a85 & v15c & v4a88 & v4a8b & v4a8e & v4a9f & v4aa2 & v4ab3 & v4ab6 & v4ab9 & v4abc & v4abf & v4ac2 & v4ac4 & v4ac6 & v4ac9 & v4acd;
wire v4acf = v40 == v1eb;
wire v4ad0 = v13 == v1ed;
wire v4ad1 = v4 == v11b;
wire v4ad2 = v4acf & v4ad0 & v4ad1;
wire v4ad3 = v4ad2;
wire v4ad4 = v4ad3;
wire v4ad6 = v17;
wire v4ad7 = v4ad6 == Out_register_OF;
wire v4ad8 = In_error_flag == Out_error_flag;
wire [2:0] v4ae0 = { v1fa };
wire v4ae1 = v4ae0 == vd;
wire v4ae2 = v4ae1;
wire v4ae3 = v4ad2 & v4ae2;
wire v4ae4 = v4ae3;
wire [31:0] v4ada = v63a;
wire [2:0] v4adb = { v1fa };
wire [31:0] v4adc = ( v4adb == 3'd0) ? In_register_EAX : 
	( v4adb == 3'd1) ? In_register_ECX : 
	( v4adb == 3'd2) ? In_register_EDX : 
	( v4adb == 3'd3) ? In_register_EBX : 
	( v4adb == 3'd4) ? In_register_ESP : 
	( v4adb == 3'd5) ? In_register_EBP : 
	( v4adb == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4ade = v4adc;
wire [31:0] v4adf = v4ada & v4ade;
wire [31:0] v4ae7 = ( v8 ) ? In_register_EBX : v4adf;
wire [31:0] v4ae9 = v4ae7;
wire v4aea = v4ae9 == Out_register_EBX;
wire v4aeb = v4ae0 == v7;
wire v4aec = v4aeb;
wire v4aed = v4ad2 & v4aec;
wire v4aee = v4aed;
wire [31:0] v4af1 = ( v8 ) ? In_register_EAX : v4adf;
wire [31:0] v4af3 = v4af1;
wire v4af4 = v4af3 == Out_register_EAX;
wire v4af5 = v4ae0 == vb;
wire v4af6 = v4af5;
wire v4af7 = v4ad2 & v4af6;
wire v4af8 = v4af7;
wire [31:0] v4afb = ( v8 ) ? In_register_ESP : v4adf;
wire [31:0] v4afd = v4afb;
wire v4afe = v4afd == Out_register_ESP;
wire v4aff = v4ae0 == vf;
wire v4b00 = v4aff;
wire v4b01 = v4ad2 & v4b00;
wire v4b02 = v4b01;
wire [31:0] v4b05 = ( v8 ) ? In_register_EBP : v4adf;
wire [31:0] v4b07 = v4b05;
wire v4b08 = v4b07 == Out_register_EBP;
wire [31:0] v4b0a = In_register_DSBASE;
wire v4b0b = v4b0a == Out_register_DSBASE;
wire v4b0c = v4ae0 == v9;
wire v4b0d = v4b0c;
wire v4b0e = v4ad2 & v4b0d;
wire v4b0f = v4b0e;
wire [31:0] v4b12 = ( v8 ) ? In_register_EDI : v4adf;
wire [31:0] v4b14 = v4b12;
wire v4b15 = v4b14 == Out_register_EDI;
wire v4b16 = v4ae0 == vc;
wire v4b17 = v4b16;
wire v4b18 = v4ad2 & v4b17;
wire v4b19 = v4b18;
wire [31:0] v4b1c = ( v8 ) ? In_register_ECX : v4adf;
wire [31:0] v4b1e = v4b1c;
wire v4b1f = v4b1e == Out_register_ECX;
wire [31:0] v4b21 = v10;
wire [31:0] v4b22 = In_register_EIP + v4b21;
wire [31:0] v4b24 = v4b22;
wire v4b25 = v4b24 == Out_register_EIP;
wire [31:0] v4b27 = In_register_CSBASE;
wire v4b28 = v4b27 == Out_register_CSBASE;
wire [31:0] v4b2a = In_register_SSBASE;
wire v4b2b = v4b2a == Out_register_SSBASE;
wire v4b2c = v4ae0 == ve;
wire v4b2d = v4b2c;
wire v4b2e = v4ad2 & v4b2d;
wire v4b2f = v4b2e;
wire [31:0] v4b32 = ( v8 ) ? In_register_EDX : v4adf;
wire [31:0] v4b34 = v4b32;
wire v4b35 = v4b34 == Out_register_EDX;
wire [7:0] v4b37 = In_register_DF;
wire v4b38 = v4b37 == Out_register_DF;
wire [31:0] v4b3a = In_register_ESBASE;
wire v4b3b = v4b3a == Out_register_ESBASE;
wire v4b3c = v17;
wire v4b3d = v4b3c == Out_register_AF;
wire [31:0] v4b3f = In_register_GSBASE;
wire v4b40 = v4b3f == Out_register_GSBASE;
wire [31:0] v4b42 = In_register_FSBASE;
wire v4b43 = v4b42 == Out_register_FSBASE;
wire v4b44 = v17;
wire v4b45 = v4b44 == Out_register_CF;
wire v4b46 = $signed(v4adf) < $signed(v15);
wire v4b48 = v4b46;
wire v4b49 = v4b48 == Out_register_SF;
wire v4b4a = v4ae0 == v11;
wire v4b4b = v4b4a;
wire v4b4c = v4ad2 & v4b4b;
wire v4b4d = v4b4c;
wire [31:0] v4b50 = ( v8 ) ? In_register_ESI : v4adf;
wire [31:0] v4b52 = v4b50;
wire v4b53 = v4b52 == Out_register_ESI;
wire [7:0] v4b54 = v4adf[7:0];
wire [2:0] v4b55_aux = v4b54[0] + v4b54[1] + v4b54[2] + v4b54[3] + v4b54[4] + v4b54[5] + v4b54[6] + v4b54[7];
wire v4b55 = { 5'b00000, v4b55_aux };
wire [7:0] v4b56 = v4b55 & v18;
wire [7:0] v4b57 = v4b56 ^ v18;
wire v4b58 = v4b57[0:0];
wire v4b5a = v4b58;
wire v4b5b = v4b5a == Out_register_PF;
wire v4b5c = v4adf == v15;
wire v4b5e = v4b5c;
wire v4b5f = v4b5e == Out_register_ZF;
wire v4b60 = v4ad7 & v15c & v4ad8 & v4aea & v4af4 & v4afe & v4b08 & v4b0b & v4b15 & v4b1f & v4b25 & v4b28 & v4ad4 & v4b2b & v4b35 & v4b38 & v4b3b & v4b3d & v4b40 & v4b43 & v4b45 & v4b49 & v4b53 & v4b5b & v4b5f;
wire [7:0] ve9 = 8'b00010110;
wire v4b61 = ve9 == v1eb;
wire v4b62 = v47 == vb69;
wire v4b63 = v4b61 & v4b62;
wire [31:0] v4b65 = vb74;
wire v4b66 =  v26 == memory_0[15: 12] && vdb3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v4b65 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v4b67 = v4b63;
wire v4b68 = v4b67;
wire [31:0] v4b6a = In_register_EDX;
wire v4b6b = v4b6a == Out_register_EDX;
wire [31:0] v4b6d = In_register_EDI;
wire v4b6e = v4b6d == Out_register_EDI;
wire [31:0] v4b70 = In_register_EAX;
wire v4b71 = v4b70 == Out_register_EAX;
wire v4b73 = In_register_OF;
wire v4b74 = v4b73 == Out_register_OF;
wire v4b75 = In_error_flag == Out_error_flag;
wire [31:0] v4b77 = vdb2;
wire v4b78 = v4b77 == Out_register_ESP;
wire [31:0] v4b7a = In_register_EBP;
wire v4b7b = v4b7a == Out_register_EBP;
wire v4b7d = In_register_CF;
wire v4b7e = v4b7d == Out_register_CF;
wire [31:0] v4b80 = In_register_ECX;
wire v4b81 = v4b80 == Out_register_ECX;
wire [31:0] v4b83 = In_register_SSBASE;
wire v4b84 = v4b83 == Out_register_SSBASE;
wire [31:0] v4b86 = In_register_ESBASE;
wire v4b87 = v4b86 == Out_register_ESBASE;
wire [31:0] v4b89 = In_register_EBX;
wire v4b8a = v4b89 == Out_register_EBX;
wire [31:0] v4b8c = In_register_DSBASE;
wire v4b8d = v4b8c == Out_register_DSBASE;
wire [31:0] v4b8f = In_register_CSBASE;
wire v4b90 = v4b8f == Out_register_CSBASE;
wire v4b92 = In_register_SF;
wire v4b93 = v4b92 == Out_register_SF;
wire [7:0] v4b95 = In_register_DF;
wire v4b96 = v4b95 == Out_register_DF;
wire [31:0] v4b98 = In_register_ESI;
wire v4b99 = v4b98 == Out_register_ESI;
wire [31:0] v4b9b = In_register_GSBASE;
wire v4b9c = v4b9b == Out_register_GSBASE;
wire [31:0] v4b9e = In_register_FSBASE;
wire v4b9f = v4b9e == Out_register_FSBASE;
wire [31:0] v4ba1 = v48;
wire [31:0] v4ba2 = In_register_EIP + v4ba1;
wire [31:0] v4ba4 = v4ba2;
wire v4ba5 = v4ba4 == Out_register_EIP;
wire v4ba7 = In_register_AF;
wire v4ba8 = v4ba7 == Out_register_AF;
wire v4baa = In_register_PF;
wire v4bab = v4baa == Out_register_PF;
wire v4bad = In_register_ZF;
wire v4bae = v4bad == Out_register_ZF;
wire v4baf = v4b66 & v4b6b & v4b68 & v4b6e & v4b71 & v4b74 & v4b75 & v4b78 & v4b7b & v15c & v4b7e & v4b81 & v4b84 & v4b87 & v4b8a & v4b8d & v4b90 & v4b93 & v4b96 & v4b99 & v4b9c & v4b9f & v4ba5 & v4ba8 & v4bab & v4bae;
wire v4bb0 = v12 == v1eb;
wire v4bb1 = v25 == v1ed;
wire v4bb2 = v14 == v1ef;
wire [2:0] v4bb3 = { v1fa };
wire v4bb4 = v4bb3 == vb;
wire v4bb5 = v4bb3 == vf;
wire v4bb6 = v4bb4 | v4bb5;
wire v4bb7 = v4bb6 ^ v8;
wire [2:0] v4bb8 = { v1fa };
wire v4bb9 = v4bb8 == vb;
wire v4bba = v4bb8 == vf;
wire v4bbb = v4bb9 | v4bba;
wire v4bbc = v4bbb ^ v8;
wire [2:0] v4bbd = { v1fa };
wire v4bbe = v4bbd == vb;
wire v4bbf = v4bbd == vf;
wire v4bc0 = v4bbe | v4bbf;
wire v4bc1 = v4bc0 ^ v8;
wire [2:0] v4bc2 = { v1fa };
wire v4bc3 = v4bc2 == vb;
wire v4bc4 = v4bc2 == vf;
wire v4bc5 = v4bc3 | v4bc4;
wire v4bc6 = v4bc5 ^ v8;
wire v4bc7 = v4bb7 & v4bbc & v4bc1 & v4bc6;
wire v4bc8 = v4bb0 & v4bb1 & v4bb2 & v4bc7;
wire v4bc9 = v4bc8;
wire v4bca = v4bc9;
wire [31:0] v4bcb = memory_0[79: 48];
wire [31:0] v4bcd = v1f7;
wire [31:0] v4bce = v4bcb + v4bcd;
wire [31:0] v4bcf = v4bce ^ v4bcd;
wire [31:0] v4bd0 = v4bcf ^ v4bcb;
wire [7:0] v4bd1 = v4bd0[7:0];
wire [7:0] v4bd2 = v4bd1 >> v1d;
wire [7:0] v4bd3 = v4bd2 & v18;
wire v4bd4 = v4bd3[0:0];
wire v4bd6 = v4bd4;
wire v4bd7 = v4bd6 == Out_register_AF;
wire v4bd8 = In_error_flag == Out_error_flag;
wire [31:0] v4bda = In_register_ESI;
wire v4bdb = v4bda == Out_register_ESI;
wire [31:0] v4bdd = In_register_FSBASE;
wire v4bde = v4bdd == Out_register_FSBASE;
wire [31:0] v4be0 = In_register_CSBASE;
wire v4be1 = v4be0 == Out_register_CSBASE;
wire [31:0] v4be3 = In_register_GSBASE;
wire v4be4 = v4be3 == Out_register_GSBASE;
wire v4be5 = v4bce < v4bcb;
wire v4be6 = v4bce < v4bcd;
wire v4be7 = v4be5 | v4be6;
wire v4be9 = v4be7;
wire v4bea = v4be9 == Out_register_CF;
wire [31:0] v4bec = In_register_EDX;
wire v4bed = v4bec == Out_register_EDX;
wire [2:0] v4bee = { v1fa };
wire [31:0] v4bef = ( v4bee == 3'd0) ? In_register_EAX : 
	( v4bee == 3'd1) ? In_register_ECX : 
	( v4bee == 3'd2) ? In_register_EDX : 
	( v4bee == 3'd3) ? In_register_EBX : 
	( v4bee == 3'd4) ? v15 : 
	( v4bee == 3'd5) ? v15 : 
	( v4bee == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4bf1 = v4bef;
wire v4bf2 =  v26 == memory_0[15: 12] && v4bf1 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] v4bf3 = v4bce[7:0];
wire [2:0] v4bf4_aux = v4bf3[0] + v4bf3[1] + v4bf3[2] + v4bf3[3] + v4bf3[4] + v4bf3[5] + v4bf3[6] + v4bf3[7];
wire v4bf4 = { 5'b00000, v4bf4_aux };
wire [7:0] v4bf5 = v4bf4 & v18;
wire [7:0] v4bf6 = v4bf5 ^ v18;
wire v4bf7 = v4bf6[0:0];
wire v4bf9 = v4bf7;
wire v4bfa = v4bf9 == Out_register_PF;
wire [31:0] v4bfc = In_register_EAX;
wire v4bfd = v4bfc == Out_register_EAX;
wire [31:0] v4bff = In_register_ECX;
wire v4c00 = v4bff == Out_register_ECX;
wire [31:0] v4c02 = In_register_EDI;
wire v4c03 = v4c02 == Out_register_EDI;
wire [31:0] v4c05 = In_register_EBP;
wire v4c06 = v4c05 == Out_register_EBP;
wire [31:0] v4c08 = In_register_ESP;
wire v4c09 = v4c08 == Out_register_ESP;
wire [31:0] v4c0b = In_register_EBX;
wire v4c0c = v4c0b == Out_register_EBX;
wire [31:0] v4c0e = v16;
wire [31:0] v4c0f = In_register_EIP + v4c0e;
wire [31:0] v4c11 = v4c0f;
wire v4c12 = v4c11 == Out_register_EIP;
wire [2:0] v4c13 = { v1fa };
wire [31:0] v4c14 = ( v4c13 == 3'd0) ? In_register_EAX : 
	( v4c13 == 3'd1) ? In_register_ECX : 
	( v4c13 == 3'd2) ? In_register_EDX : 
	( v4c13 == 3'd3) ? In_register_EBX : 
	( v4c13 == 3'd4) ? v15 : 
	( v4c13 == 3'd5) ? v15 : 
	( v4c13 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4c16 = v4c14;
wire v4c17 =  v26 == memory_1[15: 12] && v4c16 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v4bce == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v4c19 = In_register_SSBASE;
wire v4c1a = v4c19 == Out_register_SSBASE;
wire [7:0] v4c1c = In_register_DF;
wire v4c1d = v4c1c == Out_register_DF;
wire [31:0] v4c1f = In_register_DSBASE;
wire v4c20 = v4c1f == Out_register_DSBASE;
wire [31:0] v4c21 = v4bce ^ v4bcb;
wire [31:0] v4c22 = v4c21 >> v1e;
wire [31:0] v4c23 = v4bcf >> v1e;
wire [31:0] v4c24 = v4c22 + v4c23;
wire v4c25 = v4c24 == v1c;
wire v4c27 = v4c25;
wire v4c28 = v4c27 == Out_register_OF;
wire [31:0] v4c2a = In_register_ESBASE;
wire v4c2b = v4c2a == Out_register_ESBASE;
wire v4c2c = $signed(v4bce) < $signed(v15);
wire v4c2e = v4c2c;
wire v4c2f = v4c2e == Out_register_SF;
wire v4c30 = v4bce == v15;
wire v4c32 = v4c30;
wire v4c33 = v4c32 == Out_register_ZF;
wire v4c34 = v4bca & v4bd7 & v15c & v4bd8 & v4bdb & v4bde & v4be1 & v4be4 & v4bea & v4bed & v4bf2 & v4bfa & v4bfd & v4c00 & v4c03 & v4c06 & v4c09 & v4c0c & v4c12 & v4c17 & v4c1a & v4c1d & v4c20 & v4c28 & v4c2b & v4c2f & v4c33;
wire v4c35 = vd5 == v2682;
wire v4c36 = v1b == v318;
wire v4c37 = v4c35 & v4c36;
wire v4c38 = v4c37;
wire v4c39 = v4c38;
wire [31:0] v4c3b = In_register_CSBASE;
wire v4c3c = v4c3b == Out_register_CSBASE;
wire [31:0] v4c3e = In_register_GSBASE;
wire v4c3f = v4c3e == Out_register_GSBASE;
wire [2:0] v4c46 = { v268d };
wire v4c47 = v4c46 == vf;
wire v4c48 = v4c47;
wire v4c49 = v4c37 & v4c48;
wire v4c4a = v4c49;
wire [31:0] v4c41 = v477;
wire [7:0] v4c42 = v4c41[7:0];
wire [31:0] v4c43 = { 24'b000000000000000000000000, v4c42 };
wire [31:0] v4c44 = v4c43 << v31;
wire [31:0] v4c45 = v790 | v4c44;
wire v4c4d = v4c46 == vc;
wire v4c4e = v4c4d;
wire v4c4f = v4c37 & v4c4e;
wire v4c50 = v4c4f;
wire [31:0] v4c4c = v7a0 | v4c43;
wire [31:0] v4c53 = ( v8 ) ? In_register_ECX : 
	( v4c4a ) ? v4c45 : v4c4c;
wire [31:0] v4c55 = v4c53;
wire v4c56 = v4c55 == Out_register_ECX;
wire v4c5e = v4c46 == vb;
wire v4c5f = v4c5e;
wire v4c60 = v4c37 & v4c5f;
wire v4c61 = v4c60;
wire [31:0] v4c5d = v752 | v4c44;
wire v4c58 = v4c46 == v7;
wire v4c59 = v4c58;
wire v4c5a = v4c37 & v4c59;
wire v4c5b = v4c5a;
wire [31:0] v4c57 = v5c8 | v4c43;
wire [31:0] v4c64 = ( v8 ) ? In_register_EAX : 
	( v4c61 ) ? v4c5d : v4c57;
wire [31:0] v4c66 = v4c64;
wire v4c67 = v4c66 == Out_register_EAX;
wire v4c69 = v4c46 == ve;
wire v4c6a = v4c69;
wire v4c6b = v4c37 & v4c6a;
wire v4c6c = v4c6b;
wire [31:0] v4c68 = v768 | v4c43;
wire v4c6f = v4c46 == v11;
wire v4c70 = v4c6f;
wire v4c71 = v4c37 & v4c70;
wire v4c72 = v4c71;
wire [31:0] v4c6e = v778 | v4c44;
wire [31:0] v4c75 = ( v8 ) ? In_register_EDX : 
	( v4c6c ) ? v4c68 : v4c6e;
wire [31:0] v4c77 = v4c75;
wire v4c78 = v4c77 == Out_register_EDX;
wire v4c7a = In_register_PF;
wire v4c7b = v4c7a == Out_register_PF;
wire v4c7d = In_register_AF;
wire v4c7e = v4c7d == Out_register_AF;
wire [31:0] v4c80 = In_register_EDI;
wire v4c81 = v4c80 == Out_register_EDI;
wire v4c83 = In_register_CF;
wire v4c84 = v4c83 == Out_register_CF;
wire v4c86 = In_register_OF;
wire v4c87 = v4c86 == Out_register_OF;
wire [31:0] v4c89 = In_register_ESP;
wire v4c8a = v4c89 == Out_register_ESP;
wire [31:0] v4c8c = In_register_SSBASE;
wire v4c8d = v4c8c == Out_register_SSBASE;
wire v4c8f = In_register_SF;
wire v4c90 = v4c8f == Out_register_SF;
wire [31:0] v4c92 = In_register_EBP;
wire v4c93 = v4c92 == Out_register_EBP;
wire v4c94 = In_error_flag == Out_error_flag;
wire [31:0] v4c96 = In_register_ESBASE;
wire v4c97 = v4c96 == Out_register_ESBASE;
wire v4c9f = v4c46 == v9;
wire v4ca0 = v4c9f;
wire v4ca1 = v4c37 & v4ca0;
wire v4ca2 = v4ca1;
wire [31:0] v4c9e = v7c8 | v4c44;
wire v4c99 = v4c46 == vd;
wire v4c9a = v4c99;
wire v4c9b = v4c37 & v4c9a;
wire v4c9c = v4c9b;
wire [31:0] v4c98 = v7b8 | v4c43;
wire [31:0] v4ca5 = ( v8 ) ? In_register_EBX : 
	( v4ca2 ) ? v4c9e : v4c98;
wire [31:0] v4ca7 = v4ca5;
wire v4ca8 = v4ca7 == Out_register_EBX;
wire [31:0] v4caa = In_register_DSBASE;
wire v4cab = v4caa == Out_register_DSBASE;
wire [31:0] v4cad = In_register_ESI;
wire v4cae = v4cad == Out_register_ESI;
wire [31:0] v4cb0 = v1c;
wire [31:0] v4cb1 = In_register_EIP + v4cb0;
wire [31:0] v4cb3 = v4cb1;
wire v4cb4 = v4cb3 == Out_register_EIP;
wire [31:0] v4cb6 = In_register_FSBASE;
wire v4cb7 = v4cb6 == Out_register_FSBASE;
wire v4cb9 = In_register_ZF;
wire v4cba = v4cb9 == Out_register_ZF;
wire [7:0] v4cbc = In_register_DF;
wire v4cbd = v4cbc == Out_register_DF;
wire v4cbe = v4c39 & v4c3c & v4c3f & v4c56 & v4c67 & v4c78 & v4c7b & v4c7e & v4c81 & v4c84 & v4c87 & v4c8a & v4c8d & v4c90 & v4c93 & v4c94 & v4c97 & v4ca8 & v4cab & v4cae & v4cb4 & v15c & v4cb7 & v4cba & v4cbd;
wire v4cbf = v8b == v2682;
wire v4cc0 = v29 == v59f;
wire v4cc1 = v4cbf & v4cc0;
wire v4cc2 = v4cc1;
wire v4cc3 = v4cc2;
wire [2:0] v4cc5 = { v268d };
wire v4cc6 = v4cc5 == vc;
wire v4cc7 = v4cc6;
wire v4cc8 = v4cc1 & v4cc7;
wire v4cc9 = v4cc8;
wire [31:0] v4cc4 = memory_0[79: 48];
wire [31:0] v4ccc = ( v8 ) ? In_register_ECX : v4cc4;
wire [31:0] v4cce = v4ccc;
wire v4ccf = v4cce == Out_register_ECX;
wire v4cd0 = v4cc5 == ve;
wire v4cd1 = v4cd0;
wire v4cd2 = v4cc1 & v4cd1;
wire v4cd3 = v4cd2;
wire [31:0] v4cd6 = ( v8 ) ? In_register_EDX : v4cc4;
wire [31:0] v4cd8 = v4cd6;
wire v4cd9 = v4cd8 == Out_register_EDX;
wire [31:0] v4cdb = In_register_DSBASE;
wire v4cdc = v4cdb == Out_register_DSBASE;
wire [31:0] v4cde = In_register_CSBASE;
wire v4cdf = v4cde == Out_register_CSBASE;
wire v4ce0 =  v26 == memory_0[15: 12] && v55a == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v4ce2 = v2b;
wire [31:0] v4ce3 = In_register_EIP + v4ce2;
wire [31:0] v4ce5 = v4ce3;
wire v4ce6 = v4ce5 == Out_register_EIP;
wire v4ce7 = v4cc5 == v7;
wire v4ce8 = v4ce7;
wire v4ce9 = v4cc1 & v4ce8;
wire v4cea = v4ce9;
wire [31:0] v4ced = ( v8 ) ? In_register_EAX : v4cc4;
wire [31:0] v4cef = v4ced;
wire v4cf0 = v4cef == Out_register_EAX;
wire v4cf2 = In_register_PF;
wire v4cf3 = v4cf2 == Out_register_PF;
wire v4cf4 = In_error_flag == Out_error_flag;
wire v4cf5 = v4cc5 == vb;
wire v4cf6 = v4cf5;
wire v4cf7 = v4cc1 & v4cf6;
wire v4cf8 = v4cf7;
wire [31:0] v4cfb = ( v8 ) ? v55f : v4cc4;
wire [31:0] v4cfd = v4cfb;
wire v4cfe = v4cfd == Out_register_ESP;
wire v4cff = v4cc5 == v11;
wire v4d00 = v4cff;
wire v4d01 = v4cc1 & v4d00;
wire v4d02 = v4d01;
wire [31:0] v4d05 = ( v8 ) ? In_register_ESI : v4cc4;
wire [31:0] v4d07 = v4d05;
wire v4d08 = v4d07 == Out_register_ESI;
wire [7:0] v4d0a = In_register_DF;
wire v4d0b = v4d0a == Out_register_DF;
wire v4d0c = v4cc5 == vf;
wire v4d0d = v4d0c;
wire v4d0e = v4cc1 & v4d0d;
wire v4d0f = v4d0e;
wire [31:0] v4d12 = ( v8 ) ? In_register_EBP : v4cc4;
wire [31:0] v4d14 = v4d12;
wire v4d15 = v4d14 == Out_register_EBP;
wire [31:0] v4d17 = In_register_SSBASE;
wire v4d18 = v4d17 == Out_register_SSBASE;
wire [31:0] v4d1a = In_register_ESBASE;
wire v4d1b = v4d1a == Out_register_ESBASE;
wire v4d1d = In_register_AF;
wire v4d1e = v4d1d == Out_register_AF;
wire v4d1f = v4cc5 == v9;
wire v4d20 = v4d1f;
wire v4d21 = v4cc1 & v4d20;
wire v4d22 = v4d21;
wire [31:0] v4d25 = ( v8 ) ? In_register_EDI : v4cc4;
wire [31:0] v4d27 = v4d25;
wire v4d28 = v4d27 == Out_register_EDI;
wire [31:0] v4d2a = In_register_GSBASE;
wire v4d2b = v4d2a == Out_register_GSBASE;
wire [31:0] v4d2d = In_register_FSBASE;
wire v4d2e = v4d2d == Out_register_FSBASE;
wire v4d30 = In_register_CF;
wire v4d31 = v4d30 == Out_register_CF;
wire v4d33 = In_register_OF;
wire v4d34 = v4d33 == Out_register_OF;
wire v4d35 = v4cc5 == vd;
wire v4d36 = v4d35;
wire v4d37 = v4cc1 & v4d36;
wire v4d38 = v4d37;
wire [31:0] v4d3b = ( v8 ) ? In_register_EBX : v4cc4;
wire [31:0] v4d3d = v4d3b;
wire v4d3e = v4d3d == Out_register_EBX;
wire v4d40 = In_register_SF;
wire v4d41 = v4d40 == Out_register_SF;
wire v4d43 = In_register_ZF;
wire v4d44 = v4d43 == Out_register_ZF;
wire v4d45 = v4cc3 & v4ccf & v4cd9 & v4cdc & v4cdf & v4ce0 & v4ce6 & v15c & v4cf0 & v4cf3 & v4cf4 & v4cfe & v4d08 & v4d0b & v4d15 & v4d18 & v4d1b & v4d1e & v4d28 & v4d2b & v4d2e & v4d31 & v4d34 & v4d3e & v4d41 & v4d44;
wire v4d48 = v71 == v1eb;
wire v4d49 = v4f == v1ed;
wire v4d4a = v1b == v318;
wire v4d4b = v4d48 & v4d49 & v4d4a;
wire v4d57 = v4d4b;
wire v4d58 = v4d57;
wire [2:0] v4d46 = { v1fa };
wire [31:0] v4d47 = ( v4d46 == 3'd0) ? In_register_EAX : 
	( v4d46 == 3'd1) ? In_register_ECX : 
	( v4d46 == 3'd2) ? In_register_EDX : 
	( v4d46 == 3'd3) ? In_register_EBX : 
	( v4d46 == 3'd4) ? In_register_ESP : 
	( v4d46 == 3'd5) ? In_register_EBP : 
	( v4d46 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4d4d = v4d47;
wire v4d4e = v4d4d == v15;
wire v4d4f = v4d4e ^ v8;
wire [63:0] v4d50 = { 32'b00000000000000000000000000000000, v4d4d };
wire [63:0] v4d51 = v30ec / v4d50;
wire v4d52 = v4d51 < vb8;
wire v4d53 = v4d4f & v4d52;
wire [63:0] v4d54 = v30ec % v4d50;
wire [31:0] v4d55 = v4d54[31:0];
wire [31:0] v4d56 = ( v4d53 == 1'd0) ? In_register_EDX : v4d55;
wire [31:0] v4d5a = v4d56;
wire v4d5b = v4d5a == Out_register_EDX;
wire [31:0] v4d5d = In_register_ESBASE;
wire v4d5e = v4d5d == Out_register_ESBASE;
wire [31:0] v4d60 = In_register_EBX;
wire v4d61 = v4d60 == Out_register_EBX;
wire v4d62 = In_error_flag == Out_error_flag;
wire [31:0] v4d64 = In_register_DSBASE;
wire v4d65 = v4d64 == Out_register_DSBASE;
wire [31:0] v4d66 = v4d51[31:0];
wire [31:0] v4d67 = ( v4d53 == 1'd0) ? In_register_EAX : v4d66;
wire [31:0] v4d69 = v4d67;
wire v4d6a = v4d69 == Out_register_EAX;
wire [31:0] v4d6c = In_register_ECX;
wire v4d6d = v4d6c == Out_register_ECX;
wire [31:0] v4d6f = In_register_EDI;
wire v4d70 = v4d6f == Out_register_EDI;
wire [31:0] v4d72 = In_register_ESP;
wire v4d73 = v4d72 == Out_register_ESP;
wire [31:0] v4d75 = In_register_CSBASE;
wire v4d76 = v4d75 == Out_register_CSBASE;
wire [7:0] v4d77 = ( v4d53 == 1'd0) ? v2870 : v2871;
wire v4d78 = v4d77[0:0];
wire v4d7a = v4d78;
wire v4d7b = v4d7a == Out_register_AF;
wire [7:0] v4d7c = ( v4d53 == 1'd0) ? v65f : v28a8;
wire v4d7d = v4d7c[0:0];
wire v4d7f = v4d7d;
wire v4d80 = v4d7f == Out_register_CF;
wire [31:0] v4d82 = In_register_ESI;
wire v4d83 = v4d82 == Out_register_ESI;
wire [7:0] v4d84 = ( v4d53 == 1'd0) ? v28c3 : v28c4;
wire v4d85 = v4d84[0:0];
wire v4d87 = v4d85;
wire v4d88 = v4d87 == Out_register_OF;
wire [7:0] v4d89 = ( v4d53 == 1'd0) ? v1d85 : v28d0;
wire v4d8a = v4d89[0:0];
wire v4d8c = v4d8a;
wire v4d8d = v4d8c == Out_register_SF;
wire [31:0] v4d8f = v1c;
wire [31:0] v4d90 = In_register_EIP + v4d8f;
wire [31:0] v4d92 = v4d90;
wire [31:0] v4d94 = v4d92;
wire v4d95 = v4d94 == Out_register_EIP;
wire [31:0] v4d97 = In_register_SSBASE;
wire v4d98 = v4d97 == Out_register_SSBASE;
wire [31:0] v4d9a = In_register_FSBASE;
wire v4d9b = v4d9a == Out_register_FSBASE;
wire [31:0] v4d9d = In_register_GSBASE;
wire v4d9e = v4d9d == Out_register_GSBASE;
wire [7:0] v4da0 = In_register_DF;
wire v4da1 = v4da0 == Out_register_DF;
wire [7:0] v4da2 = ( v4d53 == 1'd0) ? vd06 : v28ca;
wire v4da3 = v4da2[0:0];
wire v4da5 = v4da3;
wire v4da6 = v4da5 == Out_register_PF;
wire [31:0] v4da8 = In_register_EBP;
wire v4da9 = v4da8 == Out_register_EBP;
wire [7:0] v4daa = ( v4d53 == 1'd0) ? v289b : v289c;
wire v4dab = v4daa[0:0];
wire v4dad = v4dab;
wire v4dae = v4dad == Out_register_ZF;
wire v4daf = v4d5b & v4d5e & v4d61 & v4d62 & v4d65 & v4d6a & v4d6d & v4d70 & v4d73 & v4d58 & v4d76 & v4d7b & v4d80 & v15c & v4d83 & v4d88 & v4d8d & v4d95 & v4d98 & v4d9b & v4d9e & v4da1 & v4da6 & v4da9 & v4dae;
wire [7:0] vea = 8'b10011001;
wire v4db0 = vea == v1eb;
wire v4db1 = v29 == v59f;
wire v4db2 = v4db0 & v4db1;
wire v4db3 = v4db2;
wire v4db4 = v4db3;
wire [31:0] v4db6 = In_register_EAX;
wire v4db7 = v4db6 == Out_register_EAX;
wire [31:0] v4db9 = In_register_SSBASE;
wire v4dba = v4db9 == Out_register_SSBASE;
wire v4dbc = In_register_AF;
wire v4dbd = v4dbc == Out_register_AF;
wire v4dbe = In_error_flag == Out_error_flag;
wire v4dc0 = In_register_ZF;
wire v4dc1 = v4dc0 == Out_register_ZF;
wire [31:0] v4dc2 = In_register_EAX >>> v1e;
wire [31:0] v4dc4 = v4dc2;
wire v4dc5 = v4dc4 == Out_register_EDX;
wire [31:0] v4dc7 = In_register_ESBASE;
wire v4dc8 = v4dc7 == Out_register_ESBASE;
wire [31:0] v4dca = In_register_ESP;
wire v4dcb = v4dca == Out_register_ESP;
wire [31:0] v4dcd = In_register_GSBASE;
wire v4dce = v4dcd == Out_register_GSBASE;
wire [31:0] v4dd0 = In_register_ESI;
wire v4dd1 = v4dd0 == Out_register_ESI;
wire [31:0] v4dd3 = v2b;
wire [31:0] v4dd4 = In_register_EIP + v4dd3;
wire [31:0] v4dd6 = v4dd4;
wire v4dd7 = v4dd6 == Out_register_EIP;
wire v4dd9 = In_register_PF;
wire v4dda = v4dd9 == Out_register_PF;
wire [31:0] v4ddc = In_register_ECX;
wire v4ddd = v4ddc == Out_register_ECX;
wire v4ddf = In_register_OF;
wire v4de0 = v4ddf == Out_register_OF;
wire v4de2 = In_register_CF;
wire v4de3 = v4de2 == Out_register_CF;
wire [31:0] v4de5 = In_register_EBP;
wire v4de6 = v4de5 == Out_register_EBP;
wire [31:0] v4de8 = In_register_CSBASE;
wire v4de9 = v4de8 == Out_register_CSBASE;
wire [31:0] v4deb = In_register_EDI;
wire v4dec = v4deb == Out_register_EDI;
wire [31:0] v4dee = In_register_DSBASE;
wire v4def = v4dee == Out_register_DSBASE;
wire [7:0] v4df1 = In_register_DF;
wire v4df2 = v4df1 == Out_register_DF;
wire [31:0] v4df4 = In_register_EBX;
wire v4df5 = v4df4 == Out_register_EBX;
wire [31:0] v4df7 = In_register_FSBASE;
wire v4df8 = v4df7 == Out_register_FSBASE;
wire v4dfa = In_register_SF;
wire v4dfb = v4dfa == Out_register_SF;
wire v4dfc = v4db4 & v4db7 & v4dba & v4dbd & v4dbe & v4dc1 & v4dc5 & v4dc8 & v4dcb & v4dce & v4dd1 & v4dd7 & v4dda & v4ddd & v4de0 & v4de3 & v4de6 & v4de9 & v4dec & v4def & v15c & v4df2 & v4df5 & v4df8 & v4dfb;
wire v4dfd = v44 == v2682;
wire v4dfe = v29 == v59f;
wire v4dff = v4dfd & v4dfe;
wire v4e00 = v4dff;
wire v4e01 = v4e00;
wire [31:0] v4e03 = In_register_EBX;
wire v4e04 = v4e03 == Out_register_EBX;
wire [31:0] v4e06 = In_register_ECX;
wire v4e07 = v4e06 == Out_register_ECX;
wire [7:0] v4e09 = In_register_DF;
wire v4e0a = v4e09 == Out_register_DF;
wire v4e0c = In_register_CF;
wire v4e0d = v4e0c == Out_register_CF;
wire [31:0] v4e0f = In_register_ESI;
wire v4e10 = v4e0f == Out_register_ESI;
wire v4e11 = In_error_flag == Out_error_flag;
wire [31:0] v4e13 = vdb2;
wire v4e14 = v4e13 == Out_register_ESP;
wire [31:0] v4e16 = In_register_GSBASE;
wire v4e17 = v4e16 == Out_register_GSBASE;
wire [31:0] v4e19 = In_register_FSBASE;
wire v4e1a = v4e19 == Out_register_FSBASE;
wire [31:0] v4e1c = In_register_EAX;
wire v4e1d = v4e1c == Out_register_EAX;
wire [31:0] v4e1f = In_register_EDX;
wire v4e20 = v4e1f == Out_register_EDX;
wire [2:0] v4e21 = { v268d };
wire [31:0] v4e22 = ( v4e21 == 3'd0) ? In_register_EAX : 
	( v4e21 == 3'd1) ? In_register_ECX : 
	( v4e21 == 3'd2) ? In_register_EDX : 
	( v4e21 == 3'd3) ? In_register_EBX : 
	( v4e21 == 3'd4) ? In_register_ESP : 
	( v4e21 == 3'd5) ? In_register_EBP : 
	( v4e21 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4e24 = v4e22;
wire v4e25 =  v26 == memory_0[15: 12] && vdb3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v4e24 == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v4e27 = In_register_ZF;
wire v4e28 = v4e27 == Out_register_ZF;
wire [31:0] v4e2a = In_register_EDI;
wire v4e2b = v4e2a == Out_register_EDI;
wire [31:0] v4e2d = In_register_EBP;
wire v4e2e = v4e2d == Out_register_EBP;
wire v4e30 = In_register_AF;
wire v4e31 = v4e30 == Out_register_AF;
wire [31:0] v4e33 = v2b;
wire [31:0] v4e34 = In_register_EIP + v4e33;
wire [31:0] v4e36 = v4e34;
wire v4e37 = v4e36 == Out_register_EIP;
wire [31:0] v4e39 = In_register_SSBASE;
wire v4e3a = v4e39 == Out_register_SSBASE;
wire [31:0] v4e3c = In_register_CSBASE;
wire v4e3d = v4e3c == Out_register_CSBASE;
wire [31:0] v4e3f = In_register_ESBASE;
wire v4e40 = v4e3f == Out_register_ESBASE;
wire [31:0] v4e42 = In_register_DSBASE;
wire v4e43 = v4e42 == Out_register_DSBASE;
wire v4e45 = In_register_PF;
wire v4e46 = v4e45 == Out_register_PF;
wire v4e48 = In_register_OF;
wire v4e49 = v4e48 == Out_register_OF;
wire v4e4b = In_register_SF;
wire v4e4c = v4e4b == Out_register_SF;
wire v4e4d = v4e01 & v4e04 & v4e07 & v4e0a & v15c & v4e0d & v4e10 & v4e11 & v4e14 & v4e17 & v4e1a & v4e1d & v4e20 & v4e25 & v4e28 & v4e2b & v4e2e & v4e31 & v4e37 & v4e3a & v4e3d & v4e40 & v4e43 & v4e46 & v4e49 & v4e4c;
wire v4e4e =  v26 == memory_0[15: 12] && v55a == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] veb = 8'b11000011;
wire v4e4f = veb == v1eb;
wire v4e50 = v29 == v59f;
wire v4e51 = v4e4f & v4e50;
wire v4e52 = v4e51;
wire v4e53 = v4e52;
wire v4e55 = In_register_AF;
wire v4e56 = v4e55 == Out_register_AF;
wire v4e58 = In_register_CF;
wire v4e59 = v4e58 == Out_register_CF;
wire v4e5a = In_error_flag == Out_error_flag;
wire [31:0] v4e5c = In_register_ECX;
wire v4e5d = v4e5c == Out_register_ECX;
wire [31:0] v4e5f = In_register_DSBASE;
wire v4e60 = v4e5f == Out_register_DSBASE;
wire [7:0] v4e62 = In_register_DF;
wire v4e63 = v4e62 == Out_register_DF;
wire [31:0] v4e65 = In_register_ESI;
wire v4e66 = v4e65 == Out_register_ESI;
wire [31:0] v4e68 = In_register_CSBASE;
wire v4e69 = v4e68 == Out_register_CSBASE;
wire v4e6b = In_register_ZF;
wire v4e6c = v4e6b == Out_register_ZF;
wire [31:0] v4e6e = In_register_EAX;
wire v4e6f = v4e6e == Out_register_EAX;
wire [31:0] v4e71 = In_register_EDX;
wire v4e72 = v4e71 == Out_register_EDX;
wire [31:0] v4e74 = In_register_EBX;
wire v4e75 = v4e74 == Out_register_EBX;
wire [31:0] v4e77 = In_register_ESBASE;
wire v4e78 = v4e77 == Out_register_ESBASE;
wire [31:0] v4e79 = memory_0[79: 48];
wire [31:0] v4e7c = v4e79;
wire [31:0] v4e7e = v4e7c;
wire v4e7f = v4e7e == Out_register_EIP;
wire [31:0] v4e81 = In_register_SSBASE;
wire v4e82 = v4e81 == Out_register_SSBASE;
wire [31:0] v4e84 = In_register_EDI;
wire v4e85 = v4e84 == Out_register_EDI;
wire [31:0] v4e87 = v55f;
wire v4e88 = v4e87 == Out_register_ESP;
wire [31:0] v4e8a = In_register_GSBASE;
wire v4e8b = v4e8a == Out_register_GSBASE;
wire [31:0] v4e8d = In_register_FSBASE;
wire v4e8e = v4e8d == Out_register_FSBASE;
wire v4e90 = In_register_PF;
wire v4e91 = v4e90 == Out_register_PF;
wire v4e93 = In_register_OF;
wire v4e94 = v4e93 == Out_register_OF;
wire [31:0] v4e96 = In_register_EBP;
wire v4e97 = v4e96 == Out_register_EBP;
wire v4e99 = In_register_SF;
wire v4e9a = v4e99 == Out_register_SF;
wire v4e9b = v15c & v4e4e & v4e53 & v4e56 & v4e59 & v4e5a & v4e5d & v4e60 & v4e63 & v4e66 & v4e69 & v4e6c & v4e6f & v4e72 & v4e75 & v4e78 & v4e7f & v4e82 & v4e85 & v4e88 & v4e8b & v4e8e & v4e91 & v4e94 & v4e97 & v4e9a;
wire v4e9e = ve4 == v1eb;
wire v4e9f = v35 == v316;
wire v4ea0 = v1b == v318;
wire [2:0] v4ea1 = { v1fa };
wire v4ea2 = v4ea1 == vb;
wire v4ea3 = v4ea1 == vf;
wire v4ea4 = v4ea2 | v4ea3;
wire v4ea5 = v4ea4 ^ v8;
wire [2:0] v4ea6 = { v1fa };
wire v4ea7 = v4ea6 == vb;
wire v4ea8 = v4ea6 == vf;
wire v4ea9 = v4ea7 | v4ea8;
wire v4eaa = v4ea9 ^ v8;
wire v4eab = v4ea5 & v4eaa;
wire v4eac = v4e9e & v4e9f & v4ea0 & v4eab;
wire [2:0] v4e9c = { v1fa };
wire [31:0] v4e9d = ( v4e9c == 3'd0) ? In_register_EAX : 
	( v4e9c == 3'd1) ? In_register_ECX : 
	( v4e9c == 3'd2) ? In_register_EDX : 
	( v4e9c == 3'd3) ? In_register_EBX : 
	( v4e9c == 3'd4) ? v15 : 
	( v4e9c == 3'd5) ? v15 : 
	( v4e9c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4eae = v4e9d;
wire v4eaf =  v2a == memory_0[15: 12] && v4eae == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v4eb0 = In_error_flag == Out_error_flag;
wire v4eb1 = v4eac;
wire v4eb2 = v4eb1;
wire [31:0] v4eb4 = In_register_ESI;
wire v4eb5 = v4eb4 == Out_register_ESI;
wire [31:0] v4eb7 = In_register_CSBASE;
wire v4eb8 = v4eb7 == Out_register_CSBASE;
wire [2:0] v4ece = { v320 };
wire v4ecf = v4ece == v7;
wire v4ed0 = v4ecf;
wire v4ed1 = v4eac & v4ed0;
wire v4ed2 = v4ed1;
wire [2:0] v4eb9 = { v320 };
wire [31:0] v4eba = ( v4eb9 == 3'd0) ? In_register_EAX : 
	( v4eb9 == 3'd1) ? In_register_ECX : 
	( v4eb9 == 3'd2) ? In_register_EDX : 
	( v4eb9 == 3'd3) ? In_register_EBX : 
	( v4eb9 == 3'd4) ? In_register_EAX : 
	( v4eb9 == 3'd5) ? In_register_ECX : 
	( v4eb9 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4ebb = { v320 };
wire v4ebc = v4ebb == vb;
wire v4ebd = v4ebb == v9;
wire v4ebe = v4ebc | v4ebd;
wire v4ebf = v4ebb == vf;
wire v4ec0 = v4ebe | v4ebf;
wire v4ec1 = v4ebb == v11;
wire v4ec2 = v4ec0 | v4ec1;
wire [31:0] v4ec3 = ( v4ec2 == 1'd0) ? v15 : v31;
wire [31:0] v4ec4 = v4eba >> v4ec3;
wire [31:0] v4ec5 = v4ec4 & v32;
wire [31:0] v4ec7 = v4ec5;
wire [7:0] v4ec8 = v4ec7[7:0];
wire [31:0] v4ec9 = memory_0[79: 48];
wire [7:0] v4eca = v4ec9[7:0];
wire [7:0] v4ecb = v4ec8 - v4eca;
wire [31:0] v4ecc = { 24'b000000000000000000000000, v4ecb };
wire [31:0] v4ecd = v5c8 | v4ecc;
wire v4ed6 = v4ece == vb;
wire v4ed7 = v4ed6;
wire v4ed8 = v4eac & v4ed7;
wire v4ed9 = v4ed8;
wire [31:0] v4ed4 = v4ecc << v31;
wire [31:0] v4ed5 = v752 | v4ed4;
wire [31:0] v4edc = ( v8 ) ? In_register_EAX : 
	( v4ed2 ) ? v4ecd : v4ed5;
wire [31:0] v4ede = v4edc;
wire v4edf = v4ede == Out_register_EAX;
wire [2:0] v4ee0_aux = v4ecb[0] + v4ecb[1] + v4ecb[2] + v4ecb[3] + v4ecb[4] + v4ecb[5] + v4ecb[6] + v4ecb[7];
wire v4ee0 = { 5'b00000, v4ee0_aux };
wire [7:0] v4ee1 = v4ee0 & v18;
wire [7:0] v4ee2 = v4ee1 ^ v18;
wire v4ee3 = v4ee2[0:0];
wire v4ee5 = v4ee3;
wire v4ee6 = v4ee5 == Out_register_PF;
wire [31:0] v4ee8 = In_register_EDI;
wire v4ee9 = v4ee8 == Out_register_EDI;
wire v4eeb = v4ece == vf;
wire v4eec = v4eeb;
wire v4eed = v4eac & v4eec;
wire v4eee = v4eed;
wire [31:0] v4eea = v790 | v4ed4;
wire v4ef1 = v4ece == vc;
wire v4ef2 = v4ef1;
wire v4ef3 = v4eac & v4ef2;
wire v4ef4 = v4ef3;
wire [31:0] v4ef0 = v7a0 | v4ecc;
wire [31:0] v4ef7 = ( v8 ) ? In_register_ECX : 
	( v4eee ) ? v4eea : v4ef0;
wire [31:0] v4ef9 = v4ef7;
wire v4efa = v4ef9 == Out_register_ECX;
wire [31:0] v4efc = In_register_EBP;
wire v4efd = v4efc == Out_register_EBP;
wire v4eff = v4ece == vd;
wire v4f00 = v4eff;
wire v4f01 = v4eac & v4f00;
wire v4f02 = v4f01;
wire [31:0] v4efe = v7b8 | v4ecc;
wire v4f05 = v4ece == v9;
wire v4f06 = v4f05;
wire v4f07 = v4eac & v4f06;
wire v4f08 = v4f07;
wire [31:0] v4f04 = v7c8 | v4ed4;
wire [31:0] v4f0b = ( v8 ) ? In_register_EBX : 
	( v4f02 ) ? v4efe : v4f04;
wire [31:0] v4f0d = v4f0b;
wire v4f0e = v4f0d == Out_register_EBX;
wire [31:0] v4f10 = v1c;
wire [31:0] v4f11 = In_register_EIP + v4f10;
wire [31:0] v4f13 = v4f11;
wire v4f14 = v4f13 == Out_register_EIP;
wire [31:0] v4f16 = In_register_SSBASE;
wire v4f17 = v4f16 == Out_register_SSBASE;
wire [31:0] v4f19 = In_register_ESBASE;
wire v4f1a = v4f19 == Out_register_ESBASE;
wire [7:0] v4f1b = v4ecb ^ v4ec8;
wire [7:0] v4f1c = v4f1b >> v33;
wire [7:0] v4f1d = v4eca ^ v4ec8;
wire [7:0] v4f1e = v4f1d >> v33;
wire [7:0] v4f1f = v4f1c + v4f1e;
wire v4f20 = v4f1f == v34;
wire v4f22 = v4f20;
wire v4f23 = v4f22 == Out_register_OF;
wire v4f24 = v4eca > v4ec8;
wire v4f26 = v4f24;
wire v4f27 = v4f26 == Out_register_CF;
wire v4f29 = v4ece == ve;
wire v4f2a = v4f29;
wire v4f2b = v4eac & v4f2a;
wire v4f2c = v4f2b;
wire [31:0] v4f28 = v768 | v4ecc;
wire v4f2f = v4ece == v11;
wire v4f30 = v4f2f;
wire v4f31 = v4eac & v4f30;
wire v4f32 = v4f31;
wire [31:0] v4f2e = v778 | v4ed4;
wire [31:0] v4f35 = ( v8 ) ? In_register_EDX : 
	( v4f2c ) ? v4f28 : v4f2e;
wire [31:0] v4f37 = v4f35;
wire v4f38 = v4f37 == Out_register_EDX;
wire [31:0] v4f3a = In_register_DSBASE;
wire v4f3b = v4f3a == Out_register_DSBASE;
wire [31:0] v4f3d = In_register_GSBASE;
wire v4f3e = v4f3d == Out_register_GSBASE;
wire [31:0] v4f40 = In_register_FSBASE;
wire v4f41 = v4f40 == Out_register_FSBASE;
wire v4f42 = $signed(v4ecb) < $signed(v2c);
wire v4f44 = v4f42;
wire v4f45 = v4f44 == Out_register_SF;
wire [7:0] v4f46 = v4f1d ^ v4ecb;
wire [7:0] v4f47 = v4f46 >> v1d;
wire [7:0] v4f48 = v4f47 & v18;
wire v4f49 = v4f48[0:0];
wire v4f4b = v4f49;
wire v4f4c = v4f4b == Out_register_AF;
wire [31:0] v4f4e = In_register_ESP;
wire v4f4f = v4f4e == Out_register_ESP;
wire [7:0] v4f51 = In_register_DF;
wire v4f52 = v4f51 == Out_register_DF;
wire v4f53 = v4eca == v4ec8;
wire v4f55 = v4f53;
wire v4f56 = v4f55 == Out_register_ZF;
wire v4f57 = v15c & v4eaf & v4eb0 & v4eb5 & v4eb8 & v4edf & v4ee6 & v4ee9 & v4efa & v4eb2 & v4efd & v4f0e & v4f14 & v4f17 & v4f1a & v4f23 & v4f27 & v4f38 & v4f3b & v4f3e & v4f41 & v4f45 & v4f4c & v4f4f & v4f52 & v4f56;
wire [7:0] vec = 8'b00111000;
wire v4f58 = vec == v1eb;
wire v4f59 = v1b == v318;
wire v4f5a = v4f58 & v4f59;
wire v4f64 = v4f5a;
wire v4f65 = v4f64;
wire [31:0] v4f5c = vf4b;
wire [7:0] v4f5d = v4f5c[7:0];
wire [31:0] v4f5f = v477;
wire [7:0] v4f60 = v4f5f[7:0];
wire [7:0] v4f61 = v4f5d - v4f60;
wire [7:0] v4f62 = v4f61 - v65f;
wire v4f63 = $signed(v4f62) < $signed(v2c);
wire v4f67 = v4f63;
wire v4f68 = v4f67 == Out_register_SF;
wire [31:0] v4f69 = { 24'b000000000000000000000000, v4f62 };
wire [31:0] v4f6a = v5c8 | v4f69;
wire [31:0] v4f6d = ( v8 ) ? In_register_EAX : v4f6a;
wire [31:0] v4f6f = v4f6d;
wire v4f70 = v4f6f == Out_register_EAX;
wire [31:0] v4f72 = In_register_FSBASE;
wire v4f73 = v4f72 == Out_register_FSBASE;
wire [31:0] v4f75 = In_register_ESP;
wire v4f76 = v4f75 == Out_register_ESP;
wire v4f77 = v4f61 == v65f;
wire v4f79 = v4f77;
wire v4f7a = v4f79 == Out_register_ZF;
wire [31:0] v4f7c = In_register_CSBASE;
wire v4f7d = v4f7c == Out_register_CSBASE;
wire [31:0] v4f7f = In_register_EBX;
wire v4f80 = v4f7f == Out_register_EBX;
wire [31:0] v4f82 = In_register_ECX;
wire v4f83 = v4f82 == Out_register_ECX;
wire [31:0] v4f85 = In_register_EDI;
wire v4f86 = v4f85 == Out_register_EDI;
wire [31:0] v4f88 = v1c;
wire [31:0] v4f89 = In_register_EIP + v4f88;
wire [31:0] v4f8b = v4f89;
wire v4f8c = v4f8b == Out_register_EIP;
wire [31:0] v4f8e = In_register_ESI;
wire v4f8f = v4f8e == Out_register_ESI;
wire [31:0] v4f91 = In_register_GSBASE;
wire v4f92 = v4f91 == Out_register_GSBASE;
wire v4f93 = In_error_flag == Out_error_flag;
wire [31:0] v4f95 = In_register_EDX;
wire v4f96 = v4f95 == Out_register_EDX;
wire v4f97 = v4f5d < v4f60;
wire v4f98 = v4f61 < v65f;
wire [7:0] v4f99 = { 7'b0000000, v4f98 };
wire [7:0] v4f9a = ( v4f97 == 1'd0) ? v4f99 : v18;
wire v4f9b = v4f9a[0:0];
wire v4f9d = v4f9b;
wire v4f9e = v4f9d == Out_register_CF;
wire [7:0] v4f9f = v4f62 ^ v4f5d;
wire [7:0] v4fa0 = v4f9f >> v33;
wire [7:0] v4fa1 = v4f60 ^ v4f5d;
wire [7:0] v4fa2 = v4fa1 >> v33;
wire [7:0] v4fa3 = v4fa0 + v4fa2;
wire v4fa4 = v4fa3 == v34;
wire v4fa6 = v4fa4;
wire v4fa7 = v4fa6 == Out_register_OF;
wire [31:0] v4fa9 = In_register_ESBASE;
wire v4faa = v4fa9 == Out_register_ESBASE;
wire [31:0] v4fac = In_register_EBP;
wire v4fad = v4fac == Out_register_EBP;
wire [31:0] v4faf = In_register_DSBASE;
wire v4fb0 = v4faf == Out_register_DSBASE;
wire [7:0] v4fb1 = v4f62 ^ v4fa1;
wire [7:0] v4fb2 = v4fb1 >> v1d;
wire [7:0] v4fb3 = v4fb2 & v18;
wire v4fb4 = v4fb3[0:0];
wire v4fb6 = v4fb4;
wire v4fb7 = v4fb6 == Out_register_AF;
wire [7:0] v4fb9 = In_register_DF;
wire v4fba = v4fb9 == Out_register_DF;
wire [2:0] v4fbb_aux = v4f62[0] + v4f62[1] + v4f62[2] + v4f62[3] + v4f62[4] + v4f62[5] + v4f62[6] + v4f62[7];
wire v4fbb = { 5'b00000, v4fbb_aux };
wire [7:0] v4fbc = v4fbb & v18;
wire [7:0] v4fbd = v4fbc ^ v18;
wire v4fbe = v4fbd[0:0];
wire v4fc0 = v4fbe;
wire v4fc1 = v4fc0 == Out_register_PF;
wire [31:0] v4fc3 = In_register_SSBASE;
wire v4fc4 = v4fc3 == Out_register_SSBASE;
wire v4fc5 = v4f68 & v4f70 & v4f73 & v4f76 & v4f7a & v4f7d & v15c & v4f80 & v4f65 & v4f83 & v4f86 & v4f8c & v4f8f & v4f92 & v4f93 & v4f96 & v4f9e & v4fa7 & v4faa & v4fad & v4fb0 & v4fb7 & v4fba & v4fc1 & v4fc4;
wire [10:0] ved = 11'b01011000001;
wire v4fcc = ved == v6d7;
wire v4fcd = v35 == v316;
wire v4fce = v4 == v11b;
wire [2:0] v4fcf = { v13c };
wire v4fd0 = v4fcf == vb;
wire v4fd1 = v4fcf == vf;
wire v4fd2 = v4fd0 | v4fd1;
wire v4fd3 = v4fd2 ^ v8;
wire [2:0] v4fd4 = { v12c };
wire v4fd5 = v4fd4 == vb;
wire v4fd6 = v4fd5;
wire v4fd7 = v4fd6 ^ v8;
wire [2:0] v4fd8 = { v13c };
wire v4fd9 = v4fd8 == vf;
wire v4fda = v4fd9;
wire v4fdb = v4fda ^ v8;
wire v4fdc = v4fd3 & v4fd7 & v4fdb;
wire v4fdd = v4fcc & v4fcd & v4fce & v4fdc;
wire [2:0] v4fc6 = { v13c };
wire [31:0] v4fc7 = ( v4fc6 == 3'd0) ? In_register_EAX : 
	( v4fc6 == 3'd1) ? In_register_ECX : 
	( v4fc6 == 3'd2) ? In_register_EDX : 
	( v4fc6 == 3'd3) ? In_register_EBX : 
	( v4fc6 == 3'd4) ? v15 : 
	( v4fc6 == 3'd5) ? v15 : 
	( v4fc6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v4fc8 = { v12c };
wire [31:0] v4fc9 = ( v4fc8 == 3'd0) ? In_register_EAX : 
	( v4fc8 == 3'd1) ? In_register_ECX : 
	( v4fc8 == 3'd2) ? In_register_EDX : 
	( v4fc8 == 3'd3) ? In_register_EBX : 
	( v4fc8 == 3'd4) ? v15 : 
	( v4fc8 == 3'd5) ? In_register_EBP : 
	( v4fc8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v4fca = v4fc9 << v7f4;
wire [31:0] v4fcb = v4fc7 + v4fca;
wire [31:0] v4fdf = v4fcb;
wire v4fe0 =  v2a == memory_0[15: 12] && v4fdf == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v4fe1 = v4fdd;
wire v4fe2 = v4fe1;
wire [31:0] v4fe4 = In_register_ESI;
wire v4fe5 = v4fe4 == Out_register_ESI;
wire [2:0] v4fe6 = { v320 };
wire [31:0] v4fe7 = ( v4fe6 == 3'd0) ? In_register_EAX : 
	( v4fe6 == 3'd1) ? In_register_ECX : 
	( v4fe6 == 3'd2) ? In_register_EDX : 
	( v4fe6 == 3'd3) ? In_register_EBX : 
	( v4fe6 == 3'd4) ? In_register_EAX : 
	( v4fe6 == 3'd5) ? In_register_ECX : 
	( v4fe6 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v4fe8 = { v320 };
wire v4fe9 = v4fe8 == vb;
wire v4fea = v4fe8 == v9;
wire v4feb = v4fe9 | v4fea;
wire v4fec = v4fe8 == vf;
wire v4fed = v4feb | v4fec;
wire v4fee = v4fe8 == v11;
wire v4fef = v4fed | v4fee;
wire [31:0] v4ff0 = ( v4fef == 1'd0) ? v15 : v31;
wire [31:0] v4ff1 = v4fe7 >> v4ff0;
wire [31:0] v4ff2 = v4ff1 & v32;
wire [31:0] v4ff4 = v4ff2;
wire [7:0] v4ff5 = v4ff4[7:0];
wire [31:0] v4ff6 = memory_0[79: 48];
wire [7:0] v4ff7 = v4ff6[7:0];
wire [7:0] v4ff8 = v4ff5 - v4ff7;
wire [7:0] v4ff9 = v4ff8 - v65f;
wire [2:0] v4ffa_aux = v4ff9[0] + v4ff9[1] + v4ff9[2] + v4ff9[3] + v4ff9[4] + v4ff9[5] + v4ff9[6] + v4ff9[7];
wire v4ffa = { 5'b00000, v4ffa_aux };
wire [7:0] v4ffb = v4ffa & v18;
wire [7:0] v4ffc = v4ffb ^ v18;
wire v4ffd = v4ffc[0:0];
wire v4fff = v4ffd;
wire v5000 = v4fff == Out_register_PF;
wire [2:0] v5003 = { v320 };
wire v5004 = v5003 == v7;
wire v5005 = v5004;
wire v5006 = v4fdd & v5005;
wire v5007 = v5006;
wire [31:0] v5001 = { 24'b000000000000000000000000, v4ff9 };
wire [31:0] v5002 = v5c8 | v5001;
wire v500b = v5003 == vb;
wire v500c = v500b;
wire v500d = v4fdd & v500c;
wire v500e = v500d;
wire [31:0] v5009 = v5001 << v31;
wire [31:0] v500a = v752 | v5009;
wire [31:0] v5011 = ( v8 ) ? In_register_EAX : 
	( v5007 ) ? v5002 : v500a;
wire [31:0] v5013 = v5011;
wire v5014 = v5013 == Out_register_EAX;
wire [7:0] v5015 = v4ff9 ^ v4ff5;
wire [7:0] v5016 = v5015 >> v33;
wire [7:0] v5017 = v4ff7 ^ v4ff5;
wire [7:0] v5018 = v5017 >> v33;
wire [7:0] v5019 = v5016 + v5018;
wire v501a = v5019 == v34;
wire v501c = v501a;
wire v501d = v501c == Out_register_OF;
wire v5025 = v5003 == v9;
wire v5026 = v5025;
wire v5027 = v4fdd & v5026;
wire v5028 = v5027;
wire [31:0] v5024 = v7c8 | v5009;
wire v501f = v5003 == vd;
wire v5020 = v501f;
wire v5021 = v4fdd & v5020;
wire v5022 = v5021;
wire [31:0] v501e = v7b8 | v5001;
wire [31:0] v502b = ( v8 ) ? In_register_EBX : 
	( v5028 ) ? v5024 : v501e;
wire [31:0] v502d = v502b;
wire v502e = v502d == Out_register_EBX;
wire v502f = v4ff8 == v65f;
wire v5031 = v502f;
wire v5032 = v5031 == Out_register_ZF;
wire [31:0] v5034 = In_register_ESP;
wire v5035 = v5034 == Out_register_ESP;
wire v5037 = v5003 == vf;
wire v5038 = v5037;
wire v5039 = v4fdd & v5038;
wire v503a = v5039;
wire [31:0] v5036 = v790 | v5009;
wire v503d = v5003 == vc;
wire v503e = v503d;
wire v503f = v4fdd & v503e;
wire v5040 = v503f;
wire [31:0] v503c = v7a0 | v5001;
wire [31:0] v5043 = ( v8 ) ? In_register_ECX : 
	( v503a ) ? v5036 : v503c;
wire [31:0] v5045 = v5043;
wire v5046 = v5045 == Out_register_ECX;
wire [31:0] v5048 = v10;
wire [31:0] v5049 = In_register_EIP + v5048;
wire [31:0] v504b = v5049;
wire v504c = v504b == Out_register_EIP;
wire v504e = v5003 == ve;
wire v504f = v504e;
wire v5050 = v4fdd & v504f;
wire v5051 = v5050;
wire [31:0] v504d = v768 | v5001;
wire v5054 = v5003 == v11;
wire v5055 = v5054;
wire v5056 = v4fdd & v5055;
wire v5057 = v5056;
wire [31:0] v5053 = v778 | v5009;
wire [31:0] v505a = ( v8 ) ? In_register_EDX : 
	( v5051 ) ? v504d : v5053;
wire [31:0] v505c = v505a;
wire v505d = v505c == Out_register_EDX;
wire [31:0] v505f = In_register_EDI;
wire v5060 = v505f == Out_register_EDI;
wire [31:0] v5062 = In_register_EBP;
wire v5063 = v5062 == Out_register_EBP;
wire [31:0] v5065 = In_register_CSBASE;
wire v5066 = v5065 == Out_register_CSBASE;
wire [7:0] v5068 = In_register_DF;
wire v5069 = v5068 == Out_register_DF;
wire [31:0] v506b = In_register_SSBASE;
wire v506c = v506b == Out_register_SSBASE;
wire [31:0] v506e = In_register_DSBASE;
wire v506f = v506e == Out_register_DSBASE;
wire [31:0] v5071 = In_register_GSBASE;
wire v5072 = v5071 == Out_register_GSBASE;
wire [31:0] v5074 = In_register_ESBASE;
wire v5075 = v5074 == Out_register_ESBASE;
wire [31:0] v5077 = In_register_FSBASE;
wire v5078 = v5077 == Out_register_FSBASE;
wire v5079 = In_error_flag == Out_error_flag;
wire [7:0] v507a = v4ff9 ^ v5017;
wire [7:0] v507b = v507a >> v1d;
wire [7:0] v507c = v507b & v18;
wire v507d = v507c[0:0];
wire v507f = v507d;
wire v5080 = v507f == Out_register_AF;
wire v5081 = v4ff7 > v4ff5;
wire v5082 = v4ff8 < v65f;
wire [7:0] v5083 = { 7'b0000000, v5082 };
wire [7:0] v5084 = ( v5081 == 1'd0) ? v5083 : v18;
wire v5085 = v5084[0:0];
wire v5087 = v5085;
wire v5088 = v5087 == Out_register_CF;
wire v5089 = $signed(v4ff9) < $signed(v2c);
wire v508b = v5089;
wire v508c = v508b == Out_register_SF;
wire v508d = v15c & v4fe0 & v4fe5 & v5000 & v5014 & v501d & v502e & v5032 & v5035 & v5046 & v504c & v505d & v5060 & v5063 & v5066 & v5069 & v4fe2 & v506c & v506f & v5072 & v5075 & v5078 & v5079 & v5080 & v5088 & v508c;
wire [7:0] vee = 8'b11011000;
wire v508e = vee == v1eb;
wire v508f = v30 == v316;
wire v5090 = v4 == v11b;
wire [2:0] v5091 = { v1fa };
wire v5092 = v5091 == vb;
wire v5093 = v5092;
wire v5094 = v5093 ^ v8;
wire [2:0] v5095 = { v1fa };
wire v5096 = v5095 == vb;
wire v5097 = v5096;
wire v5098 = v5097 ^ v8;
wire v5099 = v5094 & v5098;
wire v509a = v508e & v508f & v5090 & v5099;
wire v509b = vee == v1eb;
wire v509c = v8 == v829;
wire v509d = v35 == v316;
wire v509e = v1b == v318;
wire v509f = v509b & v509c & v509d & v509e;
wire v50a0 = vee == v1eb;
wire v50a1 = v2f == v316;
wire v50a2 = v14 == v1ef;
wire [2:0] v50a3 = { v1fa };
wire v50a4 = v50a3 == vb;
wire v50a5 = v50a4;
wire v50a6 = v50a5 ^ v8;
wire [2:0] v50a7 = { v1fa };
wire v50a8 = v50a7 == vb;
wire v50a9 = v50a8;
wire v50aa = v50a9 ^ v8;
wire v50ab = v50a6 & v50aa;
wire v50ac = v50a0 & v50a1 & v50a2 & v50ab;
wire v50ad = v509a | v509f | v50ac;
wire v50ae = v50ad;
wire [2:0] v50bc = { v320 };
wire v50bd = v50bc == v11;
wire v50be = v50bd;
wire v50bf = v509a & v50be;
wire [2:0] v50c0 = { v320 };
wire v50c1 = v50c0 == v11;
wire v50c2 = v50c1;
wire v50c3 = v509f & v50c2;
wire [2:0] v50c4 = { v320 };
wire v50c5 = v50c4 == v11;
wire v50c6 = v50c5;
wire v50c7 = v50ac & v50c6;
wire v50c8 = v50bf | v50c3 | v50c7;
wire [2:0] v50af = { v320 };
wire [31:0] v50b0 = ( v50af == 3'd0) ? In_register_EAX : 
	( v50af == 3'd1) ? In_register_ECX : 
	( v50af == 3'd2) ? In_register_EDX : 
	( v50af == 3'd3) ? In_register_EBX : 
	( v50af == 3'd4) ? In_register_ESP : 
	( v50af == 3'd5) ? In_register_EBP : 
	( v50af == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v50b2 = { v320 };
wire [31:0] v50b3 = ( v50b2 == 3'd0) ? In_register_EAX : 
	( v50b2 == 3'd1) ? In_register_ECX : 
	( v50b2 == 3'd2) ? In_register_EDX : 
	( v50b2 == 3'd3) ? In_register_EBX : 
	( v50b2 == 3'd4) ? In_register_ESP : 
	( v50b2 == 3'd5) ? In_register_EBP : 
	( v50b2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v50b5 = { v320 };
wire [31:0] v50b6 = ( v50b5 == 3'd0) ? In_register_EAX : 
	( v50b5 == 3'd1) ? In_register_ECX : 
	( v50b5 == 3'd2) ? In_register_EDX : 
	( v50b5 == 3'd3) ? In_register_EBX : 
	( v50b5 == 3'd4) ? In_register_ESP : 
	( v50b5 == 3'd5) ? In_register_EBP : 
	( v50b5 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v50b8 = ( v509a ) ? v50b0 : 
	( v509f ) ? v50b3 : v50b6;
wire [31:0] v50b9 = memory_0[79: 48];
wire [31:0] v50ba = v50b8 - v50b9;
wire [31:0] v50bb = v50ba - vb11;
wire [31:0] v50cb = ( v8 ) ? In_register_ESI : v50bb;
wire [31:0] v50cd = v50cb;
wire v50ce = v50cd == Out_register_ESI;
wire [1:0] v50d3 = { v889 , v888 };
wire [31:0] v50d4 = ( v50d3 == 2'd0) ? In_register_EDX : 
	( v50d3 == 2'd1) ? In_register_ESI : 
	( v50d3 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v50cf = { v1fa };
wire [31:0] v50d0 = ( v50cf == 3'd0) ? In_register_EAX : 
	( v50cf == 3'd1) ? In_register_ECX : 
	( v50cf == 3'd2) ? In_register_EDX : 
	( v50cf == 3'd3) ? In_register_EBX : 
	( v50cf == 3'd4) ? v15 : 
	( v50cf == 3'd5) ? In_register_EBP : 
	( v50cf == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v50d1 = v50d0 + v63a;
wire [2:0] v50d6 = { v1fa };
wire [31:0] v50d7 = ( v50d6 == 3'd0) ? In_register_EAX : 
	( v50d6 == 3'd1) ? In_register_ECX : 
	( v50d6 == 3'd2) ? In_register_EDX : 
	( v50d6 == 3'd3) ? In_register_EBX : 
	( v50d6 == 3'd4) ? v15 : 
	( v50d6 == 3'd5) ? In_register_EBP : 
	( v50d6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v50d8 = v50d7 + v1f7;
wire [31:0] v50da = ( v509f ) ? v50d4 : 
	( v509a ) ? v50d1 : v50d8;
wire v50db =  v26 == memory_0[15: 12] && v50da == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [7:0] v50dd = In_register_DF;
wire v50de = v50dd == Out_register_DF;
wire v50df = In_error_flag == Out_error_flag;
wire v50e0 = v50bc == v9;
wire v50e1 = v50e0;
wire v50e2 = v509a & v50e1;
wire v50e3 = v50c0 == v9;
wire v50e4 = v50e3;
wire v50e5 = v509f & v50e4;
wire v50e6 = v50c4 == v9;
wire v50e7 = v50e6;
wire v50e8 = v50ac & v50e7;
wire v50e9 = v50e2 | v50e5 | v50e8;
wire [31:0] v50ec = ( v8 ) ? In_register_EDI : v50bb;
wire [31:0] v50ee = v50ec;
wire v50ef = v50ee == Out_register_EDI;
wire v50f0 = v50bc == vd;
wire v50f1 = v50f0;
wire v50f2 = v509a & v50f1;
wire v50f3 = v50c0 == vd;
wire v50f4 = v50f3;
wire v50f5 = v509f & v50f4;
wire v50f6 = v50c4 == vd;
wire v50f7 = v50f6;
wire v50f8 = v50ac & v50f7;
wire v50f9 = v50f2 | v50f5 | v50f8;
wire [31:0] v50fc = ( v8 ) ? In_register_EBX : v50bb;
wire [31:0] v50fe = v50fc;
wire v50ff = v50fe == Out_register_EBX;
wire v5100 = v50b9 > v50b8;
wire v5101 = v50ba < vb11;
wire [7:0] v5102 = { 7'b0000000, v5101 };
wire [7:0] v5103 = ( v5100 == 1'd0) ? v5102 : v18;
wire v5104 = v5103[0:0];
wire v5106 = v5104;
wire v5107 = v5106 == Out_register_CF;
wire v5108 = v50bc == v7;
wire v5109 = v5108;
wire v510a = v509a & v5109;
wire v510b = v50c0 == v7;
wire v510c = v510b;
wire v510d = v509f & v510c;
wire v510e = v50c4 == v7;
wire v510f = v510e;
wire v5110 = v50ac & v510f;
wire v5111 = v510a | v510d | v5110;
wire [31:0] v5114 = ( v8 ) ? In_register_EAX : v50bb;
wire [31:0] v5116 = v5114;
wire v5117 = v5116 == Out_register_EAX;
wire v5118 = v50bc == vc;
wire v5119 = v5118;
wire v511a = v509a & v5119;
wire v511b = v50c0 == vc;
wire v511c = v511b;
wire v511d = v509f & v511c;
wire v511e = v50c4 == vc;
wire v511f = v511e;
wire v5120 = v50ac & v511f;
wire v5121 = v511a | v511d | v5120;
wire [31:0] v5124 = ( v8 ) ? In_register_ECX : v50bb;
wire [31:0] v5126 = v5124;
wire v5127 = v5126 == Out_register_ECX;
wire [7:0] v5128 = v50bb[7:0];
wire [2:0] v5129_aux = v5128[0] + v5128[1] + v5128[2] + v5128[3] + v5128[4] + v5128[5] + v5128[6] + v5128[7];
wire v5129 = { 5'b00000, v5129_aux };
wire [7:0] v512a = v5129 & v18;
wire [7:0] v512b = v512a ^ v18;
wire v512c = v512b[0:0];
wire v512e = v512c;
wire v512f = v512e == Out_register_PF;
wire [31:0] v5131 = In_register_DSBASE;
wire v5132 = v5131 == Out_register_DSBASE;
wire v5133 = v50bc == ve;
wire v5134 = v5133;
wire v5135 = v509a & v5134;
wire v5136 = v50c0 == ve;
wire v5137 = v5136;
wire v5138 = v509f & v5137;
wire v5139 = v50c4 == ve;
wire v513a = v5139;
wire v513b = v50ac & v513a;
wire v513c = v5135 | v5138 | v513b;
wire [31:0] v513f = ( v8 ) ? In_register_EDX : v50bb;
wire [31:0] v5141 = v513f;
wire v5142 = v5141 == Out_register_EDX;
wire v5143 = $signed(v50bb) < $signed(v15);
wire v5145 = v5143;
wire v5146 = v5145 == Out_register_SF;
wire [31:0] v5148 = In_register_GSBASE;
wire v5149 = v5148 == Out_register_GSBASE;
wire v514a = v50bc == vb;
wire v514b = v514a;
wire v514c = v509a & v514b;
wire v514d = v50c0 == vb;
wire v514e = v514d;
wire v514f = v509f & v514e;
wire v5150 = v50c4 == vb;
wire v5151 = v5150;
wire v5152 = v50ac & v5151;
wire v5153 = v514c | v514f | v5152;
wire [31:0] v5156 = ( v8 ) ? In_register_ESP : v50bb;
wire [31:0] v5158 = v5156;
wire v5159 = v5158 == Out_register_ESP;
wire v515a = v50bc == vf;
wire v515b = v515a;
wire v515c = v509a & v515b;
wire v515d = v50c0 == vf;
wire v515e = v515d;
wire v515f = v509f & v515e;
wire v5160 = v50c4 == vf;
wire v5161 = v5160;
wire v5162 = v50ac & v5161;
wire v5163 = v515c | v515f | v5162;
wire [31:0] v5166 = ( v8 ) ? In_register_EBP : v50bb;
wire [31:0] v5168 = v5166;
wire v5169 = v5168 == Out_register_EBP;
wire [31:0] v516d = ( v509f ) ? v1c : 
	( v50ac ) ? v16 : v10;
wire [31:0] v516e = In_register_EIP + v516d;
wire [31:0] v5170 = v516e;
wire v5171 = v5170 == Out_register_EIP;
wire [31:0] v5173 = In_register_CSBASE;
wire v5174 = v5173 == Out_register_CSBASE;
wire [31:0] v5176 = In_register_SSBASE;
wire v5177 = v5176 == Out_register_SSBASE;
wire [31:0] v5179 = In_register_ESBASE;
wire v517a = v5179 == Out_register_ESBASE;
wire [31:0] v517c = In_register_FSBASE;
wire v517d = v517c == Out_register_FSBASE;
wire [31:0] v517e = v50b9 ^ v50b8;
wire [31:0] v517f = v50bb ^ v517e;
wire [7:0] v5180 = v517f[7:0];
wire [7:0] v5181 = v5180 >> v1d;
wire [7:0] v5182 = v5181 & v18;
wire v5183 = v5182[0:0];
wire v5185 = v5183;
wire v5186 = v5185 == Out_register_AF;
wire [31:0] v5187 = v50bb ^ v50b8;
wire [31:0] v5188 = v5187 >> v1e;
wire [31:0] v5189 = v517e >> v1e;
wire [31:0] v518a = v5188 + v5189;
wire v518b = v518a == v1c;
wire v518d = v518b;
wire v518e = v518d == Out_register_OF;
wire v518f = v50ba == vb11;
wire v5191 = v518f;
wire v5192 = v5191 == Out_register_ZF;
wire v5193 = v50ae & v50ce & v50db & v50de & v50df & v50ef & v50ff & v5107 & v5117 & v5127 & v512f & v5132 & v5142 & v5146 & v5149 & v5159 & v5169 & v15c & v5171 & v5174 & v5177 & v517a & v517d & v5186 & v518e & v5192;
wire [7:0] vef = 8'b01110101;
wire v5194 = vef == v1eb;
wire v5195 = v29 == v59f;
wire v5196 = v5194 & v5195;
wire v5197 = v5196;
wire v5198 = v5197;
wire [31:0] v519a = In_register_GSBASE;
wire v519b = v519a == Out_register_GSBASE;
wire [31:0] v519c = memory_0[79: 48];
wire [7:0] v519d = v519c[7:0];
wire [7:0] v519e = vf4a - v519d;
wire [2:0] v519f_aux = v519e[0] + v519e[1] + v519e[2] + v519e[3] + v519e[4] + v519e[5] + v519e[6] + v519e[7];
wire v519f = { 5'b00000, v519f_aux };
wire [7:0] v51a0 = v519f & v18;
wire [7:0] v51a1 = v51a0 ^ v18;
wire v51a2 = v51a1[0:0];
wire v51a4 = v51a2;
wire v51a5 = v51a4 == Out_register_PF;
wire v51a6 = vf4a < v519d;
wire v51a8 = v51a6;
wire v51a9 = v51a8 == Out_register_CF;
wire [31:0] v51ab = In_register_ESI;
wire v51ac = v51ab == Out_register_ESI;
wire [31:0] v51ae = In_register_CSBASE;
wire v51af = v51ae == Out_register_CSBASE;
wire [31:0] v51b1 = v1b5d;
wire v51b2 = v51b1 == Out_register_EDI;
wire [31:0] v51b4 = In_register_EBX;
wire v51b5 = v51b4 == Out_register_EBX;
wire v51b6 =  v2a == memory_0[15: 12] && v1b8e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v51b8 = In_register_EAX;
wire v51b9 = v51b8 == Out_register_EAX;
wire [31:0] v51bb = In_register_EBP;
wire v51bc = v51bb == Out_register_EBP;
wire [7:0] v51bd = v519d ^ vf4a;
wire [7:0] v51be = v51bd ^ v519e;
wire [7:0] v51bf = v51be >> v1d;
wire [7:0] v51c0 = v51bf & v18;
wire v51c1 = v51c0[0:0];
wire v51c3 = v51c1;
wire v51c4 = v51c3 == Out_register_AF;
wire [31:0] v51c6 = In_register_ESP;
wire v51c7 = v51c6 == Out_register_ESP;
wire [31:0] v51c9 = In_register_ECX;
wire v51ca = v51c9 == Out_register_ECX;
wire [31:0] v51cc = In_register_EDX;
wire v51cd = v51cc == Out_register_EDX;
wire v51ce = In_error_flag == Out_error_flag;
wire [31:0] v51d0 = v2b;
wire [31:0] v51d1 = In_register_EIP + v51d0;
wire [31:0] v51d3 = v51d1;
wire v51d4 = v51d3 == Out_register_EIP;
wire [7:0] v51d5 = v519e ^ vf4a;
wire [7:0] v51d6 = v51d5 >> v33;
wire [7:0] v51d7 = v51bd >> v33;
wire [7:0] v51d8 = v51d6 + v51d7;
wire v51d9 = v51d8 == v34;
wire v51db = v51d9;
wire v51dc = v51db == Out_register_OF;
wire [31:0] v51de = In_register_SSBASE;
wire v51df = v51de == Out_register_SSBASE;
wire [31:0] v51e1 = In_register_ESBASE;
wire v51e2 = v51e1 == Out_register_ESBASE;
wire [31:0] v51e4 = In_register_DSBASE;
wire v51e5 = v51e4 == Out_register_DSBASE;
wire [31:0] v51e7 = In_register_FSBASE;
wire v51e8 = v51e7 == Out_register_FSBASE;
wire [7:0] v51ea = In_register_DF;
wire v51eb = v51ea == Out_register_DF;
wire v51ec = $signed(v519e) < $signed(v2c);
wire v51ee = v51ec;
wire v51ef = v51ee == Out_register_SF;
wire v51f0 = vf4a == v519d;
wire v51f2 = v51f0;
wire v51f3 = v51f2 == Out_register_ZF;
wire v51f4 = v5198 & v519b & v51a5 & v51a9 & v51ac & v15c & v51af & v51b2 & v51b5 & v51b6 & v51b9 & v51bc & v51c4 & v51c7 & v51ca & v51cd & v51ce & v51d4 & v51dc & v51df & v51e2 & v51e5 & v51e8 & v51eb & v51ef & v51f3;
wire v51f5 = v40 == v1eb;
wire v51f6 = v19 == v1ed;
wire v51f7 = v4 == v11b;
wire v51f8 = v51f5 & v51f6 & v51f7;
wire v51f9 = v51f8;
wire v51fa = v51f9;
wire v51fc = v17;
wire v51fd = v51fc == Out_register_CF;
wire [2:0] v5205 = { v1fa };
wire v5206 = v5205 == vd;
wire v5207 = v5206;
wire v5208 = v51f8 & v5207;
wire v5209 = v5208;
wire [31:0] v51ff = v63a;
wire [2:0] v5200 = { v1fa };
wire [31:0] v5201 = ( v5200 == 3'd0) ? In_register_EAX : 
	( v5200 == 3'd1) ? In_register_ECX : 
	( v5200 == 3'd2) ? In_register_EDX : 
	( v5200 == 3'd3) ? In_register_EBX : 
	( v5200 == 3'd4) ? In_register_ESP : 
	( v5200 == 3'd5) ? In_register_EBP : 
	( v5200 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5203 = v5201;
wire [31:0] v5204 = v51ff | v5203;
wire [31:0] v520c = ( v8 ) ? In_register_EBX : v5204;
wire [31:0] v520e = v520c;
wire v520f = v520e == Out_register_EBX;
wire v5210 = v5205 == v7;
wire v5211 = v5210;
wire v5212 = v51f8 & v5211;
wire v5213 = v5212;
wire [31:0] v5216 = ( v8 ) ? In_register_EAX : v5204;
wire [31:0] v5218 = v5216;
wire v5219 = v5218 == Out_register_EAX;
wire [31:0] v521b = In_register_ESBASE;
wire v521c = v521b == Out_register_ESBASE;
wire v521d = v5204 == v15;
wire v521f = v521d;
wire v5220 = v521f == Out_register_ZF;
wire [7:0] v5221 = v5204[7:0];
wire [2:0] v5222_aux = v5221[0] + v5221[1] + v5221[2] + v5221[3] + v5221[4] + v5221[5] + v5221[6] + v5221[7];
wire v5222 = { 5'b00000, v5222_aux };
wire [7:0] v5223 = v5222 & v18;
wire [7:0] v5224 = v5223 ^ v18;
wire v5225 = v5224[0:0];
wire v5227 = v5225;
wire v5228 = v5227 == Out_register_PF;
wire v522a = In_register_AF;
wire v522b = v522a == Out_register_AF;
wire v522c = v5205 == v9;
wire v522d = v522c;
wire v522e = v51f8 & v522d;
wire v522f = v522e;
wire [31:0] v5232 = ( v8 ) ? In_register_EDI : v5204;
wire [31:0] v5234 = v5232;
wire v5235 = v5234 == Out_register_EDI;
wire v5236 = v5205 == vb;
wire v5237 = v5236;
wire v5238 = v51f8 & v5237;
wire v5239 = v5238;
wire [31:0] v523c = ( v8 ) ? In_register_ESP : v5204;
wire [31:0] v523e = v523c;
wire v523f = v523e == Out_register_ESP;
wire [31:0] v5241 = v10;
wire [31:0] v5242 = In_register_EIP + v5241;
wire [31:0] v5244 = v5242;
wire v5245 = v5244 == Out_register_EIP;
wire v5246 = v5205 == ve;
wire v5247 = v5246;
wire v5248 = v51f8 & v5247;
wire v5249 = v5248;
wire [31:0] v524c = ( v8 ) ? In_register_EDX : v5204;
wire [31:0] v524e = v524c;
wire v524f = v524e == Out_register_EDX;
wire [31:0] v5251 = In_register_CSBASE;
wire v5252 = v5251 == Out_register_CSBASE;
wire v5253 = $signed(v5204) < $signed(v15);
wire v5255 = v5253;
wire v5256 = v5255 == Out_register_SF;
wire [31:0] v5258 = In_register_DSBASE;
wire v5259 = v5258 == Out_register_DSBASE;
wire v525a = v5205 == v11;
wire v525b = v525a;
wire v525c = v51f8 & v525b;
wire v525d = v525c;
wire [31:0] v5260 = ( v8 ) ? In_register_ESI : v5204;
wire [31:0] v5262 = v5260;
wire v5263 = v5262 == Out_register_ESI;
wire v5264 = v5205 == vf;
wire v5265 = v5264;
wire v5266 = v51f8 & v5265;
wire v5267 = v5266;
wire [31:0] v526a = ( v8 ) ? In_register_EBP : v5204;
wire [31:0] v526c = v526a;
wire v526d = v526c == Out_register_EBP;
wire [31:0] v526f = In_register_GSBASE;
wire v5270 = v526f == Out_register_GSBASE;
wire v5271 = v17;
wire v5272 = v5271 == Out_register_OF;
wire [31:0] v5274 = In_register_FSBASE;
wire v5275 = v5274 == Out_register_FSBASE;
wire [7:0] v5277 = In_register_DF;
wire v5278 = v5277 == Out_register_DF;
wire v5279 = v5205 == vc;
wire v527a = v5279;
wire v527b = v51f8 & v527a;
wire v527c = v527b;
wire [31:0] v527f = ( v8 ) ? In_register_ECX : v5204;
wire [31:0] v5281 = v527f;
wire v5282 = v5281 == Out_register_ECX;
wire [31:0] v5284 = In_register_SSBASE;
wire v5285 = v5284 == Out_register_SSBASE;
wire v5286 = In_error_flag == Out_error_flag;
wire v5287 = v51fa & v51fd & v15c & v520f & v5219 & v521c & v5220 & v5228 & v522b & v5235 & v523f & v5245 & v524f & v5252 & v5256 & v5259 & v5263 & v526d & v5270 & v5272 & v5275 & v5278 & v5282 & v5285 & v5286;
wire [7:0] vf0 = 8'b00001110;
wire v5288 = vf0 == v1eb;
wire v5289 = v1b == v318;
wire v528a = v5288 & v5289;
wire v528b = v528a;
wire v528c = v528b;
wire [31:0] v528e = In_register_EBX;
wire v528f = v528e == Out_register_EBX;
wire [31:0] v5291 = In_register_EDI;
wire v5292 = v5291 == Out_register_EDI;
wire [31:0] v5294 = In_register_GSBASE;
wire v5295 = v5294 == Out_register_GSBASE;
wire [31:0] v5297 = In_register_DSBASE;
wire v5298 = v5297 == Out_register_DSBASE;
wire v5299 = In_error_flag == Out_error_flag;
wire [31:0] v529c = v1c;
wire [31:0] v529d = In_register_EIP + v529c;
wire v529a = v28c3 == v2c;
wire [31:0] v529e = v529d + v477;
wire [31:0] v52a0 = v529e;
wire [31:0] v52a2 = v529d;
wire [31:0] v52a3 = ( v529a == 1'd0) ? v52a0 : v52a2;
wire [31:0] v52a6 = ( v8 ) ? v529d : v52a3;
wire [31:0] v52a8 = v52a6;
wire v52a9 = v52a8 == Out_register_EIP;
wire [31:0] v52ab = In_register_SSBASE;
wire v52ac = v52ab == Out_register_SSBASE;
wire [31:0] v52ae = In_register_EAX;
wire v52af = v52ae == Out_register_EAX;
wire v52b1 = In_register_OF;
wire v52b2 = v52b1 == Out_register_OF;
wire [31:0] v52b4 = In_register_ECX;
wire v52b5 = v52b4 == Out_register_ECX;
wire [31:0] v52b7 = In_register_EBP;
wire v52b8 = v52b7 == Out_register_EBP;
wire [31:0] v52ba = In_register_ESI;
wire v52bb = v52ba == Out_register_ESI;
wire [31:0] v52bd = In_register_EDX;
wire v52be = v52bd == Out_register_EDX;
wire [31:0] v52c0 = In_register_ESP;
wire v52c1 = v52c0 == Out_register_ESP;
wire [31:0] v52c3 = In_register_CSBASE;
wire v52c4 = v52c3 == Out_register_CSBASE;
wire [31:0] v52c6 = In_register_ESBASE;
wire v52c7 = v52c6 == Out_register_ESBASE;
wire v52c9 = In_register_SF;
wire v52ca = v52c9 == Out_register_SF;
wire [31:0] v52cc = In_register_FSBASE;
wire v52cd = v52cc == Out_register_FSBASE;
wire v52cf = In_register_AF;
wire v52d0 = v52cf == Out_register_AF;
wire v52d2 = In_register_CF;
wire v52d3 = v52d2 == Out_register_CF;
wire [7:0] v52d5 = In_register_DF;
wire v52d6 = v52d5 == Out_register_DF;
wire v52d8 = In_register_PF;
wire v52d9 = v52d8 == Out_register_PF;
wire v52db = In_register_ZF;
wire v52dc = v52db == Out_register_ZF;
wire v52dd = v528f & v5292 & v5295 & v5298 & v5299 & v52a9 & v52ac & v52af & v528c & v52b2 & v52b5 & v52b8 & v52bb & v52be & v52c1 & v52c4 & v52c7 & v52ca & v52cd & v52d0 & v52d3 & v52d6 & v15c & v52d9 & v52dc;
wire [7:0] vf1 = 8'b11010100;
wire v52e0 = vf1 == v1eb;
wire v52e1 = v30 == v316;
wire v52e2 = v4 == v11b;
wire [2:0] v52e3 = { v1fa };
wire v52e4 = v52e3 == vb;
wire v52e5 = v52e3 == vf;
wire v52e6 = v52e4 | v52e5;
wire v52e7 = v52e6 ^ v8;
wire [2:0] v52e8 = { v1fa };
wire v52e9 = v52e8 == vb;
wire v52ea = v52e9;
wire v52eb = v52ea ^ v8;
wire v52ec = v52e7 & v52eb;
wire v52ed = v52e0 & v52e1 & v52e2 & v52ec;
wire v52f1 = vf1 == v1eb;
wire v52f2 = v2f == v316;
wire v52f3 = v14 == v1ef;
wire [2:0] v52f4 = { v1fa };
wire v52f5 = v52f4 == vb;
wire v52f6 = v52f4 == vf;
wire v52f7 = v52f5 | v52f6;
wire v52f8 = v52f7 ^ v8;
wire [2:0] v52f9 = { v1fa };
wire v52fa = v52f9 == vb;
wire v52fb = v52fa;
wire v52fc = v52fb ^ v8;
wire v52fd = v52f8 & v52fc;
wire v52fe = v52f1 & v52f2 & v52f3 & v52fd;
wire v530f = v52ed | v52fe;
wire v5310 = v530f;
wire [2:0] v5303 = { v320 };
wire v5304 = v5303 == vb;
wire v5305 = v5304;
wire v5306 = v52ed & v5305;
wire [2:0] v5307 = { v320 };
wire v5308 = v5307 == vb;
wire v5309 = v5308;
wire v530a = v52fe & v5309;
wire v530b = v5306 | v530a;
wire [2:0] v52de = { v320 };
wire [31:0] v52df = ( v52de == 3'd0) ? In_register_EAX : 
	( v52de == 3'd1) ? In_register_ECX : 
	( v52de == 3'd2) ? In_register_EDX : 
	( v52de == 3'd3) ? In_register_EBX : 
	( v52de == 3'd4) ? In_register_ESP : 
	( v52de == 3'd5) ? In_register_EBP : 
	( v52de == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v52ef = { v320 };
wire [31:0] v52f0 = ( v52ef == 3'd0) ? In_register_EAX : 
	( v52ef == 3'd1) ? In_register_ECX : 
	( v52ef == 3'd2) ? In_register_EDX : 
	( v52ef == 3'd3) ? In_register_EBX : 
	( v52ef == 3'd4) ? In_register_ESP : 
	( v52ef == 3'd5) ? In_register_EBP : 
	( v52ef == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5300 = ( v52ed ) ? v52df : v52f0;
wire [31:0] v5301 = memory_0[79: 48];
wire [31:0] v5302 = v5300 - v5301;
wire [31:0] v530e = ( v8 ) ? In_register_ESP : v5302;
wire [31:0] v5312 = v530e;
wire v5313 = v5312 == Out_register_ESP;
wire [2:0] v5314 = { v1fa };
wire [31:0] v5315 = ( v5314 == 3'd0) ? In_register_EAX : 
	( v5314 == 3'd1) ? In_register_ECX : 
	( v5314 == 3'd2) ? In_register_EDX : 
	( v5314 == 3'd3) ? In_register_EBX : 
	( v5314 == 3'd4) ? v15 : 
	( v5314 == 3'd5) ? v15 : 
	( v5314 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5316 = v5315 + v63a;
wire [2:0] v5318 = { v1fa };
wire [31:0] v5319 = ( v5318 == 3'd0) ? In_register_EAX : 
	( v5318 == 3'd1) ? In_register_ECX : 
	( v5318 == 3'd2) ? In_register_EDX : 
	( v5318 == 3'd3) ? In_register_EBX : 
	( v5318 == 3'd4) ? v15 : 
	( v5318 == 3'd5) ? v15 : 
	( v5318 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v531a = v5319 + v1f7;
wire [31:0] v531c = ( v52ed ) ? v5316 : v531a;
wire v531d =  v26 == memory_0[15: 12] && v531c == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v531e = v5303 == ve;
wire v531f = v531e;
wire v5320 = v52ed & v531f;
wire v5321 = v5307 == ve;
wire v5322 = v5321;
wire v5323 = v52fe & v5322;
wire v5324 = v5320 | v5323;
wire [31:0] v5327 = ( v8 ) ? In_register_EDX : v5302;
wire [31:0] v5329 = v5327;
wire v532a = v5329 == Out_register_EDX;
wire [31:0] v532b = v5301 ^ v5300;
wire [31:0] v532c = v532b ^ v5302;
wire [7:0] v532d = v532c[7:0];
wire [7:0] v532e = v532d >> v1d;
wire [7:0] v532f = v532e & v18;
wire v5330 = v532f[0:0];
wire v5332 = v5330;
wire v5333 = v5332 == Out_register_AF;
wire [31:0] v5335 = In_register_GSBASE;
wire v5336 = v5335 == Out_register_GSBASE;
wire v5337 = v5303 == vd;
wire v5338 = v5337;
wire v5339 = v52ed & v5338;
wire v533a = v5307 == vd;
wire v533b = v533a;
wire v533c = v52fe & v533b;
wire v533d = v5339 | v533c;
wire [31:0] v5340 = ( v8 ) ? In_register_EBX : v5302;
wire [31:0] v5342 = v5340;
wire v5343 = v5342 == Out_register_EBX;
wire v5344 = v5303 == vc;
wire v5345 = v5344;
wire v5346 = v52ed & v5345;
wire v5347 = v5307 == vc;
wire v5348 = v5347;
wire v5349 = v52fe & v5348;
wire v534a = v5346 | v5349;
wire [31:0] v534d = ( v8 ) ? In_register_ECX : v5302;
wire [31:0] v534f = v534d;
wire v5350 = v534f == Out_register_ECX;
wire v5351 = v5303 == v9;
wire v5352 = v5351;
wire v5353 = v52ed & v5352;
wire v5354 = v5307 == v9;
wire v5355 = v5354;
wire v5356 = v52fe & v5355;
wire v5357 = v5353 | v5356;
wire [31:0] v535a = ( v8 ) ? In_register_EDI : v5302;
wire [31:0] v535c = v535a;
wire v535d = v535c == Out_register_EDI;
wire v535e = v5303 == v11;
wire v535f = v535e;
wire v5360 = v52ed & v535f;
wire v5361 = v5307 == v11;
wire v5362 = v5361;
wire v5363 = v52fe & v5362;
wire v5364 = v5360 | v5363;
wire [31:0] v5367 = ( v8 ) ? In_register_ESI : v5302;
wire [31:0] v5369 = v5367;
wire v536a = v5369 == Out_register_ESI;
wire v536b = v5303 == vf;
wire v536c = v536b;
wire v536d = v52ed & v536c;
wire v536e = v5307 == vf;
wire v536f = v536e;
wire v5370 = v52fe & v536f;
wire v5371 = v536d | v5370;
wire [31:0] v5374 = ( v8 ) ? In_register_EBP : v5302;
wire [31:0] v5376 = v5374;
wire v5377 = v5376 == Out_register_EBP;
wire [31:0] v537a = ( v52fe ) ? v16 : v10;
wire [31:0] v537b = In_register_EIP + v537a;
wire [31:0] v537d = v537b;
wire v537e = v537d == Out_register_EIP;
wire [31:0] v5380 = In_register_SSBASE;
wire v5381 = v5380 == Out_register_SSBASE;
wire [31:0] v5383 = In_register_DSBASE;
wire v5384 = v5383 == Out_register_DSBASE;
wire [7:0] v5386 = In_register_DF;
wire v5387 = v5386 == Out_register_DF;
wire [31:0] v5389 = In_register_FSBASE;
wire v538a = v5389 == Out_register_FSBASE;
wire v538b = v5303 == v7;
wire v538c = v538b;
wire v538d = v52ed & v538c;
wire v538e = v5307 == v7;
wire v538f = v538e;
wire v5390 = v52fe & v538f;
wire v5391 = v538d | v5390;
wire [31:0] v5394 = ( v8 ) ? In_register_EAX : v5302;
wire [31:0] v5396 = v5394;
wire v5397 = v5396 == Out_register_EAX;
wire v5398 = v5301 > v5300;
wire v539a = v5398;
wire v539b = v539a == Out_register_CF;
wire [31:0] v539d = In_register_ESBASE;
wire v539e = v539d == Out_register_ESBASE;
wire [31:0] v53a0 = In_register_CSBASE;
wire v53a1 = v53a0 == Out_register_CSBASE;
wire [31:0] v53a2 = v5302 ^ v5300;
wire [31:0] v53a3 = v53a2 >> v1e;
wire [31:0] v53a4 = v532b >> v1e;
wire [31:0] v53a5 = v53a3 + v53a4;
wire v53a6 = v53a5 == v1c;
wire v53a8 = v53a6;
wire v53a9 = v53a8 == Out_register_OF;
wire [7:0] v53aa = v5302[7:0];
wire [2:0] v53ab_aux = v53aa[0] + v53aa[1] + v53aa[2] + v53aa[3] + v53aa[4] + v53aa[5] + v53aa[6] + v53aa[7];
wire v53ab = { 5'b00000, v53ab_aux };
wire [7:0] v53ac = v53ab & v18;
wire [7:0] v53ad = v53ac ^ v18;
wire v53ae = v53ad[0:0];
wire v53b0 = v53ae;
wire v53b1 = v53b0 == Out_register_PF;
wire v53b2 = In_error_flag == Out_error_flag;
wire v53b3 = $signed(v5302) < $signed(v15);
wire v53b5 = v53b3;
wire v53b6 = v53b5 == Out_register_SF;
wire v53b7 = v5301 == v5300;
wire v53b9 = v53b7;
wire v53ba = v53b9 == Out_register_ZF;
wire v53bb = v5313 & v531d & v532a & v5333 & v5336 & v5343 & v5350 & v535d & v536a & v5377 & v537e & v5381 & v15c & v5384 & v5387 & v538a & v5397 & v539b & v539e & v5310 & v53a1 & v53a9 & v53b1 & v53b2 & v53b6 & v53ba;
wire v53be = ve6 == v1eb;
wire v53bf = v3 == v316;
wire v53c0 = v1b == v318;
wire v53c1 = v53be & v53bf & v53c0;
wire v53cc = v53c1;
wire v53cd = v53cc;
wire [2:0] v53c4 = { v1fa };
wire v53c5 = v53c4 == vc;
wire v53c6 = v53c5;
wire v53c7 = v53c1 & v53c6;
wire v53c8 = v53c7;
wire [2:0] v53bc = { v320 };
wire [31:0] v53bd = ( v53bc == 3'd0) ? In_register_EAX : 
	( v53bc == 3'd1) ? In_register_ECX : 
	( v53bc == 3'd2) ? In_register_EDX : 
	( v53bc == 3'd3) ? In_register_EBX : 
	( v53bc == 3'd4) ? In_register_ESP : 
	( v53bc == 3'd5) ? In_register_EBP : 
	( v53bc == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v53c3 = v53bd;
wire [31:0] v53cb = ( v8 ) ? In_register_ECX : v53c3;
wire [31:0] v53cf = v53cb;
wire v53d0 = v53cf == Out_register_ECX;
wire v53d1 = In_error_flag == Out_error_flag;
wire v53d2 = v53c4 == vb;
wire v53d3 = v53d2;
wire v53d4 = v53c1 & v53d3;
wire v53d5 = v53d4;
wire [31:0] v53d8 = ( v8 ) ? In_register_ESP : v53c3;
wire [31:0] v53da = v53d8;
wire v53db = v53da == Out_register_ESP;
wire [31:0] v53dd = v1c;
wire [31:0] v53de = In_register_EIP + v53dd;
wire [31:0] v53e0 = v53de;
wire v53e1 = v53e0 == Out_register_EIP;
wire [31:0] v53e3 = In_register_DSBASE;
wire v53e4 = v53e3 == Out_register_DSBASE;
wire v53e5 = v53c4 == vd;
wire v53e6 = v53e5;
wire v53e7 = v53c1 & v53e6;
wire v53e8 = v53e7;
wire [31:0] v53eb = ( v8 ) ? In_register_EBX : v53c3;
wire [31:0] v53ed = v53eb;
wire v53ee = v53ed == Out_register_EBX;
wire v53ef = v53c4 == v7;
wire v53f0 = v53ef;
wire v53f1 = v53c1 & v53f0;
wire v53f2 = v53f1;
wire [31:0] v53f5 = ( v8 ) ? In_register_EAX : v53c3;
wire [31:0] v53f7 = v53f5;
wire v53f8 = v53f7 == Out_register_EAX;
wire v53f9 = v53c4 == ve;
wire v53fa = v53f9;
wire v53fb = v53c1 & v53fa;
wire v53fc = v53fb;
wire [31:0] v53ff = ( v8 ) ? In_register_EDX : v53c3;
wire [31:0] v5401 = v53ff;
wire v5402 = v5401 == Out_register_EDX;
wire v5403 = v53c4 == v9;
wire v5404 = v5403;
wire v5405 = v53c1 & v5404;
wire v5406 = v5405;
wire [31:0] v5409 = ( v8 ) ? In_register_EDI : v53c3;
wire [31:0] v540b = v5409;
wire v540c = v540b == Out_register_EDI;
wire v540d = v53c4 == vf;
wire v540e = v540d;
wire v540f = v53c1 & v540e;
wire v5410 = v540f;
wire [31:0] v5413 = ( v8 ) ? In_register_EBP : v53c3;
wire [31:0] v5415 = v5413;
wire v5416 = v5415 == Out_register_EBP;
wire v5418 = In_register_OF;
wire v5419 = v5418 == Out_register_OF;
wire [31:0] v541b = In_register_SSBASE;
wire v541c = v541b == Out_register_SSBASE;
wire v541e = In_register_ZF;
wire v541f = v541e == Out_register_ZF;
wire [31:0] v5421 = In_register_GSBASE;
wire v5422 = v5421 == Out_register_GSBASE;
wire [31:0] v5424 = In_register_FSBASE;
wire v5425 = v5424 == Out_register_FSBASE;
wire [31:0] v5427 = In_register_CSBASE;
wire v5428 = v5427 == Out_register_CSBASE;
wire v542a = In_register_AF;
wire v542b = v542a == Out_register_AF;
wire v542d = In_register_CF;
wire v542e = v542d == Out_register_CF;
wire [7:0] v5430 = In_register_DF;
wire v5431 = v5430 == Out_register_DF;
wire [31:0] v5433 = In_register_ESBASE;
wire v5434 = v5433 == Out_register_ESBASE;
wire v5436 = In_register_PF;
wire v5437 = v5436 == Out_register_PF;
wire v5439 = In_register_SF;
wire v543a = v5439 == Out_register_SF;
wire v543b = v53c4 == v11;
wire v543c = v543b;
wire v543d = v53c1 & v543c;
wire v543e = v543d;
wire [31:0] v5441 = ( v8 ) ? In_register_ESI : v53c3;
wire [31:0] v5443 = v5441;
wire v5444 = v5443 == Out_register_ESI;
wire v5445 = v53d0 & v53d1 & v53db & v53e1 & v53e4 & v53ee & v53f8 & v5402 & v540c & v53cd & v5416 & v5419 & v541c & v541f & v5422 & v15c & v5425 & v5428 & v542b & v542e & v5431 & v5434 & v5437 & v543a & v5444;
wire [7:0] vf2 = 8'b01010110;
wire v5446 = vf2 == v1eb;
wire v5447 = v1b == v318;
wire v5448 = v5446 & v5447;
wire v5449 = v5448;
wire v544a = v5449;
wire [31:0] v544c = In_register_EDX;
wire v544d = v544c == Out_register_EDX;
wire [31:0] v544f = In_register_CSBASE;
wire v5450 = v544f == Out_register_CSBASE;
wire [31:0] v5452 = In_register_DSBASE;
wire v5453 = v5452 == Out_register_DSBASE;
wire [31:0] v5455 = In_register_EAX;
wire v5456 = v5455 == Out_register_EAX;
wire v5457 = In_error_flag == Out_error_flag;
wire v5459 = In_register_CF;
wire v545a = v5459 == Out_register_CF;
wire v545c = In_register_AF;
wire v545d = v545c == Out_register_AF;
wire [31:0] v545f = In_register_EBX;
wire v5460 = v545f == Out_register_EBX;
wire [31:0] v5462 = In_register_SSBASE;
wire v5463 = v5462 == Out_register_SSBASE;
wire [31:0] v5465 = In_register_ESI;
wire v5466 = v5465 == Out_register_ESI;
wire [31:0] v5468 = In_register_EBP;
wire v5469 = v5468 == Out_register_EBP;
wire [31:0] v546b = v477;
wire v546c =  v26 == memory_0[15: 12] && vdb3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v546b == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire v546e = In_register_OF;
wire v546f = v546e == Out_register_OF;
wire [31:0] v5471 = In_register_EDI;
wire v5472 = v5471 == Out_register_EDI;
wire v5474 = In_register_ZF;
wire v5475 = v5474 == Out_register_ZF;
wire [31:0] v5477 = v1c;
wire [31:0] v5478 = In_register_EIP + v5477;
wire [31:0] v547a = v5478;
wire v547b = v547a == Out_register_EIP;
wire [31:0] v547d = In_register_ECX;
wire v547e = v547d == Out_register_ECX;
wire [31:0] v5480 = In_register_FSBASE;
wire v5481 = v5480 == Out_register_FSBASE;
wire [31:0] v5483 = In_register_ESBASE;
wire v5484 = v5483 == Out_register_ESBASE;
wire [31:0] v5486 = In_register_GSBASE;
wire v5487 = v5486 == Out_register_GSBASE;
wire [7:0] v5489 = In_register_DF;
wire v548a = v5489 == Out_register_DF;
wire v548c = In_register_PF;
wire v548d = v548c == Out_register_PF;
wire [31:0] v548f = vdb2;
wire v5490 = v548f == Out_register_ESP;
wire v5492 = In_register_SF;
wire v5493 = v5492 == Out_register_SF;
wire v5494 = v544a & v544d & v15c & v5450 & v5453 & v5456 & v5457 & v545a & v545d & v5460 & v5463 & v5466 & v5469 & v546c & v546f & v5472 & v5475 & v547b & v547e & v5481 & v5484 & v5487 & v548a & v548d & v5490 & v5493;
wire v5495 = In_error_flag == Out_error_flag;
wire [7:0] vf3 = 8'b10001000;
wire v5496 = vf3 == v1eb;
wire v5497 = v35 == v316;
wire v5498 = v1b == v318;
wire [2:0] v5499 = { v1fa };
wire v549a = v5499 == vb;
wire v549b = v5499 == vf;
wire v549c = v549a | v549b;
wire v549d = v549c ^ v8;
wire [2:0] v549e = { v1fa };
wire v549f = v549e == vb;
wire v54a0 = v549e == vf;
wire v54a1 = v549f | v54a0;
wire v54a2 = v54a1 ^ v8;
wire [2:0] v54a3 = { v1fa };
wire v54a4 = v54a3 == vb;
wire v54a5 = v54a3 == vf;
wire v54a6 = v54a4 | v54a5;
wire v54a7 = v54a6 ^ v8;
wire [2:0] v54a8 = { v1fa };
wire v54a9 = v54a8 == vb;
wire v54aa = v54a8 == vf;
wire v54ab = v54a9 | v54aa;
wire v54ac = v54ab ^ v8;
wire v54ad = v549d & v54a2 & v54a7 & v54ac;
wire v54ae = v5496 & v5497 & v5498 & v54ad;
wire [10:0] vf4 = 11'b10001000001;
wire v54af = vf4 == v6d7;
wire v54b0 = v35 == v316;
wire v54b1 = v4 == v11b;
wire [2:0] v54b2 = { v13c };
wire v54b3 = v54b2 == vb;
wire v54b4 = v54b2 == vf;
wire v54b5 = v54b3 | v54b4;
wire v54b6 = v54b5 ^ v8;
wire [2:0] v54b7 = { v12c };
wire v54b8 = v54b7 == vb;
wire v54b9 = v54b8;
wire v54ba = v54b9 ^ v8;
wire [2:0] v54bb = { v13c };
wire v54bc = v54bb == vf;
wire v54bd = v54bc;
wire v54be = v54bd ^ v8;
wire [2:0] v54bf = { v13c };
wire v54c0 = v54bf == vb;
wire v54c1 = v54bf == vf;
wire v54c2 = v54c0 | v54c1;
wire v54c3 = v54c2 ^ v8;
wire [2:0] v54c4 = { v12c };
wire v54c5 = v54c4 == vb;
wire v54c6 = v54c5;
wire v54c7 = v54c6 ^ v8;
wire [2:0] v54c8 = { v13c };
wire v54c9 = v54c8 == vf;
wire v54ca = v54c9;
wire v54cb = v54ca ^ v8;
wire v54cc = v54b6 & v54ba & v54be & v54c3 & v54c7 & v54cb;
wire v54cd = v54af & v54b0 & v54b1 & v54cc;
wire v54ce = v54ae | v54cd;
wire v54cf = v54ce;
wire [31:0] v54d1 = In_register_ESP;
wire v54d2 = v54d1 == Out_register_ESP;
wire [2:0] v54d6 = { v13c };
wire [31:0] v54d7 = ( v54d6 == 3'd0) ? In_register_EAX : 
	( v54d6 == 3'd1) ? In_register_ECX : 
	( v54d6 == 3'd2) ? In_register_EDX : 
	( v54d6 == 3'd3) ? In_register_EBX : 
	( v54d6 == 3'd4) ? v15 : 
	( v54d6 == 3'd5) ? v15 : 
	( v54d6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v54d8 = { v12c };
wire [31:0] v54d9 = ( v54d8 == 3'd0) ? In_register_EAX : 
	( v54d8 == 3'd1) ? In_register_ECX : 
	( v54d8 == 3'd2) ? In_register_EDX : 
	( v54d8 == 3'd3) ? In_register_EBX : 
	( v54d8 == 3'd4) ? v15 : 
	( v54d8 == 3'd5) ? In_register_EBP : 
	( v54d8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v54da = v54d9 << v7f4;
wire [31:0] v54db = v54d7 + v54da;
wire [2:0] v54d3 = { v1fa };
wire [31:0] v54d4 = ( v54d3 == 3'd0) ? In_register_EAX : 
	( v54d3 == 3'd1) ? In_register_ECX : 
	( v54d3 == 3'd2) ? In_register_EDX : 
	( v54d3 == 3'd3) ? In_register_EBX : 
	( v54d3 == 3'd4) ? v15 : 
	( v54d3 == 3'd5) ? v15 : 
	( v54d3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v54dd = ( v54cd ) ? v54db : v54d4;
wire v54de =  v26 == memory_0[15: 12] && v54dd == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v54e0 = In_register_DSBASE;
wire v54e1 = v54e0 == Out_register_DSBASE;
wire [31:0] v54e3 = In_register_EAX;
wire v54e4 = v54e3 == Out_register_EAX;
wire [31:0] v54e6 = In_register_EDX;
wire v54e7 = v54e6 == Out_register_EDX;
wire [31:0] v54e9 = In_register_EDI;
wire v54ea = v54e9 == Out_register_EDI;
wire [31:0] v54ec = In_register_ECX;
wire v54ed = v54ec == Out_register_ECX;
wire [2:0] v54f1 = { v13c };
wire [31:0] v54f2 = ( v54f1 == 3'd0) ? In_register_EAX : 
	( v54f1 == 3'd1) ? In_register_ECX : 
	( v54f1 == 3'd2) ? In_register_EDX : 
	( v54f1 == 3'd3) ? In_register_EBX : 
	( v54f1 == 3'd4) ? v15 : 
	( v54f1 == 3'd5) ? v15 : 
	( v54f1 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v54f3 = { v12c };
wire [31:0] v54f4 = ( v54f3 == 3'd0) ? In_register_EAX : 
	( v54f3 == 3'd1) ? In_register_ECX : 
	( v54f3 == 3'd2) ? In_register_EDX : 
	( v54f3 == 3'd3) ? In_register_EBX : 
	( v54f3 == 3'd4) ? v15 : 
	( v54f3 == 3'd5) ? In_register_EBP : 
	( v54f3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v54f5 = v54f4 << v7f4;
wire [31:0] v54f6 = v54f2 + v54f5;
wire [2:0] v54ee = { v1fa };
wire [31:0] v54ef = ( v54ee == 3'd0) ? In_register_EAX : 
	( v54ee == 3'd1) ? In_register_ECX : 
	( v54ee == 3'd2) ? In_register_EDX : 
	( v54ee == 3'd3) ? In_register_EBX : 
	( v54ee == 3'd4) ? v15 : 
	( v54ee == 3'd5) ? v15 : 
	( v54ee == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v54f8 = ( v54cd ) ? v54f6 : v54ef;
wire [31:0] v54f9 = memory_0[79: 48];
wire [2:0] v54fa = { v320 };
wire [31:0] v54fb = ( v54fa == 3'd0) ? In_register_EAX : 
	( v54fa == 3'd1) ? In_register_ECX : 
	( v54fa == 3'd2) ? In_register_EDX : 
	( v54fa == 3'd3) ? In_register_EBX : 
	( v54fa == 3'd4) ? In_register_ESP : 
	( v54fa == 3'd5) ? In_register_EBP : 
	( v54fa == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v54fd = { v320 };
wire [31:0] v54fe = ( v54fd == 3'd0) ? In_register_EAX : 
	( v54fd == 3'd1) ? In_register_ECX : 
	( v54fd == 3'd2) ? In_register_EDX : 
	( v54fd == 3'd3) ? In_register_EBX : 
	( v54fd == 3'd4) ? In_register_ESP : 
	( v54fd == 3'd5) ? In_register_EBP : 
	( v54fd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5500 = ( v54ae ) ? v54fb : v54fe;
wire [31:0] v5501 = v54f9 + v5500;
wire [31:0] v5502 = v5501 + vb11;
wire v5503 =  v26 == memory_1[15: 12] && v54f8 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v5502 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v5505 = In_register_ESI;
wire v5506 = v5505 == Out_register_ESI;
wire [31:0] v5508 = In_register_EBP;
wire v5509 = v5508 == Out_register_EBP;
wire [31:0] v550b = In_register_CSBASE;
wire v550c = v550b == Out_register_CSBASE;
wire [31:0] v550e = In_register_SSBASE;
wire v550f = v550e == Out_register_SSBASE;
wire [31:0] v5512 = ( v54ae ) ? v1c : v10;
wire [31:0] v5513 = In_register_EIP + v5512;
wire [31:0] v5515 = v5513;
wire v5516 = v5515 == Out_register_EIP;
wire [31:0] v5517 = v5502 ^ v5500;
wire [31:0] v5518 = v5517 ^ v54f9;
wire [7:0] v5519 = v5518[7:0];
wire [7:0] v551a = v5519 >> v1d;
wire [7:0] v551b = v551a & v18;
wire v551c = v551b[0:0];
wire v551e = v551c;
wire v551f = v551e == Out_register_AF;
wire v5520 = v5502 == v15;
wire v5522 = v5520;
wire v5523 = v5522 == Out_register_ZF;
wire [31:0] v5525 = In_register_ESBASE;
wire v5526 = v5525 == Out_register_ESBASE;
wire [31:0] v5528 = In_register_EBX;
wire v5529 = v5528 == Out_register_EBX;
wire [31:0] v552b = In_register_GSBASE;
wire v552c = v552b == Out_register_GSBASE;
wire v552d = v5501 < v54f9;
wire v552e = v5501 < v5500;
wire v552f = v552d | v552e;
wire v5530 = v5502 < v5501;
wire v5531 = v5502 < vb11;
wire v5532 = v5530 | v5531;
wire [7:0] v5533 = { 7'b0000000, v5532 };
wire [7:0] v5534 = ( v552f == 1'd0) ? v5533 : v18;
wire v5535 = v5534[0:0];
wire v5537 = v5535;
wire v5538 = v5537 == Out_register_CF;
wire [31:0] v553a = In_register_FSBASE;
wire v553b = v553a == Out_register_FSBASE;
wire [7:0] v553d = In_register_DF;
wire v553e = v553d == Out_register_DF;
wire [31:0] v553f = v5502 ^ v54f9;
wire [31:0] v5540 = v553f >> v1e;
wire [31:0] v5541 = v5517 >> v1e;
wire [31:0] v5542 = v5540 + v5541;
wire v5543 = v5542 == v1c;
wire v5545 = v5543;
wire v5546 = v5545 == Out_register_OF;
wire [7:0] v5547 = v5502[7:0];
wire [2:0] v5548_aux = v5547[0] + v5547[1] + v5547[2] + v5547[3] + v5547[4] + v5547[5] + v5547[6] + v5547[7];
wire v5548 = { 5'b00000, v5548_aux };
wire [7:0] v5549 = v5548 & v18;
wire [7:0] v554a = v5549 ^ v18;
wire v554b = v554a[0:0];
wire v554d = v554b;
wire v554e = v554d == Out_register_PF;
wire v554f = $signed(v5502) < $signed(v15);
wire v5551 = v554f;
wire v5552 = v5551 == Out_register_SF;
wire v5553 = v5495 & v54d2 & v54de & v54e1 & v54e4 & v54e7 & v54ea & v54ed & v15c & v5503 & v5506 & v5509 & v550c & v550f & v5516 & v54cf & v551f & v5523 & v5526 & v5529 & v552c & v5538 & v553b & v553e & v5546 & v554e & v5552;
wire [7:0] vf5 = 8'b01011110;
wire v5554 = vf5 == v1eb;
wire v5555 = v1b == v318;
wire v5556 = v5554 & v5555;
wire v5557 = v5556;
wire v5558 = v5557;
wire v555a = In_register_ZF;
wire v555b = v555a == Out_register_ZF;
wire [31:0] v555d = In_register_EBX;
wire v555e = v555d == Out_register_EBX;
wire [31:0] v5560 = In_register_EDI;
wire v5561 = v5560 == Out_register_EDI;
wire v5562 = In_error_flag == Out_error_flag;
wire [31:0] v5564 = In_register_ESBASE;
wire v5565 = v5564 == Out_register_ESBASE;
wire [31:0] v5567 = In_register_ESI;
wire v5568 = v5567 == Out_register_ESI;
wire [31:0] v556a = In_register_ECX;
wire v556b = v556a == Out_register_ECX;
wire [31:0] v556d = In_register_EBP;
wire v556e = v556d == Out_register_EBP;
wire [31:0] v5570 = In_register_EDX;
wire v5571 = v5570 == Out_register_EDX;
wire [31:0] v5573 = In_register_ESP;
wire v5574 = v5573 == Out_register_ESP;
wire [31:0] v5576 = In_register_FSBASE;
wire v5577 = v5576 == Out_register_FSBASE;
wire [31:0] v5579 = v1c;
wire [31:0] v557a = In_register_EIP + v5579;
wire [31:0] v557b = v557a + v477;
wire [31:0] v557d = v557b;
wire [31:0] v557f = v557a;
wire [31:0] v5580 = ( vd07 == 1'd0) ? v557d : v557f;
wire [31:0] v5583 = ( v8 ) ? v557a : v5580;
wire [31:0] v5585 = v5583;
wire v5586 = v5585 == Out_register_EIP;
wire [31:0] v5588 = In_register_CSBASE;
wire v5589 = v5588 == Out_register_CSBASE;
wire [31:0] v558b = In_register_SSBASE;
wire v558c = v558b == Out_register_SSBASE;
wire [31:0] v558e = In_register_GSBASE;
wire v558f = v558e == Out_register_GSBASE;
wire [31:0] v5591 = In_register_DSBASE;
wire v5592 = v5591 == Out_register_DSBASE;
wire v5594 = In_register_OF;
wire v5595 = v5594 == Out_register_OF;
wire [31:0] v5597 = In_register_EAX;
wire v5598 = v5597 == Out_register_EAX;
wire v559a = In_register_CF;
wire v559b = v559a == Out_register_CF;
wire v559d = In_register_AF;
wire v559e = v559d == Out_register_AF;
wire [7:0] v55a0 = In_register_DF;
wire v55a1 = v55a0 == Out_register_DF;
wire v55a3 = In_register_PF;
wire v55a4 = v55a3 == Out_register_PF;
wire v55a6 = In_register_SF;
wire v55a7 = v55a6 == Out_register_SF;
wire v55a8 = v5558 & v555b & v555e & v5561 & v15c & v5562 & v5565 & v5568 & v556b & v556e & v5571 & v5574 & v5577 & v5586 & v5589 & v558c & v558f & v5592 & v5595 & v5598 & v559b & v559e & v55a1 & v55a4 & v55a7;
wire [7:0] vf6 = 8'b10011000;
wire v55a9 = vf6 == v1eb;
wire v55aa = v35 == v316;
wire v55ab = v1b == v318;
wire [2:0] v55ac = { v1fa };
wire v55ad = v55ac == vb;
wire v55ae = v55ac == vf;
wire v55af = v55ad | v55ae;
wire v55b0 = v55af ^ v8;
wire [2:0] v55b1 = { v1fa };
wire v55b2 = v55b1 == vb;
wire v55b3 = v55b1 == vf;
wire v55b4 = v55b2 | v55b3;
wire v55b5 = v55b4 ^ v8;
wire [2:0] v55b6 = { v1fa };
wire v55b7 = v55b6 == vb;
wire v55b8 = v55b6 == vf;
wire v55b9 = v55b7 | v55b8;
wire v55ba = v55b9 ^ v8;
wire [2:0] v55bb = { v1fa };
wire v55bc = v55bb == vb;
wire v55bd = v55bb == vf;
wire v55be = v55bc | v55bd;
wire v55bf = v55be ^ v8;
wire v55c0 = v55b0 & v55b5 & v55ba & v55bf;
wire v55c1 = v55a9 & v55aa & v55ab & v55c0;
wire v55c2 = v55c1;
wire v55c3 = v55c2;
wire [31:0] v55c5 = In_register_EAX;
wire v55c6 = v55c5 == Out_register_EAX;
wire [31:0] v55c8 = In_register_DSBASE;
wire v55c9 = v55c8 == Out_register_DSBASE;
wire [31:0] v55cb = In_register_GSBASE;
wire v55cc = v55cb == Out_register_GSBASE;
wire v55cd = In_error_flag == Out_error_flag;
wire [31:0] v55cf = In_register_ESI;
wire v55d0 = v55cf == Out_register_ESI;
wire [2:0] v55d1 = { v1fa };
wire [31:0] v55d2 = ( v55d1 == 3'd0) ? In_register_EAX : 
	( v55d1 == 3'd1) ? In_register_ECX : 
	( v55d1 == 3'd2) ? In_register_EDX : 
	( v55d1 == 3'd3) ? In_register_EBX : 
	( v55d1 == 3'd4) ? v15 : 
	( v55d1 == 3'd5) ? v15 : 
	( v55d1 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v55d4 = v55d2;
wire [31:0] v55d5 = memory_0[79: 48];
wire [2:0] v55d6 = { v320 };
wire [31:0] v55d7 = ( v55d6 == 3'd0) ? In_register_EAX : 
	( v55d6 == 3'd1) ? In_register_ECX : 
	( v55d6 == 3'd2) ? In_register_EDX : 
	( v55d6 == 3'd3) ? In_register_EBX : 
	( v55d6 == 3'd4) ? In_register_ESP : 
	( v55d6 == 3'd5) ? In_register_EBP : 
	( v55d6 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v55d9 = v55d7;
wire [31:0] v55da = v55d5 - v55d9;
wire [31:0] v55db = v55da - vb11;
wire v55dc =  v26 == memory_1[15: 12] && v55d4 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v55db == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v55de = In_register_ECX;
wire v55df = v55de == Out_register_ECX;
wire [31:0] v55e0 = v55db ^ v55d5;
wire [31:0] v55e1 = v55e0 >> v1e;
wire [31:0] v55e2 = v55d5 ^ v55d9;
wire [31:0] v55e3 = v55e2 >> v1e;
wire [31:0] v55e4 = v55e1 + v55e3;
wire v55e5 = v55e4 == v1c;
wire v55e7 = v55e5;
wire v55e8 = v55e7 == Out_register_OF;
wire [31:0] v55ea = In_register_EDX;
wire v55eb = v55ea == Out_register_EDX;
wire [31:0] v55ed = In_register_CSBASE;
wire v55ee = v55ed == Out_register_CSBASE;
wire [31:0] v55f0 = In_register_ESP;
wire v55f1 = v55f0 == Out_register_ESP;
wire [31:0] v55f3 = In_register_SSBASE;
wire v55f4 = v55f3 == Out_register_SSBASE;
wire [31:0] v55f6 = In_register_EBX;
wire v55f7 = v55f6 == Out_register_EBX;
wire [2:0] v55f8 = { v1fa };
wire [31:0] v55f9 = ( v55f8 == 3'd0) ? In_register_EAX : 
	( v55f8 == 3'd1) ? In_register_ECX : 
	( v55f8 == 3'd2) ? In_register_EDX : 
	( v55f8 == 3'd3) ? In_register_EBX : 
	( v55f8 == 3'd4) ? v15 : 
	( v55f8 == 3'd5) ? v15 : 
	( v55f8 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v55fb = v55f9;
wire v55fc =  v26 == memory_0[15: 12] && v55fb == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v55fe = In_register_EBP;
wire v55ff = v55fe == Out_register_EBP;
wire [31:0] v5601 = v1c;
wire [31:0] v5602 = In_register_EIP + v5601;
wire [31:0] v5604 = v5602;
wire v5605 = v5604 == Out_register_EIP;
wire [31:0] v5607 = In_register_ESBASE;
wire v5608 = v5607 == Out_register_ESBASE;
wire [31:0] v560a = In_register_EDI;
wire v560b = v560a == Out_register_EDI;
wire [31:0] v560c = v55db ^ v55e2;
wire [7:0] v560d = v560c[7:0];
wire [7:0] v560e = v560d >> v1d;
wire [7:0] v560f = v560e & v18;
wire v5610 = v560f[0:0];
wire v5612 = v5610;
wire v5613 = v5612 == Out_register_AF;
wire [31:0] v5615 = In_register_FSBASE;
wire v5616 = v5615 == Out_register_FSBASE;
wire v5617 = v55d5 < v55d9;
wire v5618 = v55da < vb11;
wire [7:0] v5619 = { 7'b0000000, v5618 };
wire [7:0] v561a = ( v5617 == 1'd0) ? v5619 : v18;
wire v561b = v561a[0:0];
wire v561d = v561b;
wire v561e = v561d == Out_register_CF;
wire [7:0] v5620 = In_register_DF;
wire v5621 = v5620 == Out_register_DF;
wire [7:0] v5622 = v55db[7:0];
wire [2:0] v5623_aux = v5622[0] + v5622[1] + v5622[2] + v5622[3] + v5622[4] + v5622[5] + v5622[6] + v5622[7];
wire v5623 = { 5'b00000, v5623_aux };
wire [7:0] v5624 = v5623 & v18;
wire [7:0] v5625 = v5624 ^ v18;
wire v5626 = v5625[0:0];
wire v5628 = v5626;
wire v5629 = v5628 == Out_register_PF;
wire v562a = $signed(v55db) < $signed(v15);
wire v562c = v562a;
wire v562d = v562c == Out_register_SF;
wire v562e = v55da == vb11;
wire v5630 = v562e;
wire v5631 = v5630 == Out_register_ZF;
wire v5632 = v55c6 & v55c9 & v55cc & v55cd & v55d0 & v55dc & v55df & v55e8 & v15c & v55eb & v55ee & v55f1 & v55f4 & v55f7 & v55fc & v55ff & v55c3 & v5605 & v5608 & v560b & v5613 & v5616 & v561e & v5621 & v5629 & v562d & v5631;
wire v5633 = vc7 == v1eb;
wire v5634 = v30 == v316;
wire v5635 = v4 == v11b;
wire [2:0] v5636 = { v1fa };
wire v5637 = v5636 == vb;
wire v5638 = v5636 == vf;
wire v5639 = v5637 | v5638;
wire v563a = v5639 ^ v8;
wire [2:0] v563b = { v1fa };
wire v563c = v563b == vb;
wire v563d = v563c;
wire v563e = v563d ^ v8;
wire v563f = v563a & v563e;
wire v5640 = v5633 & v5634 & v5635 & v563f;
wire v5641 = vc7 == v1eb;
wire v5642 = v35 == v316;
wire v5643 = v1b == v318;
wire [2:0] v5644 = { v1fa };
wire v5645 = v5644 == vb;
wire v5646 = v5644 == vf;
wire v5647 = v5645 | v5646;
wire v5648 = v5647 ^ v8;
wire [2:0] v5649 = { v1fa };
wire v564a = v5649 == vb;
wire v564b = v5649 == vf;
wire v564c = v564a | v564b;
wire v564d = v564c ^ v8;
wire v564e = v5648 & v564d;
wire v564f = v5641 & v5642 & v5643 & v564e;
wire v5650 = v5640 | v564f;
wire v5651 = v5650;
wire [31:0] v5653 = In_register_EAX;
wire v5654 = v5653 == Out_register_EAX;
wire [31:0] v5656 = In_register_EBP;
wire v5657 = v5656 == Out_register_EBP;
wire v5658 = In_error_flag == Out_error_flag;
wire [31:0] v565a = In_register_GSBASE;
wire v565b = v565a == Out_register_GSBASE;
wire [31:0] v565d = In_register_EBX;
wire v565e = v565d == Out_register_EBX;
wire [31:0] v5661 = ( v564f ) ? v1c : v10;
wire [31:0] v5662 = In_register_EIP + v5661;
wire [31:0] v5664 = v5662;
wire v5665 = v5664 == Out_register_EIP;
wire [31:0] v5667 = In_register_ECX;
wire v5668 = v5667 == Out_register_ECX;
wire [31:0] v5669 = memory_0[79: 48];
wire [2:0] v566a = { v320 };
wire [31:0] v566b = ( v566a == 3'd0) ? In_register_EAX : 
	( v566a == 3'd1) ? In_register_ECX : 
	( v566a == 3'd2) ? In_register_EDX : 
	( v566a == 3'd3) ? In_register_EBX : 
	( v566a == 3'd4) ? In_register_ESP : 
	( v566a == 3'd5) ? In_register_EBP : 
	( v566a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v566d = { v320 };
wire [31:0] v566e = ( v566d == 3'd0) ? In_register_EAX : 
	( v566d == 3'd1) ? In_register_ECX : 
	( v566d == 3'd2) ? In_register_EDX : 
	( v566d == 3'd3) ? In_register_EBX : 
	( v566d == 3'd4) ? In_register_ESP : 
	( v566d == 3'd5) ? In_register_EBP : 
	( v566d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5670 = ( v5640 ) ? v566b : v566e;
wire v5671 = v5669 > v5670;
wire v5673 = v5671;
wire v5674 = v5673 == Out_register_CF;
wire [31:0] v5676 = In_register_EDX;
wire v5677 = v5676 == Out_register_EDX;
wire [31:0] v5678 = v5670 - v5669;
wire [7:0] v5679 = v5678[7:0];
wire [2:0] v567a_aux = v5679[0] + v5679[1] + v5679[2] + v5679[3] + v5679[4] + v5679[5] + v5679[6] + v5679[7];
wire v567a = { 5'b00000, v567a_aux };
wire [7:0] v567b = v567a & v18;
wire [7:0] v567c = v567b ^ v18;
wire v567d = v567c[0:0];
wire v567f = v567d;
wire v5680 = v567f == Out_register_PF;
wire [31:0] v5682 = In_register_EDI;
wire v5683 = v5682 == Out_register_EDI;
wire [31:0] v5685 = In_register_DSBASE;
wire v5686 = v5685 == Out_register_DSBASE;
wire [2:0] v5687 = { v1fa };
wire [31:0] v5688 = ( v5687 == 3'd0) ? In_register_EAX : 
	( v5687 == 3'd1) ? In_register_ECX : 
	( v5687 == 3'd2) ? In_register_EDX : 
	( v5687 == 3'd3) ? In_register_EBX : 
	( v5687 == 3'd4) ? v15 : 
	( v5687 == 3'd5) ? v15 : 
	( v5687 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5689 = v5688 + v63a;
wire [2:0] v568b = { v1fa };
wire [31:0] v568c = ( v568b == 3'd0) ? In_register_EAX : 
	( v568b == 3'd1) ? In_register_ECX : 
	( v568b == 3'd2) ? In_register_EDX : 
	( v568b == 3'd3) ? In_register_EBX : 
	( v568b == 3'd4) ? v15 : 
	( v568b == 3'd5) ? v15 : 
	( v568b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v568e = ( v5640 ) ? v5689 : v568c;
wire v568f =  v26 == memory_0[15: 12] && v568e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v5691 = In_register_ESI;
wire v5692 = v5691 == Out_register_ESI;
wire [31:0] v5693 = v5678 ^ v5670;
wire [31:0] v5694 = v5693 >> v1e;
wire [31:0] v5695 = v5669 ^ v5670;
wire [31:0] v5696 = v5695 >> v1e;
wire [31:0] v5697 = v5694 + v5696;
wire v5698 = v5697 == v1c;
wire v569a = v5698;
wire v569b = v569a == Out_register_OF;
wire [31:0] v569d = In_register_ESP;
wire v569e = v569d == Out_register_ESP;
wire [31:0] v56a0 = In_register_CSBASE;
wire v56a1 = v56a0 == Out_register_CSBASE;
wire [31:0] v56a3 = In_register_SSBASE;
wire v56a4 = v56a3 == Out_register_SSBASE;
wire [31:0] v56a6 = In_register_ESBASE;
wire v56a7 = v56a6 == Out_register_ESBASE;
wire [7:0] v56a9 = In_register_DF;
wire v56aa = v56a9 == Out_register_DF;
wire [31:0] v56ab = v5695 ^ v5678;
wire [7:0] v56ac = v56ab[7:0];
wire [7:0] v56ad = v56ac >> v1d;
wire [7:0] v56ae = v56ad & v18;
wire v56af = v56ae[0:0];
wire v56b1 = v56af;
wire v56b2 = v56b1 == Out_register_AF;
wire [31:0] v56b4 = In_register_FSBASE;
wire v56b5 = v56b4 == Out_register_FSBASE;
wire v56b6 = $signed(v5678) < $signed(v15);
wire v56b8 = v56b6;
wire v56b9 = v56b8 == Out_register_SF;
wire v56ba = v5669 == v5670;
wire v56bc = v56ba;
wire v56bd = v56bc == Out_register_ZF;
wire v56be = v5651 & v15c & v5654 & v5657 & v5658 & v565b & v565e & v5665 & v5668 & v5674 & v5677 & v5680 & v5683 & v5686 & v568f & v5692 & v569b & v569e & v56a1 & v56a4 & v56a7 & v56aa & v56b2 & v56b5 & v56b9 & v56bd;
wire [7:0] vf7 = 8'b00011110;
wire v56bf = vf7 == v1eb;
wire v56c0 = v1b == v318;
wire v56c1 = v56bf & v56c0;
wire v56c2 = v56c1;
wire v56c3 = v56c2;
wire [31:0] v56c5 = In_register_FSBASE;
wire v56c6 = v56c5 == Out_register_FSBASE;
wire [31:0] v56c8 = In_register_DSBASE;
wire v56c9 = v56c8 == Out_register_DSBASE;
wire v56ca = In_error_flag == Out_error_flag;
wire [31:0] v56cc = In_register_EDI;
wire v56cd = v56cc == Out_register_EDI;
wire [31:0] v56cf = In_register_ECX;
wire v56d0 = v56cf == Out_register_ECX;
wire v56d2 = In_register_SF;
wire v56d3 = v56d2 == Out_register_SF;
wire [31:0] v56d5 = In_register_EAX;
wire v56d6 = v56d5 == Out_register_EAX;
wire [31:0] v56d8 = In_register_ESI;
wire v56d9 = v56d8 == Out_register_ESI;
wire [31:0] v56db = In_register_EDX;
wire v56dc = v56db == Out_register_EDX;
wire [31:0] v56de = In_register_CSBASE;
wire v56df = v56de == Out_register_CSBASE;
wire [31:0] v56e1 = In_register_EBP;
wire v56e2 = v56e1 == Out_register_EBP;
wire [31:0] v56e4 = v1c;
wire [31:0] v56e5 = In_register_EIP + v56e4;
wire [31:0] v56e6 = v56e5 + v477;
wire [31:0] v56e8 = v56e6;
wire [31:0] v56ea = v56e5;
wire [31:0] v56eb = ( v1d86 == 1'd0) ? v56e8 : v56ea;
wire [31:0] v56ee = ( v56c2 ) ? v56eb : v56e5;
wire [31:0] v56f0 = v56ee;
wire v56f1 = v56f0 == Out_register_EIP;
wire [31:0] v56f3 = In_register_EBX;
wire v56f4 = v56f3 == Out_register_EBX;
wire [31:0] v56f6 = In_register_SSBASE;
wire v56f7 = v56f6 == Out_register_SSBASE;
wire [31:0] v56f9 = In_register_ESBASE;
wire v56fa = v56f9 == Out_register_ESBASE;
wire [31:0] v56fc = In_register_GSBASE;
wire v56fd = v56fc == Out_register_GSBASE;
wire [31:0] v56ff = In_register_ESP;
wire v5700 = v56ff == Out_register_ESP;
wire v5702 = In_register_CF;
wire v5703 = v5702 == Out_register_CF;
wire v5705 = In_register_AF;
wire v5706 = v5705 == Out_register_AF;
wire v5708 = In_register_PF;
wire v5709 = v5708 == Out_register_PF;
wire [7:0] v570b = In_register_DF;
wire v570c = v570b == Out_register_DF;
wire v570e = In_register_OF;
wire v570f = v570e == Out_register_OF;
wire v5711 = In_register_ZF;
wire v5712 = v5711 == Out_register_ZF;
wire v5713 = v56c6 & v56c3 & v56c9 & v56ca & v56cd & v56d0 & v56d3 & v56d6 & v15c & v56d9 & v56dc & v56df & v56e2 & v56f1 & v56f4 & v56f7 & v56fa & v56fd & v5700 & v5703 & v5706 & v5709 & v570c & v570f & v5712;
wire [7:0] vf8 = 8'b01010101;
wire v5714 = vf8 == v1eb;
wire v5715 = v29 == v59f;
wire v5716 = v5714 & v5715;
wire v5717 = v5716;
wire v5718 = v5717;
wire v5719 =  v2a == memory_0[15: 12] && v1b8e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && vf4a == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [7:0] v571b = In_register_DF;
wire v571c = v571b == Out_register_DF;
wire v571d = In_error_flag == Out_error_flag;
wire v571f = In_register_SF;
wire v5720 = v571f == Out_register_SF;
wire [31:0] v5722 = In_register_ESP;
wire v5723 = v5722 == Out_register_ESP;
wire [31:0] v5725 = v2b;
wire [31:0] v5726 = In_register_EIP + v5725;
wire [31:0] v5728 = v5726;
wire v5729 = v5728 == Out_register_EIP;
wire v572b = In_register_CF;
wire v572c = v572b == Out_register_CF;
wire [31:0] v572e = In_register_EDX;
wire v572f = v572e == Out_register_EDX;
wire [31:0] v5731 = In_register_EBX;
wire v5732 = v5731 == Out_register_EBX;
wire [31:0] v5734 = In_register_ESI;
wire v5735 = v5734 == Out_register_ESI;
wire [31:0] v5737 = In_register_ESBASE;
wire v5738 = v5737 == Out_register_ESBASE;
wire [31:0] v573a = In_register_FSBASE;
wire v573b = v573a == Out_register_FSBASE;
wire [31:0] v573d = In_register_ECX;
wire v573e = v573d == Out_register_ECX;
wire [31:0] v5740 = In_register_EAX;
wire v5741 = v5740 == Out_register_EAX;
wire [31:0] v5743 = v1b5d;
wire v5744 = v5743 == Out_register_EDI;
wire v5746 = In_register_OF;
wire v5747 = v5746 == Out_register_OF;
wire [31:0] v5749 = In_register_EBP;
wire v574a = v5749 == Out_register_EBP;
wire [31:0] v574c = In_register_CSBASE;
wire v574d = v574c == Out_register_CSBASE;
wire v574f = In_register_AF;
wire v5750 = v574f == Out_register_AF;
wire [31:0] v5752 = In_register_SSBASE;
wire v5753 = v5752 == Out_register_SSBASE;
wire [31:0] v5755 = In_register_DSBASE;
wire v5756 = v5755 == Out_register_DSBASE;
wire [31:0] v5758 = In_register_GSBASE;
wire v5759 = v5758 == Out_register_GSBASE;
wire v575b = In_register_PF;
wire v575c = v575b == Out_register_PF;
wire v575e = In_register_ZF;
wire v575f = v575e == Out_register_ZF;
wire v5760 = v5718 & v15c & v5719 & v571c & v571d & v5720 & v5723 & v5729 & v572c & v572f & v5732 & v5735 & v5738 & v573b & v573e & v5741 & v5744 & v5747 & v574a & v574d & v5750 & v5753 & v5756 & v5759 & v575c & v575f;
wire v5761 = vd2 == v1eb;
wire v5762 = v8 == v829;
wire v5763 = v30 == v316;
wire v5764 = v4 == v11b;
wire v5765 = v5761 & v5762 & v5763 & v5764;
wire v5766 = v5765;
wire v5767 = v5766;
wire [1:0] v5768 = { v889 , v888 };
wire [31:0] v5769 = ( v5768 == 2'd0) ? In_register_EDX : 
	( v5768 == 2'd1) ? In_register_ESI : 
	( v5768 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v576a = v5769 + v63a;
wire [31:0] v576c = v576a;
wire v576d =  v2a == memory_0[15: 12] && v576c == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v576f = In_register_OF;
wire v5770 = v576f == Out_register_OF;
wire [2:0] v5775 = { v320 };
wire v577d = v5775 == v9;
wire v577e = v577d;
wire v577f = v5765 & v577e;
wire v5780 = v577f;
wire [31:0] v5771 = memory_0[79: 48];
wire [7:0] v5772 = v5771[7:0];
wire [31:0] v5773 = { 24'b000000000000000000000000, v5772 };
wire [31:0] v577b = v5773 << v31;
wire [31:0] v577c = v7c8 | v577b;
wire v5776 = v5775 == vd;
wire v5777 = v5776;
wire v5778 = v5765 & v5777;
wire v5779 = v5778;
wire [31:0] v5774 = v7b8 | v5773;
wire [31:0] v5783 = ( v8 ) ? In_register_EBX : 
	( v5780 ) ? v577c : v5774;
wire [31:0] v5785 = v5783;
wire v5786 = v5785 == Out_register_EBX;
wire v5788 = In_register_CF;
wire v5789 = v5788 == Out_register_CF;
wire v578b = v5775 == vf;
wire v578c = v578b;
wire v578d = v5765 & v578c;
wire v578e = v578d;
wire [31:0] v578a = v790 | v577b;
wire v5791 = v5775 == vc;
wire v5792 = v5791;
wire v5793 = v5765 & v5792;
wire v5794 = v5793;
wire [31:0] v5790 = v7a0 | v5773;
wire [31:0] v5797 = ( v8 ) ? In_register_ECX : 
	( v578e ) ? v578a : v5790;
wire [31:0] v5799 = v5797;
wire v579a = v5799 == Out_register_ECX;
wire [31:0] v579c = In_register_EBP;
wire v579d = v579c == Out_register_EBP;
wire v57a5 = v5775 == v11;
wire v57a6 = v57a5;
wire v57a7 = v5765 & v57a6;
wire v57a8 = v57a7;
wire [31:0] v57a4 = v778 | v577b;
wire v579f = v5775 == ve;
wire v57a0 = v579f;
wire v57a1 = v5765 & v57a0;
wire v57a2 = v57a1;
wire [31:0] v579e = v768 | v5773;
wire [31:0] v57ab = ( v8 ) ? In_register_EDX : 
	( v57a8 ) ? v57a4 : v579e;
wire [31:0] v57ad = v57ab;
wire v57ae = v57ad == Out_register_EDX;
wire v57af = In_error_flag == Out_error_flag;
wire v57b1 = v5775 == v7;
wire v57b2 = v57b1;
wire v57b3 = v5765 & v57b2;
wire v57b4 = v57b3;
wire [31:0] v57b0 = v5c8 | v5773;
wire v57b7 = v5775 == vb;
wire v57b8 = v57b7;
wire v57b9 = v5765 & v57b8;
wire v57ba = v57b9;
wire [31:0] v57b6 = v752 | v577b;
wire [31:0] v57bd = ( v8 ) ? In_register_EAX : 
	( v57b4 ) ? v57b0 : v57b6;
wire [31:0] v57bf = v57bd;
wire v57c0 = v57bf == Out_register_EAX;
wire [31:0] v57c2 = In_register_DSBASE;
wire v57c3 = v57c2 == Out_register_DSBASE;
wire [7:0] v57c5 = In_register_DF;
wire v57c6 = v57c5 == Out_register_DF;
wire [31:0] v57c8 = In_register_ESI;
wire v57c9 = v57c8 == Out_register_ESI;
wire [31:0] v57cb = In_register_ESP;
wire v57cc = v57cb == Out_register_ESP;
wire [31:0] v57ce = In_register_ESBASE;
wire v57cf = v57ce == Out_register_ESBASE;
wire [31:0] v57d1 = In_register_EDI;
wire v57d2 = v57d1 == Out_register_EDI;
wire [31:0] v57d4 = In_register_CSBASE;
wire v57d5 = v57d4 == Out_register_CSBASE;
wire [31:0] v57d7 = In_register_SSBASE;
wire v57d8 = v57d7 == Out_register_SSBASE;
wire [31:0] v57da = In_register_FSBASE;
wire v57db = v57da == Out_register_FSBASE;
wire [31:0] v57dd = In_register_GSBASE;
wire v57de = v57dd == Out_register_GSBASE;
wire v57e0 = In_register_AF;
wire v57e1 = v57e0 == Out_register_AF;
wire v57e3 = In_register_PF;
wire v57e4 = v57e3 == Out_register_PF;
wire [31:0] v57e6 = v10;
wire [31:0] v57e7 = In_register_EIP + v57e6;
wire [31:0] v57e9 = v57e7;
wire v57ea = v57e9 == Out_register_EIP;
wire v57ec = In_register_SF;
wire v57ed = v57ec == Out_register_SF;
wire v57ef = In_register_ZF;
wire v57f0 = v57ef == Out_register_ZF;
wire v57f1 = v5767 & v576d & v15c & v5770 & v5786 & v5789 & v579a & v579d & v57ae & v57af & v57c0 & v57c3 & v57c6 & v57c9 & v57cc & v57cf & v57d2 & v57d5 & v57d8 & v57db & v57de & v57e1 & v57e4 & v57ea & v57ed & v57f0;
wire v57f2 = v4e == v1eb;
wire v57f3 = v13 == v1ed;
wire v57f4 = v1b == v318;
wire v57f5 = v57f2 & v57f3 & v57f4;
wire v57f6 = v57f5;
wire v57f7 = v57f6;
wire [31:0] v57f9 = In_register_CSBASE;
wire v57fa = v57f9 == Out_register_CSBASE;
wire [31:0] v57fc = In_register_EAX;
wire v57fd = v57fc == Out_register_EAX;
wire v57ff = In_register_AF;
wire v5800 = v57ff == Out_register_AF;
wire [31:0] v5802 = In_register_EBX;
wire v5803 = v5802 == Out_register_EBX;
wire [31:0] v5805 = In_register_ESI;
wire v5806 = v5805 == Out_register_ESI;
wire [31:0] v5808 = In_register_EDI;
wire v5809 = v5808 == Out_register_EDI;
wire [31:0] v580b = In_register_ECX;
wire v580c = v580b == Out_register_ECX;
wire [31:0] v580e = In_register_DSBASE;
wire v580f = v580e == Out_register_DSBASE;
wire [31:0] v5811 = In_register_EDX;
wire v5812 = v5811 == Out_register_EDX;
wire [31:0] v5814 = In_register_ESBASE;
wire v5815 = v5814 == Out_register_ESBASE;
wire v5817 = In_register_OF;
wire v5818 = v5817 == Out_register_OF;
wire v581a = In_register_ZF;
wire v581b = v581a == Out_register_ZF;
wire [31:0] v581d = In_register_ESP;
wire v581e = v581d == Out_register_ESP;
wire [31:0] v5820 = In_register_EBP;
wire v5821 = v5820 == Out_register_EBP;
wire [2:0] v5822 = { v1fa };
wire [31:0] v5823 = ( v5822 == 3'd0) ? In_register_EAX : 
	( v5822 == 3'd1) ? In_register_ECX : 
	( v5822 == 3'd2) ? In_register_EDX : 
	( v5822 == 3'd3) ? In_register_EBX : 
	( v5822 == 3'd4) ? In_register_ESP : 
	( v5822 == 3'd5) ? In_register_EBP : 
	( v5822 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5825 = v5823;
wire [31:0] v5828 = v5825;
wire [31:0] v582a = v5828;
wire v582b = v582a == Out_register_EIP;
wire [31:0] v582d = In_register_SSBASE;
wire v582e = v582d == Out_register_SSBASE;
wire [31:0] v5830 = In_register_GSBASE;
wire v5831 = v5830 == Out_register_GSBASE;
wire [31:0] v5833 = In_register_FSBASE;
wire v5834 = v5833 == Out_register_FSBASE;
wire v5835 = In_error_flag == Out_error_flag;
wire [7:0] v5837 = In_register_DF;
wire v5838 = v5837 == Out_register_DF;
wire v583a = In_register_CF;
wire v583b = v583a == Out_register_CF;
wire v583d = In_register_PF;
wire v583e = v583d == Out_register_PF;
wire v5840 = In_register_SF;
wire v5841 = v5840 == Out_register_SF;
wire v5842 = v57f7 & v57fa & v15c & v57fd & v5800 & v5803 & v5806 & v5809 & v580c & v580f & v5812 & v5815 & v5818 & v581b & v581e & v5821 & v582b & v582e & v5831 & v5834 & v5835 & v5838 & v583b & v583e & v5841;
wire [7:0] vf9 = 8'b00010100;
wire v5843 = vf9 == v1eb;
wire v5844 = v35 == v316;
wire v5845 = v1b == v318;
wire [2:0] v5846 = { v1fa };
wire v5847 = v5846 == vb;
wire v5848 = v5846 == vf;
wire v5849 = v5847 | v5848;
wire v584a = v5849 ^ v8;
wire [2:0] v584b = { v1fa };
wire v584c = v584b == vb;
wire v584d = v584b == vf;
wire v584e = v584c | v584d;
wire v584f = v584e ^ v8;
wire [2:0] v5850 = { v1fa };
wire v5851 = v5850 == vb;
wire v5852 = v5850 == vf;
wire v5853 = v5851 | v5852;
wire v5854 = v5853 ^ v8;
wire [2:0] v5855 = { v1fa };
wire v5856 = v5855 == vb;
wire v5857 = v5855 == vf;
wire v5858 = v5856 | v5857;
wire v5859 = v5858 ^ v8;
wire v585a = v584a & v584f & v5854 & v5859;
wire v585b = v5843 & v5844 & v5845 & v585a;
wire v585c = vf9 == v1eb;
wire v585d = v2f == v316;
wire v585e = v14 == v1ef;
wire [2:0] v585f = { v1fa };
wire v5860 = v585f == vb;
wire v5861 = v585f == vf;
wire v5862 = v5860 | v5861;
wire v5863 = v5862 ^ v8;
wire [2:0] v5864 = { v1fa };
wire v5865 = v5864 == vb;
wire v5866 = v5865;
wire v5867 = v5866 ^ v8;
wire [2:0] v5868 = { v1fa };
wire v5869 = v5868 == vb;
wire v586a = v5868 == vf;
wire v586b = v5869 | v586a;
wire v586c = v586b ^ v8;
wire [2:0] v586d = { v1fa };
wire v586e = v586d == vb;
wire v586f = v586e;
wire v5870 = v586f ^ v8;
wire v5871 = v5863 & v5867 & v586c & v5870;
wire v5872 = v585c & v585d & v585e & v5871;
wire v5873 = vf9 == v1eb;
wire v5874 = v30 == v316;
wire v5875 = v4 == v11b;
wire [2:0] v5876 = { v1fa };
wire v5877 = v5876 == vb;
wire v5878 = v5877;
wire v5879 = v5878 ^ v8;
wire [2:0] v587a = { v1fa };
wire v587b = v587a == vb;
wire v587c = v587b;
wire v587d = v587c ^ v8;
wire [2:0] v587e = { v1fa };
wire v587f = v587e == vb;
wire v5880 = v587f;
wire v5881 = v5880 ^ v8;
wire [2:0] v5882 = { v1fa };
wire v5883 = v5882 == vb;
wire v5884 = v5883;
wire v5885 = v5884 ^ v8;
wire v5886 = v5879 & v587d & v5881 & v5885;
wire v5887 = v5873 & v5874 & v5875 & v5886;
wire v5888 = v585b | v5872 | v5887;
wire v5889 = v5888;
wire [31:0] v588b = In_register_ECX;
wire v588c = v588b == Out_register_ECX;
wire [31:0] v588d = memory_0[79: 48];
wire [7:0] v588e = v588d[7:0];
wire [2:0] v588f = { v320 };
wire [31:0] v5890 = ( v588f == 3'd0) ? In_register_EAX : 
	( v588f == 3'd1) ? In_register_ECX : 
	( v588f == 3'd2) ? In_register_EDX : 
	( v588f == 3'd3) ? In_register_EBX : 
	( v588f == 3'd4) ? In_register_EAX : 
	( v588f == 3'd5) ? In_register_ECX : 
	( v588f == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5891 = { v320 };
wire v5892 = v5891 == vb;
wire v5893 = v5891 == v9;
wire v5894 = v5892 | v5893;
wire v5895 = v5891 == vf;
wire v5896 = v5894 | v5895;
wire v5897 = v5891 == v11;
wire v5898 = v5896 | v5897;
wire [31:0] v5899 = ( v5898 == 1'd0) ? v15 : v31;
wire [31:0] v589a = v5890 >> v5899;
wire [31:0] v589b = v589a & v32;
wire [2:0] v589d = { v320 };
wire [31:0] v589e = ( v589d == 3'd0) ? In_register_EAX : 
	( v589d == 3'd1) ? In_register_ECX : 
	( v589d == 3'd2) ? In_register_EDX : 
	( v589d == 3'd3) ? In_register_EBX : 
	( v589d == 3'd4) ? In_register_EAX : 
	( v589d == 3'd5) ? In_register_ECX : 
	( v589d == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v589f = { v320 };
wire v58a0 = v589f == vb;
wire v58a1 = v589f == v9;
wire v58a2 = v58a0 | v58a1;
wire v58a3 = v589f == vf;
wire v58a4 = v58a2 | v58a3;
wire v58a5 = v589f == v11;
wire v58a6 = v58a4 | v58a5;
wire [31:0] v58a7 = ( v58a6 == 1'd0) ? v15 : v31;
wire [31:0] v58a8 = v589e >> v58a7;
wire [31:0] v58a9 = v58a8 & v32;
wire [2:0] v58ab = { v320 };
wire [31:0] v58ac = ( v58ab == 3'd0) ? In_register_EAX : 
	( v58ab == 3'd1) ? In_register_ECX : 
	( v58ab == 3'd2) ? In_register_EDX : 
	( v58ab == 3'd3) ? In_register_EBX : 
	( v58ab == 3'd4) ? In_register_EAX : 
	( v58ab == 3'd5) ? In_register_ECX : 
	( v58ab == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v58ad = { v320 };
wire v58ae = v58ad == vb;
wire v58af = v58ad == v9;
wire v58b0 = v58ae | v58af;
wire v58b1 = v58ad == vf;
wire v58b2 = v58b0 | v58b1;
wire v58b3 = v58ad == v11;
wire v58b4 = v58b2 | v58b3;
wire [31:0] v58b5 = ( v58b4 == 1'd0) ? v15 : v31;
wire [31:0] v58b6 = v58ac >> v58b5;
wire [31:0] v58b7 = v58b6 & v32;
wire [31:0] v58b9 = ( v585b ) ? v589b : 
	( v5872 ) ? v58a9 : v58b7;
wire [7:0] v58ba = v58b9[7:0];
wire [7:0] v58bb = v588e ^ v58ba;
wire [7:0] v58bc = v588e - v58ba;
wire [7:0] v58bd = v58bb ^ v58bc;
wire [7:0] v58be = v58bd >> v1d;
wire [7:0] v58bf = v58be & v18;
wire v58c0 = v58bf[0:0];
wire v58c2 = v58c0;
wire v58c3 = v58c2 == Out_register_AF;
wire [2:0] v58c7 = { v1fa };
wire [31:0] v58c8 = ( v58c7 == 3'd0) ? In_register_EAX : 
	( v58c7 == 3'd1) ? In_register_ECX : 
	( v58c7 == 3'd2) ? In_register_EDX : 
	( v58c7 == 3'd3) ? In_register_EBX : 
	( v58c7 == 3'd4) ? v15 : 
	( v58c7 == 3'd5) ? v15 : 
	( v58c7 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58c9 = v58c8 + v1f7;
wire [2:0] v58cb = { v1fa };
wire [31:0] v58cc = ( v58cb == 3'd0) ? In_register_EAX : 
	( v58cb == 3'd1) ? In_register_ECX : 
	( v58cb == 3'd2) ? In_register_EDX : 
	( v58cb == 3'd3) ? In_register_EBX : 
	( v58cb == 3'd4) ? v15 : 
	( v58cb == 3'd5) ? In_register_EBP : 
	( v58cb == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58cd = v58cc + v63a;
wire [2:0] v58c4 = { v1fa };
wire [31:0] v58c5 = ( v58c4 == 3'd0) ? In_register_EAX : 
	( v58c4 == 3'd1) ? In_register_ECX : 
	( v58c4 == 3'd2) ? In_register_EDX : 
	( v58c4 == 3'd3) ? In_register_EBX : 
	( v58c4 == 3'd4) ? v15 : 
	( v58c4 == 3'd5) ? v15 : 
	( v58c4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58cf = ( v5872 ) ? v58c9 : 
	( v5887 ) ? v58cd : v58c5;
wire v58d0 =  v2a == memory_0[15: 12] && v58cf == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v58d1 = v588e < v58ba;
wire v58d3 = v58d1;
wire v58d4 = v58d3 == Out_register_CF;
wire [31:0] v58d8 = ( v585b ) ? v1c : 
	( v5872 ) ? v16 : v10;
wire [31:0] v58d9 = In_register_EIP + v58d8;
wire [31:0] v58db = v58d9;
wire v58dc = v58db == Out_register_EIP;
wire v58dd = In_error_flag == Out_error_flag;
wire [7:0] v58de = v58bc ^ v588e;
wire [7:0] v58df = v58de >> v33;
wire [7:0] v58e0 = v58bb >> v33;
wire [7:0] v58e1 = v58df + v58e0;
wire v58e2 = v58e1 == v34;
wire v58e4 = v58e2;
wire v58e5 = v58e4 == Out_register_OF;
wire [31:0] v58e7 = In_register_SSBASE;
wire v58e8 = v58e7 == Out_register_SSBASE;
wire [31:0] v58ea = In_register_EAX;
wire v58eb = v58ea == Out_register_EAX;
wire [31:0] v58ed = In_register_ESP;
wire v58ee = v58ed == Out_register_ESP;
wire [31:0] v58f0 = In_register_EBX;
wire v58f1 = v58f0 == Out_register_EBX;
wire [2:0] v58f5 = { v1fa };
wire [31:0] v58f6 = ( v58f5 == 3'd0) ? In_register_EAX : 
	( v58f5 == 3'd1) ? In_register_ECX : 
	( v58f5 == 3'd2) ? In_register_EDX : 
	( v58f5 == 3'd3) ? In_register_EBX : 
	( v58f5 == 3'd4) ? v15 : 
	( v58f5 == 3'd5) ? v15 : 
	( v58f5 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58f7 = v58f6 + v1f7;
wire [2:0] v58f9 = { v1fa };
wire [31:0] v58fa = ( v58f9 == 3'd0) ? In_register_EAX : 
	( v58f9 == 3'd1) ? In_register_ECX : 
	( v58f9 == 3'd2) ? In_register_EDX : 
	( v58f9 == 3'd3) ? In_register_EBX : 
	( v58f9 == 3'd4) ? v15 : 
	( v58f9 == 3'd5) ? In_register_EBP : 
	( v58f9 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58fb = v58fa + v63a;
wire [2:0] v58f2 = { v1fa };
wire [31:0] v58f3 = ( v58f2 == 3'd0) ? In_register_EAX : 
	( v58f2 == 3'd1) ? In_register_ECX : 
	( v58f2 == 3'd2) ? In_register_EDX : 
	( v58f2 == 3'd3) ? In_register_EBX : 
	( v58f2 == 3'd4) ? v15 : 
	( v58f2 == 3'd5) ? v15 : 
	( v58f2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v58fd = ( v5872 ) ? v58f7 : 
	( v5887 ) ? v58fb : v58f3;
wire v58fe =  v2a == memory_1[15: 12] && v58fd == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v58bc == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [7:0] v5900 = In_register_DF;
wire v5901 = v5900 == Out_register_DF;
wire [31:0] v5903 = In_register_ESI;
wire v5904 = v5903 == Out_register_ESI;
wire [31:0] v5906 = In_register_EDI;
wire v5907 = v5906 == Out_register_EDI;
wire [31:0] v5909 = In_register_CSBASE;
wire v590a = v5909 == Out_register_CSBASE;
wire [31:0] v590c = In_register_ESBASE;
wire v590d = v590c == Out_register_ESBASE;
wire [31:0] v590f = In_register_DSBASE;
wire v5910 = v590f == Out_register_DSBASE;
wire [31:0] v5912 = In_register_GSBASE;
wire v5913 = v5912 == Out_register_GSBASE;
wire [31:0] v5915 = In_register_EBP;
wire v5916 = v5915 == Out_register_EBP;
wire [31:0] v5918 = In_register_EDX;
wire v5919 = v5918 == Out_register_EDX;
wire [31:0] v591b = In_register_FSBASE;
wire v591c = v591b == Out_register_FSBASE;
wire [2:0] v591d_aux = v58bc[0] + v58bc[1] + v58bc[2] + v58bc[3] + v58bc[4] + v58bc[5] + v58bc[6] + v58bc[7];
wire v591d = { 5'b00000, v591d_aux };
wire [7:0] v591e = v591d & v18;
wire [7:0] v591f = v591e ^ v18;
wire v5920 = v591f[0:0];
wire v5922 = v5920;
wire v5923 = v5922 == Out_register_PF;
wire v5924 = $signed(v58bc) < $signed(v2c);
wire v5926 = v5924;
wire v5927 = v5926 == Out_register_SF;
wire v5928 = v588e == v58ba;
wire v592a = v5928;
wire v592b = v592a == Out_register_ZF;
wire v592c = v5889 & v588c & v58c3 & v58d0 & v58d4 & v58dc & v58dd & v58e5 & v58e8 & v58eb & v58ee & v15c & v58f1 & v58fe & v5901 & v5904 & v5907 & v590a & v590d & v5910 & v5913 & v5916 & v5919 & v591c & v5923 & v5927 & v592b;
wire [7:0] vfa = 8'b00011001;
wire v592d = vfa == v1eb;
wire v592e = v29 == v59f;
wire v592f = v592d & v592e;
wire v5930 = v592f;
wire v5931 = v5930;
wire v5933 = In_register_AF;
wire v5934 = v5933 == Out_register_AF;
wire v5936 = In_register_OF;
wire v5937 = v5936 == Out_register_OF;
wire v5939 = In_register_SF;
wire v593a = v5939 == Out_register_SF;
wire [31:0] v593c = In_register_ESI;
wire v593d = v593c == Out_register_ESI;
wire [31:0] v593f = In_register_ECX;
wire v5940 = v593f == Out_register_ECX;
wire v5941 = In_error_flag == Out_error_flag;
wire [31:0] v5943 = In_register_EBX;
wire v5944 = v5943 == Out_register_EBX;
wire [31:0] v5946 = In_register_EDI;
wire v5947 = v5946 == Out_register_EDI;
wire [31:0] v5949 = In_register_EDX;
wire v594a = v5949 == Out_register_EDX;
wire [31:0] v594c = In_register_ESP;
wire v594d = v594c == Out_register_ESP;
wire [31:0] v594f = In_register_EBP;
wire v5950 = v594f == Out_register_EBP;
wire [31:0] v5952 = v2867;
wire v5953 = v5952 == Out_register_EAX;
wire [31:0] v5955 = v2b;
wire [31:0] v5956 = In_register_EIP + v5955;
wire [31:0] v5958 = v5956;
wire v5959 = v5958 == Out_register_EIP;
wire v595b = In_register_PF;
wire v595c = v595b == Out_register_PF;
wire [31:0] v595e = In_register_CSBASE;
wire v595f = v595e == Out_register_CSBASE;
wire [31:0] v5961 = In_register_ESBASE;
wire v5962 = v5961 == Out_register_ESBASE;
wire [31:0] v5964 = In_register_GSBASE;
wire v5965 = v5964 == Out_register_GSBASE;
wire [31:0] v5967 = In_register_SSBASE;
wire v5968 = v5967 == Out_register_SSBASE;
wire [31:0] v596a = In_register_FSBASE;
wire v596b = v596a == Out_register_FSBASE;
wire v596d = In_register_CF;
wire v596e = v596d == Out_register_CF;
wire [31:0] v5970 = In_register_DSBASE;
wire v5971 = v5970 == Out_register_DSBASE;
wire [7:0] v5973 = In_register_DF;
wire v5974 = v5973 == Out_register_DF;
wire v5976 = In_register_ZF;
wire v5977 = v5976 == Out_register_ZF;
wire v5978 = v5931 & v5934 & v5937 & v593a & v593d & v5940 & v5941 & v5944 & v5947 & v594a & v594d & v5950 & v15c & v5953 & v5959 & v595c & v595f & v5962 & v5965 & v5968 & v596b & v596e & v5971 & v5974 & v5977;
wire [15:0] vfb = 16'b0111111100100000;
wire v5979 = vfb == v117;
wire v597a = v4 == v11b;
wire [2:0] v597b = { v13c };
wire v597c = v597b == vb;
wire v597d = v597b == vf;
wire v597e = v597c | v597d;
wire v597f = v597e ^ v8;
wire [2:0] v5980 = { v12c };
wire v5981 = v5980 == vb;
wire v5982 = v5981;
wire v5983 = v5982 ^ v8;
wire [2:0] v5984 = { v13c };
wire v5985 = v5984 == vf;
wire v5986 = v5985;
wire v5987 = v5986 ^ v8;
wire [2:0] v5988 = { v13c };
wire v5989 = v5988 == vb;
wire v598a = v5988 == vf;
wire v598b = v5989 | v598a;
wire v598c = v598b ^ v8;
wire [2:0] v598d = { v12c };
wire v598e = v598d == vb;
wire v598f = v598e;
wire v5990 = v598f ^ v8;
wire [2:0] v5991 = { v13c };
wire v5992 = v5991 == vf;
wire v5993 = v5992;
wire v5994 = v5993 ^ v8;
wire v5995 = v597f & v5983 & v5987 & v598c & v5990 & v5994;
wire v5996 = v5979 & v597a & v5995;
wire v5997 = v5996;
wire v5998 = v5997;
wire [31:0] v599a = In_register_ESI;
wire v599b = v599a == Out_register_ESI;
wire [2:0] v599c = { v13c };
wire [31:0] v599d = ( v599c == 3'd0) ? In_register_EAX : 
	( v599c == 3'd1) ? In_register_ECX : 
	( v599c == 3'd2) ? In_register_EDX : 
	( v599c == 3'd3) ? In_register_EBX : 
	( v599c == 3'd4) ? v15 : 
	( v599c == 3'd5) ? v15 : 
	( v599c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v599e = { v12c };
wire [31:0] v599f = ( v599e == 3'd0) ? In_register_EAX : 
	( v599e == 3'd1) ? In_register_ECX : 
	( v599e == 3'd2) ? In_register_EDX : 
	( v599e == 3'd3) ? In_register_EBX : 
	( v599e == 3'd4) ? v15 : 
	( v599e == 3'd5) ? In_register_EBP : 
	( v599e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v59a0 = v599f << v7f4;
wire [31:0] v59a1 = v599d + v59a0;
wire [31:0] v59a3 = v59a1;
wire [31:0] v59a4 = memory_0[79: 48];
wire [7:0] v59a5 = v59a4[7:0];
wire [7:0] v59a6 = v59a5 + v18;
wire v59a7 =  v2a == memory_1[15: 12] && v59a3 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v59a6 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v59a9 = In_register_EBX;
wire v59aa = v59a9 == Out_register_EBX;
wire [31:0] v59ac = In_register_EBP;
wire v59ad = v59ac == Out_register_EBP;
wire [31:0] v59af = In_register_ECX;
wire v59b0 = v59af == Out_register_ECX;
wire [31:0] v59b2 = In_register_EAX;
wire v59b3 = v59b2 == Out_register_EAX;
wire [31:0] v59b5 = In_register_DSBASE;
wire v59b6 = v59b5 == Out_register_DSBASE;
wire [7:0] v59b7 = v59a6 ^ v59a5;
wire [7:0] v59b8 = v59b7 >> v1d;
wire [7:0] v59b9 = v59b8 & v18;
wire v59ba = v59b9[0:0];
wire v59bc = v59ba;
wire v59bd = v59bc == Out_register_AF;
wire v59be = In_error_flag == Out_error_flag;
wire [31:0] v59c0 = In_register_EDX;
wire v59c1 = v59c0 == Out_register_EDX;
wire v59c2 = $signed(v59a6) < $signed(v2c);
wire v59c4 = v59c2;
wire v59c5 = v59c4 == Out_register_SF;
wire [31:0] v59c7 = In_register_GSBASE;
wire v59c8 = v59c7 == Out_register_GSBASE;
wire [31:0] v59ca = In_register_EDI;
wire v59cb = v59ca == Out_register_EDI;
wire [2:0] v59cc = { v13c };
wire [31:0] v59cd = ( v59cc == 3'd0) ? In_register_EAX : 
	( v59cc == 3'd1) ? In_register_ECX : 
	( v59cc == 3'd2) ? In_register_EDX : 
	( v59cc == 3'd3) ? In_register_EBX : 
	( v59cc == 3'd4) ? v15 : 
	( v59cc == 3'd5) ? v15 : 
	( v59cc == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v59ce = { v12c };
wire [31:0] v59cf = ( v59ce == 3'd0) ? In_register_EAX : 
	( v59ce == 3'd1) ? In_register_ECX : 
	( v59ce == 3'd2) ? In_register_EDX : 
	( v59ce == 3'd3) ? In_register_EBX : 
	( v59ce == 3'd4) ? v15 : 
	( v59ce == 3'd5) ? In_register_EBP : 
	( v59ce == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v59d0 = v59cf << v7f4;
wire [31:0] v59d1 = v59cd + v59d0;
wire [31:0] v59d3 = v59d1;
wire v59d4 =  v2a == memory_0[15: 12] && v59d3 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v59d6 = v10;
wire [31:0] v59d7 = In_register_EIP + v59d6;
wire [31:0] v59d9 = v59d7;
wire v59da = v59d9 == Out_register_EIP;
wire [31:0] v59dc = In_register_ESP;
wire v59dd = v59dc == Out_register_ESP;
wire [31:0] v59df = In_register_CSBASE;
wire v59e0 = v59df == Out_register_CSBASE;
wire [31:0] v59e2 = In_register_SSBASE;
wire v59e3 = v59e2 == Out_register_SSBASE;
wire [31:0] v59e5 = In_register_ESBASE;
wire v59e6 = v59e5 == Out_register_ESBASE;
wire [31:0] v59e8 = In_register_FSBASE;
wire v59e9 = v59e8 == Out_register_FSBASE;
wire v59eb = In_register_CF;
wire v59ec = v59eb == Out_register_CF;
wire [7:0] v59ee = In_register_DF;
wire v59ef = v59ee == Out_register_DF;
wire v59f0 = v59a6 == v2c;
wire v59f2 = v59f0;
wire v59f3 = v59f2 == Out_register_ZF;
wire [7:0] v59f4 = v59b7 >> v33;
wire [7:0] v59f5 = v59a6 >> v33;
wire [7:0] v59f6 = v59f4 + v59f5;
wire v59f7 = v59f6 == v34;
wire v59f9 = v59f7;
wire v59fa = v59f9 == Out_register_OF;
wire [2:0] v59fb_aux = v59a6[0] + v59a6[1] + v59a6[2] + v59a6[3] + v59a6[4] + v59a6[5] + v59a6[6] + v59a6[7];
wire v59fb = { 5'b00000, v59fb_aux };
wire [7:0] v59fc = v59fb & v18;
wire [7:0] v59fd = v59fc ^ v18;
wire v59fe = v59fd[0:0];
wire v5a00 = v59fe;
wire v5a01 = v5a00 == Out_register_PF;
wire v5a02 = v599b & v15c & v59a7 & v59aa & v59ad & v59b0 & v59b3 & v59b6 & v59bd & v59be & v59c1 & v59c5 & v59c8 & v59cb & v59d4 & v5998 & v59da & v59dd & v59e0 & v59e3 & v59e6 & v59e9 & v59ec & v59ef & v59f3 & v59fa & v5a01;
wire v5a0a = v3e == v1eb;
wire v5a0b = v98 == v1ed;
wire v5a0c = v43 == vab3;
wire [2:0] v5a0d = { v1fa };
wire v5a0e = v5a0d == vb;
wire v5a0f = v5a0e;
wire v5a10 = v5a0f ^ v8;
wire [2:0] v5a11 = { v1fa };
wire v5a12 = v5a11 == vb;
wire v5a13 = v5a12;
wire v5a14 = v5a13 ^ v8;
wire v5a15 = v5a10 & v5a14;
wire v5a16 = v5a0a & v5a0b & v5a0c & v5a15;
wire [2:0] v5a07 = { v1fa };
wire [31:0] v5a08 = ( v5a07 == 3'd0) ? In_register_EAX : 
	( v5a07 == 3'd1) ? In_register_ECX : 
	( v5a07 == 3'd2) ? In_register_EDX : 
	( v5a07 == 3'd3) ? In_register_EBX : 
	( v5a07 == 3'd4) ? v15 : 
	( v5a07 == 3'd5) ? In_register_EBP : 
	( v5a07 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5a09 = v5a08 + v1f7;
wire [15:0] vfc = 16'b0000000110111100;
wire v5a03 = vfc == v117;
wire v5a04 = v43 == vab3;
wire v5a05 = v5a03 & v5a04;
wire [31:0] v5a18 = ( v5a16 ) ? v5a09 : v1f7;
wire v5a19 =  v2a == memory_0[15: 12] && v5a18 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v5a1a = v5a05 | v5a16;
wire v5a1b = v5a1a;
wire [31:0] v5a1d = In_register_ESP;
wire v5a1e = v5a1d == Out_register_ESP;
wire [31:0] v5a20 = In_register_EBX;
wire v5a21 = v5a20 == Out_register_EBX;
wire [31:0] v5a23 = In_register_ESI;
wire v5a24 = v5a23 == Out_register_ESI;
wire [31:0] v5a26 = In_register_ESBASE;
wire v5a27 = v5a26 == Out_register_ESBASE;
wire [31:0] v5a29 = In_register_CSBASE;
wire v5a2a = v5a29 == Out_register_CSBASE;
wire [31:0] v5a2c = In_register_EAX;
wire v5a2d = v5a2c == Out_register_EAX;
wire v5a2e = In_error_flag == Out_error_flag;
wire [31:0] v5a30 = In_register_ECX;
wire v5a31 = v5a30 == Out_register_ECX;
wire [7:0] v5a33 = In_register_DF;
wire v5a34 = v5a33 == Out_register_DF;
wire [31:0] v5a35 = memory_0[79: 48];
wire [7:0] v5a36 = v5a35[7:0];
wire [31:0] v5a39 = vb0c;
wire [7:0] v5a3a = v5a39[7:0];
wire [7:0] v5a3b = v5a36 - v5a3a;
wire [7:0] v5a3c = v5a3b ^ v5a36;
wire [7:0] v5a3d = v5a3c >> v33;
wire [7:0] v5a3e = v5a36 ^ v5a3a;
wire [7:0] v5a3f = v5a3e >> v33;
wire [7:0] v5a40 = v5a3d + v5a3f;
wire v5a41 = v5a40 == v34;
wire v5a43 = v5a41;
wire v5a44 = v5a43 == Out_register_OF;
wire [31:0] v5a46 = In_register_EDX;
wire v5a47 = v5a46 == Out_register_EDX;
wire v5a48 = v5a36 < v5a3a;
wire v5a4a = v5a48;
wire v5a4b = v5a4a == Out_register_CF;
wire [31:0] v5a4d = In_register_FSBASE;
wire v5a4e = v5a4d == Out_register_FSBASE;
wire [31:0] v5a50 = In_register_GSBASE;
wire v5a51 = v5a50 == Out_register_GSBASE;
wire [31:0] v5a53 = In_register_EDI;
wire v5a54 = v5a53 == Out_register_EDI;
wire [7:0] v5a55 = v5a3e ^ v5a3b;
wire [7:0] v5a56 = v5a55 >> v1d;
wire [7:0] v5a57 = v5a56 & v18;
wire v5a58 = v5a57[0:0];
wire v5a5a = v5a58;
wire v5a5b = v5a5a == Out_register_AF;
wire [2:0] v5a5c_aux = v5a3b[0] + v5a3b[1] + v5a3b[2] + v5a3b[3] + v5a3b[4] + v5a3b[5] + v5a3b[6] + v5a3b[7];
wire v5a5c = { 5'b00000, v5a5c_aux };
wire [7:0] v5a5d = v5a5c & v18;
wire [7:0] v5a5e = v5a5d ^ v18;
wire v5a5f = v5a5e[0:0];
wire v5a61 = v5a5f;
wire v5a62 = v5a61 == Out_register_PF;
wire [31:0] v5a64 = In_register_EBP;
wire v5a65 = v5a64 == Out_register_EBP;
wire [31:0] v5a68 = v45;
wire [31:0] v5a69 = In_register_EIP + v5a68;
wire [31:0] v5a6b = v5a69;
wire v5a6c = v5a6b == Out_register_EIP;
wire [31:0] v5a6e = In_register_SSBASE;
wire v5a6f = v5a6e == Out_register_SSBASE;
wire v5a70 = v5a36 == v5a3a;
wire v5a72 = v5a70;
wire v5a73 = v5a72 == Out_register_ZF;
wire [31:0] v5a75 = In_register_DSBASE;
wire v5a76 = v5a75 == Out_register_DSBASE;
wire v5a77 = $signed(v5a3b) < $signed(v2c);
wire v5a79 = v5a77;
wire v5a7a = v5a79 == Out_register_SF;
wire v5a7b = v5a19 & v5a1e & v5a21 & v5a24 & v5a27 & v5a2a & v5a2d & v5a2e & v15c & v5a31 & v5a1b & v5a34 & v5a44 & v5a47 & v5a4b & v5a4e & v5a51 & v5a54 & v5a5b & v5a62 & v5a65 & v5a6c & v5a6f & v5a73 & v5a76 & v5a7a;
wire v5a7c = v5d == v1eb;
wire v5a7d = v30 == v316;
wire v5a7e = v4 == v11b;
wire [2:0] v5a7f = { v1fa };
wire v5a80 = v5a7f == vb;
wire v5a81 = v5a80;
wire v5a82 = v5a81 ^ v8;
wire [2:0] v5a83 = { v1fa };
wire v5a84 = v5a83 == vb;
wire v5a85 = v5a84;
wire v5a86 = v5a85 ^ v8;
wire [2:0] v5a87 = { v1fa };
wire v5a88 = v5a87 == vb;
wire v5a89 = v5a88;
wire v5a8a = v5a89 ^ v8;
wire [2:0] v5a8b = { v1fa };
wire v5a8c = v5a8b == vb;
wire v5a8d = v5a8c;
wire v5a8e = v5a8d ^ v8;
wire v5a8f = v5a82 & v5a86 & v5a8a & v5a8e;
wire v5a90 = v5a7c & v5a7d & v5a7e & v5a8f;
wire [10:0] vfd = 11'b00010000101;
wire v5a91 = vfd == v6d7;
wire v5a92 = v35 == v316;
wire v5a93 = v14 == v1ef;
wire v5a94 = v5a91 & v5a92 & v5a93;
wire [10:0] vfe = 11'b00010000001;
wire v5a95 = vfe == v6d7;
wire v5a96 = v30 == v316;
wire v5a97 = v94 == v20a0;
wire v5a98 = v38 == v6da;
wire [2:0] v5a99 = { v13c };
wire v5a9a = v5a99 == v7;
wire v5a9b = v5a99 == vc;
wire v5a9c = v5a99 == ve;
wire v5a9d = v5a99 == vd;
wire v5a9e = v5a99 == v11;
wire v5a9f = v5a99 == v9;
wire v5aa0 = v5a9a | v5a9b | v5a9c | v5a9d | v5a9e | v5a9f;
wire v5aa1 = v5aa0 ^ v8;
wire [2:0] v5aa2 = { v13c };
wire v5aa3 = v5aa2 == v7;
wire v5aa4 = v5aa2 == vc;
wire v5aa5 = v5aa2 == ve;
wire v5aa6 = v5aa2 == vd;
wire v5aa7 = v5aa2 == v11;
wire v5aa8 = v5aa2 == v9;
wire v5aa9 = v5aa3 | v5aa4 | v5aa5 | v5aa6 | v5aa7 | v5aa8;
wire v5aaa = v5aa9 ^ v8;
wire v5aab = v5aa1 & v5aaa;
wire v5aac = v5a95 & v5a96 & v5a97 & v5a98 & v5aab;
wire v5aad = v5d == v1eb;
wire v5aae = v2f == v316;
wire v5aaf = v14 == v1ef;
wire [2:0] v5ab0 = { v1fa };
wire v5ab1 = v5ab0 == vb;
wire v5ab2 = v5ab0 == vf;
wire v5ab3 = v5ab1 | v5ab2;
wire v5ab4 = v5ab3 ^ v8;
wire [2:0] v5ab5 = { v1fa };
wire v5ab6 = v5ab5 == vb;
wire v5ab7 = v5ab6;
wire v5ab8 = v5ab7 ^ v8;
wire [2:0] v5ab9 = { v1fa };
wire v5aba = v5ab9 == vb;
wire v5abb = v5ab9 == vf;
wire v5abc = v5aba | v5abb;
wire v5abd = v5abc ^ v8;
wire [2:0] v5abe = { v1fa };
wire v5abf = v5abe == vb;
wire v5ac0 = v5abf;
wire v5ac1 = v5ac0 ^ v8;
wire v5ac2 = v5ab4 & v5ab8 & v5abd & v5ac1;
wire v5ac3 = v5aad & v5aae & v5aaf & v5ac2;
wire v5ac4 = v5d == v1eb;
wire v5ac5 = v35 == v316;
wire v5ac6 = v1b == v318;
wire [2:0] v5ac7 = { v1fa };
wire v5ac8 = v5ac7 == vb;
wire v5ac9 = v5ac7 == vf;
wire v5aca = v5ac8 | v5ac9;
wire v5acb = v5aca ^ v8;
wire [2:0] v5acc = { v1fa };
wire v5acd = v5acc == vb;
wire v5ace = v5acc == vf;
wire v5acf = v5acd | v5ace;
wire v5ad0 = v5acf ^ v8;
wire [2:0] v5ad1 = { v1fa };
wire v5ad2 = v5ad1 == vb;
wire v5ad3 = v5ad1 == vf;
wire v5ad4 = v5ad2 | v5ad3;
wire v5ad5 = v5ad4 ^ v8;
wire [2:0] v5ad6 = { v1fa };
wire v5ad7 = v5ad6 == vb;
wire v5ad8 = v5ad6 == vf;
wire v5ad9 = v5ad7 | v5ad8;
wire v5ada = v5ad9 ^ v8;
wire v5adb = v5acb & v5ad0 & v5ad5 & v5ada;
wire v5adc = v5ac4 & v5ac5 & v5ac6 & v5adb;
wire v5add = vfe == v6d7;
wire v5ade = v35 == v316;
wire v5adf = instruction_bits[17: 17];
wire v5ae0 = v8 == v5adf;
wire v5ae1 = v4 == v11b;
wire [2:0] v5ae2 = { v12c };
wire v5ae3 = v5ae2 == vb;
wire v5ae4 = v5ae3;
wire v5ae5 = v5ae4 ^ v8;
wire [2:0] v5ae6 = { v12c };
wire v5ae7 = v5ae6 == vb;
wire v5ae8 = v5ae7;
wire v5ae9 = v5ae8 ^ v8;
wire v5aea = v5ae5 & v5ae9;
wire v5aeb = v5add & v5ade & v5ae0 & v5ae1 & v5aea;
wire v5aec = v5a90 | v5a94 | v5aac | v5ac3 | v5adc | v5aeb;
wire v5aed = v5aec;
wire v5aef = v17;
wire v5af0 = v5aef == Out_register_CF;
wire [31:0] v5af2 = In_register_CSBASE;
wire v5af3 = v5af2 == Out_register_CSBASE;
wire [31:0] v5af5 = In_register_SSBASE;
wire v5af6 = v5af5 == Out_register_SSBASE;
wire [31:0] v5af7 = memory_0[79: 48];
wire [7:0] v5af8 = v5af7[7:0];
wire [2:0] v5b31 = { v320 };
wire [31:0] v5b32 = ( v5b31 == 3'd0) ? In_register_EAX : 
	( v5b31 == 3'd1) ? In_register_ECX : 
	( v5b31 == 3'd2) ? In_register_EDX : 
	( v5b31 == 3'd3) ? In_register_EBX : 
	( v5b31 == 3'd4) ? In_register_EAX : 
	( v5b31 == 3'd5) ? In_register_ECX : 
	( v5b31 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5b33 = { v320 };
wire v5b34 = v5b33 == vb;
wire v5b35 = v5b33 == v9;
wire v5b36 = v5b34 | v5b35;
wire v5b37 = v5b33 == vf;
wire v5b38 = v5b36 | v5b37;
wire v5b39 = v5b33 == v11;
wire v5b3a = v5b38 | v5b39;
wire [31:0] v5b3b = ( v5b3a == 1'd0) ? v15 : v31;
wire [31:0] v5b3c = v5b32 >> v5b3b;
wire [31:0] v5b3d = v5b3c & v32;
wire [2:0] v5b3f = { v320 };
wire [31:0] v5b40 = ( v5b3f == 3'd0) ? In_register_EAX : 
	( v5b3f == 3'd1) ? In_register_ECX : 
	( v5b3f == 3'd2) ? In_register_EDX : 
	( v5b3f == 3'd3) ? In_register_EBX : 
	( v5b3f == 3'd4) ? In_register_EAX : 
	( v5b3f == 3'd5) ? In_register_ECX : 
	( v5b3f == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5b41 = { v320 };
wire v5b42 = v5b41 == vb;
wire v5b43 = v5b41 == v9;
wire v5b44 = v5b42 | v5b43;
wire v5b45 = v5b41 == vf;
wire v5b46 = v5b44 | v5b45;
wire v5b47 = v5b41 == v11;
wire v5b48 = v5b46 | v5b47;
wire [31:0] v5b49 = ( v5b48 == 1'd0) ? v15 : v31;
wire [31:0] v5b4a = v5b40 >> v5b49;
wire [31:0] v5b4b = v5b4a & v32;
wire [2:0] v5af9 = { v320 };
wire [31:0] v5afa = ( v5af9 == 3'd0) ? In_register_EAX : 
	( v5af9 == 3'd1) ? In_register_ECX : 
	( v5af9 == 3'd2) ? In_register_EDX : 
	( v5af9 == 3'd3) ? In_register_EBX : 
	( v5af9 == 3'd4) ? In_register_EAX : 
	( v5af9 == 3'd5) ? In_register_ECX : 
	( v5af9 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5afb = { v320 };
wire v5afc = v5afb == vb;
wire v5afd = v5afb == v9;
wire v5afe = v5afc | v5afd;
wire v5aff = v5afb == vf;
wire v5b00 = v5afe | v5aff;
wire v5b01 = v5afb == v11;
wire v5b02 = v5b00 | v5b01;
wire [31:0] v5b03 = ( v5b02 == 1'd0) ? v15 : v31;
wire [31:0] v5b04 = v5afa >> v5b03;
wire [31:0] v5b05 = v5b04 & v32;
wire [2:0] v5b07 = { v320 };
wire [31:0] v5b08 = ( v5b07 == 3'd0) ? In_register_EAX : 
	( v5b07 == 3'd1) ? In_register_ECX : 
	( v5b07 == 3'd2) ? In_register_EDX : 
	( v5b07 == 3'd3) ? In_register_EBX : 
	( v5b07 == 3'd4) ? In_register_EAX : 
	( v5b07 == 3'd5) ? In_register_ECX : 
	( v5b07 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5b09 = { v320 };
wire v5b0a = v5b09 == vb;
wire v5b0b = v5b09 == v9;
wire v5b0c = v5b0a | v5b0b;
wire v5b0d = v5b09 == vf;
wire v5b0e = v5b0c | v5b0d;
wire v5b0f = v5b09 == v11;
wire v5b10 = v5b0e | v5b0f;
wire [31:0] v5b11 = ( v5b10 == 1'd0) ? v15 : v31;
wire [31:0] v5b12 = v5b08 >> v5b11;
wire [31:0] v5b13 = v5b12 & v32;
wire [2:0] v5b15 = { v320 };
wire [31:0] v5b16 = ( v5b15 == 3'd0) ? In_register_EAX : 
	( v5b15 == 3'd1) ? In_register_ECX : 
	( v5b15 == 3'd2) ? In_register_EDX : 
	( v5b15 == 3'd3) ? In_register_EBX : 
	( v5b15 == 3'd4) ? In_register_EAX : 
	( v5b15 == 3'd5) ? In_register_ECX : 
	( v5b15 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5b17 = { v320 };
wire v5b18 = v5b17 == vb;
wire v5b19 = v5b17 == v9;
wire v5b1a = v5b18 | v5b19;
wire v5b1b = v5b17 == vf;
wire v5b1c = v5b1a | v5b1b;
wire v5b1d = v5b17 == v11;
wire v5b1e = v5b1c | v5b1d;
wire [31:0] v5b1f = ( v5b1e == 1'd0) ? v15 : v31;
wire [31:0] v5b20 = v5b16 >> v5b1f;
wire [31:0] v5b21 = v5b20 & v32;
wire [2:0] v5b23 = { v320 };
wire [31:0] v5b24 = ( v5b23 == 3'd0) ? In_register_EAX : 
	( v5b23 == 3'd1) ? In_register_ECX : 
	( v5b23 == 3'd2) ? In_register_EDX : 
	( v5b23 == 3'd3) ? In_register_EBX : 
	( v5b23 == 3'd4) ? In_register_EAX : 
	( v5b23 == 3'd5) ? In_register_ECX : 
	( v5b23 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5b25 = { v320 };
wire v5b26 = v5b25 == vb;
wire v5b27 = v5b25 == v9;
wire v5b28 = v5b26 | v5b27;
wire v5b29 = v5b25 == vf;
wire v5b2a = v5b28 | v5b29;
wire v5b2b = v5b25 == v11;
wire v5b2c = v5b2a | v5b2b;
wire [31:0] v5b2d = ( v5b2c == 1'd0) ? v15 : v31;
wire [31:0] v5b2e = v5b24 >> v5b2d;
wire [31:0] v5b2f = v5b2e & v32;
wire [31:0] v5b4d = ( v5adc ) ? v5b3d : 
	( v5aeb ) ? v5b4b : 
	( v5a90 ) ? v5b05 : 
	( v5a94 ) ? v5b13 : 
	( v5aac ) ? v5b21 : v5b2f;
wire [7:0] v5b4e = v5b4d[7:0];
wire [7:0] v5b4f = v5af8 | v5b4e;
wire v5b50 = $signed(v5b4f) < $signed(v2c);
wire v5b52 = v5b50;
wire v5b53 = v5b52 == Out_register_SF;
wire [31:0] v5b55 = In_register_ESP;
wire v5b56 = v5b55 == Out_register_ESP;
wire v5b57 = In_error_flag == Out_error_flag;
wire [2:0] v5b58 = { v1fa };
wire [31:0] v5b59 = ( v5b58 == 3'd0) ? In_register_EAX : 
	( v5b58 == 3'd1) ? In_register_ECX : 
	( v5b58 == 3'd2) ? In_register_EDX : 
	( v5b58 == 3'd3) ? In_register_EBX : 
	( v5b58 == 3'd4) ? v15 : 
	( v5b58 == 3'd5) ? In_register_EBP : 
	( v5b58 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b5a = v5b59 + v63a;
wire [2:0] v5b5d = { v13c };
wire [31:0] v5b5e = ( v5b5d == 3'd0) ? v15 : 
	( v5b5d == 3'd1) ? v15 : 
	( v5b5d == 3'd2) ? v15 : 
	( v5b5d == 3'd3) ? v15 : 
	( v5b5d == 3'd4) ? In_register_ESP : 
	( v5b5d == 3'd5) ? In_register_EBP : 
	( v5b5d == 3'd6) ? v15 : v15;
wire [31:0] v5b5f = v5b5e + v7f8;
wire [2:0] v5b61 = { v1fa };
wire [31:0] v5b62 = ( v5b61 == 3'd0) ? In_register_EAX : 
	( v5b61 == 3'd1) ? In_register_ECX : 
	( v5b61 == 3'd2) ? In_register_EDX : 
	( v5b61 == 3'd3) ? In_register_EBX : 
	( v5b61 == 3'd4) ? v15 : 
	( v5b61 == 3'd5) ? v15 : 
	( v5b61 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b63 = v5b62 + v1f7;
wire v5b69 = instruction_bits[16: 16];
wire v5b68 = instruction_bits[18: 18];
wire [1:0] v5b6a = { v5b69 , v5b68 };
wire [31:0] v5b6b = ( v5b6a == 2'd0) ? In_register_EDX : 
	( v5b6a == 2'd1) ? In_register_ESI : 
	( v5b6a == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v5b6c = { v12c };
wire [31:0] v5b6d = ( v5b6c == 3'd0) ? In_register_EAX : 
	( v5b6c == 3'd1) ? In_register_ECX : 
	( v5b6c == 3'd2) ? In_register_EDX : 
	( v5b6c == 3'd3) ? In_register_EBX : 
	( v5b6c == 3'd4) ? v15 : 
	( v5b6c == 3'd5) ? In_register_EBP : 
	( v5b6c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b6e = v5b6d << v7f4;
wire [31:0] v5b6f = v5b6b + v5b6e;
wire [2:0] v5b65 = { v1fa };
wire [31:0] v5b66 = ( v5b65 == 3'd0) ? In_register_EAX : 
	( v5b65 == 3'd1) ? In_register_ECX : 
	( v5b65 == 3'd2) ? In_register_EDX : 
	( v5b65 == 3'd3) ? In_register_EBX : 
	( v5b65 == 3'd4) ? v15 : 
	( v5b65 == 3'd5) ? v15 : 
	( v5b65 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b71 = ( v5a90 ) ? v5b5a : 
	( v5aac ) ? v5b5f : 
	( v5ac3 ) ? v5b63 : 
	( v5aeb ) ? v5b6f : 
	( v5adc ) ? v5b66 : v1f7;
wire v5b72 =  v2a == memory_1[15: 12] && v5b71 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v5b4f == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v5b79 = ( v5aac ) ? v27 : 
	( v5adc ) ? v1c : 
	( v5a94 | v5ac3 ) ? v16 : v10;
wire [31:0] v5b7a = In_register_EIP + v5b79;
wire [31:0] v5b7c = v5b7a;
wire v5b7d = v5b7c == Out_register_EIP;
wire [31:0] v5b7f = In_register_EDI;
wire v5b80 = v5b7f == Out_register_EDI;
wire [31:0] v5b82 = In_register_EAX;
wire v5b83 = v5b82 == Out_register_EAX;
wire [7:0] v5b85 = In_register_DF;
wire v5b86 = v5b85 == Out_register_DF;
wire [2:0] v5b87 = { v1fa };
wire [31:0] v5b88 = ( v5b87 == 3'd0) ? In_register_EAX : 
	( v5b87 == 3'd1) ? In_register_ECX : 
	( v5b87 == 3'd2) ? In_register_EDX : 
	( v5b87 == 3'd3) ? In_register_EBX : 
	( v5b87 == 3'd4) ? v15 : 
	( v5b87 == 3'd5) ? In_register_EBP : 
	( v5b87 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b89 = v5b88 + v63a;
wire [2:0] v5b8c = { v13c };
wire [31:0] v5b8d = ( v5b8c == 3'd0) ? v15 : 
	( v5b8c == 3'd1) ? v15 : 
	( v5b8c == 3'd2) ? v15 : 
	( v5b8c == 3'd3) ? v15 : 
	( v5b8c == 3'd4) ? In_register_ESP : 
	( v5b8c == 3'd5) ? In_register_EBP : 
	( v5b8c == 3'd6) ? v15 : v15;
wire [31:0] v5b8e = v5b8d + v7f8;
wire [2:0] v5b90 = { v1fa };
wire [31:0] v5b91 = ( v5b90 == 3'd0) ? In_register_EAX : 
	( v5b90 == 3'd1) ? In_register_ECX : 
	( v5b90 == 3'd2) ? In_register_EDX : 
	( v5b90 == 3'd3) ? In_register_EBX : 
	( v5b90 == 3'd4) ? v15 : 
	( v5b90 == 3'd5) ? v15 : 
	( v5b90 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b92 = v5b91 + v1f7;
wire [1:0] v5b97 = { v5b69 , v5b68 };
wire [31:0] v5b98 = ( v5b97 == 2'd0) ? In_register_EDX : 
	( v5b97 == 2'd1) ? In_register_ESI : 
	( v5b97 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v5b99 = { v12c };
wire [31:0] v5b9a = ( v5b99 == 3'd0) ? In_register_EAX : 
	( v5b99 == 3'd1) ? In_register_ECX : 
	( v5b99 == 3'd2) ? In_register_EDX : 
	( v5b99 == 3'd3) ? In_register_EBX : 
	( v5b99 == 3'd4) ? v15 : 
	( v5b99 == 3'd5) ? In_register_EBP : 
	( v5b99 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b9b = v5b9a << v7f4;
wire [31:0] v5b9c = v5b98 + v5b9b;
wire [2:0] v5b94 = { v1fa };
wire [31:0] v5b95 = ( v5b94 == 3'd0) ? In_register_EAX : 
	( v5b94 == 3'd1) ? In_register_ECX : 
	( v5b94 == 3'd2) ? In_register_EDX : 
	( v5b94 == 3'd3) ? In_register_EBX : 
	( v5b94 == 3'd4) ? v15 : 
	( v5b94 == 3'd5) ? v15 : 
	( v5b94 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5b9e = ( v5a90 ) ? v5b89 : 
	( v5aac ) ? v5b8e : 
	( v5ac3 ) ? v5b92 : 
	( v5aeb ) ? v5b9c : 
	( v5adc ) ? v5b95 : v1f7;
wire v5b9f =  v2a == memory_0[15: 12] && v5b9e == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v5ba0 = v17;
wire v5ba1 = v5ba0 == Out_register_OF;
wire [31:0] v5ba3 = In_register_ESI;
wire v5ba4 = v5ba3 == Out_register_ESI;
wire [31:0] v5ba6 = In_register_EDX;
wire v5ba7 = v5ba6 == Out_register_EDX;
wire [31:0] v5ba9 = In_register_ECX;
wire v5baa = v5ba9 == Out_register_ECX;
wire [31:0] v5bac = In_register_EBP;
wire v5bad = v5bac == Out_register_EBP;
wire [31:0] v5baf = In_register_ESBASE;
wire v5bb0 = v5baf == Out_register_ESBASE;
wire [31:0] v5bb2 = In_register_DSBASE;
wire v5bb3 = v5bb2 == Out_register_DSBASE;
wire [31:0] v5bb5 = In_register_EBX;
wire v5bb6 = v5bb5 == Out_register_EBX;
wire [31:0] v5bb8 = In_register_GSBASE;
wire v5bb9 = v5bb8 == Out_register_GSBASE;
wire [31:0] v5bbb = In_register_FSBASE;
wire v5bbc = v5bbb == Out_register_FSBASE;
wire v5bbe = In_register_AF;
wire v5bbf = v5bbe == Out_register_AF;
wire [2:0] v5bc0_aux = v5b4f[0] + v5b4f[1] + v5b4f[2] + v5b4f[3] + v5b4f[4] + v5b4f[5] + v5b4f[6] + v5b4f[7];
wire v5bc0 = { 5'b00000, v5bc0_aux };
wire [7:0] v5bc1 = v5bc0 & v18;
wire [7:0] v5bc2 = v5bc1 ^ v18;
wire v5bc3 = v5bc2[0:0];
wire v5bc5 = v5bc3;
wire v5bc6 = v5bc5 == Out_register_PF;
wire v5bc7 = v5b4f == v2c;
wire v5bc9 = v5bc7;
wire v5bca = v5bc9 == Out_register_ZF;
wire v5bcb = v5aed & v15c & v5af0 & v5af3 & v5af6 & v5b53 & v5b56 & v5b57 & v5b72 & v5b7d & v5b80 & v5b83 & v5b86 & v5b9f & v5ba1 & v5ba4 & v5ba7 & v5baa & v5bad & v5bb0 & v5bb3 & v5bb6 & v5bb9 & v5bbc & v5bbf & v5bc6 & v5bca;
wire [7:0] vff = 8'b10001110;
wire v5bcc = vff == v1eb;
wire v5bcd = v1b == v318;
wire v5bce = v5bcc & v5bcd;
wire v5bcf = v5bce;
wire v5bd0 = v5bcf;
wire [31:0] v5bd2 = In_register_EBX;
wire v5bd3 = v5bd2 == Out_register_EBX;
wire [31:0] v5bd5 = In_register_ECX;
wire v5bd6 = v5bd5 == Out_register_ECX;
wire [31:0] v5bd8 = In_register_EBP;
wire v5bd9 = v5bd8 == Out_register_EBP;
wire v5bdb = In_register_AF;
wire v5bdc = v5bdb == Out_register_AF;
wire [31:0] v5bde = In_register_ESI;
wire v5bdf = v5bde == Out_register_ESI;
wire [31:0] v5be1 = In_register_SSBASE;
wire v5be2 = v5be1 == Out_register_SSBASE;
wire [31:0] v5be4 = In_register_EDI;
wire v5be5 = v5be4 == Out_register_EDI;
wire [31:0] v5be7 = In_register_EDX;
wire v5be8 = v5be7 == Out_register_EDX;
wire [31:0] v5bea = In_register_ESP;
wire v5beb = v5bea == Out_register_ESP;
wire v5bec = In_error_flag == Out_error_flag;
wire [31:0] v5bee = In_register_EAX;
wire v5bef = v5bee == Out_register_EAX;
wire [31:0] v5bf1 = v1c;
wire [31:0] v5bf2 = In_register_EIP + v5bf1;
wire [31:0] v5bf4 = v5bf2;
wire [31:0] v5bf5 = v5bf2 + v477;
wire [31:0] v5bf7 = v5bf5;
wire [31:0] v5bf8 = ( v529a == 1'd0) ? v5bf4 : v5bf7;
wire [31:0] v5bfb = ( v8 ) ? v5bf2 : v5bf8;
wire [31:0] v5bfd = v5bfb;
wire v5bfe = v5bfd == Out_register_EIP;
wire [31:0] v5c00 = In_register_ESBASE;
wire v5c01 = v5c00 == Out_register_ESBASE;
wire v5c03 = In_register_ZF;
wire v5c04 = v5c03 == Out_register_ZF;
wire [7:0] v5c06 = In_register_DF;
wire v5c07 = v5c06 == Out_register_DF;
wire v5c09 = In_register_PF;
wire v5c0a = v5c09 == Out_register_PF;
wire [31:0] v5c0c = In_register_CSBASE;
wire v5c0d = v5c0c == Out_register_CSBASE;
wire [31:0] v5c0f = In_register_DSBASE;
wire v5c10 = v5c0f == Out_register_DSBASE;
wire [31:0] v5c12 = In_register_GSBASE;
wire v5c13 = v5c12 == Out_register_GSBASE;
wire v5c15 = In_register_CF;
wire v5c16 = v5c15 == Out_register_CF;
wire v5c18 = In_register_SF;
wire v5c19 = v5c18 == Out_register_SF;
wire [31:0] v5c1b = In_register_FSBASE;
wire v5c1c = v5c1b == Out_register_FSBASE;
wire v5c1e = In_register_OF;
wire v5c1f = v5c1e == Out_register_OF;
wire v5c20 = v5bd3 & v5bd6 & v5bd9 & v5bd0 & v5bdc & v5bdf & v5be2 & v5be5 & v5be8 & v5beb & v5bec & v5bef & v5bfe & v5c01 & v5c04 & v5c07 & v5c0a & v5c0d & v5c10 & v5c13 & v15c & v5c16 & v5c19 & v5c1c & v5c1f;
wire v5c21 = In_error_flag == Out_error_flag;
wire [15:0] v100 = 16'b0110010000000000;
wire v5c22 = v100 == v117;
wire v5c23 = v3 == v119;
wire v5c24 = v4 == v11b;
wire v5c25 = v5c22 & v5c23 & v5c24;
wire v5c26 = v5c25;
wire v5c27 = v5c26;
wire [2:0] v5c4b = { v13c };
wire v5c4c = v5c4b == v7;
wire v5c4d = v5c4c;
wire v5c4e = v5c25 & v5c4d;
wire v5c4f = v5c4e;
wire [2:0] v5c28 = { v12c };
wire [31:0] v5c29 = ( v5c28 == 3'd0) ? In_register_EAX : 
	( v5c28 == 3'd1) ? In_register_ECX : 
	( v5c28 == 3'd2) ? In_register_EDX : 
	( v5c28 == 3'd3) ? In_register_EBX : 
	( v5c28 == 3'd4) ? In_register_EAX : 
	( v5c28 == 3'd5) ? In_register_ECX : 
	( v5c28 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5c2a = { v12c };
wire v5c2b = v5c2a == vb;
wire v5c2c = v5c2a == v9;
wire v5c2d = v5c2b | v5c2c;
wire v5c2e = v5c2a == vf;
wire v5c2f = v5c2d | v5c2e;
wire v5c30 = v5c2a == v11;
wire v5c31 = v5c2f | v5c30;
wire [31:0] v5c32 = ( v5c31 == 1'd0) ? v15 : v31;
wire [31:0] v5c33 = v5c29 >> v5c32;
wire [31:0] v5c34 = v5c33 & v32;
wire [31:0] v5c36 = v5c34;
wire [7:0] v5c37 = v5c36[7:0];
wire [2:0] v5c38 = { v13c };
wire [31:0] v5c39 = ( v5c38 == 3'd0) ? In_register_EAX : 
	( v5c38 == 3'd1) ? In_register_ECX : 
	( v5c38 == 3'd2) ? In_register_EDX : 
	( v5c38 == 3'd3) ? In_register_EBX : 
	( v5c38 == 3'd4) ? In_register_EAX : 
	( v5c38 == 3'd5) ? In_register_ECX : 
	( v5c38 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v5c3a = { v13c };
wire v5c3b = v5c3a == vb;
wire v5c3c = v5c3a == v9;
wire v5c3d = v5c3b | v5c3c;
wire v5c3e = v5c3a == vf;
wire v5c3f = v5c3d | v5c3e;
wire v5c40 = v5c3a == v11;
wire v5c41 = v5c3f | v5c40;
wire [31:0] v5c42 = ( v5c41 == 1'd0) ? v15 : v31;
wire [31:0] v5c43 = v5c39 >> v5c42;
wire [31:0] v5c44 = v5c43 & v32;
wire [31:0] v5c46 = v5c44;
wire [7:0] v5c47 = v5c46[7:0];
wire [7:0] v5c48 = v5c37 + v5c47;
wire [31:0] v5c49 = { 24'b000000000000000000000000, v5c48 };
wire [31:0] v5c4a = v5c8 | v5c49;
wire v5c53 = v5c4b == vb;
wire v5c54 = v5c53;
wire v5c55 = v5c25 & v5c54;
wire v5c56 = v5c55;
wire [31:0] v5c51 = v5c49 << v31;
wire [31:0] v5c52 = v752 | v5c51;
wire [31:0] v5c59 = ( v5c4f ) ? v5c4a : 
	( v5c56 ) ? v5c52 : In_register_EAX;
wire [31:0] v5c5b = v5c59;
wire v5c5c = v5c5b == Out_register_EAX;
wire [31:0] v5c5e = In_register_EDI;
wire v5c5f = v5c5e == Out_register_EDI;
wire [31:0] v5c61 = In_register_GSBASE;
wire v5c62 = v5c61 == Out_register_GSBASE;
wire [31:0] v5c64 = In_register_ESI;
wire v5c65 = v5c64 == Out_register_ESI;
wire [31:0] v5c67 = In_register_ESP;
wire v5c68 = v5c67 == Out_register_ESP;
wire [7:0] v5c69 = v5c48 ^ v5c47;
wire [7:0] v5c6a = v5c69 >> v33;
wire [7:0] v5c6b = v5c48 ^ v5c37;
wire [7:0] v5c6c = v5c6b >> v33;
wire [7:0] v5c6d = v5c6a + v5c6c;
wire v5c6e = v5c6d == v34;
wire v5c70 = v5c6e;
wire v5c71 = v5c70 == Out_register_OF;
wire v5c73 = v5c4b == vd;
wire v5c74 = v5c73;
wire v5c75 = v5c25 & v5c74;
wire v5c76 = v5c75;
wire [31:0] v5c72 = v7b8 | v5c49;
wire v5c79 = v5c4b == v9;
wire v5c7a = v5c79;
wire v5c7b = v5c25 & v5c7a;
wire v5c7c = v5c7b;
wire [31:0] v5c78 = v7c8 | v5c51;
wire [31:0] v5c7f = ( v8 ) ? In_register_EBX : 
	( v5c76 ) ? v5c72 : v5c78;
wire [31:0] v5c81 = v5c7f;
wire v5c82 = v5c81 == Out_register_EBX;
wire v5c84 = v5c4b == vf;
wire v5c85 = v5c84;
wire v5c86 = v5c25 & v5c85;
wire v5c87 = v5c86;
wire [31:0] v5c83 = v790 | v5c51;
wire v5c8a = v5c4b == vc;
wire v5c8b = v5c8a;
wire v5c8c = v5c25 & v5c8b;
wire v5c8d = v5c8c;
wire [31:0] v5c89 = v7a0 | v5c49;
wire [31:0] v5c90 = ( v5c87 ) ? v5c83 : 
	( v5c8d ) ? v5c89 : In_register_ECX;
wire [31:0] v5c92 = v5c90;
wire v5c93 = v5c92 == Out_register_ECX;
wire [31:0] v5c95 = In_register_EBP;
wire v5c96 = v5c95 == Out_register_EBP;
wire [31:0] v5c98 = In_register_ESBASE;
wire v5c99 = v5c98 == Out_register_ESBASE;
wire [31:0] v5c9b = v10;
wire [31:0] v5c9c = In_register_EIP + v5c9b;
wire [31:0] v5c9e = v5c9c;
wire v5c9f = v5c9e == Out_register_EIP;
wire v5ca0 = v5c48 == v2c;
wire v5ca2 = v5ca0;
wire v5ca3 = v5ca2 == Out_register_ZF;
wire [31:0] v5ca5 = In_register_CSBASE;
wire v5ca6 = v5ca5 == Out_register_CSBASE;
wire [31:0] v5ca8 = In_register_SSBASE;
wire v5ca9 = v5ca8 == Out_register_SSBASE;
wire v5caa = v5c48 < v5c47;
wire v5cab = v5c48 < v5c37;
wire v5cac = v5caa | v5cab;
wire v5cae = v5cac;
wire v5caf = v5cae == Out_register_CF;
wire v5cb0 = $signed(v5c48) < $signed(v2c);
wire v5cb2 = v5cb0;
wire v5cb3 = v5cb2 == Out_register_SF;
wire [31:0] v5cb5 = In_register_DSBASE;
wire v5cb6 = v5cb5 == Out_register_DSBASE;
wire [31:0] v5cb8 = In_register_FSBASE;
wire v5cb9 = v5cb8 == Out_register_FSBASE;
wire v5cc1 = v5c4b == v11;
wire v5cc2 = v5cc1;
wire v5cc3 = v5c25 & v5cc2;
wire v5cc4 = v5cc3;
wire [31:0] v5cc0 = v778 | v5c51;
wire v5cbb = v5c4b == ve;
wire v5cbc = v5cbb;
wire v5cbd = v5c25 & v5cbc;
wire v5cbe = v5cbd;
wire [31:0] v5cba = v768 | v5c49;
wire [31:0] v5cc7 = ( v5cc4 ) ? v5cc0 : 
	( v5cbe ) ? v5cba : In_register_EDX;
wire [31:0] v5cc9 = v5cc7;
wire v5cca = v5cc9 == Out_register_EDX;
wire [7:0] v5ccc = In_register_DF;
wire v5ccd = v5ccc == Out_register_DF;
wire [2:0] v5cce_aux = v5c48[0] + v5c48[1] + v5c48[2] + v5c48[3] + v5c48[4] + v5c48[5] + v5c48[6] + v5c48[7];
wire v5cce = { 5'b00000, v5cce_aux };
wire [7:0] v5ccf = v5cce & v18;
wire [7:0] v5cd0 = v5ccf ^ v18;
wire v5cd1 = v5cd0[0:0];
wire v5cd3 = v5cd1;
wire v5cd4 = v5cd3 == Out_register_PF;
wire [7:0] v5cd5 = v5c6b ^ v5c47;
wire [7:0] v5cd6 = v5cd5 >> v1d;
wire [7:0] v5cd7 = v5cd6 & v18;
wire v5cd8 = v5cd7[0:0];
wire v5cda = v5cd8;
wire v5cdb = v5cda == Out_register_AF;
wire v5cdc = v5c21 & v5c27 & v5c5c & v5c5f & v5c62 & v5c65 & v5c68 & v5c71 & v5c82 & v5c93 & v5c96 & v5c99 & v15c & v5c9f & v5ca3 & v5ca6 & v5ca9 & v5caf & v5cb3 & v5cb6 & v5cb9 & v5cca & v5ccd & v5cd4 & v5cdb;
wire [7:0] v101 = 8'b00110100;
wire v5cdd = v101 == v1eb;
wire v5cde = v1b == v318;
wire v5cdf = v5cdd & v5cde;
wire v5ce0 = v5cdf;
wire v5ce1 = v5ce0;
wire [31:0] v5ce3 = vf4b;
wire [7:0] v5ce4 = v5ce3[7:0];
wire [31:0] v5ce6 = v477;
wire [7:0] v5ce7 = v5ce6[7:0];
wire v5ce8 = v5ce4 == v5ce7;
wire v5cea = v5ce8;
wire v5ceb = v5cea == Out_register_ZF;
wire [31:0] v5ced = v1c;
wire [31:0] v5cee = In_register_EIP + v5ced;
wire [31:0] v5cf0 = v5cee;
wire v5cf1 = v5cf0 == Out_register_EIP;
wire [7:0] v5cf2 = v5ce7 ^ v5ce4;
wire [7:0] v5cf3 = v5ce4 - v5ce7;
wire [7:0] v5cf4 = v5cf2 ^ v5cf3;
wire [7:0] v5cf5 = v5cf4 >> v1d;
wire [7:0] v5cf6 = v5cf5 & v18;
wire v5cf7 = v5cf6[0:0];
wire v5cf9 = v5cf7;
wire v5cfa = v5cf9 == Out_register_AF;
wire [31:0] v5cfc = In_register_ESP;
wire v5cfd = v5cfc == Out_register_ESP;
wire [31:0] v5cff = In_register_EBP;
wire v5d00 = v5cff == Out_register_EBP;
wire [31:0] v5d02 = In_register_SSBASE;
wire v5d03 = v5d02 == Out_register_SSBASE;
wire [31:0] v5d05 = In_register_FSBASE;
wire v5d06 = v5d05 == Out_register_FSBASE;
wire [31:0] v5d08 = In_register_EDX;
wire v5d09 = v5d08 == Out_register_EDX;
wire [31:0] v5d0b = In_register_GSBASE;
wire v5d0c = v5d0b == Out_register_GSBASE;
wire [31:0] v5d0e = In_register_DSBASE;
wire v5d0f = v5d0e == Out_register_DSBASE;
wire [31:0] v5d11 = In_register_EBX;
wire v5d12 = v5d11 == Out_register_EBX;
wire [31:0] v5d14 = In_register_ESI;
wire v5d15 = v5d14 == Out_register_ESI;
wire [31:0] v5d17 = In_register_EDI;
wire v5d18 = v5d17 == Out_register_EDI;
wire [31:0] v5d19 = { 24'b000000000000000000000000, v5cf3 };
wire [31:0] v5d1a = v5c8 | v5d19;
wire [31:0] v5d1d = ( v8 ) ? In_register_EAX : v5d1a;
wire [31:0] v5d1f = v5d1d;
wire v5d20 = v5d1f == Out_register_EAX;
wire [31:0] v5d22 = In_register_CSBASE;
wire v5d23 = v5d22 == Out_register_CSBASE;
wire v5d24 = $signed(v5cf3) < $signed(v2c);
wire v5d26 = v5d24;
wire v5d27 = v5d26 == Out_register_SF;
wire [31:0] v5d29 = In_register_ESBASE;
wire v5d2a = v5d29 == Out_register_ESBASE;
wire [7:0] v5d2c = In_register_DF;
wire v5d2d = v5d2c == Out_register_DF;
wire v5d2e = In_error_flag == Out_error_flag;
wire [7:0] v5d2f = v5cf3 ^ v5ce4;
wire [7:0] v5d30 = v5d2f >> v33;
wire [7:0] v5d31 = v5cf2 >> v33;
wire [7:0] v5d32 = v5d30 + v5d31;
wire v5d33 = v5d32 == v34;
wire v5d35 = v5d33;
wire v5d36 = v5d35 == Out_register_OF;
wire [31:0] v5d38 = In_register_ECX;
wire v5d39 = v5d38 == Out_register_ECX;
wire [2:0] v5d3a_aux = v5cf3[0] + v5cf3[1] + v5cf3[2] + v5cf3[3] + v5cf3[4] + v5cf3[5] + v5cf3[6] + v5cf3[7];
wire v5d3a = { 5'b00000, v5d3a_aux };
wire [7:0] v5d3b = v5d3a & v18;
wire [7:0] v5d3c = v5d3b ^ v18;
wire v5d3d = v5d3c[0:0];
wire v5d3f = v5d3d;
wire v5d40 = v5d3f == Out_register_PF;
wire v5d41 = v5ce4 < v5ce7;
wire v5d43 = v5d41;
wire v5d44 = v5d43 == Out_register_CF;
wire v5d45 = v5ce1 & v5ceb & v5cf1 & v5cfa & v5cfd & v5d00 & v5d03 & v5d06 & v5d09 & v5d0c & v5d0f & v5d12 & v5d15 & v5d18 & v5d20 & v5d23 & v5d27 & v5d2a & v5d2d & v15c & v5d2e & v5d36 & v5d39 & v5d40 & v5d44;
wire [7:0] v102 = 8'b10101100;
wire v5d46 = v102 == v1eb;
wire v5d47 = v47 == vb69;
wire v5d48 = v5d46 & v5d47;
wire v5d4c = v5d48;
wire v5d4d = v5d4c;
wire [31:0] v5d4a = v48;
wire [31:0] v5d4b = In_register_EIP + v5d4a;
wire [31:0] v5d4f = v5d4b;
wire v5d50 = v5d4f == Out_register_EIP;
wire [31:0] v5d52 = In_register_ESBASE;
wire v5d53 = v5d52 == Out_register_ESBASE;
wire v5d54 = In_error_flag == Out_error_flag;
wire [31:0] v5d56 = In_register_ESI;
wire v5d57 = v5d56 == Out_register_ESI;
wire [31:0] v5d59 = In_register_EBX;
wire v5d5a = v5d59 == Out_register_EBX;
wire [31:0] v5d5c = In_register_ECX;
wire v5d5d = v5d5c == Out_register_ECX;
wire [31:0] v5d5f = In_register_EDX;
wire v5d60 = v5d5f == Out_register_EDX;
wire [31:0] v5d62 = In_register_EDI;
wire v5d63 = v5d62 == Out_register_EDI;
wire [31:0] v5d65 = In_register_ESP;
wire v5d66 = v5d65 == Out_register_ESP;
wire [31:0] v5d68 = In_register_EBP;
wire v5d69 = v5d68 == Out_register_EBP;
wire [31:0] v5d6b = vb74;
wire [31:0] v5d6d = In_register_EAX;
wire [31:0] v5d6e = v5d6b ^ v5d6d;
wire [31:0] v5d71 = ( v5d4c ) ? v5d6e : In_register_EAX;
wire [31:0] v5d73 = v5d71;
wire v5d74 = v5d73 == Out_register_EAX;
wire [31:0] v5d76 = In_register_CSBASE;
wire v5d77 = v5d76 == Out_register_CSBASE;
wire v5d79 = v17;
wire v5d7a = v5d79 == Out_register_CF;
wire [31:0] v5d7c = In_register_SSBASE;
wire v5d7d = v5d7c == Out_register_SSBASE;
wire v5d7e = v17;
wire v5d7f = v5d7e == Out_register_OF;
wire [31:0] v5d81 = In_register_DSBASE;
wire v5d82 = v5d81 == Out_register_DSBASE;
wire [31:0] v5d84 = In_register_GSBASE;
wire v5d85 = v5d84 == Out_register_GSBASE;
wire [31:0] v5d87 = In_register_FSBASE;
wire v5d88 = v5d87 == Out_register_FSBASE;
wire v5d8a = In_register_AF;
wire v5d8b = v5d8a == Out_register_AF;
wire [7:0] v5d8d = In_register_DF;
wire v5d8e = v5d8d == Out_register_DF;
wire [7:0] v5d8f = v5d6e[7:0];
wire [2:0] v5d90_aux = v5d8f[0] + v5d8f[1] + v5d8f[2] + v5d8f[3] + v5d8f[4] + v5d8f[5] + v5d8f[6] + v5d8f[7];
wire v5d90 = { 5'b00000, v5d90_aux };
wire [7:0] v5d91 = v5d90 & v18;
wire [7:0] v5d92 = v5d91 ^ v18;
wire v5d93 = v5d92[0:0];
wire v5d95 = v5d93;
wire v5d96 = v5d95 == Out_register_PF;
wire v5d97 = $signed(v5d6e) < $signed(v15);
wire v5d99 = v5d97;
wire v5d9a = v5d99 == Out_register_SF;
wire v5d9b = v5d6e == v15;
wire v5d9d = v5d9b;
wire v5d9e = v5d9d == Out_register_ZF;
wire v5d9f = v15c & v5d50 & v5d53 & v5d54 & v5d57 & v5d5a & v5d5d & v5d60 & v5d63 & v5d66 & v5d4d & v5d69 & v5d74 & v5d77 & v5d7a & v5d7d & v5d7f & v5d82 & v5d85 & v5d88 & v5d8b & v5d8e & v5d96 & v5d9a & v5d9e;
wire [7:0] v103 = 8'b01111001;
wire v5da5 = v103 == v1eb;
wire v5da6 = v29 == v59f;
wire v5da7 = v5da5 & v5da6;
wire v5da8 = v5da7;
wire v5da9 = v5da8;
wire [31:0] v5da0 = In_register_EAX >> v31;
wire [7:0] v5da1 = v5da0[7:0];
wire [7:0] v5da2 = v5da1 >> v1d;
wire [7:0] v5da3 = v5da2 & v18;
wire v5da4 = v5da3[0:0];
wire v5dab = v5da4;
wire v5dac = v5dab == Out_register_AF;
wire [31:0] v5dae = In_register_SSBASE;
wire v5daf = v5dae == Out_register_SSBASE;
wire [7:0] v5db0 = v5da1 & v18;
wire v5db1 = v5db0[0:0];
wire v5db3 = v5db1;
wire v5db4 = v5db3 == Out_register_CF;
wire v5db5 = In_error_flag == Out_error_flag;
wire [31:0] v5db7 = In_register_GSBASE;
wire v5db8 = v5db7 == Out_register_GSBASE;
wire [31:0] v5dba = In_register_ESI;
wire v5dbb = v5dba == Out_register_ESI;
wire [31:0] v5dbd = v2b;
wire [31:0] v5dbe = In_register_EIP + v5dbd;
wire [31:0] v5dc0 = v5dbe;
wire v5dc1 = v5dc0 == Out_register_EIP;
wire [31:0] v5dc3 = In_register_EAX;
wire v5dc4 = v5dc3 == Out_register_EAX;
wire [7:0] v5dc6 = In_register_DF;
wire v5dc7 = v5dc6 == Out_register_DF;
wire [31:0] v5dc9 = In_register_EDI;
wire v5dca = v5dc9 == Out_register_EDI;
wire [31:0] v5dcc = In_register_ESBASE;
wire v5dcd = v5dcc == Out_register_ESBASE;
wire [31:0] v5dcf = In_register_EDX;
wire v5dd0 = v5dcf == Out_register_EDX;
wire [31:0] v5dd2 = In_register_EBX;
wire v5dd3 = v5dd2 == Out_register_EBX;
wire [31:0] v5dd5 = In_register_ECX;
wire v5dd6 = v5dd5 == Out_register_ECX;
wire [31:0] v5dd8 = In_register_EBP;
wire v5dd9 = v5dd8 == Out_register_EBP;
wire [31:0] v5ddb = In_register_DSBASE;
wire v5ddc = v5ddb == Out_register_DSBASE;
wire v5dde = In_register_OF;
wire v5ddf = v5dde == Out_register_OF;
wire [31:0] v5de1 = In_register_CSBASE;
wire v5de2 = v5de1 == Out_register_CSBASE;
wire [7:0] v5de3 = v5da1 >> v33;
wire v5de4 = v5de3[0:0];
wire v5de6 = v5de4;
wire v5de7 = v5de6 == Out_register_SF;
wire [31:0] v5de9 = In_register_FSBASE;
wire v5dea = v5de9 == Out_register_FSBASE;
wire [31:0] v5dec = In_register_ESP;
wire v5ded = v5dec == Out_register_ESP;
wire [7:0] v5dee = v5da1 >> v34;
wire [7:0] v5def = v5dee & v18;
wire v5df0 = v5def[0:0];
wire v5df2 = v5df0;
wire v5df3 = v5df2 == Out_register_PF;
wire [7:0] v5df4 = v5da1 >> vcd;
wire [7:0] v5df5 = v5df4 & v18;
wire v5df6 = v5df5[0:0];
wire v5df8 = v5df6;
wire v5df9 = v5df8 == Out_register_ZF;
wire v5dfa = v5dac & v5daf & v5db4 & v5db5 & v5db8 & v5dbb & v15c & v5dc1 & v5dc4 & v5dc7 & v5dca & v5dcd & v5dd0 & v5dd3 & v5dd6 & v5dd9 & v5ddc & v5ddf & v5de2 & v5da9 & v5de7 & v5dea & v5ded & v5df3 & v5df9;
wire v5dfb = v71 == v1eb;
wire v5dfc = v73 == v1ed;
wire v5dfd = vaf == v2f0b;
wire [2:0] v5dfe = { v1fa };
wire v5dff = v5dfe == vb;
wire v5e00 = v5dfe == vf;
wire v5e01 = v5dff | v5e00;
wire v5e02 = v5e01 ^ v8;
wire [2:0] v5e03 = { v1fa };
wire v5e04 = v5e03 == vb;
wire v5e05 = v5e04;
wire v5e06 = v5e05 ^ v8;
wire v5e07 = v5e02 & v5e06;
wire v5e08 = v5dfb & v5dfc & v5dfd & v5e07;
wire v5e09 = v5e08;
wire v5e0a = v5e09;
wire [31:0] v5e0c = In_register_EBX;
wire v5e0d = v5e0c == Out_register_EBX;
wire v5e0e = In_error_flag == Out_error_flag;
wire [31:0] v5e10 = vb2;
wire [31:0] v5e11 = In_register_EIP + v5e10;
wire [31:0] v5e13 = v5e11;
wire v5e14 = v5e13 == Out_register_EIP;
wire [31:0] v5e16 = In_register_ECX;
wire v5e17 = v5e16 == Out_register_ECX;
wire [31:0] v5e19 = In_register_EDI;
wire v5e1a = v5e19 == Out_register_EDI;
wire v5e1c = v17;
wire v5e1d = v5e1c == Out_register_CF;
wire [31:0] v5e1f = In_register_EAX;
wire v5e20 = v5e1f == Out_register_EAX;
wire [31:0] v5e21 = memory_0[79: 48];
wire [31:0] v5e23 = v2fae;
wire [31:0] v5e24 = v5e21 & v5e23;
wire v5e25 = $signed(v5e24) < $signed(v15);
wire v5e27 = v5e25;
wire v5e28 = v5e27 == Out_register_SF;
wire [31:0] v5e2a = In_register_EBP;
wire v5e2b = v5e2a == Out_register_EBP;
wire [31:0] v5e2d = In_register_ESP;
wire v5e2e = v5e2d == Out_register_ESP;
wire [31:0] v5e30 = In_register_EDX;
wire v5e31 = v5e30 == Out_register_EDX;
wire [31:0] v5e33 = In_register_CSBASE;
wire v5e34 = v5e33 == Out_register_CSBASE;
wire [7:0] v5e36 = In_register_DF;
wire v5e37 = v5e36 == Out_register_DF;
wire [31:0] v5e39 = In_register_ESBASE;
wire v5e3a = v5e39 == Out_register_ESBASE;
wire [2:0] v5e3b = { v1fa };
wire [31:0] v5e3c = ( v5e3b == 3'd0) ? In_register_EAX : 
	( v5e3b == 3'd1) ? In_register_ECX : 
	( v5e3b == 3'd2) ? In_register_EDX : 
	( v5e3b == 3'd3) ? In_register_EBX : 
	( v5e3b == 3'd4) ? v15 : 
	( v5e3b == 3'd5) ? v15 : 
	( v5e3b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5e3d = v5e3c + v1f7;
wire [31:0] v5e3f = v5e3d;
wire v5e40 =  v26 == memory_0[15: 12] && v5e3f == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v5e42 = In_register_DSBASE;
wire v5e43 = v5e42 == Out_register_DSBASE;
wire [31:0] v5e45 = In_register_FSBASE;
wire v5e46 = v5e45 == Out_register_FSBASE;
wire [31:0] v5e48 = In_register_GSBASE;
wire v5e49 = v5e48 == Out_register_GSBASE;
wire v5e4b = In_register_AF;
wire v5e4c = v5e4b == Out_register_AF;
wire v5e4d = v17;
wire v5e4e = v5e4d == Out_register_OF;
wire [31:0] v5e50 = In_register_SSBASE;
wire v5e51 = v5e50 == Out_register_SSBASE;
wire [31:0] v5e53 = In_register_ESI;
wire v5e54 = v5e53 == Out_register_ESI;
wire [7:0] v5e55 = v5e24[7:0];
wire [2:0] v5e56_aux = v5e55[0] + v5e55[1] + v5e55[2] + v5e55[3] + v5e55[4] + v5e55[5] + v5e55[6] + v5e55[7];
wire v5e56 = { 5'b00000, v5e56_aux };
wire [7:0] v5e57 = v5e56 & v18;
wire [7:0] v5e58 = v5e57 ^ v18;
wire v5e59 = v5e58[0:0];
wire v5e5b = v5e59;
wire v5e5c = v5e5b == Out_register_PF;
wire v5e5d = v5e24 == v15;
wire v5e5f = v5e5d;
wire v5e60 = v5e5f == Out_register_ZF;
wire v5e61 = v5e0a & v5e0d & v15c & v5e0e & v5e14 & v5e17 & v5e1a & v5e1d & v5e20 & v5e28 & v5e2b & v5e2e & v5e31 & v5e34 & v5e37 & v5e3a & v5e40 & v5e43 & v5e46 & v5e49 & v5e4c & v5e4e & v5e51 & v5e54 & v5e5c & v5e60;
wire v5e64 = v40 == v1eb;
wire v5e65 = va8 == v1ed;
wire v5e66 = v4 == v11b;
wire v5e67 = v5e64 & v5e65 & v5e66;
wire v5e75 = v5e67;
wire v5e76 = v5e75;
wire [2:0] v5e6d = { v1fa };
wire v5e6e = v5e6d == v9;
wire v5e6f = v5e6e;
wire v5e70 = v5e67 & v5e6f;
wire v5e71 = v5e70;
wire [2:0] v5e62 = { v1fa };
wire [31:0] v5e63 = ( v5e62 == 3'd0) ? In_register_EAX : 
	( v5e62 == 3'd1) ? In_register_ECX : 
	( v5e62 == 3'd2) ? In_register_EDX : 
	( v5e62 == 3'd3) ? In_register_EBX : 
	( v5e62 == 3'd4) ? In_register_ESP : 
	( v5e62 == 3'd5) ? In_register_EBP : 
	( v5e62 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5e69 = v5e63;
wire [31:0] v5e6b = v63a;
wire [31:0] v5e6c = v5e69 - v5e6b;
wire [31:0] v5e74 = ( v5e71 ) ? v5e6c : In_register_EDI;
wire [31:0] v5e78 = v5e74;
wire v5e79 = v5e78 == Out_register_EDI;
wire [31:0] v5e7a = v5e6b ^ v5e69;
wire [31:0] v5e7b = v5e7a ^ v5e6c;
wire [7:0] v5e7c = v5e7b[7:0];
wire [7:0] v5e7d = v5e7c >> v1d;
wire [7:0] v5e7e = v5e7d & v18;
wire v5e7f = v5e7e[0:0];
wire v5e81 = v5e7f;
wire v5e82 = v5e81 == Out_register_AF;
wire v5e83 = In_error_flag == Out_error_flag;
wire [31:0] v5e85 = In_register_CSBASE;
wire v5e86 = v5e85 == Out_register_CSBASE;
wire v5e87 = v5e6d == vd;
wire v5e88 = v5e87;
wire v5e89 = v5e67 & v5e88;
wire v5e8a = v5e89;
wire [31:0] v5e8d = ( v5e8a ) ? v5e6c : In_register_EBX;
wire [31:0] v5e8f = v5e8d;
wire v5e90 = v5e8f == Out_register_EBX;
wire [31:0] v5e92 = v10;
wire [31:0] v5e93 = In_register_EIP + v5e92;
wire [31:0] v5e95 = v5e93;
wire v5e96 = v5e95 == Out_register_EIP;
wire [31:0] v5e97 = v5e6c ^ v5e69;
wire [31:0] v5e98 = v5e97 >> v1e;
wire [31:0] v5e99 = v5e7a >> v1e;
wire [31:0] v5e9a = v5e98 + v5e99;
wire v5e9b = v5e9a == v1c;
wire v5e9d = v5e9b;
wire v5e9e = v5e9d == Out_register_OF;
wire v5e9f = v5e6d == ve;
wire v5ea0 = v5e9f;
wire v5ea1 = v5e67 & v5ea0;
wire v5ea2 = v5ea1;
wire [31:0] v5ea5 = ( v5ea2 ) ? v5e6c : In_register_EDX;
wire [31:0] v5ea7 = v5ea5;
wire v5ea8 = v5ea7 == Out_register_EDX;
wire [7:0] v5eaa = In_register_DF;
wire v5eab = v5eaa == Out_register_DF;
wire v5eac = v5e6d == vf;
wire v5ead = v5eac;
wire v5eae = v5e67 & v5ead;
wire v5eaf = v5eae;
wire [31:0] v5eb2 = ( v5eaf ) ? v5e6c : In_register_EBP;
wire [31:0] v5eb4 = v5eb2;
wire v5eb5 = v5eb4 == Out_register_EBP;
wire [31:0] v5eb7 = In_register_GSBASE;
wire v5eb8 = v5eb7 == Out_register_GSBASE;
wire v5eb9 = v5e6d == v11;
wire v5eba = v5eb9;
wire v5ebb = v5e67 & v5eba;
wire v5ebc = v5ebb;
wire [31:0] v5ebf = ( v5ebc ) ? v5e6c : In_register_ESI;
wire [31:0] v5ec1 = v5ebf;
wire v5ec2 = v5ec1 == Out_register_ESI;
wire [31:0] v5ec4 = In_register_SSBASE;
wire v5ec5 = v5ec4 == Out_register_SSBASE;
wire [31:0] v5ec7 = In_register_ESBASE;
wire v5ec8 = v5ec7 == Out_register_ESBASE;
wire [31:0] v5eca = In_register_DSBASE;
wire v5ecb = v5eca == Out_register_DSBASE;
wire v5ecc = v5e6d == v7;
wire v5ecd = v5ecc;
wire v5ece = v5e67 & v5ecd;
wire v5ecf = v5ece;
wire [31:0] v5ed2 = ( v5ecf ) ? v5e6c : In_register_EAX;
wire [31:0] v5ed4 = v5ed2;
wire v5ed5 = v5ed4 == Out_register_EAX;
wire v5ed6 = v5e6d == vb;
wire v5ed7 = v5ed6;
wire v5ed8 = v5e67 & v5ed7;
wire v5ed9 = v5ed8;
wire [31:0] v5edc = ( v5ed9 ) ? v5e6c : In_register_ESP;
wire [31:0] v5ede = v5edc;
wire v5edf = v5ede == Out_register_ESP;
wire [31:0] v5ee1 = In_register_FSBASE;
wire v5ee2 = v5ee1 == Out_register_FSBASE;
wire v5ee3 = v5e69 < v5e6b;
wire v5ee5 = v5ee3;
wire v5ee6 = v5ee5 == Out_register_CF;
wire v5ee7 = $signed(v5e6c) < $signed(v15);
wire v5ee9 = v5ee7;
wire v5eea = v5ee9 == Out_register_SF;
wire [7:0] v5eeb = v5e6c[7:0];
wire [2:0] v5eec_aux = v5eeb[0] + v5eeb[1] + v5eeb[2] + v5eeb[3] + v5eeb[4] + v5eeb[5] + v5eeb[6] + v5eeb[7];
wire v5eec = { 5'b00000, v5eec_aux };
wire [7:0] v5eed = v5eec & v18;
wire [7:0] v5eee = v5eed ^ v18;
wire v5eef = v5eee[0:0];
wire v5ef1 = v5eef;
wire v5ef2 = v5ef1 == Out_register_PF;
wire v5ef3 = v5e6d == vc;
wire v5ef4 = v5ef3;
wire v5ef5 = v5e67 & v5ef4;
wire v5ef6 = v5ef5;
wire [31:0] v5ef9 = ( v5ef6 ) ? v5e6c : In_register_ECX;
wire [31:0] v5efb = v5ef9;
wire v5efc = v5efb == Out_register_ECX;
wire v5efd = v5e69 == v5e6b;
wire v5eff = v5efd;
wire v5f00 = v5eff == Out_register_ZF;
wire v5f01 = v5e79 & v5e76 & v5e82 & v5e83 & v5e86 & v5e90 & v5e96 & v5e9e & v5ea8 & v5eab & v15c & v5eb5 & v5eb8 & v5ec2 & v5ec5 & v5ec8 & v5ecb & v5ed5 & v5edf & v5ee2 & v5ee6 & v5eea & v5ef2 & v5efc & v5f00;
wire v5f02 = v12 == v1eb;
wire v5f03 = va8 == v1ed;
wire v5f04 = v14 == v1ef;
wire v5f05 = v5f02 & v5f03 & v5f04;
wire v5f06 = v5f05;
wire v5f07 = v5f06;
wire [2:0] v5f0f = { v1fa };
wire v5f10 = v5f0f == vb;
wire v5f11 = v5f10;
wire v5f12 = v5f05 & v5f11;
wire v5f13 = v5f12;
wire [2:0] v5f08 = { v1fa };
wire [31:0] v5f09 = ( v5f08 == 3'd0) ? In_register_EAX : 
	( v5f08 == 3'd1) ? In_register_ECX : 
	( v5f08 == 3'd2) ? In_register_EDX : 
	( v5f08 == 3'd3) ? In_register_EBX : 
	( v5f08 == 3'd4) ? In_register_ESP : 
	( v5f08 == 3'd5) ? In_register_EBP : 
	( v5f08 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5f0b = v5f09;
wire [31:0] v5f0d = v1f7;
wire [31:0] v5f0e = v5f0b - v5f0d;
wire [31:0] v5f16 = ( v5f13 ) ? v5f0e : In_register_ESP;
wire [31:0] v5f18 = v5f16;
wire v5f19 = v5f18 == Out_register_ESP;
wire [31:0] v5f1b = In_register_SSBASE;
wire v5f1c = v5f1b == Out_register_SSBASE;
wire [31:0] v5f1d = v5f0d ^ v5f0b;
wire [31:0] v5f1e = v5f1d ^ v5f0e;
wire [7:0] v5f1f = v5f1e[7:0];
wire [7:0] v5f20 = v5f1f >> v1d;
wire [7:0] v5f21 = v5f20 & v18;
wire v5f22 = v5f21[0:0];
wire v5f24 = v5f22;
wire v5f25 = v5f24 == Out_register_AF;
wire v5f26 = v5f0f == v7;
wire v5f27 = v5f26;
wire v5f28 = v5f05 & v5f27;
wire v5f29 = v5f28;
wire [31:0] v5f2c = ( v5f29 ) ? v5f0e : In_register_EAX;
wire [31:0] v5f2e = v5f2c;
wire v5f2f = v5f2e == Out_register_EAX;
wire [31:0] v5f31 = v16;
wire [31:0] v5f32 = In_register_EIP + v5f31;
wire [31:0] v5f34 = v5f32;
wire v5f35 = v5f34 == Out_register_EIP;
wire v5f36 = In_error_flag == Out_error_flag;
wire v5f37 = v5f0f == vf;
wire v5f38 = v5f37;
wire v5f39 = v5f05 & v5f38;
wire v5f3a = v5f39;
wire [31:0] v5f3d = ( v5f3a ) ? v5f0e : In_register_EBP;
wire [31:0] v5f3f = v5f3d;
wire v5f40 = v5f3f == Out_register_EBP;
wire v5f41 = v5f0f == v9;
wire v5f42 = v5f41;
wire v5f43 = v5f05 & v5f42;
wire v5f44 = v5f43;
wire [31:0] v5f47 = ( v5f44 ) ? v5f0e : In_register_EDI;
wire [31:0] v5f49 = v5f47;
wire v5f4a = v5f49 == Out_register_EDI;
wire v5f4b = v5f0f == vd;
wire v5f4c = v5f4b;
wire v5f4d = v5f05 & v5f4c;
wire v5f4e = v5f4d;
wire [31:0] v5f51 = ( v5f4e ) ? v5f0e : In_register_EBX;
wire [31:0] v5f53 = v5f51;
wire v5f54 = v5f53 == Out_register_EBX;
wire [7:0] v5f55 = v5f0e[7:0];
wire [2:0] v5f56_aux = v5f55[0] + v5f55[1] + v5f55[2] + v5f55[3] + v5f55[4] + v5f55[5] + v5f55[6] + v5f55[7];
wire v5f56 = { 5'b00000, v5f56_aux };
wire [7:0] v5f57 = v5f56 & v18;
wire [7:0] v5f58 = v5f57 ^ v18;
wire v5f59 = v5f58[0:0];
wire v5f5b = v5f59;
wire v5f5c = v5f5b == Out_register_PF;
wire v5f5d = v5f0f == ve;
wire v5f5e = v5f5d;
wire v5f5f = v5f05 & v5f5e;
wire v5f60 = v5f5f;
wire [31:0] v5f63 = ( v5f60 ) ? v5f0e : In_register_EDX;
wire [31:0] v5f65 = v5f63;
wire v5f66 = v5f65 == Out_register_EDX;
wire v5f67 = v5f0f == v11;
wire v5f68 = v5f67;
wire v5f69 = v5f05 & v5f68;
wire v5f6a = v5f69;
wire [31:0] v5f6d = ( v5f6a ) ? v5f0e : In_register_ESI;
wire [31:0] v5f6f = v5f6d;
wire v5f70 = v5f6f == Out_register_ESI;
wire [31:0] v5f72 = In_register_DSBASE;
wire v5f73 = v5f72 == Out_register_DSBASE;
wire [31:0] v5f75 = In_register_CSBASE;
wire v5f76 = v5f75 == Out_register_CSBASE;
wire [31:0] v5f78 = In_register_GSBASE;
wire v5f79 = v5f78 == Out_register_GSBASE;
wire v5f7a = v5f0b < v5f0d;
wire v5f7c = v5f7a;
wire v5f7d = v5f7c == Out_register_CF;
wire [31:0] v5f7f = In_register_FSBASE;
wire v5f80 = v5f7f == Out_register_FSBASE;
wire [7:0] v5f82 = In_register_DF;
wire v5f83 = v5f82 == Out_register_DF;
wire [31:0] v5f85 = In_register_ESBASE;
wire v5f86 = v5f85 == Out_register_ESBASE;
wire [31:0] v5f87 = v5f0e ^ v5f0b;
wire [31:0] v5f88 = v5f87 >> v1e;
wire [31:0] v5f89 = v5f1d >> v1e;
wire [31:0] v5f8a = v5f88 + v5f89;
wire v5f8b = v5f8a == v1c;
wire v5f8d = v5f8b;
wire v5f8e = v5f8d == Out_register_OF;
wire v5f8f = v5f0f == vc;
wire v5f90 = v5f8f;
wire v5f91 = v5f05 & v5f90;
wire v5f92 = v5f91;
wire [31:0] v5f95 = ( v5f92 ) ? v5f0e : In_register_ECX;
wire [31:0] v5f97 = v5f95;
wire v5f98 = v5f97 == Out_register_ECX;
wire v5f99 = $signed(v5f0e) < $signed(v15);
wire v5f9b = v5f99;
wire v5f9c = v5f9b == Out_register_SF;
wire v5f9d = v5f0b == v5f0d;
wire v5f9f = v5f9d;
wire v5fa0 = v5f9f == Out_register_ZF;
wire v5fa1 = v5f07 & v5f19 & v5f1c & v5f25 & v5f2f & v5f35 & v5f36 & v5f40 & v15c & v5f4a & v5f54 & v5f5c & v5f66 & v5f70 & v5f73 & v5f76 & v5f79 & v5f7d & v5f80 & v5f83 & v5f86 & v5f8e & v5f98 & v5f9c & v5fa0;
wire [15:0] v104 = 16'b0110111100100000;
wire v5fa8 = v104 == v117;
wire v5fa9 = v38 == v6da;
wire [2:0] v5faa = { v13c };
wire v5fab = v5faa == vb;
wire v5fac = v5faa == vf;
wire v5fad = v5fab | v5fac;
wire v5fae = v5fad ^ v8;
wire [2:0] v5faf = { v12c };
wire v5fb0 = v5faf == vb;
wire v5fb1 = v5fb0;
wire v5fb2 = v5fb1 ^ v8;
wire [2:0] v5fb3 = { v13c };
wire v5fb4 = v5fb3 == vf;
wire v5fb5 = v5fb4;
wire v5fb6 = v5fb5 ^ v8;
wire v5fb7 = v5fae & v5fb2 & v5fb6;
wire v5fb8 = v5fa8 & v5fa9 & v5fb7;
wire [2:0] v5fa2 = { v13c };
wire [31:0] v5fa3 = ( v5fa2 == 3'd0) ? In_register_EAX : 
	( v5fa2 == 3'd1) ? In_register_ECX : 
	( v5fa2 == 3'd2) ? In_register_EDX : 
	( v5fa2 == 3'd3) ? In_register_EBX : 
	( v5fa2 == 3'd4) ? v15 : 
	( v5fa2 == 3'd5) ? v15 : 
	( v5fa2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v5fa4 = { v12c };
wire [31:0] v5fa5 = ( v5fa4 == 3'd0) ? In_register_EAX : 
	( v5fa4 == 3'd1) ? In_register_ECX : 
	( v5fa4 == 3'd2) ? In_register_EDX : 
	( v5fa4 == 3'd3) ? In_register_EBX : 
	( v5fa4 == 3'd4) ? v15 : 
	( v5fa4 == 3'd5) ? In_register_EBP : 
	( v5fa4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v5fa6 = v5fa5 << v7f4;
wire [31:0] v5fa7 = v5fa3 + v5fa6;
wire [31:0] v5fba = v5fa7;
wire v5fbb =  v2a == memory_0[15: 12] && v5fba == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v5fbc = v5fb8;
wire v5fbd = v5fbc;
wire [31:0] v5fbf = In_register_ESBASE;
wire v5fc0 = v5fbf == Out_register_ESBASE;
wire [7:0] v5fc2 = In_register_DF;
wire v5fc3 = v5fc2 == Out_register_DF;
wire [31:0] v5fc5 = In_register_EAX;
wire v5fc6 = v5fc5 == Out_register_EAX;
wire [31:0] v5fc8 = In_register_ESP;
wire v5fc9 = v5fc8 == Out_register_ESP;
wire v5fcb = In_register_AF;
wire v5fcc = v5fcb == Out_register_AF;
wire v5fcd = In_error_flag == Out_error_flag;
wire [31:0] v5fce = memory_0[79: 48];
wire [7:0] v5fcf = v5fce[7:0];
wire [31:0] v5fd1 = v7f8;
wire [7:0] v5fd2 = v5fd1[7:0];
wire [7:0] v5fd3 = v5fcf & v5fd2;
wire v5fd4 = v5fd3 == v2c;
wire v5fd6 = v5fd4;
wire v5fd7 = v5fd6 == Out_register_ZF;
wire [31:0] v5fd9 = In_register_ECX;
wire v5fda = v5fd9 == Out_register_ECX;
wire [2:0] v5fdb_aux = v5fd3[0] + v5fd3[1] + v5fd3[2] + v5fd3[3] + v5fd3[4] + v5fd3[5] + v5fd3[6] + v5fd3[7];
wire v5fdb = { 5'b00000, v5fdb_aux };
wire [7:0] v5fdc = v5fdb & v18;
wire [7:0] v5fdd = v5fdc ^ v18;
wire v5fde = v5fdd[0:0];
wire v5fe0 = v5fde;
wire v5fe1 = v5fe0 == Out_register_PF;
wire [31:0] v5fe3 = In_register_EBX;
wire v5fe4 = v5fe3 == Out_register_EBX;
wire [31:0] v5fe6 = In_register_FSBASE;
wire v5fe7 = v5fe6 == Out_register_FSBASE;
wire [31:0] v5fe9 = In_register_EDX;
wire v5fea = v5fe9 == Out_register_EDX;
wire [31:0] v5fec = In_register_EBP;
wire v5fed = v5fec == Out_register_EBP;
wire v5fef = v17;
wire v5ff0 = v5fef == Out_register_CF;
wire [31:0] v5ff2 = v27;
wire [31:0] v5ff3 = In_register_EIP + v5ff2;
wire [31:0] v5ff5 = v5ff3;
wire v5ff6 = v5ff5 == Out_register_EIP;
wire [31:0] v5ff8 = In_register_SSBASE;
wire v5ff9 = v5ff8 == Out_register_SSBASE;
wire [31:0] v5ffb = In_register_DSBASE;
wire v5ffc = v5ffb == Out_register_DSBASE;
wire [31:0] v5ffe = In_register_EDI;
wire v5fff = v5ffe == Out_register_EDI;
wire [31:0] v6001 = In_register_GSBASE;
wire v6002 = v6001 == Out_register_GSBASE;
wire [31:0] v6004 = In_register_CSBASE;
wire v6005 = v6004 == Out_register_CSBASE;
wire v6006 = v17;
wire v6007 = v6006 == Out_register_OF;
wire [31:0] v6009 = In_register_ESI;
wire v600a = v6009 == Out_register_ESI;
wire v600b = $signed(v5fd3) < $signed(v2c);
wire v600d = v600b;
wire v600e = v600d == Out_register_SF;
wire v600f = v5fbb & v5fc0 & v5fc3 & v15c & v5fbd & v5fc6 & v5fc9 & v5fcc & v5fcd & v5fd7 & v5fda & v5fe1 & v5fe4 & v5fe7 & v5fea & v5fed & v5ff0 & v5ff6 & v5ff9 & v5ffc & v5fff & v6002 & v6005 & v6007 & v600a & v600e;
wire [4:0] v105 = 5'b10010;
wire v6010 = v105 == v2682;
wire v6011 = v29 == v59f;
wire v6012 = v6010 & v6011;
wire [7:0] v106 = 8'b00100110;
wire v6013 = v106 == v1eb;
wire v6014 = v105 == v1ed;
wire v6015 = v1b == v318;
wire v6016 = v6013 & v6014 & v6015;
wire v6017 = v6012 | v6016;
wire v6018 = v6017;
wire [2:0] v6021 = { v268d };
wire v6022 = v6021 == v7;
wire v6023 = v6022;
wire v6024 = v6012 & v6023;
wire [2:0] v6025 = { v1fa };
wire v6026 = v6025 == v7;
wire v6027 = v6026;
wire v6028 = v6016 & v6027;
wire v6029 = v6024 | v6028;
wire [2:0] v6019 = { v268d };
wire [31:0] v601a = ( v6019 == 3'd0) ? In_register_EAX : 
	( v6019 == 3'd1) ? In_register_ECX : 
	( v6019 == 3'd2) ? In_register_EDX : 
	( v6019 == 3'd3) ? In_register_EBX : 
	( v6019 == 3'd4) ? In_register_ESP : 
	( v6019 == 3'd5) ? In_register_EBP : 
	( v6019 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v601c = { v1fa };
wire [31:0] v601d = ( v601c == 3'd0) ? In_register_EAX : 
	( v601c == 3'd1) ? In_register_ECX : 
	( v601c == 3'd2) ? In_register_EDX : 
	( v601c == 3'd3) ? In_register_EBX : 
	( v601c == 3'd4) ? In_register_ESP : 
	( v601c == 3'd5) ? In_register_EBP : 
	( v601c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v601f = ( v6012 ) ? v601a : v601d;
wire [31:0] v6020 = v601f + v20;
wire [31:0] v602c = ( v6029 ) ? v6020 : In_register_EAX;
wire [31:0] v602e = v602c;
wire v602f = v602e == Out_register_EAX;
wire [31:0] v6031 = In_register_FSBASE;
wire v6032 = v6031 == Out_register_FSBASE;
wire [31:0] v6034 = In_register_GSBASE;
wire v6035 = v6034 == Out_register_GSBASE;
wire v6036 = v6021 == vd;
wire v6037 = v6036;
wire v6038 = v6012 & v6037;
wire v6039 = v6025 == vd;
wire v603a = v6039;
wire v603b = v6016 & v603a;
wire v603c = v6038 | v603b;
wire [31:0] v603f = ( v603c ) ? v6020 : In_register_EBX;
wire [31:0] v6041 = v603f;
wire v6042 = v6041 == Out_register_EBX;
wire v6043 = v6021 == vc;
wire v6044 = v6043;
wire v6045 = v6012 & v6044;
wire v6046 = v6025 == vc;
wire v6047 = v6046;
wire v6048 = v6016 & v6047;
wire v6049 = v6045 | v6048;
wire [31:0] v604c = ( v6049 ) ? v6020 : In_register_ECX;
wire [31:0] v604e = v604c;
wire v604f = v604e == Out_register_ECX;
wire v6050 = In_error_flag == Out_error_flag;
wire v6051 = v6021 == v11;
wire v6052 = v6051;
wire v6053 = v6012 & v6052;
wire v6054 = v6025 == v11;
wire v6055 = v6054;
wire v6056 = v6016 & v6055;
wire v6057 = v6053 | v6056;
wire [31:0] v605a = ( v6057 ) ? v6020 : In_register_ESI;
wire [31:0] v605c = v605a;
wire v605d = v605c == Out_register_ESI;
wire v605e = v6021 == vf;
wire v605f = v605e;
wire v6060 = v6012 & v605f;
wire v6061 = v6025 == vf;
wire v6062 = v6061;
wire v6063 = v6016 & v6062;
wire v6064 = v6060 | v6063;
wire [31:0] v6067 = ( v6064 ) ? v6020 : In_register_EBP;
wire [31:0] v6069 = v6067;
wire v606a = v6069 == Out_register_EBP;
wire v606b = v6021 == v9;
wire v606c = v606b;
wire v606d = v6012 & v606c;
wire v606e = v6025 == v9;
wire v606f = v606e;
wire v6070 = v6016 & v606f;
wire v6071 = v606d | v6070;
wire [31:0] v6074 = ( v6071 ) ? v6020 : In_register_EDI;
wire [31:0] v6076 = v6074;
wire v6077 = v6076 == Out_register_EDI;
wire v6078 = v6021 == ve;
wire v6079 = v6078;
wire v607a = v6012 & v6079;
wire v607b = v6025 == ve;
wire v607c = v607b;
wire v607d = v6016 & v607c;
wire v607e = v607a | v607d;
wire [31:0] v6081 = ( v607e ) ? v6020 : In_register_EDX;
wire [31:0] v6083 = v6081;
wire v6084 = v6083 == Out_register_EDX;
wire [31:0] v6087 = ( v6012 ) ? v2b : v1c;
wire [31:0] v6088 = In_register_EIP + v6087;
wire [31:0] v608a = v6088;
wire v608b = v608a == Out_register_EIP;
wire [31:0] v608d = In_register_CSBASE;
wire v608e = v608d == Out_register_CSBASE;
wire [31:0] v6090 = In_register_ESBASE;
wire v6091 = v6090 == Out_register_ESBASE;
wire [7:0] v6092 = v6020[7:0];
wire [2:0] v6093_aux = v6092[0] + v6092[1] + v6092[2] + v6092[3] + v6092[4] + v6092[5] + v6092[6] + v6092[7];
wire v6093 = { 5'b00000, v6093_aux };
wire [7:0] v6094 = v6093 & v18;
wire [7:0] v6095 = v6094 ^ v18;
wire v6096 = v6095[0:0];
wire v6098 = v6096;
wire v6099 = v6098 == Out_register_PF;
wire [31:0] v609b = In_register_SSBASE;
wire v609c = v609b == Out_register_SSBASE;
wire v609d = v6021 == vb;
wire v609e = v609d;
wire v609f = v6012 & v609e;
wire v60a0 = v6025 == vb;
wire v60a1 = v60a0;
wire v60a2 = v6016 & v60a1;
wire v60a3 = v609f | v60a2;
wire [31:0] v60a6 = ( v60a3 ) ? v6020 : In_register_ESP;
wire [31:0] v60a8 = v60a6;
wire v60a9 = v60a8 == Out_register_ESP;
wire [31:0] v60ab = In_register_DSBASE;
wire v60ac = v60ab == Out_register_DSBASE;
wire [31:0] v60ad = v6020 ^ v601f;
wire [7:0] v60ae = v60ad[7:0];
wire [7:0] v60af = v60ae >> v1d;
wire [7:0] v60b0 = v60af & v18;
wire v60b1 = v60b0[0:0];
wire v60b3 = v60b1;
wire v60b4 = v60b3 == Out_register_AF;
wire v60b6 = In_register_CF;
wire v60b7 = v60b6 == Out_register_CF;
wire [7:0] v60b9 = In_register_DF;
wire v60ba = v60b9 == Out_register_DF;
wire [31:0] v60bb = v60ad >> v1e;
wire [31:0] v60bc = v601f >> v1e;
wire [31:0] v60bd = v60bb + v60bc;
wire v60be = v60bd == v1c;
wire v60c0 = v60be;
wire v60c1 = v60c0 == Out_register_OF;
wire v60c2 = $signed(v6020) < $signed(v15);
wire v60c4 = v60c2;
wire v60c5 = v60c4 == Out_register_SF;
wire v60c6 = v6020 == v15;
wire v60c8 = v60c6;
wire v60c9 = v60c8 == Out_register_ZF;
wire v60ca = v6018 & v602f & v6032 & v6035 & v6042 & v604f & v6050 & v605d & v606a & v6077 & v6084 & v608b & v608e & v15c & v6091 & v6099 & v609c & v60a9 & v60ac & v60b4 & v60b7 & v60ba & v60c1 & v60c5 & v60c9;
wire v60cb = v2e == v1eb;
wire v60cc = v3 == v316;
wire v60cd = v1b == v318;
wire v60ce = v60cb & v60cc & v60cd;
wire v60cf = v60ce;
wire v60d0 = v60cf;
wire [7:0] v60d2 = In_register_DF;
wire v60d3 = v60d2 == Out_register_DF;
wire [2:0] v60f8 = { v1fa };
wire v6100 = v60f8 == v11;
wire v6101 = v6100;
wire v6102 = v60ce & v6101;
wire v6103 = v6102;
wire [2:0] v60d4 = { v1fa };
wire [31:0] v60d5 = ( v60d4 == 3'd0) ? In_register_EAX : 
	( v60d4 == 3'd1) ? In_register_ECX : 
	( v60d4 == 3'd2) ? In_register_EDX : 
	( v60d4 == 3'd3) ? In_register_EBX : 
	( v60d4 == 3'd4) ? In_register_EAX : 
	( v60d4 == 3'd5) ? In_register_ECX : 
	( v60d4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v60d6 = { v1fa };
wire v60d7 = v60d6 == vb;
wire v60d8 = v60d6 == v9;
wire v60d9 = v60d7 | v60d8;
wire v60da = v60d6 == vf;
wire v60db = v60d9 | v60da;
wire v60dc = v60d6 == v11;
wire v60dd = v60db | v60dc;
wire [31:0] v60de = ( v60dd == 1'd0) ? v15 : v31;
wire [31:0] v60df = v60d5 >> v60de;
wire [31:0] v60e0 = v60df & v32;
wire [31:0] v60e2 = v60e0;
wire [7:0] v60e3 = v60e2[7:0];
wire [2:0] v60e4 = { v320 };
wire [31:0] v60e5 = ( v60e4 == 3'd0) ? In_register_EAX : 
	( v60e4 == 3'd1) ? In_register_ECX : 
	( v60e4 == 3'd2) ? In_register_EDX : 
	( v60e4 == 3'd3) ? In_register_EBX : 
	( v60e4 == 3'd4) ? In_register_EAX : 
	( v60e4 == 3'd5) ? In_register_ECX : 
	( v60e4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v60e6 = { v320 };
wire v60e7 = v60e6 == vb;
wire v60e8 = v60e6 == v9;
wire v60e9 = v60e7 | v60e8;
wire v60ea = v60e6 == vf;
wire v60eb = v60e9 | v60ea;
wire v60ec = v60e6 == v11;
wire v60ed = v60eb | v60ec;
wire [31:0] v60ee = ( v60ed == 1'd0) ? v15 : v31;
wire [31:0] v60ef = v60e5 >> v60ee;
wire [31:0] v60f0 = v60ef & v32;
wire [31:0] v60f2 = v60f0;
wire [7:0] v60f3 = v60f2[7:0];
wire [7:0] v60f4 = v60e3 - v60f3;
wire [7:0] v60f5 = v60f4 - v65f;
wire [31:0] v60f6 = { 24'b000000000000000000000000, v60f5 };
wire [31:0] v60fe = v60f6 << v31;
wire [31:0] v60ff = v778 | v60fe;
wire v60f9 = v60f8 == ve;
wire v60fa = v60f9;
wire v60fb = v60ce & v60fa;
wire v60fc = v60fb;
wire [31:0] v60f7 = v768 | v60f6;
wire [31:0] v6106 = ( v6103 ) ? v60ff : 
	( v60fc ) ? v60f7 : In_register_EDX;
wire [31:0] v6108 = v6106;
wire v6109 = v6108 == Out_register_EDX;
wire [31:0] v610b = In_register_ESI;
wire v610c = v610b == Out_register_ESI;
wire [31:0] v610e = In_register_SSBASE;
wire v610f = v610e == Out_register_SSBASE;
wire v6110 = In_error_flag == Out_error_flag;
wire [31:0] v6112 = In_register_GSBASE;
wire v6113 = v6112 == Out_register_GSBASE;
wire [31:0] v6115 = In_register_ESBASE;
wire v6116 = v6115 == Out_register_ESBASE;
wire v6117 = v60e3 < v60f3;
wire v6118 = v60f4 < v65f;
wire [7:0] v6119 = { 7'b0000000, v6118 };
wire [7:0] v611a = ( v6117 == 1'd0) ? v6119 : v18;
wire v611b = v611a[0:0];
wire v611d = v611b;
wire v611e = v611d == Out_register_CF;
wire [31:0] v6120 = In_register_ESP;
wire v6121 = v6120 == Out_register_ESP;
wire v6123 = v60f8 == vd;
wire v6124 = v6123;
wire v6125 = v60ce & v6124;
wire v6126 = v6125;
wire [31:0] v6122 = v7b8 | v60f6;
wire v6129 = v60f8 == v9;
wire v612a = v6129;
wire v612b = v60ce & v612a;
wire v612c = v612b;
wire [31:0] v6128 = v7c8 | v60fe;
wire [31:0] v612f = ( v6126 ) ? v6122 : 
	( v8 ) ? In_register_EBX : v6128;
wire [31:0] v6131 = v612f;
wire v6132 = v6131 == Out_register_EBX;
wire [31:0] v6134 = In_register_FSBASE;
wire v6135 = v6134 == Out_register_FSBASE;
wire v6137 = v60f8 == vf;
wire v6138 = v6137;
wire v6139 = v60ce & v6138;
wire v613a = v6139;
wire [31:0] v6136 = v790 | v60fe;
wire v613d = v60f8 == vc;
wire v613e = v613d;
wire v613f = v60ce & v613e;
wire v6140 = v613f;
wire [31:0] v613c = v7a0 | v60f6;
wire [31:0] v6143 = ( v8 ) ? In_register_ECX : 
	( v613a ) ? v6136 : v613c;
wire [31:0] v6145 = v6143;
wire v6146 = v6145 == Out_register_ECX;
wire v6148 = v60f8 == v7;
wire v6149 = v6148;
wire v614a = v60ce & v6149;
wire v614b = v614a;
wire [31:0] v6147 = v5c8 | v60f6;
wire v614e = v60f8 == vb;
wire v614f = v614e;
wire v6150 = v60ce & v614f;
wire v6151 = v6150;
wire [31:0] v614d = v752 | v60fe;
wire [31:0] v6154 = ( v8 ) ? In_register_EAX : 
	( v614b ) ? v6147 : v614d;
wire [31:0] v6156 = v6154;
wire v6157 = v6156 == Out_register_EAX;
wire [31:0] v6159 = In_register_EBP;
wire v615a = v6159 == Out_register_EBP;
wire [31:0] v615c = In_register_EDI;
wire v615d = v615c == Out_register_EDI;
wire [31:0] v615f = In_register_CSBASE;
wire v6160 = v615f == Out_register_CSBASE;
wire [31:0] v6162 = In_register_DSBASE;
wire v6163 = v6162 == Out_register_DSBASE;
wire [7:0] v6164 = v60f3 ^ v60e3;
wire [7:0] v6165 = v60f5 ^ v6164;
wire [7:0] v6166 = v6165 >> v1d;
wire [7:0] v6167 = v6166 & v18;
wire v6168 = v6167[0:0];
wire v616a = v6168;
wire v616b = v616a == Out_register_AF;
wire [7:0] v616c = v60f5 ^ v60e3;
wire [7:0] v616d = v616c >> v33;
wire [7:0] v616e = v6164 >> v33;
wire [7:0] v616f = v616d + v616e;
wire v6170 = v616f == v34;
wire v6172 = v6170;
wire v6173 = v6172 == Out_register_OF;
wire v6174 = $signed(v60f5) < $signed(v2c);
wire v6176 = v6174;
wire v6177 = v6176 == Out_register_SF;
wire [2:0] v6178_aux = v60f5[0] + v60f5[1] + v60f5[2] + v60f5[3] + v60f5[4] + v60f5[5] + v60f5[6] + v60f5[7];
wire v6178 = { 5'b00000, v6178_aux };
wire [7:0] v6179 = v6178 & v18;
wire [7:0] v617a = v6179 ^ v18;
wire v617b = v617a[0:0];
wire v617d = v617b;
wire v617e = v617d == Out_register_PF;
wire [31:0] v6180 = v1c;
wire [31:0] v6181 = In_register_EIP + v6180;
wire [31:0] v6183 = v6181;
wire v6184 = v6183 == Out_register_EIP;
wire v6185 = v60f4 == v65f;
wire v6187 = v6185;
wire v6188 = v6187 == Out_register_ZF;
wire v6189 = v60d3 & v6109 & v15c & v610c & v610f & v6110 & v6113 & v6116 & v611e & v6121 & v6132 & v6135 & v6146 & v6157 & v615a & v615d & v6160 & v6163 & v616b & v6173 & v60d0 & v6177 & v617e & v6184 & v6188;
wire v618a = v40 == v1eb;
wire v618b = v8 == v829;
wire [4:0] v107 = 5'b10100;
wire v618c = v107 == v1ed;
wire v618d = v4 == v11b;
wire v618e = v618a & v618b & v618c & v618d;
wire v618f = v40 == v1eb;
wire v6190 = v82 == v1ed;
wire v6191 = v38 == v6da;
wire [2:0] v6192 = { v1fa };
wire v6193 = v6192 == vb;
wire v6194 = v6193;
wire v6195 = v6194 ^ v8;
wire [2:0] v6196 = { v1fa };
wire v6197 = v6196 == vb;
wire v6198 = v6197;
wire v6199 = v6198 ^ v8;
wire [2:0] v619a = { v1fa };
wire v619b = v619a == vb;
wire v619c = v619b;
wire v619d = v619c ^ v8;
wire [2:0] v619e = { v1fa };
wire v619f = v619e == vb;
wire v61a0 = v619f;
wire v61a1 = v61a0 ^ v8;
wire v61a2 = v6195 & v6199 & v619d & v61a1;
wire v61a3 = v618f & v6190 & v6191 & v61a2;
wire v61a4 = v618e | v61a3;
wire v61a5 = v61a4;
wire [31:0] v61a7 = In_register_ESI;
wire v61a8 = v61a7 == Out_register_ESI;
wire [31:0] v61a9 = memory_0[79: 48];
wire [31:0] v61ac = ( v61a3 ) ? v7f8 : v63a;
wire [31:0] v61ad = v61a9 - v61ac;
wire [7:0] v61ae = v61ad[7:0];
wire [2:0] v61af_aux = v61ae[0] + v61ae[1] + v61ae[2] + v61ae[3] + v61ae[4] + v61ae[5] + v61ae[6] + v61ae[7];
wire v61af = { 5'b00000, v61af_aux };
wire [7:0] v61b0 = v61af & v18;
wire [7:0] v61b1 = v61b0 ^ v18;
wire v61b2 = v61b1[0:0];
wire v61b4 = v61b2;
wire v61b5 = v61b4 == Out_register_PF;
wire [31:0] v61b8 = ( v61a3 ) ? v27 : v10;
wire [31:0] v61b9 = In_register_EIP + v61b8;
wire [31:0] v61bb = v61b9;
wire v61bc = v61bb == Out_register_EIP;
wire v61bd = In_error_flag == Out_error_flag;
wire [31:0] v61bf = In_register_EBX;
wire v61c0 = v61bf == Out_register_EBX;
wire [1:0] v61c1 = { v889 , v888 };
wire [31:0] v61c2 = ( v61c1 == 2'd0) ? In_register_EDX : 
	( v61c1 == 2'd1) ? In_register_ESI : 
	( v61c1 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v61c4 = { v1fa };
wire [31:0] v61c5 = ( v61c4 == 3'd0) ? In_register_EAX : 
	( v61c4 == 3'd1) ? In_register_ECX : 
	( v61c4 == 3'd2) ? In_register_EDX : 
	( v61c4 == 3'd3) ? In_register_EBX : 
	( v61c4 == 3'd4) ? v15 : 
	( v61c4 == 3'd5) ? In_register_EBP : 
	( v61c4 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v61c6 = v61c5 + v63a;
wire [31:0] v61c8 = ( v618e ) ? v61c2 : v61c6;
wire v61c9 =  v26 == memory_1[15: 12] && v61c8 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v61ad == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [1:0] v61ca = { v889 , v888 };
wire [31:0] v61cb = ( v61ca == 2'd0) ? In_register_EDX : 
	( v61ca == 2'd1) ? In_register_ESI : 
	( v61ca == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v61cd = { v1fa };
wire [31:0] v61ce = ( v61cd == 3'd0) ? In_register_EAX : 
	( v61cd == 3'd1) ? In_register_ECX : 
	( v61cd == 3'd2) ? In_register_EDX : 
	( v61cd == 3'd3) ? In_register_EBX : 
	( v61cd == 3'd4) ? v15 : 
	( v61cd == 3'd5) ? In_register_EBP : 
	( v61cd == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v61cf = v61ce + v63a;
wire [31:0] v61d1 = ( v618e ) ? v61cb : v61cf;
wire v61d2 =  v26 == memory_0[15: 12] && v61d1 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v61d4 = In_register_ESBASE;
wire v61d5 = v61d4 == Out_register_ESBASE;
wire [31:0] v61d7 = In_register_EDI;
wire v61d8 = v61d7 == Out_register_EDI;
wire [31:0] v61da = In_register_ESP;
wire v61db = v61da == Out_register_ESP;
wire [31:0] v61dd = In_register_EAX;
wire v61de = v61dd == Out_register_EAX;
wire [7:0] v61e0 = In_register_DF;
wire v61e1 = v61e0 == Out_register_DF;
wire [31:0] v61e3 = In_register_SSBASE;
wire v61e4 = v61e3 == Out_register_SSBASE;
wire [31:0] v61e6 = In_register_DSBASE;
wire v61e7 = v61e6 == Out_register_DSBASE;
wire [31:0] v61e9 = In_register_ECX;
wire v61ea = v61e9 == Out_register_ECX;
wire [31:0] v61ec = In_register_GSBASE;
wire v61ed = v61ec == Out_register_GSBASE;
wire [31:0] v61ef = In_register_CSBASE;
wire v61f0 = v61ef == Out_register_CSBASE;
wire [31:0] v61f1 = v61ad ^ v61a9;
wire [31:0] v61f2 = v61f1 >> v1e;
wire [31:0] v61f3 = v61a9 ^ v61ac;
wire [31:0] v61f4 = v61f3 >> v1e;
wire [31:0] v61f5 = v61f2 + v61f4;
wire v61f6 = v61f5 == v1c;
wire v61f8 = v61f6;
wire v61f9 = v61f8 == Out_register_OF;
wire [31:0] v61fb = In_register_EDX;
wire v61fc = v61fb == Out_register_EDX;
wire [31:0] v61fe = In_register_FSBASE;
wire v61ff = v61fe == Out_register_FSBASE;
wire [31:0] v6200 = v61f3 ^ v61ad;
wire [7:0] v6201 = v6200[7:0];
wire [7:0] v6202 = v6201 >> v1d;
wire [7:0] v6203 = v6202 & v18;
wire v6204 = v6203[0:0];
wire v6206 = v6204;
wire v6207 = v6206 == Out_register_AF;
wire v6208 = v61a9 < v61ac;
wire v620a = v6208;
wire v620b = v620a == Out_register_CF;
wire [31:0] v620d = In_register_EBP;
wire v620e = v620d == Out_register_EBP;
wire v620f = $signed(v61ad) < $signed(v15);
wire v6211 = v620f;
wire v6212 = v6211 == Out_register_SF;
wire v6213 = v61a9 == v61ac;
wire v6215 = v6213;
wire v6216 = v6215 == Out_register_ZF;
wire v6217 = v61a8 & v61b5 & v15c & v61bc & v61bd & v61a5 & v61c0 & v61c9 & v61d2 & v61d5 & v61d8 & v61db & v61de & v61e1 & v61e4 & v61e7 & v61ea & v61ed & v61f0 & v61f9 & v61fc & v61ff & v6207 & v620b & v620e & v6212 & v6216;
wire v6218 = v2 == v117;
wire v6219 = v30 == v119;
wire v621a = v38 == v6da;
wire [2:0] v621b = { v13c };
wire v621c = v621b == vb;
wire v621d = v621c;
wire v621e = v621d ^ v8;
wire [2:0] v621f = { v13c };
wire v6220 = v621f == vb;
wire v6221 = v6220;
wire v6222 = v6221 ^ v8;
wire v6223 = v621e & v6222;
wire v6224 = v6218 & v6219 & v621a & v6223;
wire v6225 = v2 == v117;
wire v6226 = v2f == v119;
wire v6227 = v43 == vab3;
wire [2:0] v6228 = { v13c };
wire v6229 = v6228 == vb;
wire v622a = v6228 == vf;
wire v622b = v6229 | v622a;
wire v622c = v622b ^ v8;
wire [2:0] v622d = { v13c };
wire v622e = v622d == vb;
wire v622f = v622e;
wire v6230 = v622f ^ v8;
wire v6231 = v622c & v6230;
wire v6232 = v6225 & v6226 & v6227 & v6231;
wire [18:0] v108 = 19'b0110011010010001001;
wire v6233 = v108 == vdfa;
wire v6234 = v4b == v3d60;
wire v6235 = v51 == vdfc;
wire [2:0] v6236 = { v3d58 };
wire v6237 = v6236 == vb;
wire v6238 = v6237;
wire v6239 = v6238 ^ v8;
wire v623a = v6239;
wire v623b = v6233 & v6234 & v6235 & v623a;
wire v623c = v2 == v117;
wire v623d = v35 == v119;
wire v623e = v4 == v11b;
wire [2:0] v623f = { v13c };
wire v6240 = v623f == vb;
wire v6241 = v623f == vf;
wire v6242 = v6240 | v6241;
wire v6243 = v6242 ^ v8;
wire [2:0] v6244 = { v13c };
wire v6245 = v6244 == vb;
wire v6246 = v6244 == vf;
wire v6247 = v6245 | v6246;
wire v6248 = v6247 ^ v8;
wire v6249 = v6243 & v6248;
wire v624a = v623c & v623d & v623e & v6249;
wire v624b = v6224 | v6232 | v623b | v624a;
wire v624c = v624b;
wire [31:0] v624e = In_register_EAX;
wire v624f = v624e == Out_register_EAX;
wire [31:0] v6251 = In_register_EBX;
wire v6252 = v6251 == Out_register_EBX;
wire v6254 = In_register_SF;
wire v6255 = v6254 == Out_register_SF;
wire [31:0] v6257 = In_register_ECX;
wire v6258 = v6257 == Out_register_ECX;
wire [31:0] v625a = In_register_CSBASE;
wire v625b = v625a == Out_register_CSBASE;
wire [2:0] v6269 = { v13c };
wire [31:0] v626a = ( v6269 == 3'd0) ? In_register_EAX : 
	( v6269 == 3'd1) ? In_register_ECX : 
	( v6269 == 3'd2) ? In_register_EDX : 
	( v6269 == 3'd3) ? In_register_EBX : 
	( v6269 == 3'd4) ? v15 : 
	( v6269 == 3'd5) ? v15 : 
	( v6269 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6260 = { v13c };
wire [31:0] v6261 = ( v6260 == 3'd0) ? In_register_EAX : 
	( v6260 == 3'd1) ? In_register_ECX : 
	( v6260 == 3'd2) ? In_register_EDX : 
	( v6260 == 3'd3) ? In_register_EBX : 
	( v6260 == 3'd4) ? v15 : 
	( v6260 == 3'd5) ? v15 : 
	( v6260 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6262 = v6261 + vc2d;
wire [2:0] v6264 = { v3d58 };
wire [31:0] v6265 = ( v6264 == 3'd0) ? In_register_EAX : 
	( v6264 == 3'd1) ? In_register_ECX : 
	( v6264 == 3'd2) ? In_register_EDX : 
	( v6264 == 3'd3) ? In_register_EBX : 
	( v6264 == 3'd4) ? v15 : 
	( v6264 == 3'd5) ? In_register_EBP : 
	( v6264 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6266 = v6265 << v3d5c;
wire [31:0] v6267 = v6266 + v2faa;
wire [2:0] v625c = { v13c };
wire [31:0] v625d = ( v625c == 3'd0) ? In_register_EAX : 
	( v625c == 3'd1) ? In_register_ECX : 
	( v625c == 3'd2) ? In_register_EDX : 
	( v625c == 3'd3) ? In_register_EBX : 
	( v625c == 3'd4) ? v15 : 
	( v625c == 3'd5) ? In_register_EBP : 
	( v625c == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v625e = v625d + v7f8;
wire [31:0] v626c = ( v624a ) ? v626a : 
	( v6232 ) ? v6262 : 
	( v623b ) ? v6267 : v625e;
wire [2:0] v626d = { v12c };
wire [31:0] v626e = ( v626d == 3'd0) ? In_register_EAX : 
	( v626d == 3'd1) ? In_register_ECX : 
	( v626d == 3'd2) ? In_register_EDX : 
	( v626d == 3'd3) ? In_register_EBX : 
	( v626d == 3'd4) ? In_register_ESP : 
	( v626d == 3'd5) ? In_register_EBP : 
	( v626d == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v626f = v626e & v6;
wire [2:0] v6271 = { v12c };
wire [31:0] v6272 = ( v6271 == 3'd0) ? In_register_EAX : 
	( v6271 == 3'd1) ? In_register_ECX : 
	( v6271 == 3'd2) ? In_register_EDX : 
	( v6271 == 3'd3) ? In_register_EBX : 
	( v6271 == 3'd4) ? In_register_ESP : 
	( v6271 == 3'd5) ? In_register_EBP : 
	( v6271 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6273 = v6272 & v6;
wire [2:0] v6275 = { v12c };
wire [31:0] v6276 = ( v6275 == 3'd0) ? In_register_EAX : 
	( v6275 == 3'd1) ? In_register_ECX : 
	( v6275 == 3'd2) ? In_register_EDX : 
	( v6275 == 3'd3) ? In_register_EBX : 
	( v6275 == 3'd4) ? In_register_ESP : 
	( v6275 == 3'd5) ? In_register_EBP : 
	( v6275 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6277 = v6276 & v6;
wire [2:0] v6279 = { v12c };
wire [31:0] v627a = ( v6279 == 3'd0) ? In_register_EAX : 
	( v6279 == 3'd1) ? In_register_ECX : 
	( v6279 == 3'd2) ? In_register_EDX : 
	( v6279 == 3'd3) ? In_register_EBX : 
	( v6279 == 3'd4) ? In_register_ESP : 
	( v6279 == 3'd5) ? In_register_EBP : 
	( v6279 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v627b = v627a & v6;
wire [31:0] v627d = ( v6224 ) ? v626f : 
	( v6232 ) ? v6273 : 
	( v623b ) ? v6277 : v627b;
wire [15:0] v627e = v627d[15:0];
wire v627f =  v9f == memory_0[15: 12] && v626c == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && v627e == memory_0[79: 48] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b1 == memory_0[1: 1];
wire [31:0] v6281 = In_register_EDX;
wire v6282 = v6281 == Out_register_EDX;
wire v6284 = In_register_CF;
wire v6285 = v6284 == Out_register_CF;
wire v6287 = In_register_OF;
wire v6288 = v6287 == Out_register_OF;
wire [31:0] v628a = In_register_ESI;
wire v628b = v628a == Out_register_ESI;
wire [31:0] v6290 = ( v6232 ) ? v45 : 
	( v623b ) ? v31 : 
	( v6224 ) ? v27 : v10;
wire [31:0] v6291 = In_register_EIP + v6290;
wire [31:0] v6293 = v6291;
wire v6294 = v6293 == Out_register_EIP;
wire [31:0] v6296 = In_register_EBP;
wire v6297 = v6296 == Out_register_EBP;
wire [31:0] v6299 = In_register_EDI;
wire v629a = v6299 == Out_register_EDI;
wire v629b = In_error_flag == Out_error_flag;
wire [31:0] v629d = In_register_ESP;
wire v629e = v629d == Out_register_ESP;
wire [31:0] v62a0 = In_register_SSBASE;
wire v62a1 = v62a0 == Out_register_SSBASE;
wire [31:0] v62a3 = In_register_GSBASE;
wire v62a4 = v62a3 == Out_register_GSBASE;
wire v62a6 = In_register_AF;
wire v62a7 = v62a6 == Out_register_AF;
wire [7:0] v62a9 = In_register_DF;
wire v62aa = v62a9 == Out_register_DF;
wire v62ac = In_register_PF;
wire v62ad = v62ac == Out_register_PF;
wire [31:0] v62af = In_register_DSBASE;
wire v62b0 = v62af == Out_register_DSBASE;
wire [31:0] v62b2 = In_register_FSBASE;
wire v62b3 = v62b2 == Out_register_FSBASE;
wire [31:0] v62b5 = In_register_ESBASE;
wire v62b6 = v62b5 == Out_register_ESBASE;
wire v62b8 = In_register_ZF;
wire v62b9 = v62b8 == Out_register_ZF;
wire v62ba = v624c & v624f & v6252 & v6255 & v6258 & v625b & v627f & v6282 & v6285 & v6288 & v628b & v6294 & v6297 & v629a & v15c & v629b & v629e & v62a1 & v62a4 & v62a7 & v62aa & v62ad & v62b0 & v62b3 & v62b6 & v62b9;
wire [7:0] v109 = 8'b01011000;
wire v62c8 = v109 == v1eb;
wire v62c9 = v3 == v316;
wire v62ca = v1b == v318;
wire v62cb = v62c8 & v62c9 & v62ca;
wire v62f2 = v62cb;
wire v62f3 = v62f2;
wire [2:0] v62e4 = { v320 };
wire v62e5 = v62e4 == vf;
wire v62e6 = v62e5;
wire v62e7 = v62cb & v62e6;
wire v62e8 = v62e7;
wire [2:0] v62bb = { v320 };
wire [31:0] v62bc = ( v62bb == 3'd0) ? In_register_EAX : 
	( v62bb == 3'd1) ? In_register_ECX : 
	( v62bb == 3'd2) ? In_register_EDX : 
	( v62bb == 3'd3) ? In_register_EBX : 
	( v62bb == 3'd4) ? In_register_EAX : 
	( v62bb == 3'd5) ? In_register_ECX : 
	( v62bb == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v62bd = { v320 };
wire v62be = v62bd == vb;
wire v62bf = v62bd == v9;
wire v62c0 = v62be | v62bf;
wire v62c1 = v62bd == vf;
wire v62c2 = v62c0 | v62c1;
wire v62c3 = v62bd == v11;
wire v62c4 = v62c2 | v62c3;
wire [31:0] v62c5 = ( v62c4 == 1'd0) ? v15 : v31;
wire [31:0] v62c6 = v62bc >> v62c5;
wire [31:0] v62c7 = v62c6 & v32;
wire [31:0] v62cd = v62c7;
wire [7:0] v62ce = v62cd[7:0];
wire [2:0] v62cf = { v1fa };
wire [31:0] v62d0 = ( v62cf == 3'd0) ? In_register_EAX : 
	( v62cf == 3'd1) ? In_register_ECX : 
	( v62cf == 3'd2) ? In_register_EDX : 
	( v62cf == 3'd3) ? In_register_EBX : 
	( v62cf == 3'd4) ? In_register_EAX : 
	( v62cf == 3'd5) ? In_register_ECX : 
	( v62cf == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v62d1 = { v1fa };
wire v62d2 = v62d1 == vb;
wire v62d3 = v62d1 == v9;
wire v62d4 = v62d2 | v62d3;
wire v62d5 = v62d1 == vf;
wire v62d6 = v62d4 | v62d5;
wire v62d7 = v62d1 == v11;
wire v62d8 = v62d6 | v62d7;
wire [31:0] v62d9 = ( v62d8 == 1'd0) ? v15 : v31;
wire [31:0] v62da = v62d0 >> v62d9;
wire [31:0] v62db = v62da & v32;
wire [31:0] v62dd = v62db;
wire [7:0] v62de = v62dd[7:0];
wire [7:0] v62df = v62ce - v62de;
wire [7:0] v62e0 = v62df - v65f;
wire [31:0] v62e1 = { 24'b000000000000000000000000, v62e0 };
wire [31:0] v62e2 = v62e1 << v31;
wire [31:0] v62e3 = v790 | v62e2;
wire v62eb = v62e4 == vc;
wire v62ec = v62eb;
wire v62ed = v62cb & v62ec;
wire v62ee = v62ed;
wire [31:0] v62ea = v7a0 | v62e1;
wire [31:0] v62f1 = ( v8 ) ? In_register_ECX : 
	( v62e8 ) ? v62e3 : v62ea;
wire [31:0] v62f5 = v62f1;
wire v62f6 = v62f5 == Out_register_ECX;
wire v62f8 = v62e4 == vd;
wire v62f9 = v62f8;
wire v62fa = v62cb & v62f9;
wire v62fb = v62fa;
wire [31:0] v62f7 = v7b8 | v62e1;
wire v62fe = v62e4 == v9;
wire v62ff = v62fe;
wire v6300 = v62cb & v62ff;
wire v6301 = v6300;
wire [31:0] v62fd = v7c8 | v62e2;
wire [31:0] v6304 = ( v8 ) ? In_register_EBX : 
	( v62fb ) ? v62f7 : v62fd;
wire [31:0] v6306 = v6304;
wire v6307 = v6306 == Out_register_EBX;
wire [31:0] v6309 = In_register_ESI;
wire v630a = v6309 == Out_register_ESI;
wire [7:0] v630c = In_register_DF;
wire v630d = v630c == Out_register_DF;
wire [31:0] v630f = In_register_EDI;
wire v6310 = v630f == Out_register_EDI;
wire [31:0] v6312 = In_register_ESP;
wire v6313 = v6312 == Out_register_ESP;
wire v6315 = v62e4 == v7;
wire v6316 = v6315;
wire v6317 = v62cb & v6316;
wire v6318 = v6317;
wire [31:0] v6314 = v5c8 | v62e1;
wire v631b = v62e4 == vb;
wire v631c = v631b;
wire v631d = v62cb & v631c;
wire v631e = v631d;
wire [31:0] v631a = v752 | v62e2;
wire [31:0] v6321 = ( v8 ) ? In_register_EAX : 
	( v6318 ) ? v6314 : v631a;
wire [31:0] v6323 = v6321;
wire v6324 = v6323 == Out_register_EAX;
wire [2:0] v6325_aux = v62e0[0] + v62e0[1] + v62e0[2] + v62e0[3] + v62e0[4] + v62e0[5] + v62e0[6] + v62e0[7];
wire v6325 = { 5'b00000, v6325_aux };
wire [7:0] v6326 = v6325 & v18;
wire [7:0] v6327 = v6326 ^ v18;
wire v6328 = v6327[0:0];
wire v632a = v6328;
wire v632b = v632a == Out_register_PF;
wire v632d = v62e4 == ve;
wire v632e = v632d;
wire v632f = v62cb & v632e;
wire v6330 = v632f;
wire [31:0] v632c = v768 | v62e1;
wire v6333 = v62e4 == v11;
wire v6334 = v6333;
wire v6335 = v62cb & v6334;
wire v6336 = v6335;
wire [31:0] v6332 = v778 | v62e2;
wire [31:0] v6339 = ( v8 ) ? In_register_EDX : 
	( v6330 ) ? v632c : v6332;
wire [31:0] v633b = v6339;
wire v633c = v633b == Out_register_EDX;
wire [31:0] v633e = v1c;
wire [31:0] v633f = In_register_EIP + v633e;
wire [31:0] v6341 = v633f;
wire v6342 = v6341 == Out_register_EIP;
wire [31:0] v6344 = In_register_CSBASE;
wire v6345 = v6344 == Out_register_CSBASE;
wire [31:0] v6347 = In_register_SSBASE;
wire v6348 = v6347 == Out_register_SSBASE;
wire [7:0] v6349 = v62e0 ^ v62ce;
wire [7:0] v634a = v6349 >> v33;
wire [7:0] v634b = v62de ^ v62ce;
wire [7:0] v634c = v634b >> v33;
wire [7:0] v634d = v634a + v634c;
wire v634e = v634d == v34;
wire v6350 = v634e;
wire v6351 = v6350 == Out_register_OF;
wire [31:0] v6353 = In_register_FSBASE;
wire v6354 = v6353 == Out_register_FSBASE;
wire [31:0] v6356 = In_register_ESBASE;
wire v6357 = v6356 == Out_register_ESBASE;
wire [31:0] v6359 = In_register_DSBASE;
wire v635a = v6359 == Out_register_DSBASE;
wire v635b = In_error_flag == Out_error_flag;
wire v635c = v62ce < v62de;
wire v635d = v62df < v65f;
wire [7:0] v635e = { 7'b0000000, v635d };
wire [7:0] v635f = ( v635c == 1'd0) ? v635e : v18;
wire v6360 = v635f[0:0];
wire v6362 = v6360;
wire v6363 = v6362 == Out_register_CF;
wire [31:0] v6365 = In_register_EBP;
wire v6366 = v6365 == Out_register_EBP;
wire [31:0] v6368 = In_register_GSBASE;
wire v6369 = v6368 == Out_register_GSBASE;
wire [7:0] v636a = v62e0 ^ v634b;
wire [7:0] v636b = v636a >> v1d;
wire [7:0] v636c = v636b & v18;
wire v636d = v636c[0:0];
wire v636f = v636d;
wire v6370 = v636f == Out_register_AF;
wire v6371 = $signed(v62e0) < $signed(v2c);
wire v6373 = v6371;
wire v6374 = v6373 == Out_register_SF;
wire v6375 = v62df == v65f;
wire v6377 = v6375;
wire v6378 = v6377 == Out_register_ZF;
wire v6379 = v62f6 & v6307 & v630a & v630d & v6310 & v6313 & v6324 & v632b & v62f3 & v633c & v6342 & v6345 & v6348 & v6351 & v6354 & v6357 & v635a & v635b & v15c & v6363 & v6366 & v6369 & v6370 & v6374 & v6378;
wire [7:0] v10a = 8'b00001100;
wire v637a = v10a == v1eb;
wire v637b = v8 == v829;
wire v637c = v35 == v316;
wire v637d = v1b == v318;
wire v637e = v637a & v637b & v637c & v637d;
wire v637f = v10a == v1eb;
wire v6380 = v2f == v316;
wire v6381 = v14 == v1ef;
wire [2:0] v6382 = { v1fa };
wire v6383 = v6382 == vb;
wire v6384 = v6382 == vf;
wire v6385 = v6383 | v6384;
wire v6386 = v6385 ^ v8;
wire [2:0] v6387 = { v1fa };
wire v6388 = v6387 == vb;
wire v6389 = v6388;
wire v638a = v6389 ^ v8;
wire [2:0] v638b = { v1fa };
wire v638c = v638b == vb;
wire v638d = v638b == vf;
wire v638e = v638c | v638d;
wire v638f = v638e ^ v8;
wire [2:0] v6390 = { v1fa };
wire v6391 = v6390 == vb;
wire v6392 = v6391;
wire v6393 = v6392 ^ v8;
wire v6394 = v6386 & v638a & v638f & v6393;
wire v6395 = v637f & v6380 & v6381 & v6394;
wire v6396 = v10a == v1eb;
wire v6397 = v8 == v829;
wire v6398 = v30 == v316;
wire v6399 = v4 == v11b;
wire v639a = v6396 & v6397 & v6398 & v6399;
wire [10:0] v10b = 11'b00001100101;
wire v639b = v10b == v6d7;
wire v639c = v35 == v316;
wire v639d = v14 == v1ef;
wire v639e = v639b & v639c & v639d;
wire v639f = v637e | v6395 | v639a | v639e;
wire v63a0 = v639f;
wire [31:0] v63a2 = In_register_CSBASE;
wire v63a3 = v63a2 == Out_register_CSBASE;
wire [31:0] v63a5 = In_register_ESI;
wire v63a6 = v63a5 == Out_register_ESI;
wire v63a7 = In_error_flag == Out_error_flag;
wire [31:0] v63a9 = In_register_SSBASE;
wire v63aa = v63a9 == Out_register_SSBASE;
wire [31:0] v63ac = In_register_ECX;
wire v63ad = v63ac == Out_register_ECX;
wire [1:0] v63ae = { v889 , v888 };
wire [31:0] v63af = ( v63ae == 2'd0) ? In_register_EDX : 
	( v63ae == 2'd1) ? In_register_ESI : 
	( v63ae == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v63b1 = { v1fa };
wire [31:0] v63b2 = ( v63b1 == 3'd0) ? In_register_EAX : 
	( v63b1 == 3'd1) ? In_register_ECX : 
	( v63b1 == 3'd2) ? In_register_EDX : 
	( v63b1 == 3'd3) ? In_register_EBX : 
	( v63b1 == 3'd4) ? v15 : 
	( v63b1 == 3'd5) ? v15 : 
	( v63b1 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v63b3 = v63b2 + v1f7;
wire [1:0] v63b5 = { v889 , v888 };
wire [31:0] v63b6 = ( v63b5 == 2'd0) ? In_register_EDX : 
	( v63b5 == 2'd1) ? In_register_ESI : 
	( v63b5 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v63b7 = v63b6 + v63a;
wire [31:0] v63ba = ( v637e ) ? v63af : 
	( v639e ) ? v1f7 : 
	( v6395 ) ? v63b3 : v63b7;
wire v63bb =  v2a == memory_0[15: 12] && v63ba == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v63bd = In_register_EDX;
wire v63be = v63bd == Out_register_EDX;
wire [31:0] v63c0 = In_register_EDI;
wire v63c1 = v63c0 == Out_register_EDI;
wire [31:0] v63c3 = In_register_EAX;
wire v63c4 = v63c3 == Out_register_EAX;
wire [31:0] v63c6 = In_register_EBX;
wire v63c7 = v63c6 == Out_register_EBX;
wire [31:0] v63c9 = In_register_GSBASE;
wire v63ca = v63c9 == Out_register_GSBASE;
wire [31:0] v63cc = In_register_ESP;
wire v63cd = v63cc == Out_register_ESP;
wire [31:0] v63cf = In_register_EBP;
wire v63d0 = v63cf == Out_register_EBP;
wire v63d2 = v17;
wire v63d3 = v63d2 == Out_register_OF;
wire [31:0] v63d4 = memory_0[79: 48];
wire [7:0] v63d5 = v63d4[7:0];
wire [2:0] v63d6 = { v320 };
wire [31:0] v63d7 = ( v63d6 == 3'd0) ? In_register_EAX : 
	( v63d6 == 3'd1) ? In_register_ECX : 
	( v63d6 == 3'd2) ? In_register_EDX : 
	( v63d6 == 3'd3) ? In_register_EBX : 
	( v63d6 == 3'd4) ? In_register_EAX : 
	( v63d6 == 3'd5) ? In_register_ECX : 
	( v63d6 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v63d8 = { v320 };
wire v63d9 = v63d8 == vb;
wire v63da = v63d8 == v9;
wire v63db = v63d9 | v63da;
wire v63dc = v63d8 == vf;
wire v63dd = v63db | v63dc;
wire v63de = v63d8 == v11;
wire v63df = v63dd | v63de;
wire [31:0] v63e0 = ( v63df == 1'd0) ? v15 : v31;
wire [31:0] v63e1 = v63d7 >> v63e0;
wire [31:0] v63e2 = v63e1 & v32;
wire [2:0] v63e4 = { v320 };
wire [31:0] v63e5 = ( v63e4 == 3'd0) ? In_register_EAX : 
	( v63e4 == 3'd1) ? In_register_ECX : 
	( v63e4 == 3'd2) ? In_register_EDX : 
	( v63e4 == 3'd3) ? In_register_EBX : 
	( v63e4 == 3'd4) ? In_register_EAX : 
	( v63e4 == 3'd5) ? In_register_ECX : 
	( v63e4 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v63e6 = { v320 };
wire v63e7 = v63e6 == vb;
wire v63e8 = v63e6 == v9;
wire v63e9 = v63e7 | v63e8;
wire v63ea = v63e6 == vf;
wire v63eb = v63e9 | v63ea;
wire v63ec = v63e6 == v11;
wire v63ed = v63eb | v63ec;
wire [31:0] v63ee = ( v63ed == 1'd0) ? v15 : v31;
wire [31:0] v63ef = v63e5 >> v63ee;
wire [31:0] v63f0 = v63ef & v32;
wire [2:0] v63f2 = { v320 };
wire [31:0] v63f3 = ( v63f2 == 3'd0) ? In_register_EAX : 
	( v63f2 == 3'd1) ? In_register_ECX : 
	( v63f2 == 3'd2) ? In_register_EDX : 
	( v63f2 == 3'd3) ? In_register_EBX : 
	( v63f2 == 3'd4) ? In_register_EAX : 
	( v63f2 == 3'd5) ? In_register_ECX : 
	( v63f2 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v63f4 = { v320 };
wire v63f5 = v63f4 == vb;
wire v63f6 = v63f4 == v9;
wire v63f7 = v63f5 | v63f6;
wire v63f8 = v63f4 == vf;
wire v63f9 = v63f7 | v63f8;
wire v63fa = v63f4 == v11;
wire v63fb = v63f9 | v63fa;
wire [31:0] v63fc = ( v63fb == 1'd0) ? v15 : v31;
wire [31:0] v63fd = v63f3 >> v63fc;
wire [31:0] v63fe = v63fd & v32;
wire [2:0] v6400 = { v320 };
wire [31:0] v6401 = ( v6400 == 3'd0) ? In_register_EAX : 
	( v6400 == 3'd1) ? In_register_ECX : 
	( v6400 == 3'd2) ? In_register_EDX : 
	( v6400 == 3'd3) ? In_register_EBX : 
	( v6400 == 3'd4) ? In_register_EAX : 
	( v6400 == 3'd5) ? In_register_ECX : 
	( v6400 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6402 = { v320 };
wire v6403 = v6402 == vb;
wire v6404 = v6402 == v9;
wire v6405 = v6403 | v6404;
wire v6406 = v6402 == vf;
wire v6407 = v6405 | v6406;
wire v6408 = v6402 == v11;
wire v6409 = v6407 | v6408;
wire [31:0] v640a = ( v6409 == 1'd0) ? v15 : v31;
wire [31:0] v640b = v6401 >> v640a;
wire [31:0] v640c = v640b & v32;
wire [31:0] v640e = ( v637e ) ? v63e2 : 
	( v6395 ) ? v63f0 : 
	( v639a ) ? v63fe : v640c;
wire [7:0] v640f = v640e[7:0];
wire [7:0] v6410 = v63d5 ^ v640f;
wire v6411 = $signed(v6410) < $signed(v2c);
wire v6413 = v6411;
wire v6414 = v6413 == Out_register_SF;
wire [31:0] v6419 = ( v637e ) ? v1c : 
	( v6395 | v639e ) ? v16 : v10;
wire [31:0] v641a = In_register_EIP + v6419;
wire [31:0] v641c = v641a;
wire v641d = v641c == Out_register_EIP;
wire [31:0] v641f = In_register_FSBASE;
wire v6420 = v641f == Out_register_FSBASE;
wire [1:0] v6421 = { v889 , v888 };
wire [31:0] v6422 = ( v6421 == 2'd0) ? In_register_EDX : 
	( v6421 == 2'd1) ? In_register_ESI : 
	( v6421 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [2:0] v6424 = { v1fa };
wire [31:0] v6425 = ( v6424 == 3'd0) ? In_register_EAX : 
	( v6424 == 3'd1) ? In_register_ECX : 
	( v6424 == 3'd2) ? In_register_EDX : 
	( v6424 == 3'd3) ? In_register_EBX : 
	( v6424 == 3'd4) ? v15 : 
	( v6424 == 3'd5) ? v15 : 
	( v6424 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6426 = v6425 + v1f7;
wire [1:0] v6428 = { v889 , v888 };
wire [31:0] v6429 = ( v6428 == 2'd0) ? In_register_EDX : 
	( v6428 == 2'd1) ? In_register_ESI : 
	( v6428 == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v642a = v6429 + v63a;
wire [31:0] v642d = ( v637e ) ? v6422 : 
	( v639e ) ? v1f7 : 
	( v6395 ) ? v6426 : v642a;
wire v642e =  v2a == memory_1[15: 12] && v642d == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v6410 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v642f = v17;
wire v6430 = v642f == Out_register_CF;
wire [2:0] v6431_aux = v6410[0] + v6410[1] + v6410[2] + v6410[3] + v6410[4] + v6410[5] + v6410[6] + v6410[7];
wire v6431 = { 5'b00000, v6431_aux };
wire [7:0] v6432 = v6431 & v18;
wire [7:0] v6433 = v6432 ^ v18;
wire v6434 = v6433[0:0];
wire v6436 = v6434;
wire v6437 = v6436 == Out_register_PF;
wire [31:0] v6439 = In_register_ESBASE;
wire v643a = v6439 == Out_register_ESBASE;
wire [31:0] v643c = In_register_DSBASE;
wire v643d = v643c == Out_register_DSBASE;
wire [7:0] v643f = In_register_DF;
wire v6440 = v643f == Out_register_DF;
wire v6442 = In_register_AF;
wire v6443 = v6442 == Out_register_AF;
wire v6444 = v6410 == v2c;
wire v6446 = v6444;
wire v6447 = v6446 == Out_register_ZF;
wire v6448 = v63a0 & v63a3 & v63a6 & v63a7 & v63aa & v63ad & v63bb & v63be & v63c1 & v63c4 & v63c7 & v63ca & v63cd & v63d0 & v63d3 & v6414 & v641d & v15c & v6420 & v642e & v6430 & v6437 & v643a & v643d & v6440 & v6443 & v6447;
wire [7:0] v10c = 8'b01001110;
wire v6449 = v10c == v1eb;
wire v644a = v1b == v318;
wire v644b = v6449 & v644a;
wire v644c = v644b;
wire v644d = v644c;
wire [31:0] v644f = In_register_DSBASE;
wire v6450 = v644f == Out_register_DSBASE;
wire v6451 = In_error_flag == Out_error_flag;
wire [31:0] v6453 = In_register_EBX;
wire v6454 = v6453 == Out_register_EBX;
wire [7:0] v6456 = In_register_DF;
wire v6457 = v6456 == Out_register_DF;
wire [31:0] v6459 = In_register_EAX;
wire v645a = v6459 == Out_register_EAX;
wire [31:0] v645c = In_register_EDX;
wire v645d = v645c == Out_register_EDX;
wire [31:0] v645f = In_register_ESI;
wire v6460 = v645f == Out_register_ESI;
wire [31:0] v6462 = In_register_CSBASE;
wire v6463 = v6462 == Out_register_CSBASE;
wire v6465 = In_register_CF;
wire v6466 = v6465 == Out_register_CF;
wire [31:0] v6468 = In_register_EBP;
wire v6469 = v6468 == Out_register_EBP;
wire v646b = In_register_OF;
wire v646c = v646b == Out_register_OF;
wire [31:0] v646e = In_register_SSBASE;
wire v646f = v646e == Out_register_SSBASE;
wire [31:0] v6471 = In_register_ESP;
wire v6472 = v6471 == Out_register_ESP;
wire [31:0] v6474 = In_register_ECX;
wire v6475 = v6474 == Out_register_ECX;
wire [31:0] v6477 = v1c;
wire [31:0] v6478 = In_register_EIP + v6477;
wire [31:0] v647a = v6478;
wire [31:0] v647b = v6478 + v477;
wire [31:0] v647d = v647b;
wire [31:0] v647e = ( In_register_CF == 1'd0) ? v647a : v647d;
wire [31:0] v6481 = ( v644c ) ? v647e : v6478;
wire [31:0] v6483 = v6481;
wire v6484 = v6483 == Out_register_EIP;
wire [31:0] v6486 = In_register_ESBASE;
wire v6487 = v6486 == Out_register_ESBASE;
wire [31:0] v6489 = In_register_GSBASE;
wire v648a = v6489 == Out_register_GSBASE;
wire [31:0] v648c = In_register_EDI;
wire v648d = v648c == Out_register_EDI;
wire v648f = In_register_PF;
wire v6490 = v648f == Out_register_PF;
wire [31:0] v6492 = In_register_FSBASE;
wire v6493 = v6492 == Out_register_FSBASE;
wire v6495 = In_register_AF;
wire v6496 = v6495 == Out_register_AF;
wire v6498 = In_register_SF;
wire v6499 = v6498 == Out_register_SF;
wire v649b = In_register_ZF;
wire v649c = v649b == Out_register_ZF;
wire v649d = v644d & v6450 & v6451 & v6454 & v6457 & v645a & v645d & v6460 & v6463 & v15c & v6466 & v6469 & v646c & v646f & v6472 & v6475 & v6484 & v6487 & v648a & v648d & v6490 & v6493 & v6496 & v6499 & v649c;
wire v649e = v70 == v1eb;
wire v649f = v3 == v316;
wire v64a0 = v1b == v318;
wire v64a1 = v649e & v649f & v64a0;
wire v64a2 = v64a1;
wire v64a3 = v64a2;
wire v64a4 = In_error_flag == Out_error_flag;
wire [2:0] v64c9 = { v1fa };
wire v64ca = v64c9 == v7;
wire v64cb = v64ca;
wire v64cc = v64a1 & v64cb;
wire v64cd = v64cc;
wire [2:0] v64a5 = { v320 };
wire [31:0] v64a6 = ( v64a5 == 3'd0) ? In_register_EAX : 
	( v64a5 == 3'd1) ? In_register_ECX : 
	( v64a5 == 3'd2) ? In_register_EDX : 
	( v64a5 == 3'd3) ? In_register_EBX : 
	( v64a5 == 3'd4) ? In_register_EAX : 
	( v64a5 == 3'd5) ? In_register_ECX : 
	( v64a5 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v64a7 = { v320 };
wire v64a8 = v64a7 == vb;
wire v64a9 = v64a7 == v9;
wire v64aa = v64a8 | v64a9;
wire v64ab = v64a7 == vf;
wire v64ac = v64aa | v64ab;
wire v64ad = v64a7 == v11;
wire v64ae = v64ac | v64ad;
wire [31:0] v64af = ( v64ae == 1'd0) ? v15 : v31;
wire [31:0] v64b0 = v64a6 >> v64af;
wire [31:0] v64b1 = v64b0 & v32;
wire [31:0] v64b3 = v64b1;
wire [7:0] v64b4 = v64b3[7:0];
wire [2:0] v64b5 = { v1fa };
wire [31:0] v64b6 = ( v64b5 == 3'd0) ? In_register_EAX : 
	( v64b5 == 3'd1) ? In_register_ECX : 
	( v64b5 == 3'd2) ? In_register_EDX : 
	( v64b5 == 3'd3) ? In_register_EBX : 
	( v64b5 == 3'd4) ? In_register_EAX : 
	( v64b5 == 3'd5) ? In_register_ECX : 
	( v64b5 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v64b7 = { v1fa };
wire v64b8 = v64b7 == vb;
wire v64b9 = v64b7 == v9;
wire v64ba = v64b8 | v64b9;
wire v64bb = v64b7 == vf;
wire v64bc = v64ba | v64bb;
wire v64bd = v64b7 == v11;
wire v64be = v64bc | v64bd;
wire [31:0] v64bf = ( v64be == 1'd0) ? v15 : v31;
wire [31:0] v64c0 = v64b6 >> v64bf;
wire [31:0] v64c1 = v64c0 & v32;
wire [31:0] v64c3 = v64c1;
wire [7:0] v64c4 = v64c3[7:0];
wire [7:0] v64c5 = v64b4 + v64c4;
wire [7:0] v64c6 = v65f + v64c5;
wire [31:0] v64c7 = { 24'b000000000000000000000000, v64c6 };
wire [31:0] v64c8 = v5c8 | v64c7;
wire v64d1 = v64c9 == vb;
wire v64d2 = v64d1;
wire v64d3 = v64a1 & v64d2;
wire v64d4 = v64d3;
wire [31:0] v64cf = v64c7 << v31;
wire [31:0] v64d0 = v752 | v64cf;
wire [31:0] v64d7 = ( v8 ) ? In_register_EAX : 
	( v64cd ) ? v64c8 : v64d0;
wire [31:0] v64d9 = v64d7;
wire v64da = v64d9 == Out_register_EAX;
wire v64dc = v64c9 == vd;
wire v64dd = v64dc;
wire v64de = v64a1 & v64dd;
wire v64df = v64de;
wire [31:0] v64db = v7b8 | v64c7;
wire v64e2 = v64c9 == v9;
wire v64e3 = v64e2;
wire v64e4 = v64a1 & v64e3;
wire v64e5 = v64e4;
wire [31:0] v64e1 = v7c8 | v64cf;
wire [31:0] v64e8 = ( v8 ) ? In_register_EBX : 
	( v64df ) ? v64db : v64e1;
wire [31:0] v64ea = v64e8;
wire v64eb = v64ea == Out_register_EBX;
wire v64ed = v64c9 == ve;
wire v64ee = v64ed;
wire v64ef = v64a1 & v64ee;
wire v64f0 = v64ef;
wire [31:0] v64ec = v768 | v64c7;
wire v64f3 = v64c9 == v11;
wire v64f4 = v64f3;
wire v64f5 = v64a1 & v64f4;
wire v64f6 = v64f5;
wire [31:0] v64f2 = v778 | v64cf;
wire [31:0] v64f9 = ( v8 ) ? In_register_EDX : 
	( v64f0 ) ? v64ec : v64f2;
wire [31:0] v64fb = v64f9;
wire v64fc = v64fb == Out_register_EDX;
wire [31:0] v64fe = In_register_ESI;
wire v64ff = v64fe == Out_register_ESI;
wire [31:0] v6501 = In_register_EBP;
wire v6502 = v6501 == Out_register_EBP;
wire [2:0] v6503_aux = v64c6[0] + v64c6[1] + v64c6[2] + v64c6[3] + v64c6[4] + v64c6[5] + v64c6[6] + v64c6[7];
wire v6503 = { 5'b00000, v6503_aux };
wire [7:0] v6504 = v6503 & v18;
wire [7:0] v6505 = v6504 ^ v18;
wire v6506 = v6505[0:0];
wire v6508 = v6506;
wire v6509 = v6508 == Out_register_PF;
wire [31:0] v650b = In_register_ESP;
wire v650c = v650b == Out_register_ESP;
wire [31:0] v650e = In_register_CSBASE;
wire v650f = v650e == Out_register_CSBASE;
wire [31:0] v6511 = In_register_EDI;
wire v6512 = v6511 == Out_register_EDI;
wire [7:0] v6513 = v64c6 ^ v64b4;
wire [7:0] v6514 = v6513 ^ v64c4;
wire [7:0] v6515 = v6514 >> v1d;
wire [7:0] v6516 = v6515 & v18;
wire v6517 = v6516[0:0];
wire v6519 = v6517;
wire v651a = v6519 == Out_register_AF;
wire [7:0] v651b = v64c6 ^ v64c4;
wire [7:0] v651c = v651b >> v33;
wire [7:0] v651d = v6513 >> v33;
wire [7:0] v651e = v651c + v651d;
wire v651f = v651e == v34;
wire v6521 = v651f;
wire v6522 = v6521 == Out_register_OF;
wire [31:0] v6524 = In_register_SSBASE;
wire v6525 = v6524 == Out_register_SSBASE;
wire [31:0] v6527 = In_register_ESBASE;
wire v6528 = v6527 == Out_register_ESBASE;
wire [31:0] v652a = In_register_GSBASE;
wire v652b = v652a == Out_register_GSBASE;
wire v652d = v64c9 == vf;
wire v652e = v652d;
wire v652f = v64a1 & v652e;
wire v6530 = v652f;
wire [31:0] v652c = v790 | v64cf;
wire v6533 = v64c9 == vc;
wire v6534 = v6533;
wire v6535 = v64a1 & v6534;
wire v6536 = v6535;
wire [31:0] v6532 = v7a0 | v64c7;
wire [31:0] v6539 = ( v8 ) ? In_register_ECX : 
	( v6530 ) ? v652c : v6532;
wire [31:0] v653b = v6539;
wire v653c = v653b == Out_register_ECX;
wire [31:0] v653e = In_register_DSBASE;
wire v653f = v653e == Out_register_DSBASE;
wire [31:0] v6541 = In_register_FSBASE;
wire v6542 = v6541 == Out_register_FSBASE;
wire [31:0] v6544 = v1c;
wire [31:0] v6545 = In_register_EIP + v6544;
wire [31:0] v6547 = v6545;
wire v6548 = v6547 == Out_register_EIP;
wire v6549 = v64c5 < v64c4;
wire v654a = v64c5 < v64b4;
wire v654b = v6549 | v654a;
wire v654c = v654b ^ v8;
wire v654d = v64c6 < v64c5;
wire v654e = v64c6 < v65f;
wire v654f = v654d | v654e;
wire [7:0] v6550 = { 7'b0000000, v654f };
wire [7:0] v6551 = ( v654c == 1'd0) ? v18 : v6550;
wire v6552 = v6551[0:0];
wire v6554 = v6552;
wire v6555 = v6554 == Out_register_CF;
wire [7:0] v6557 = In_register_DF;
wire v6558 = v6557 == Out_register_DF;
wire v6559 = $signed(v64c6) < $signed(v2c);
wire v655b = v6559;
wire v655c = v655b == Out_register_SF;
wire v655d = v64c6 == v2c;
wire v655f = v655d;
wire v6560 = v655f == Out_register_ZF;
wire v6561 = v64a3 & v64a4 & v15c & v64da & v64eb & v64fc & v64ff & v6502 & v6509 & v650c & v650f & v6512 & v651a & v6522 & v6525 & v6528 & v652b & v653c & v653f & v6542 & v6548 & v6555 & v6558 & v655c & v6560;
wire [31:0] v6562 = memory_0[79: 48];
wire v6563 =  v26 == memory_1[15: 12] && vdb3 == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v6562 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire v6577 = v4e == v1eb;
wire v6578 = vb7 == v1ed;
wire v6579 = v1b == v318;
wire [2:0] v657a = { v1fa };
wire v657b = v657a == vb;
wire v657c = v657a == vf;
wire v657d = v657b | v657c;
wire v657e = v657d ^ v8;
wire [2:0] v657f = { v1fa };
wire v6580 = v657f == vb;
wire v6581 = v657f == vf;
wire v6582 = v6580 | v6581;
wire v6583 = v6582 ^ v8;
wire v6584 = v657e & v6583;
wire v6585 = v6577 & v6578 & v6579 & v6584;
wire [2:0] v6575 = { v1fa };
wire [31:0] v6576 = ( v6575 == 3'd0) ? In_register_EAX : 
	( v6575 == 3'd1) ? In_register_ECX : 
	( v6575 == 3'd2) ? In_register_EDX : 
	( v6575 == 3'd3) ? In_register_EBX : 
	( v6575 == 3'd4) ? v15 : 
	( v6575 == 3'd5) ? v15 : 
	( v6575 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [15:0] v10d = 16'b1111111100101110;
wire v658a = v10d == v117;
wire v658b = v94 == v20a0;
wire v658c = v38 == v6da;
wire [2:0] v658d = { v13c };
wire v658e = v658d == v7;
wire v658f = v658d == vc;
wire v6590 = v658d == ve;
wire v6591 = v658d == vd;
wire v6592 = v658d == v11;
wire v6593 = v658d == v9;
wire v6594 = v658e | v658f | v6590 | v6591 | v6592 | v6593;
wire v6595 = v6594 ^ v8;
wire v6596 = v6595;
wire v6597 = v658a & v658b & v658c & v6596;
wire [2:0] v6587 = { v13c };
wire [31:0] v6588 = ( v6587 == 3'd0) ? v15 : 
	( v6587 == 3'd1) ? v15 : 
	( v6587 == 3'd2) ? v15 : 
	( v6587 == 3'd3) ? v15 : 
	( v6587 == 3'd4) ? In_register_ESP : 
	( v6587 == 3'd5) ? In_register_EBP : 
	( v6587 == 3'd6) ? v15 : v15;
wire [31:0] v6589 = v6588 + v7f8;
wire v6567 = v4e == v1eb;
wire v6568 = vd5 == v1ed;
wire v6569 = v14 == v1ef;
wire [2:0] v656a = { v1fa };
wire v656b = v656a == vb;
wire v656c = v656b;
wire v656d = v656c ^ v8;
wire [2:0] v656e = { v1fa };
wire v656f = v656e == vb;
wire v6570 = v656f;
wire v6571 = v6570 ^ v8;
wire v6572 = v656d & v6571;
wire v6573 = v6567 & v6568 & v6569 & v6572;
wire [2:0] v6564 = { v1fa };
wire [31:0] v6565 = ( v6564 == 3'd0) ? In_register_EAX : 
	( v6564 == 3'd1) ? In_register_ECX : 
	( v6564 == 3'd2) ? In_register_EDX : 
	( v6564 == 3'd3) ? In_register_EBX : 
	( v6564 == 3'd4) ? v15 : 
	( v6564 == 3'd5) ? In_register_EBP : 
	( v6564 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6566 = v6565 + v1f7;
wire [31:0] v6599 = ( v6585 ) ? v6576 : 
	( v6597 ) ? v6589 : v6566;
wire v659a =  v26 == memory_0[15: 12] && v6599 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire v659b = v6573 | v6585 | v6597;
wire v659c = v659b;
wire [31:0] v659e = In_register_EDI;
wire v659f = v659e == Out_register_EDI;
wire v65a0 = In_error_flag == Out_error_flag;
wire [31:0] v65a2 = In_register_EBX;
wire v65a3 = v65a2 == Out_register_EBX;
wire [31:0] v65a5 = In_register_EAX;
wire v65a6 = v65a5 == Out_register_EAX;
wire [31:0] v65a8 = In_register_FSBASE;
wire v65a9 = v65a8 == Out_register_FSBASE;
wire v65ab = In_register_CF;
wire v65ac = v65ab == Out_register_CF;
wire [31:0] v65ae = In_register_ECX;
wire v65af = v65ae == Out_register_ECX;
wire [31:0] v65b1 = In_register_EDX;
wire v65b2 = v65b1 == Out_register_EDX;
wire [31:0] v65b4 = vdb2;
wire v65b5 = v65b4 == Out_register_ESP;
wire [31:0] v65b7 = In_register_ESI;
wire v65b8 = v65b7 == Out_register_ESI;
wire [31:0] v65bc = ( v6597 ) ? v27 : 
	( v6585 ) ? v1c : v16;
wire [31:0] v65bd = In_register_EIP + v65bc;
wire [31:0] v65bf = v65bd;
wire v65c0 = v65bf == Out_register_EIP;
wire [31:0] v65c2 = In_register_SSBASE;
wire v65c3 = v65c2 == Out_register_SSBASE;
wire [31:0] v65c5 = In_register_CSBASE;
wire v65c6 = v65c5 == Out_register_CSBASE;
wire v65c8 = In_register_SF;
wire v65c9 = v65c8 == Out_register_SF;
wire [31:0] v65cb = In_register_EBP;
wire v65cc = v65cb == Out_register_EBP;
wire [31:0] v65ce = In_register_ESBASE;
wire v65cf = v65ce == Out_register_ESBASE;
wire [31:0] v65d1 = In_register_DSBASE;
wire v65d2 = v65d1 == Out_register_DSBASE;
wire [31:0] v65d4 = In_register_GSBASE;
wire v65d5 = v65d4 == Out_register_GSBASE;
wire [7:0] v65d7 = In_register_DF;
wire v65d8 = v65d7 == Out_register_DF;
wire v65da = In_register_AF;
wire v65db = v65da == Out_register_AF;
wire v65dd = In_register_OF;
wire v65de = v65dd == Out_register_OF;
wire v65e0 = In_register_PF;
wire v65e1 = v65e0 == Out_register_PF;
wire v65e3 = In_register_ZF;
wire v65e4 = v65e3 == Out_register_ZF;
wire v65e5 = v6563 & v659a & v659f & v65a0 & v65a3 & v65a6 & v65a9 & v65ac & v65af & v65b2 & v65b5 & v15c & v65b8 & v659c & v65c0 & v65c3 & v65c6 & v65c9 & v65cc & v65cf & v65d2 & v65d5 & v65d8 & v65db & v65de & v65e1 & v65e4;
wire v65e6 = In_error_flag == Out_error_flag;
wire v65e7 = v3e == v1eb;
wire v65e8 = v4f == v1ed;
wire v65e9 = v4 == v11b;
wire v65ea = v65e7 & v65e8 & v65e9;
wire v660f = v65ea;
wire v6610 = v660f;
wire [2:0] v6600 = { v1fa };
wire v6601 = v6600 == ve;
wire v6602 = v6601;
wire v6603 = v65ea & v6602;
wire v6604 = v6603;
wire [31:0] v65ec = v63a;
wire [2:0] v65ed = { v1fa };
wire [31:0] v65ee = ( v65ed == 3'd0) ? In_register_EAX : 
	( v65ed == 3'd1) ? In_register_ECX : 
	( v65ed == 3'd2) ? In_register_EDX : 
	( v65ed == 3'd3) ? In_register_EBX : 
	( v65ed == 3'd4) ? In_register_EAX : 
	( v65ed == 3'd5) ? In_register_ECX : 
	( v65ed == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v65ef = { v1fa };
wire v65f0 = v65ef == vb;
wire v65f1 = v65ef == v9;
wire v65f2 = v65f0 | v65f1;
wire v65f3 = v65ef == vf;
wire v65f4 = v65f2 | v65f3;
wire v65f5 = v65ef == v11;
wire v65f6 = v65f4 | v65f5;
wire [31:0] v65f7 = ( v65f6 == 1'd0) ? v15 : v31;
wire [31:0] v65f8 = v65ee >> v65f7;
wire [31:0] v65f9 = v65f8 & v32;
wire [31:0] v65fb = v65f9;
wire [31:0] v65fc = v65ec ^ v65fb;
wire [7:0] v65fd = v65fc[7:0];
wire [31:0] v65fe = { 24'b000000000000000000000000, v65fd };
wire [31:0] v65ff = v768 | v65fe;
wire v6608 = v6600 == v11;
wire v6609 = v6608;
wire v660a = v65ea & v6609;
wire v660b = v660a;
wire [31:0] v6606 = v65fe << v31;
wire [31:0] v6607 = v778 | v6606;
wire [31:0] v660e = ( v6604 ) ? v65ff : 
	( v660b ) ? v6607 : In_register_EDX;
wire [31:0] v6612 = v660e;
wire v6613 = v6612 == Out_register_EDX;
wire [31:0] v6615 = In_register_EDI;
wire v6616 = v6615 == Out_register_EDI;
wire [31:0] v6618 = In_register_FSBASE;
wire v6619 = v6618 == Out_register_FSBASE;
wire v661b = v6600 == v7;
wire v661c = v661b;
wire v661d = v65ea & v661c;
wire v661e = v661d;
wire [31:0] v661a = v5c8 | v65fe;
wire v6621 = v6600 == vb;
wire v6622 = v6621;
wire v6623 = v65ea & v6622;
wire v6624 = v6623;
wire [31:0] v6620 = v752 | v6606;
wire [31:0] v6627 = ( v8 ) ? In_register_EAX : 
	( v661e ) ? v661a : v6620;
wire [31:0] v6629 = v6627;
wire v662a = v6629 == Out_register_EAX;
wire v662c = v6600 == vd;
wire v662d = v662c;
wire v662e = v65ea & v662d;
wire v662f = v662e;
wire [31:0] v662b = v7b8 | v65fe;
wire v6632 = v6600 == v9;
wire v6633 = v6632;
wire v6634 = v65ea & v6633;
wire v6635 = v6634;
wire [31:0] v6631 = v7c8 | v6606;
wire [31:0] v6638 = ( v8 ) ? In_register_EBX : 
	( v662f ) ? v662b : v6631;
wire [31:0] v663a = v6638;
wire v663b = v663a == Out_register_EBX;
wire v663d = v17;
wire v663e = v663d == Out_register_CF;
wire [31:0] v6640 = In_register_SSBASE;
wire v6641 = v6640 == Out_register_SSBASE;
wire v6643 = v6600 == vf;
wire v6644 = v6643;
wire v6645 = v65ea & v6644;
wire v6646 = v6645;
wire [31:0] v6642 = v790 | v6606;
wire v6649 = v6600 == vc;
wire v664a = v6649;
wire v664b = v65ea & v664a;
wire v664c = v664b;
wire [31:0] v6648 = v7a0 | v65fe;
wire [31:0] v664f = ( v8 ) ? In_register_ECX : 
	( v6646 ) ? v6642 : v6648;
wire [31:0] v6651 = v664f;
wire v6652 = v6651 == Out_register_ECX;
wire [31:0] v6654 = In_register_ESP;
wire v6655 = v6654 == Out_register_ESP;
wire [31:0] v6657 = In_register_CSBASE;
wire v6658 = v6657 == Out_register_CSBASE;
wire v6659 = $signed(v65fd) < $signed(v2c);
wire v665b = v6659;
wire v665c = v665b == Out_register_SF;
wire v665d = v65fd == v2c;
wire v665f = v665d;
wire v6660 = v665f == Out_register_ZF;
wire [31:0] v6662 = v10;
wire [31:0] v6663 = In_register_EIP + v6662;
wire [31:0] v6665 = v6663;
wire v6666 = v6665 == Out_register_EIP;
wire [31:0] v6668 = In_register_ESBASE;
wire v6669 = v6668 == Out_register_ESBASE;
wire [31:0] v666b = In_register_DSBASE;
wire v666c = v666b == Out_register_DSBASE;
wire [7:0] v666e = In_register_DF;
wire v666f = v666e == Out_register_DF;
wire [31:0] v6671 = In_register_GSBASE;
wire v6672 = v6671 == Out_register_GSBASE;
wire v6674 = In_register_AF;
wire v6675 = v6674 == Out_register_AF;
wire v6676 = v17;
wire v6677 = v6676 == Out_register_OF;
wire [31:0] v6679 = In_register_EBP;
wire v667a = v6679 == Out_register_EBP;
wire [2:0] v667b_aux = v65fd[0] + v65fd[1] + v65fd[2] + v65fd[3] + v65fd[4] + v65fd[5] + v65fd[6] + v65fd[7];
wire v667b = { 5'b00000, v667b_aux };
wire [7:0] v667c = v667b & v18;
wire [7:0] v667d = v667c ^ v18;
wire v667e = v667d[0:0];
wire v6680 = v667e;
wire v6681 = v6680 == Out_register_PF;
wire [31:0] v6683 = In_register_ESI;
wire v6684 = v6683 == Out_register_ESI;
wire v6685 = v65e6 & v6613 & v6616 & v6619 & v15c & v662a & v663b & v6610 & v663e & v6641 & v6652 & v6655 & v6658 & v665c & v6660 & v6666 & v6669 & v666c & v666f & v6672 & v6675 & v6677 & v667a & v6681 & v6684;
wire v6686 = v86 == v117;
wire v6687 = v92 == v20a0;
wire v6688 = v38 == v6da;
wire v6689 = v6686 & v6687 & v6688;
wire v668a = v6689;
wire v668b = v668a;
wire [31:0] v668d = In_register_ECX;
wire v668e = v668d == Out_register_ECX;
wire [31:0] v6690 = In_register_EDI;
wire v6691 = v6690 == Out_register_EDI;
wire [31:0] v6693 = v27;
wire [31:0] v6694 = In_register_EIP + v6693;
wire [31:0] v6696 = v6694;
wire v6697 = v6696 == Out_register_EIP;
wire v6698 = In_error_flag == Out_error_flag;
wire [31:0] v669a = In_register_EBX;
wire v669b = v669a == Out_register_EBX;
wire [31:0] v669d = In_register_ESP;
wire v669e = v669d == Out_register_ESP;
wire [31:0] v66a0 = v7f8;
wire [15:0] v66a1 = v66a0[15:0];
wire [2:0] v66a2 = { v13c };
wire [31:0] v66a3 = ( v66a2 == 3'd0) ? In_register_EAX : 
	( v66a2 == 3'd1) ? In_register_ECX : 
	( v66a2 == 3'd2) ? In_register_EDX : 
	( v66a2 == 3'd3) ? In_register_EBX : 
	( v66a2 == 3'd4) ? In_register_ESP : 
	( v66a2 == 3'd5) ? In_register_EBP : 
	( v66a2 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v66a4 = v66a3 & v6;
wire [31:0] v66a6 = v66a4;
wire [15:0] v66a7 = v66a6[15:0];
wire [15:0] v66a8 = v66a1 ^ v66a7;
wire [15:0] v66a9 = v66a7 - v66a1;
wire [15:0] v66aa = v66a8 ^ v66a9;
wire [7:0] v66ab = v66aa[7:0];
wire [7:0] v66ac = v66ab >> v1d;
wire [7:0] v66ad = v66ac & v18;
wire v66ae = v66ad[0:0];
wire v66b0 = v66ae;
wire v66b1 = v66b0 == Out_register_AF;
wire [31:0] v66b3 = In_register_EDX;
wire v66b4 = v66b3 == Out_register_EDX;
wire v66b5 = v66a7 < v66a1;
wire v66b7 = v66b5;
wire v66b8 = v66b7 == Out_register_CF;
wire [31:0] v66ba = In_register_ESI;
wire v66bb = v66ba == Out_register_ESI;
wire [31:0] v66bd = In_register_EAX;
wire v66be = v66bd == Out_register_EAX;
wire [31:0] v66c0 = In_register_CSBASE;
wire v66c1 = v66c0 == Out_register_CSBASE;
wire [31:0] v66c3 = In_register_SSBASE;
wire v66c4 = v66c3 == Out_register_SSBASE;
wire v66c5 = $signed(v66a9) < $signed(v87);
wire v66c7 = v66c5;
wire v66c8 = v66c7 == Out_register_SF;
wire [31:0] v66ca = In_register_DSBASE;
wire v66cb = v66ca == Out_register_DSBASE;
wire [7:0] v66cc = v66a9[7:0];
wire [2:0] v66cd_aux = v66cc[0] + v66cc[1] + v66cc[2] + v66cc[3] + v66cc[4] + v66cc[5] + v66cc[6] + v66cc[7];
wire v66cd = { 5'b00000, v66cd_aux };
wire [7:0] v66ce = v66cd & v18;
wire [7:0] v66cf = v66ce ^ v18;
wire v66d0 = v66cf[0:0];
wire v66d2 = v66d0;
wire v66d3 = v66d2 == Out_register_PF;
wire [31:0] v66d5 = In_register_GSBASE;
wire v66d6 = v66d5 == Out_register_GSBASE;
wire [31:0] v66d8 = In_register_FSBASE;
wire v66d9 = v66d8 == Out_register_FSBASE;
wire [7:0] v66db = In_register_DF;
wire v66dc = v66db == Out_register_DF;
wire [31:0] v66de = In_register_ESBASE;
wire v66df = v66de == Out_register_ESBASE;
wire [31:0] v66e1 = In_register_EBP;
wire v66e2 = v66e1 == Out_register_EBP;
wire [15:0] v66e3 = v66a9 ^ v66a7;
wire [15:0] v66e4 = v66e3 >> v88;
wire [15:0] v66e5 = v66a8 >> v88;
wire [15:0] v66e6 = v66e4 + v66e5;
wire v66e7 = v66e6 == v89;
wire v66e9 = v66e7;
wire v66ea = v66e9 == Out_register_OF;
wire v66eb = v66a7 == v66a1;
wire v66ed = v66eb;
wire v66ee = v66ed == Out_register_ZF;
wire v66ef = v15c & v668e & v6691 & v6697 & v6698 & v669b & v669e & v66b1 & v66b4 & v668b & v66b8 & v66bb & v66be & v66c1 & v66c4 & v66c8 & v66cb & v66d3 & v66d6 & v66d9 & v66dc & v66df & v66e2 & v66ea & v66ee;
wire [7:0] v10e = 8'b00110000;
wire v66f0 = v10e == v1eb;
wire v66f1 = v1b == v318;
wire v66f2 = v66f0 & v66f1;
wire v66f3 = v66f2;
wire v66f4 = v66f3;
wire [31:0] v66f6 = In_register_EDI;
wire v66f7 = v66f6 == Out_register_EDI;
wire v66f8 = In_error_flag == Out_error_flag;
wire v66fa = v17;
wire v66fb = v66fa == Out_register_OF;
wire [31:0] v66fd = In_register_EBX;
wire v66fe = v66fd == Out_register_EBX;
wire [31:0] v6700 = v477;
wire [31:0] v6702 = vf4b;
wire [31:0] v6703 = v6700 | v6702;
wire [7:0] v6704 = v6703[7:0];
wire [31:0] v6705 = { 24'b000000000000000000000000, v6704 };
wire [31:0] v6706 = v5c8 | v6705;
wire [31:0] v6709 = ( v8 ) ? In_register_EAX : v6706;
wire [31:0] v670b = v6709;
wire v670c = v670b == Out_register_EAX;
wire [31:0] v670e = v1c;
wire [31:0] v670f = In_register_EIP + v670e;
wire [31:0] v6711 = v670f;
wire v6712 = v6711 == Out_register_EIP;
wire [31:0] v6714 = In_register_ECX;
wire v6715 = v6714 == Out_register_ECX;
wire [31:0] v6717 = In_register_EDX;
wire v6718 = v6717 == Out_register_EDX;
wire [31:0] v671a = In_register_ESP;
wire v671b = v671a == Out_register_ESP;
wire [31:0] v671d = In_register_ESBASE;
wire v671e = v671d == Out_register_ESBASE;
wire [31:0] v6720 = In_register_EBP;
wire v6721 = v6720 == Out_register_EBP;
wire [31:0] v6723 = In_register_SSBASE;
wire v6724 = v6723 == Out_register_SSBASE;
wire [31:0] v6726 = In_register_CSBASE;
wire v6727 = v6726 == Out_register_CSBASE;
wire [31:0] v6729 = In_register_DSBASE;
wire v672a = v6729 == Out_register_DSBASE;
wire [7:0] v672c = In_register_DF;
wire v672d = v672c == Out_register_DF;
wire [31:0] v672f = In_register_GSBASE;
wire v6730 = v672f == Out_register_GSBASE;
wire v6731 = $signed(v6704) < $signed(v2c);
wire v6733 = v6731;
wire v6734 = v6733 == Out_register_SF;
wire [31:0] v6736 = In_register_FSBASE;
wire v6737 = v6736 == Out_register_FSBASE;
wire [31:0] v6739 = In_register_ESI;
wire v673a = v6739 == Out_register_ESI;
wire v673b = v17;
wire v673c = v673b == Out_register_CF;
wire [2:0] v673d_aux = v6704[0] + v6704[1] + v6704[2] + v6704[3] + v6704[4] + v6704[5] + v6704[6] + v6704[7];
wire v673d = { 5'b00000, v673d_aux };
wire [7:0] v673e = v673d & v18;
wire [7:0] v673f = v673e ^ v18;
wire v6740 = v673f[0:0];
wire v6742 = v6740;
wire v6743 = v6742 == Out_register_PF;
wire v6745 = In_register_AF;
wire v6746 = v6745 == Out_register_AF;
wire v6747 = v6704 == v2c;
wire v6749 = v6747;
wire v674a = v6749 == Out_register_ZF;
wire v674b = v66f7 & v66f8 & v66fb & v15c & v66f4 & v66fe & v670c & v6712 & v6715 & v6718 & v671b & v671e & v6721 & v6724 & v6727 & v672a & v672d & v6730 & v6734 & v6737 & v673a & v673c & v6743 & v6746 & v674a;
wire v674c = v2c == v1eb;
wire v674d = v35 == v316;
wire v674e = v1b == v318;
wire [2:0] v674f = { v1fa };
wire v6750 = v674f == vb;
wire v6751 = v674f == vf;
wire v6752 = v6750 | v6751;
wire v6753 = v6752 ^ v8;
wire [2:0] v6754 = { v1fa };
wire v6755 = v6754 == vb;
wire v6756 = v6754 == vf;
wire v6757 = v6755 | v6756;
wire v6758 = v6757 ^ v8;
wire [2:0] v6759 = { v1fa };
wire v675a = v6759 == vb;
wire v675b = v6759 == vf;
wire v675c = v675a | v675b;
wire v675d = v675c ^ v8;
wire [2:0] v675e = { v1fa };
wire v675f = v675e == vb;
wire v6760 = v675e == vf;
wire v6761 = v675f | v6760;
wire v6762 = v6761 ^ v8;
wire v6763 = v6753 & v6758 & v675d & v6762;
wire v6764 = v674c & v674d & v674e & v6763;
wire v6765 = v2c == v1eb;
wire v6766 = v2f == v316;
wire v6767 = v14 == v1ef;
wire [2:0] v6768 = { v1fa };
wire v6769 = v6768 == vb;
wire v676a = v6768 == vf;
wire v676b = v6769 | v676a;
wire v676c = v676b ^ v8;
wire [2:0] v676d = { v1fa };
wire v676e = v676d == vb;
wire v676f = v676e;
wire v6770 = v676f ^ v8;
wire [2:0] v6771 = { v1fa };
wire v6772 = v6771 == vb;
wire v6773 = v6771 == vf;
wire v6774 = v6772 | v6773;
wire v6775 = v6774 ^ v8;
wire [2:0] v6776 = { v1fa };
wire v6777 = v6776 == vb;
wire v6778 = v6777;
wire v6779 = v6778 ^ v8;
wire v677a = v676c & v6770 & v6775 & v6779;
wire v677b = v6765 & v6766 & v6767 & v677a;
wire v677c = v100 == v117;
wire v677d = v35 == v119;
wire v677e = v4 == v11b;
wire [2:0] v677f = { v13c };
wire v6780 = v677f == vb;
wire v6781 = v677f == vf;
wire v6782 = v6780 | v6781;
wire v6783 = v6782 ^ v8;
wire [2:0] v6784 = { v13c };
wire v6785 = v6784 == vb;
wire v6786 = v6784 == vf;
wire v6787 = v6785 | v6786;
wire v6788 = v6787 ^ v8;
wire [2:0] v6789 = { v13c };
wire v678a = v6789 == vb;
wire v678b = v6789 == vf;
wire v678c = v678a | v678b;
wire v678d = v678c ^ v8;
wire [2:0] v678e = { v13c };
wire v678f = v678e == vb;
wire v6790 = v678e == vf;
wire v6791 = v678f | v6790;
wire v6792 = v6791 ^ v8;
wire v6793 = v6783 & v6788 & v678d & v6792;
wire v6794 = v677c & v677d & v677e & v6793;
wire v6795 = v2c == v1eb;
wire v6796 = v8 == v829;
wire v6797 = v30 == v316;
wire v6798 = v4 == v11b;
wire v6799 = v6795 & v6796 & v6797 & v6798;
wire [10:0] v10f = 11'b00000000001;
wire v679a = v10f == v6d7;
wire v679b = v35 == v316;
wire v679c = v4 == v11b;
wire [2:0] v679d = { v13c };
wire v679e = v679d == vb;
wire v679f = v679d == vf;
wire v67a0 = v679e | v679f;
wire v67a1 = v67a0 ^ v8;
wire [2:0] v67a2 = { v12c };
wire v67a3 = v67a2 == vb;
wire v67a4 = v67a3;
wire v67a5 = v67a4 ^ v8;
wire [2:0] v67a6 = { v13c };
wire v67a7 = v67a6 == vf;
wire v67a8 = v67a7;
wire v67a9 = v67a8 ^ v8;
wire [2:0] v67aa = { v13c };
wire v67ab = v67aa == vb;
wire v67ac = v67aa == vf;
wire v67ad = v67ab | v67ac;
wire v67ae = v67ad ^ v8;
wire [2:0] v67af = { v12c };
wire v67b0 = v67af == vb;
wire v67b1 = v67b0;
wire v67b2 = v67b1 ^ v8;
wire [2:0] v67b3 = { v13c };
wire v67b4 = v67b3 == vf;
wire v67b5 = v67b4;
wire v67b6 = v67b5 ^ v8;
wire v67b7 = v67a1 & v67a5 & v67a9 & v67ae & v67b2 & v67b6;
wire v67b8 = v679a & v679b & v679c & v67b7;
wire [10:0] v110 = 11'b00000000101;
wire v67b9 = v110 == v6d7;
wire v67ba = v35 == v316;
wire v67bb = v14 == v1ef;
wire v67bc = v67b9 & v67ba & v67bb;
wire [15:0] v111 = 16'b1110011000000000;
wire v67bd = v111 == v117;
wire v67be = instruction_bits[18: 18];
wire v67bf = v17 == v67be;
wire v67c0 = v35 == v119;
wire v67c1 = v4 == v11b;
wire v67c2 = instruction_bits[17: 17];
wire v67c3 = { v67c2 };
wire v67c4 = v67c3;
wire v67c5 = v67c4 ^ v8;
wire v67c6 = { v67c2 };
wire v67c7 = v67c6;
wire v67c8 = v67c7 ^ v8;
wire v67c9 = v67c5 & v67c8;
wire v67ca = v67bd & v67bf & v67c0 & v67c1 & v67c9;
wire v67cb = v6764 | v677b | v6794 | v6799 | v67b8 | v67bc | v67ca;
wire v67cc = v67cb;
wire [31:0] v67ce = In_register_CSBASE;
wire v67cf = v67ce == Out_register_CSBASE;
wire [31:0] v67d1 = In_register_ESI;
wire v67d2 = v67d1 == Out_register_ESI;
wire [31:0] v67d3 = memory_0[79: 48];
wire [7:0] v67d4 = v67d3[7:0];
wire [2:0] v67d5 = { v320 };
wire [31:0] v67d6 = ( v67d5 == 3'd0) ? In_register_EAX : 
	( v67d5 == 3'd1) ? In_register_ECX : 
	( v67d5 == 3'd2) ? In_register_EDX : 
	( v67d5 == 3'd3) ? In_register_EBX : 
	( v67d5 == 3'd4) ? In_register_EAX : 
	( v67d5 == 3'd5) ? In_register_ECX : 
	( v67d5 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v67d7 = { v320 };
wire v67d8 = v67d7 == vb;
wire v67d9 = v67d7 == v9;
wire v67da = v67d8 | v67d9;
wire v67db = v67d7 == vf;
wire v67dc = v67da | v67db;
wire v67dd = v67d7 == v11;
wire v67de = v67dc | v67dd;
wire [31:0] v67df = ( v67de == 1'd0) ? v15 : v31;
wire [31:0] v67e0 = v67d6 >> v67df;
wire [31:0] v67e1 = v67e0 & v32;
wire [2:0] v67e3 = { v320 };
wire [31:0] v67e4 = ( v67e3 == 3'd0) ? In_register_EAX : 
	( v67e3 == 3'd1) ? In_register_ECX : 
	( v67e3 == 3'd2) ? In_register_EDX : 
	( v67e3 == 3'd3) ? In_register_EBX : 
	( v67e3 == 3'd4) ? In_register_EAX : 
	( v67e3 == 3'd5) ? In_register_ECX : 
	( v67e3 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v67e5 = { v320 };
wire v67e6 = v67e5 == vb;
wire v67e7 = v67e5 == v9;
wire v67e8 = v67e6 | v67e7;
wire v67e9 = v67e5 == vf;
wire v67ea = v67e8 | v67e9;
wire v67eb = v67e5 == v11;
wire v67ec = v67ea | v67eb;
wire [31:0] v67ed = ( v67ec == 1'd0) ? v15 : v31;
wire [31:0] v67ee = v67e4 >> v67ed;
wire [31:0] v67ef = v67ee & v32;
wire [2:0] v67f1 = { v12c };
wire [31:0] v67f2 = ( v67f1 == 3'd0) ? In_register_EAX : 
	( v67f1 == 3'd1) ? In_register_ECX : 
	( v67f1 == 3'd2) ? In_register_EDX : 
	( v67f1 == 3'd3) ? In_register_EBX : 
	( v67f1 == 3'd4) ? In_register_EAX : 
	( v67f1 == 3'd5) ? In_register_ECX : 
	( v67f1 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v67f3 = { v12c };
wire v67f4 = v67f3 == vb;
wire v67f5 = v67f3 == v9;
wire v67f6 = v67f4 | v67f5;
wire v67f7 = v67f3 == vf;
wire v67f8 = v67f6 | v67f7;
wire v67f9 = v67f3 == v11;
wire v67fa = v67f8 | v67f9;
wire [31:0] v67fb = ( v67fa == 1'd0) ? v15 : v31;
wire [31:0] v67fc = v67f2 >> v67fb;
wire [31:0] v67fd = v67fc & v32;
wire [2:0] v67ff = { v320 };
wire [31:0] v6800 = ( v67ff == 3'd0) ? In_register_EAX : 
	( v67ff == 3'd1) ? In_register_ECX : 
	( v67ff == 3'd2) ? In_register_EDX : 
	( v67ff == 3'd3) ? In_register_EBX : 
	( v67ff == 3'd4) ? In_register_EAX : 
	( v67ff == 3'd5) ? In_register_ECX : 
	( v67ff == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6801 = { v320 };
wire v6802 = v6801 == vb;
wire v6803 = v6801 == v9;
wire v6804 = v6802 | v6803;
wire v6805 = v6801 == vf;
wire v6806 = v6804 | v6805;
wire v6807 = v6801 == v11;
wire v6808 = v6806 | v6807;
wire [31:0] v6809 = ( v6808 == 1'd0) ? v15 : v31;
wire [31:0] v680a = v6800 >> v6809;
wire [31:0] v680b = v680a & v32;
wire [2:0] v680d = { v320 };
wire [31:0] v680e = ( v680d == 3'd0) ? In_register_EAX : 
	( v680d == 3'd1) ? In_register_ECX : 
	( v680d == 3'd2) ? In_register_EDX : 
	( v680d == 3'd3) ? In_register_EBX : 
	( v680d == 3'd4) ? In_register_EAX : 
	( v680d == 3'd5) ? In_register_ECX : 
	( v680d == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v680f = { v320 };
wire v6810 = v680f == vb;
wire v6811 = v680f == v9;
wire v6812 = v6810 | v6811;
wire v6813 = v680f == vf;
wire v6814 = v6812 | v6813;
wire v6815 = v680f == v11;
wire v6816 = v6814 | v6815;
wire [31:0] v6817 = ( v6816 == 1'd0) ? v15 : v31;
wire [31:0] v6818 = v680e >> v6817;
wire [31:0] v6819 = v6818 & v32;
wire [2:0] v681b = { v320 };
wire [31:0] v681c = ( v681b == 3'd0) ? In_register_EAX : 
	( v681b == 3'd1) ? In_register_ECX : 
	( v681b == 3'd2) ? In_register_EDX : 
	( v681b == 3'd3) ? In_register_EBX : 
	( v681b == 3'd4) ? In_register_EAX : 
	( v681b == 3'd5) ? In_register_ECX : 
	( v681b == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v681d = { v320 };
wire v681e = v681d == vb;
wire v681f = v681d == v9;
wire v6820 = v681e | v681f;
wire v6821 = v681d == vf;
wire v6822 = v6820 | v6821;
wire v6823 = v681d == v11;
wire v6824 = v6822 | v6823;
wire [31:0] v6825 = ( v6824 == 1'd0) ? v15 : v31;
wire [31:0] v6826 = v681c >> v6825;
wire [31:0] v6827 = v6826 & v32;
wire [2:0] v6829 = { v12c };
wire [31:0] v682a = ( v6829 == 3'd0) ? In_register_EAX : 
	( v6829 == 3'd1) ? In_register_ECX : 
	( v6829 == 3'd2) ? In_register_EDX : 
	( v6829 == 3'd3) ? In_register_EBX : 
	( v6829 == 3'd4) ? In_register_EAX : 
	( v6829 == 3'd5) ? In_register_ECX : 
	( v6829 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v682b = { v12c };
wire v682c = v682b == vb;
wire v682d = v682b == v9;
wire v682e = v682c | v682d;
wire v682f = v682b == vf;
wire v6830 = v682e | v682f;
wire v6831 = v682b == v11;
wire v6832 = v6830 | v6831;
wire [31:0] v6833 = ( v6832 == 1'd0) ? v15 : v31;
wire [31:0] v6834 = v682a >> v6833;
wire [31:0] v6835 = v6834 & v32;
wire [31:0] v6837 = ( v6764 ) ? v67e1 : 
	( v677b ) ? v67ef : 
	( v6794 ) ? v67fd : 
	( v6799 ) ? v680b : 
	( v67b8 ) ? v6819 : 
	( v67bc ) ? v6827 : v6835;
wire [7:0] v6838 = v6837[7:0];
wire [7:0] v6839 = v67d4 + v6838;
wire [7:0] v683a = v6839 ^ v6838;
wire [7:0] v683b = v683a ^ v67d4;
wire [7:0] v683c = v683b >> v1d;
wire [7:0] v683d = v683c & v18;
wire v683e = v683d[0:0];
wire v6840 = v683e;
wire v6841 = v6840 == Out_register_AF;
wire [7:0] v6842 = v6839 ^ v67d4;
wire [7:0] v6843 = v6842 >> v33;
wire [7:0] v6844 = v683a >> v33;
wire [7:0] v6845 = v6843 + v6844;
wire v6846 = v6845 == v34;
wire v6848 = v6846;
wire v6849 = v6848 == Out_register_OF;
wire [31:0] v684b = In_register_EBP;
wire v684c = v684b == Out_register_EBP;
wire [31:0] v684e = In_register_EDI;
wire v684f = v684e == Out_register_EDI;
wire [2:0] v685e = { v13c };
wire [31:0] v685f = ( v685e == 3'd0) ? In_register_EAX : 
	( v685e == 3'd1) ? In_register_ECX : 
	( v685e == 3'd2) ? In_register_EDX : 
	( v685e == 3'd3) ? In_register_EBX : 
	( v685e == 3'd4) ? v15 : 
	( v685e == 3'd5) ? v15 : 
	( v685e == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6860 = { v12c };
wire [31:0] v6861 = ( v6860 == 3'd0) ? In_register_EAX : 
	( v6860 == 3'd1) ? In_register_ECX : 
	( v6860 == 3'd2) ? In_register_EDX : 
	( v6860 == 3'd3) ? In_register_EBX : 
	( v6860 == 3'd4) ? v15 : 
	( v6860 == 3'd5) ? In_register_EBP : 
	( v6860 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6862 = v6861 << v7f4;
wire [31:0] v6863 = v685f + v6862;
wire [1:0] v685a = { v889 , v888 };
wire [31:0] v685b = ( v685a == 2'd0) ? In_register_EDX : 
	( v685a == 2'd1) ? In_register_ESI : 
	( v685a == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v685c = v685b + v63a;
wire [2:0] v6857 = { v13c };
wire [31:0] v6858 = ( v6857 == 3'd0) ? In_register_EAX : 
	( v6857 == 3'd1) ? In_register_ECX : 
	( v6857 == 3'd2) ? In_register_EDX : 
	( v6857 == 3'd3) ? In_register_EBX : 
	( v6857 == 3'd4) ? v15 : 
	( v6857 == 3'd5) ? v15 : 
	( v6857 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6850 = { v1fa };
wire [31:0] v6851 = ( v6850 == 3'd0) ? In_register_EAX : 
	( v6850 == 3'd1) ? In_register_ECX : 
	( v6850 == 3'd2) ? In_register_EDX : 
	( v6850 == 3'd3) ? In_register_EBX : 
	( v6850 == 3'd4) ? v15 : 
	( v6850 == 3'd5) ? v15 : 
	( v6850 == 3'd6) ? In_register_ESI : In_register_EDI;
wire v6866 = { v67c2 };
wire [31:0] v6867 = ( v6866 == 1'd0) ? In_register_EBX : v15;
wire [31:0] v6868 = v6867 & v6;
wire v6869 = { v5b69 };
wire [31:0] v686a = ( v6869 == 1'd0) ? In_register_ESI : In_register_EDI;
wire [31:0] v686b = v686a & v6;
wire [31:0] v686c = v6868 + v686b;
wire [2:0] v6853 = { v1fa };
wire [31:0] v6854 = ( v6853 == 3'd0) ? In_register_EAX : 
	( v6853 == 3'd1) ? In_register_ECX : 
	( v6853 == 3'd2) ? In_register_EDX : 
	( v6853 == 3'd3) ? In_register_EBX : 
	( v6853 == 3'd4) ? v15 : 
	( v6853 == 3'd5) ? v15 : 
	( v6853 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6855 = v6854 + v1f7;
wire [31:0] v686e = ( v67b8 ) ? v6863 : 
	( v6799 ) ? v685c : 
	( v67bc ) ? v1f7 : 
	( v6794 ) ? v6858 : 
	( v6764 ) ? v6851 : 
	( v67ca ) ? v686c : v6855;
wire v686f =  v2a == memory_1[15: 12] && v686e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v6839 == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v6871 = In_register_ECX;
wire v6872 = v6871 == Out_register_ECX;
wire [31:0] v6874 = In_register_EAX;
wire v6875 = v6874 == Out_register_EAX;
wire [31:0] v6877 = In_register_DSBASE;
wire v6878 = v6877 == Out_register_DSBASE;
wire [31:0] v687a = In_register_FSBASE;
wire v687b = v687a == Out_register_FSBASE;
wire [31:0] v687d = In_register_EDX;
wire v687e = v687d == Out_register_EDX;
wire [31:0] v6880 = In_register_ESP;
wire v6881 = v6880 == Out_register_ESP;
wire v6882 = In_error_flag == Out_error_flag;
wire v6899 = { v67c2 };
wire [31:0] v689a = ( v6899 == 1'd0) ? In_register_EBX : v15;
wire [31:0] v689b = v689a & v6;
wire v689c = { v5b69 };
wire [31:0] v689d = ( v689c == 1'd0) ? In_register_ESI : In_register_EDI;
wire [31:0] v689e = v689d & v6;
wire [31:0] v689f = v689b + v689e;
wire [2:0] v688a = { v13c };
wire [31:0] v688b = ( v688a == 3'd0) ? In_register_EAX : 
	( v688a == 3'd1) ? In_register_ECX : 
	( v688a == 3'd2) ? In_register_EDX : 
	( v688a == 3'd3) ? In_register_EBX : 
	( v688a == 3'd4) ? v15 : 
	( v688a == 3'd5) ? v15 : 
	( v688a == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6883 = { v1fa };
wire [31:0] v6884 = ( v6883 == 3'd0) ? In_register_EAX : 
	( v6883 == 3'd1) ? In_register_ECX : 
	( v6883 == 3'd2) ? In_register_EDX : 
	( v6883 == 3'd3) ? In_register_EBX : 
	( v6883 == 3'd4) ? v15 : 
	( v6883 == 3'd5) ? v15 : 
	( v6883 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6886 = { v1fa };
wire [31:0] v6887 = ( v6886 == 3'd0) ? In_register_EAX : 
	( v6886 == 3'd1) ? In_register_ECX : 
	( v6886 == 3'd2) ? In_register_EDX : 
	( v6886 == 3'd3) ? In_register_EBX : 
	( v6886 == 3'd4) ? v15 : 
	( v6886 == 3'd5) ? v15 : 
	( v6886 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6888 = v6887 + v1f7;
wire [1:0] v688d = { v889 , v888 };
wire [31:0] v688e = ( v688d == 2'd0) ? In_register_EDX : 
	( v688d == 2'd1) ? In_register_ESI : 
	( v688d == 2'd2) ? In_register_EBX : In_register_EDI;
wire [31:0] v688f = v688e + v63a;
wire [2:0] v6891 = { v13c };
wire [31:0] v6892 = ( v6891 == 3'd0) ? In_register_EAX : 
	( v6891 == 3'd1) ? In_register_ECX : 
	( v6891 == 3'd2) ? In_register_EDX : 
	( v6891 == 3'd3) ? In_register_EBX : 
	( v6891 == 3'd4) ? v15 : 
	( v6891 == 3'd5) ? v15 : 
	( v6891 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [2:0] v6893 = { v12c };
wire [31:0] v6894 = ( v6893 == 3'd0) ? In_register_EAX : 
	( v6893 == 3'd1) ? In_register_ECX : 
	( v6893 == 3'd2) ? In_register_EDX : 
	( v6893 == 3'd3) ? In_register_EBX : 
	( v6893 == 3'd4) ? v15 : 
	( v6893 == 3'd5) ? In_register_EBP : 
	( v6893 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6895 = v6894 << v7f4;
wire [31:0] v6896 = v6892 + v6895;
wire [31:0] v68a1 = ( v67ca ) ? v689f : 
	( v67bc ) ? v1f7 : 
	( v6794 ) ? v688b : 
	( v6764 ) ? v6884 : 
	( v677b ) ? v6888 : 
	( v6799 ) ? v688f : v6896;
wire v68a2 =  v2a == memory_0[15: 12] && v68a1 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v68a4 = In_register_SSBASE;
wire v68a5 = v68a4 == Out_register_SSBASE;
wire [31:0] v68a7 = In_register_ESBASE;
wire v68a8 = v68a7 == Out_register_ESBASE;
wire [31:0] v68aa = In_register_GSBASE;
wire v68ab = v68aa == Out_register_GSBASE;
wire [31:0] v68b3 = ( v6764 ) ? v1c : 
	( v677b | v67bc ) ? v16 : v10;
wire [31:0] v68b4 = In_register_EIP + v68b3;
wire [31:0] v68b6 = v68b4;
wire v68b7 = v68b6 == Out_register_EIP;
wire v68b8 = v6839 < v67d4;
wire v68b9 = v6839 < v6838;
wire v68ba = v68b8 | v68b9;
wire v68bc = v68ba;
wire v68bd = v68bc == Out_register_CF;
wire [31:0] v68bf = In_register_EBX;
wire v68c0 = v68bf == Out_register_EBX;
wire [7:0] v68c2 = In_register_DF;
wire v68c3 = v68c2 == Out_register_DF;
wire [2:0] v68c4_aux = v6839[0] + v6839[1] + v6839[2] + v6839[3] + v6839[4] + v6839[5] + v6839[6] + v6839[7];
wire v68c4 = { 5'b00000, v68c4_aux };
wire [7:0] v68c5 = v68c4 & v18;
wire [7:0] v68c6 = v68c5 ^ v18;
wire v68c7 = v68c6[0:0];
wire v68c9 = v68c7;
wire v68ca = v68c9 == Out_register_PF;
wire v68cb = $signed(v6839) < $signed(v2c);
wire v68cd = v68cb;
wire v68ce = v68cd == Out_register_SF;
wire v68cf = v6839 == v2c;
wire v68d1 = v68cf;
wire v68d2 = v68d1 == Out_register_ZF;
wire v68d3 = v67cf & v67d2 & v6841 & v67cc & v6849 & v684c & v684f & v686f & v15c & v6872 & v6875 & v6878 & v687b & v687e & v6881 & v6882 & v68a2 & v68a5 & v68a8 & v68ab & v68b7 & v68bd & v68c0 & v68c3 & v68ca & v68ce & v68d2;
wire v68d4 = v68 == v2682;
wire v68d5 = v29 == v59f;
wire v68d6 = v68d4 & v68d5;
wire v68d7 = v68d6;
wire v68d8 = v68d7;
wire [31:0] v68da = v2b;
wire [31:0] v68db = In_register_EIP + v68da;
wire [31:0] v68dd = v68db;
wire v68de = v68dd == Out_register_EIP;
wire [2:0] v68e4 = { v268d };
wire v68e5 = v68e4 == v11;
wire v68e6 = v68e5;
wire v68e7 = v68d6 & v68e6;
wire v68e8 = v68e7;
wire [2:0] v68df = { v268d };
wire [31:0] v68e0 = ( v68df == 3'd0) ? In_register_EAX : 
	( v68df == 3'd1) ? In_register_ECX : 
	( v68df == 3'd2) ? In_register_EDX : 
	( v68df == 3'd3) ? In_register_EBX : 
	( v68df == 3'd4) ? In_register_ESP : 
	( v68df == 3'd5) ? In_register_EBP : 
	( v68df == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v68e2 = v68e0;
wire [31:0] v68e3 = v68e2 + v2b;
wire [31:0] v68eb = ( v8 ) ? In_register_ESI : v68e3;
wire [31:0] v68ed = v68eb;
wire v68ee = v68ed == Out_register_ESI;
wire [31:0] v68f0 = In_register_SSBASE;
wire v68f1 = v68f0 == Out_register_SSBASE;
wire v68f2 = v68e4 == ve;
wire v68f3 = v68f2;
wire v68f4 = v68d6 & v68f3;
wire v68f5 = v68f4;
wire [31:0] v68f8 = ( v8 ) ? In_register_EDX : v68e3;
wire [31:0] v68fa = v68f8;
wire v68fb = v68fa == Out_register_EDX;
wire v68fc = In_error_flag == Out_error_flag;
wire v68fd = v68e4 == vb;
wire v68fe = v68fd;
wire v68ff = v68d6 & v68fe;
wire v6900 = v68ff;
wire [31:0] v6903 = ( v8 ) ? In_register_ESP : v68e3;
wire [31:0] v6905 = v6903;
wire v6906 = v6905 == Out_register_ESP;
wire v6907 = v68e4 == vc;
wire v6908 = v6907;
wire v6909 = v68d6 & v6908;
wire v690a = v6909;
wire [31:0] v690d = ( v8 ) ? In_register_ECX : v68e3;
wire [31:0] v690f = v690d;
wire v6910 = v690f == Out_register_ECX;
wire v6911 = v68e4 == vd;
wire v6912 = v6911;
wire v6913 = v68d6 & v6912;
wire v6914 = v6913;
wire [31:0] v6917 = ( v8 ) ? In_register_EBX : v68e3;
wire [31:0] v6919 = v6917;
wire v691a = v6919 == Out_register_EBX;
wire v691b = v68e4 == vf;
wire v691c = v691b;
wire v691d = v68d6 & v691c;
wire v691e = v691d;
wire [31:0] v6921 = ( v8 ) ? In_register_EBP : v68e3;
wire [31:0] v6923 = v6921;
wire v6924 = v6923 == Out_register_EBP;
wire [31:0] v6926 = In_register_FSBASE;
wire v6927 = v6926 == Out_register_FSBASE;
wire [31:0] v6929 = In_register_CSBASE;
wire v692a = v6929 == Out_register_CSBASE;
wire [31:0] v692c = In_register_ESBASE;
wire v692d = v692c == Out_register_ESBASE;
wire v692e = v68e4 == v9;
wire v692f = v692e;
wire v6930 = v68d6 & v692f;
wire v6931 = v6930;
wire [31:0] v6934 = ( v8 ) ? In_register_EDI : v68e3;
wire [31:0] v6936 = v6934;
wire v6937 = v6936 == Out_register_EDI;
wire [31:0] v6939 = In_register_DSBASE;
wire v693a = v6939 == Out_register_DSBASE;
wire [31:0] v693c = In_register_GSBASE;
wire v693d = v693c == Out_register_GSBASE;
wire [31:0] v693e = v68e3 ^ v68e2;
wire [7:0] v693f = v693e[7:0];
wire [7:0] v6940 = v693f >> v1d;
wire [7:0] v6941 = v6940 & v18;
wire v6942 = v6941[0:0];
wire v6944 = v6942;
wire v6945 = v6944 == Out_register_AF;
wire v6947 = In_register_CF;
wire v6948 = v6947 == Out_register_CF;
wire [7:0] v694a = In_register_DF;
wire v694b = v694a == Out_register_DF;
wire [31:0] v694c = v693e >> v1e;
wire [31:0] v694d = v68e3 >> v1e;
wire [31:0] v694e = v694c + v694d;
wire v694f = v694e == v1c;
wire v6951 = v694f;
wire v6952 = v6951 == Out_register_OF;
wire [7:0] v6953 = v68e3[7:0];
wire [2:0] v6954_aux = v6953[0] + v6953[1] + v6953[2] + v6953[3] + v6953[4] + v6953[5] + v6953[6] + v6953[7];
wire v6954 = { 5'b00000, v6954_aux };
wire [7:0] v6955 = v6954 & v18;
wire [7:0] v6956 = v6955 ^ v18;
wire v6957 = v6956[0:0];
wire v6959 = v6957;
wire v695a = v6959 == Out_register_PF;
wire v695b = $signed(v68e3) < $signed(v15);
wire v695d = v695b;
wire v695e = v695d == Out_register_SF;
wire v695f = v68e4 == v7;
wire v6960 = v695f;
wire v6961 = v68d6 & v6960;
wire v6962 = v6961;
wire [31:0] v6965 = ( v8 ) ? In_register_EAX : v68e3;
wire [31:0] v6967 = v6965;
wire v6968 = v6967 == Out_register_EAX;
wire v6969 = v68e3 == v15;
wire v696b = v6969;
wire v696c = v696b == Out_register_ZF;
wire v696d = v68d8 & v68de & v68ee & v68f1 & v68fb & v68fc & v6906 & v15c & v6910 & v691a & v6924 & v6927 & v692a & v692d & v6937 & v693a & v693d & v6945 & v6948 & v694b & v6952 & v695a & v695e & v6968 & v696c;
wire [7:0] v112 = 8'b10100101;
wire v696e = v112 == v1eb;
wire v696f = v29 == v59f;
wire v6970 = v696e & v696f;
wire v6971 = v6970;
wire v6972 = v6971;
wire [31:0] v6974 = In_register_EBX;
wire v6975 = v6974 == Out_register_EBX;
wire [31:0] v6977 = v2b;
wire [31:0] v6978 = In_register_EIP + v6977;
wire [31:0] v697a = v6978;
wire v697b = v697a == Out_register_EIP;
wire [31:0] v697d = In_register_EDX;
wire v697e = v697d == Out_register_EDX;
wire v697f = In_error_flag == Out_error_flag;
wire [31:0] v6981 = v23be;
wire v6982 = v6981 == Out_register_EDI;
wire [31:0] v6984 = In_register_EBP;
wire v6985 = v6984 == Out_register_EBP;
wire v6986 =  v26 == memory_0[15: 12] && v5a7 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v6988 = In_register_DSBASE;
wire v6989 = v6988 == Out_register_DSBASE;
wire [31:0] v698b = In_register_ECX;
wire v698c = v698b == Out_register_ECX;
wire [31:0] v698e = In_register_SSBASE;
wire v698f = v698e == Out_register_SSBASE;
wire [31:0] v6991 = In_register_GSBASE;
wire v6992 = v6991 == Out_register_GSBASE;
wire [31:0] v6994 = v8cd;
wire v6995 = v6994 == Out_register_ESI;
wire v6997 = In_register_PF;
wire v6998 = v6997 == Out_register_PF;
wire [31:0] v699a = In_register_ESP;
wire v699b = v699a == Out_register_ESP;
wire [31:0] v699c = memory_0[79: 48];
wire v699d =  v26 == memory_1[15: 12] && v1b8e == memory_1[47: 16] && In_timestamp == memory_1[143: 80] && v699c == memory_1[79: 48] && 4'd1 == memory_1[11: 8] && 1'b1 == memory_1[0: 0] && 6'b000000 == memory_1[7: 2] && 1'b1 == memory_1[1: 1];
wire [31:0] v699f = In_register_CSBASE;
wire v69a0 = v699f == Out_register_CSBASE;
wire [31:0] v69a2 = In_register_ESBASE;
wire v69a3 = v69a2 == Out_register_ESBASE;
wire v69a5 = In_register_OF;
wire v69a6 = v69a5 == Out_register_OF;
wire [31:0] v69a8 = In_register_EAX;
wire v69a9 = v69a8 == Out_register_EAX;
wire [31:0] v69ab = In_register_FSBASE;
wire v69ac = v69ab == Out_register_FSBASE;
wire v69ae = In_register_AF;
wire v69af = v69ae == Out_register_AF;
wire v69b1 = In_register_CF;
wire v69b2 = v69b1 == Out_register_CF;
wire [7:0] v69b4 = In_register_DF;
wire v69b5 = v69b4 == Out_register_DF;
wire v69b7 = In_register_SF;
wire v69b8 = v69b7 == Out_register_SF;
wire v69ba = In_register_ZF;
wire v69bb = v69ba == Out_register_ZF;
wire v69bc = v6972 & v6975 & v697b & v697e & v697f & v6982 & v6985 & v6986 & v6989 & v698c & v15c & v698f & v6992 & v6995 & v6998 & v699b & v699d & v69a0 & v69a3 & v69a6 & v69a9 & v69ac & v69af & v69b2 & v69b5 & v69b8 & v69bb;
wire v69bd = In_error_flag == Out_error_flag;
wire [7:0] v113 = 8'b00111100;
wire v69be = v113 == v1eb;
wire v69bf = v1b == v318;
wire v69c0 = v69be & v69bf;
wire v69c1 = v69c0;
wire v69c2 = v69c1;
wire [31:0] v69c4 = In_register_ESI;
wire v69c5 = v69c4 == Out_register_ESI;
wire [31:0] v69c7 = vf4b;
wire [7:0] v69c8 = v69c7[7:0];
wire [31:0] v69ca = v477;
wire [7:0] v69cb = v69ca[7:0];
wire v69cc = v69c8 < v69cb;
wire v69ce = v69cc;
wire v69cf = v69ce == Out_register_CF;
wire [31:0] v69d1 = In_register_SSBASE;
wire v69d2 = v69d1 == Out_register_SSBASE;
wire [31:0] v69d4 = In_register_GSBASE;
wire v69d5 = v69d4 == Out_register_GSBASE;
wire [31:0] v69d7 = In_register_ECX;
wire v69d8 = v69d7 == Out_register_ECX;
wire [31:0] v69da = In_register_DSBASE;
wire v69db = v69da == Out_register_DSBASE;
wire v69dc = v69c8 == v69cb;
wire v69de = v69dc;
wire v69df = v69de == Out_register_ZF;
wire [31:0] v69e1 = In_register_ESBASE;
wire v69e2 = v69e1 == Out_register_ESBASE;
wire [31:0] v69e4 = In_register_EDI;
wire v69e5 = v69e4 == Out_register_EDI;
wire [31:0] v69e7 = In_register_EBX;
wire v69e8 = v69e7 == Out_register_EBX;
wire [31:0] v69ea = In_register_ESP;
wire v69eb = v69ea == Out_register_ESP;
wire [31:0] v69ed = In_register_EBP;
wire v69ee = v69ed == Out_register_EBP;
wire [7:0] v69ef = v69c8 - v69cb;
wire v69f0 = $signed(v69ef) < $signed(v2c);
wire v69f2 = v69f0;
wire v69f3 = v69f2 == Out_register_SF;
wire [31:0] v69f5 = In_register_EAX;
wire v69f6 = v69f5 == Out_register_EAX;
wire [7:0] v69f7 = v69ef ^ v69c8;
wire [7:0] v69f8 = v69f7 >> v33;
wire [7:0] v69f9 = v69cb ^ v69c8;
wire [7:0] v69fa = v69f9 >> v33;
wire [7:0] v69fb = v69f8 + v69fa;
wire v69fc = v69fb == v34;
wire v69fe = v69fc;
wire v69ff = v69fe == Out_register_OF;
wire [31:0] v6a01 = In_register_CSBASE;
wire v6a02 = v6a01 == Out_register_CSBASE;
wire [31:0] v6a04 = In_register_EDX;
wire v6a05 = v6a04 == Out_register_EDX;
wire [31:0] v6a07 = v1c;
wire [31:0] v6a08 = In_register_EIP + v6a07;
wire [31:0] v6a0a = v6a08;
wire v6a0b = v6a0a == Out_register_EIP;
wire [31:0] v6a0d = In_register_FSBASE;
wire v6a0e = v6a0d == Out_register_FSBASE;
wire [7:0] v6a0f = v69f9 ^ v69ef;
wire [7:0] v6a10 = v6a0f >> v1d;
wire [7:0] v6a11 = v6a10 & v18;
wire v6a12 = v6a11[0:0];
wire v6a14 = v6a12;
wire v6a15 = v6a14 == Out_register_AF;
wire [7:0] v6a17 = In_register_DF;
wire v6a18 = v6a17 == Out_register_DF;
wire [2:0] v6a19_aux = v69ef[0] + v69ef[1] + v69ef[2] + v69ef[3] + v69ef[4] + v69ef[5] + v69ef[6] + v69ef[7];
wire v6a19 = { 5'b00000, v6a19_aux };
wire [7:0] v6a1a = v6a19 & v18;
wire [7:0] v6a1b = v6a1a ^ v18;
wire v6a1c = v6a1b[0:0];
wire v6a1e = v6a1c;
wire v6a1f = v6a1e == Out_register_PF;
wire v6a20 = v69bd & v69c5 & v69cf & v69d2 & v69c2 & v69d5 & v69d8 & v15c & v69db & v69df & v69e2 & v69e5 & v69e8 & v69eb & v69ee & v69f3 & v69f6 & v69ff & v6a02 & v6a05 & v6a0b & v6a0e & v6a15 & v6a18 & v6a1f;
wire v6a30 = vb4 == v1eb;
wire v6a31 = v35 == v316;
wire v6a32 = v1b == v318;
wire [2:0] v6a33 = { v1fa };
wire v6a34 = v6a33 == vb;
wire v6a35 = v6a33 == vf;
wire v6a36 = v6a34 | v6a35;
wire v6a37 = v6a36 ^ v8;
wire [2:0] v6a38 = { v1fa };
wire v6a39 = v6a38 == vb;
wire v6a3a = v6a38 == vf;
wire v6a3b = v6a39 | v6a3a;
wire v6a3c = v6a3b ^ v8;
wire v6a3d = v6a37 & v6a3c;
wire v6a3e = v6a30 & v6a31 & v6a32 & v6a3d;
wire [10:0] v114 = 11'b01001100101;
wire v6a4d = v114 == v6d7;
wire v6a4e = v35 == v316;
wire v6a4f = v14 == v1ef;
wire v6a50 = v6a4d & v6a4e & v6a4f;
wire [18:0] v115 = 19'b0010011001001100101;
wire v6a5f = v115 == vdfa;
wire v6a60 = v35 == v119;
wire v6a61 = v43 == vab3;
wire v6a62 = v6a5f & v6a60 & v6a61;
wire v6a86 = v6a3e | v6a50 | v6a62;
wire v6a87 = v6a86;
wire [2:0] v6a69 = { v320 };
wire v6a6a = v6a69 == v7;
wire v6a6b = v6a6a;
wire v6a6c = v6a3e & v6a6b;
wire [2:0] v6a6d = { v320 };
wire v6a6e = v6a6d == v7;
wire v6a6f = v6a6e;
wire v6a70 = v6a50 & v6a6f;
wire [2:0] v6a71 = { v12c };
wire v6a72 = v6a71 == v7;
wire v6a73 = v6a72;
wire v6a74 = v6a62 & v6a73;
wire v6a75 = v6a6c | v6a70 | v6a74;
wire [31:0] v6a21 = memory_0[79: 48];
wire [7:0] v6a22 = v6a21[7:0];
wire [2:0] v6a40 = { v320 };
wire [31:0] v6a41 = ( v6a40 == 3'd0) ? In_register_EAX : 
	( v6a40 == 3'd1) ? In_register_ECX : 
	( v6a40 == 3'd2) ? In_register_EDX : 
	( v6a40 == 3'd3) ? In_register_EBX : 
	( v6a40 == 3'd4) ? In_register_EAX : 
	( v6a40 == 3'd5) ? In_register_ECX : 
	( v6a40 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6a42 = { v320 };
wire v6a43 = v6a42 == vb;
wire v6a44 = v6a42 == v9;
wire v6a45 = v6a43 | v6a44;
wire v6a46 = v6a42 == vf;
wire v6a47 = v6a45 | v6a46;
wire v6a48 = v6a42 == v11;
wire v6a49 = v6a47 | v6a48;
wire [31:0] v6a4a = ( v6a49 == 1'd0) ? v15 : v31;
wire [31:0] v6a4b = v6a41 >> v6a4a;
wire [31:0] v6a4c = v6a4b & v32;
wire [2:0] v6a52 = { v12c };
wire [31:0] v6a53 = ( v6a52 == 3'd0) ? In_register_EAX : 
	( v6a52 == 3'd1) ? In_register_ECX : 
	( v6a52 == 3'd2) ? In_register_EDX : 
	( v6a52 == 3'd3) ? In_register_EBX : 
	( v6a52 == 3'd4) ? In_register_EAX : 
	( v6a52 == 3'd5) ? In_register_ECX : 
	( v6a52 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6a54 = { v12c };
wire v6a55 = v6a54 == vb;
wire v6a56 = v6a54 == v9;
wire v6a57 = v6a55 | v6a56;
wire v6a58 = v6a54 == vf;
wire v6a59 = v6a57 | v6a58;
wire v6a5a = v6a54 == v11;
wire v6a5b = v6a59 | v6a5a;
wire [31:0] v6a5c = ( v6a5b == 1'd0) ? v15 : v31;
wire [31:0] v6a5d = v6a53 >> v6a5c;
wire [31:0] v6a5e = v6a5d & v32;
wire [2:0] v6a23 = { v320 };
wire [31:0] v6a24 = ( v6a23 == 3'd0) ? In_register_EAX : 
	( v6a23 == 3'd1) ? In_register_ECX : 
	( v6a23 == 3'd2) ? In_register_EDX : 
	( v6a23 == 3'd3) ? In_register_EBX : 
	( v6a23 == 3'd4) ? In_register_EAX : 
	( v6a23 == 3'd5) ? In_register_ECX : 
	( v6a23 == 3'd6) ? In_register_EDX : In_register_EBX;
wire [2:0] v6a25 = { v320 };
wire v6a26 = v6a25 == vb;
wire v6a27 = v6a25 == v9;
wire v6a28 = v6a26 | v6a27;
wire v6a29 = v6a25 == vf;
wire v6a2a = v6a28 | v6a29;
wire v6a2b = v6a25 == v11;
wire v6a2c = v6a2a | v6a2b;
wire [31:0] v6a2d = ( v6a2c == 1'd0) ? v15 : v31;
wire [31:0] v6a2e = v6a24 >> v6a2d;
wire [31:0] v6a2f = v6a2e & v32;
wire [31:0] v6a64 = ( v6a50 ) ? v6a4c : 
	( v6a62 ) ? v6a5e : v6a2f;
wire [7:0] v6a65 = v6a64[7:0];
wire [7:0] v6a66 = v6a22 ^ v6a65;
wire [31:0] v6a67 = { 24'b000000000000000000000000, v6a66 };
wire [31:0] v6a68 = v5c8 | v6a67;
wire v6a79 = v6a69 == vb;
wire v6a7a = v6a79;
wire v6a7b = v6a3e & v6a7a;
wire v6a7c = v6a6d == vb;
wire v6a7d = v6a7c;
wire v6a7e = v6a50 & v6a7d;
wire v6a7f = v6a71 == vb;
wire v6a80 = v6a7f;
wire v6a81 = v6a62 & v6a80;
wire v6a82 = v6a7b | v6a7e | v6a81;
wire [31:0] v6a77 = v6a67 << v31;
wire [31:0] v6a78 = v752 | v6a77;
wire [31:0] v6a85 = ( v8 ) ? In_register_EAX : 
	( v6a75 ) ? v6a68 : v6a78;
wire [31:0] v6a89 = v6a85;
wire v6a8a = v6a89 == Out_register_EAX;
wire [2:0] v6a8b = { v1fa };
wire [31:0] v6a8c = ( v6a8b == 3'd0) ? In_register_EAX : 
	( v6a8b == 3'd1) ? In_register_ECX : 
	( v6a8b == 3'd2) ? In_register_EDX : 
	( v6a8b == 3'd3) ? In_register_EBX : 
	( v6a8b == 3'd4) ? v15 : 
	( v6a8b == 3'd5) ? v15 : 
	( v6a8b == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v6a90 = ( v6a62 ) ? vc2d : 
	( v6a50 ) ? v1f7 : v6a8c;
wire v6a91 =  v2a == memory_0[15: 12] && v6a90 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [31:0] v6a93 = In_register_CSBASE;
wire v6a94 = v6a93 == Out_register_CSBASE;
wire v6a96 = v6a69 == vd;
wire v6a97 = v6a96;
wire v6a98 = v6a3e & v6a97;
wire v6a99 = v6a6d == vd;
wire v6a9a = v6a99;
wire v6a9b = v6a50 & v6a9a;
wire v6a9c = v6a71 == vd;
wire v6a9d = v6a9c;
wire v6a9e = v6a62 & v6a9d;
wire v6a9f = v6a98 | v6a9b | v6a9e;
wire [31:0] v6a95 = v7b8 | v6a67;
wire v6aa2 = v6a69 == v9;
wire v6aa3 = v6aa2;
wire v6aa4 = v6a3e & v6aa3;
wire v6aa5 = v6a6d == v9;
wire v6aa6 = v6aa5;
wire v6aa7 = v6a50 & v6aa6;
wire v6aa8 = v6a71 == v9;
wire v6aa9 = v6aa8;
wire v6aaa = v6a62 & v6aa9;
wire v6aab = v6aa4 | v6aa7 | v6aaa;
wire [31:0] v6aa1 = v7c8 | v6a77;
wire [31:0] v6aae = ( v8 ) ? In_register_EBX : 
	( v6a9f ) ? v6a95 : v6aa1;
wire [31:0] v6ab0 = v6aae;
wire v6ab1 = v6ab0 == Out_register_EBX;
wire [31:0] v6ab3 = In_register_ESI;
wire v6ab4 = v6ab3 == Out_register_ESI;
wire [31:0] v6ab6 = In_register_ESP;
wire v6ab7 = v6ab6 == Out_register_ESP;
wire [31:0] v6abb = ( v6a62 ) ? v45 : 
	( v6a3e ) ? v1c : v16;
wire [31:0] v6abc = In_register_EIP + v6abb;
wire [31:0] v6abe = v6abc;
wire v6abf = v6abe == Out_register_EIP;
wire v6ac1 = v6a69 == ve;
wire v6ac2 = v6ac1;
wire v6ac3 = v6a3e & v6ac2;
wire v6ac4 = v6a6d == ve;
wire v6ac5 = v6ac4;
wire v6ac6 = v6a50 & v6ac5;
wire v6ac7 = v6a71 == ve;
wire v6ac8 = v6ac7;
wire v6ac9 = v6a62 & v6ac8;
wire v6aca = v6ac3 | v6ac6 | v6ac9;
wire [31:0] v6ac0 = v768 | v6a67;
wire v6acd = v6a69 == v11;
wire v6ace = v6acd;
wire v6acf = v6a3e & v6ace;
wire v6ad0 = v6a6d == v11;
wire v6ad1 = v6ad0;
wire v6ad2 = v6a50 & v6ad1;
wire v6ad3 = v6a71 == v11;
wire v6ad4 = v6ad3;
wire v6ad5 = v6a62 & v6ad4;
wire v6ad6 = v6acf | v6ad2 | v6ad5;
wire [31:0] v6acc = v778 | v6a77;
wire [31:0] v6ad9 = ( v8 ) ? In_register_EDX : 
	( v6aca ) ? v6ac0 : v6acc;
wire [31:0] v6adb = v6ad9;
wire v6adc = v6adb == Out_register_EDX;
wire v6ade = v6a69 == vf;
wire v6adf = v6ade;
wire v6ae0 = v6a3e & v6adf;
wire v6ae1 = v6a6d == vf;
wire v6ae2 = v6ae1;
wire v6ae3 = v6a50 & v6ae2;
wire v6ae4 = v6a71 == vf;
wire v6ae5 = v6ae4;
wire v6ae6 = v6a62 & v6ae5;
wire v6ae7 = v6ae0 | v6ae3 | v6ae6;
wire [31:0] v6add = v790 | v6a77;
wire v6aea = v6a69 == vc;
wire v6aeb = v6aea;
wire v6aec = v6a3e & v6aeb;
wire v6aed = v6a6d == vc;
wire v6aee = v6aed;
wire v6aef = v6a50 & v6aee;
wire v6af0 = v6a71 == vc;
wire v6af1 = v6af0;
wire v6af2 = v6a62 & v6af1;
wire v6af3 = v6aec | v6aef | v6af2;
wire [31:0] v6ae9 = v7a0 | v6a67;
wire [31:0] v6af6 = ( v8 ) ? In_register_ECX : 
	( v6ae7 ) ? v6add : v6ae9;
wire [31:0] v6af8 = v6af6;
wire v6af9 = v6af8 == Out_register_ECX;
wire [31:0] v6afb = In_register_EDI;
wire v6afc = v6afb == Out_register_EDI;
wire [31:0] v6afe = In_register_EBP;
wire v6aff = v6afe == Out_register_EBP;
wire [31:0] v6b01 = In_register_ESBASE;
wire v6b02 = v6b01 == Out_register_ESBASE;
wire [31:0] v6b04 = In_register_GSBASE;
wire v6b05 = v6b04 == Out_register_GSBASE;
wire [31:0] v6b07 = In_register_SSBASE;
wire v6b08 = v6b07 == Out_register_SSBASE;
wire v6b0a = In_register_AF;
wire v6b0b = v6b0a == Out_register_AF;
wire [7:0] v6b0d = In_register_DF;
wire v6b0e = v6b0d == Out_register_DF;
wire v6b0f = In_error_flag == Out_error_flag;
wire [31:0] v6b11 = In_register_DSBASE;
wire v6b12 = v6b11 == Out_register_DSBASE;
wire [31:0] v6b14 = In_register_FSBASE;
wire v6b15 = v6b14 == Out_register_FSBASE;
wire v6b17 = v17;
wire v6b18 = v6b17 == Out_register_CF;
wire v6b19 = v17;
wire v6b1a = v6b19 == Out_register_OF;
wire [2:0] v6b1b_aux = v6a66[0] + v6a66[1] + v6a66[2] + v6a66[3] + v6a66[4] + v6a66[5] + v6a66[6] + v6a66[7];
wire v6b1b = { 5'b00000, v6b1b_aux };
wire [7:0] v6b1c = v6b1b & v18;
wire [7:0] v6b1d = v6b1c ^ v18;
wire v6b1e = v6b1d[0:0];
wire v6b20 = v6b1e;
wire v6b21 = v6b20 == Out_register_PF;
wire v6b22 = $signed(v6a66) < $signed(v2c);
wire v6b24 = v6b22;
wire v6b25 = v6b24 == Out_register_SF;
wire v6b26 = v6a66 == v2c;
wire v6b28 = v6b26;
wire v6b29 = v6b28 == Out_register_ZF;
wire v6b2a = v15c & v6a8a & v6a91 & v6a94 & v6ab1 & v6a87 & v6ab4 & v6ab7 & v6abf & v6adc & v6af9 & v6afc & v6aff & v6b02 & v6b05 & v6b08 & v6b0b & v6b0e & v6b0f & v6b12 & v6b15 & v6b18 & v6b1a & v6b21 & v6b25 & v6b29;
wire v6b2b = v1ea | v281 | v314 | v3ac | v450 | v4a9 | v53a | v59d | v5f4 | v6b8 | v827 | v8c2 | v912 | v997 | va97 | vb67 | vbc3 | vcde | vd35 | vda5 | vdf9 | ve62 | vec9 | vf38 | vf9b | v106a | v110c | v1209 | v12a2 | v134f | v13a5 | v13f7 | v1443 | v149c | v14f4 | v1541 | v15a5 | v1640 | v16d2 | v17bb | v1891 | v196c | v1a28 | v1aa9 | v1b39 | v1b9f | v1c48 | v1c98 | v1d09 | v1d76 | v1dcd | v1e40 | v1e8c | v1fa2 | v2032 | v209e | v214d | v21e0 | v2275 | v2343 | v2399 | v23e7 | v244e | v2512 | v25b0 | v2612 | v2680 | v2709 | v27a5 | v284a | v28d6 | v294b | v29b2 | v2a2f | v2ab6 | v2b4a | v2bc3 | v2c27 | v2cd0 | v2d7c | v2de6 | v2e77 | v2ece | v2fc3 | v3070 | v30c7 | v3154 | v3224 | v328f | v3456 | v34d8 | v3603 | v3659 | v36ca | v372c | v37ee | v3873 | v3917 | v39b9 | v3a5e | v3ab5 | v3b07 | v3b70 | v3c28 | v3c91 | v3d33 | v3e27 | v3e83 | v3f9d | v3fed | v4051 | v40e9 | v4145 | v423d | v43f7 | v4443 | v4493 | v4514 | v45c1 | v462d | v46b3 | v473b | v47f5 | v4891 | v4984 | v49fb | v4ace | v4b60 | v4baf | v4c34 | v4cbe | v4d45 | v4daf | v4dfc | v4e4d | v4e9b | v4f57 | v4fc5 | v508d | v5193 | v51f4 | v5287 | v52dd | v53bb | v5445 | v5494 | v5553 | v55a8 | v5632 | v56be | v5713 | v5760 | v57f1 | v5842 | v592c | v5978 | v5a02 | v5a7b | v5bcb | v5c20 | v5cdc | v5d45 | v5d9f | v5dfa | v5e61 | v5f01 | v5fa1 | v600f | v60ca | v6189 | v6217 | v62ba | v6379 | v6448 | v649d | v6561 | v65e5 | v6685 | v66ef | v674b | v68d3 | v696d | v69bc | v6a20 | v6b2a;
assign result = v6b2b;
assign dummy = 1'b0;
endmodule
