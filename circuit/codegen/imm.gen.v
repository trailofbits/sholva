
// this file was generated by codegen.py on 2021-08-02 13:53:55.070767
// do NOT edit it by hand

assign imm = (has_imm) ?
    (has_modrm) ?
    (has_sib) ?
    (has_disp) ?
    (is_disp8) ?
    (is_imm8) ?
    (sext8_32(unescaped_instr[39:32])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[47:32])) :
    (unescaped_instr[63:32]) :
    (is_imm8) ?
    (sext8_32(unescaped_instr[63:56])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[71:56])) :
    (unescaped_instr[87:56]) :
    (is_imm8) ?
    (sext8_32(unescaped_instr[31:24])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[39:24])) :
    (unescaped_instr[55:24]) :
    (has_disp) ?
    (is_disp8) ?
    (is_imm8) ?
    (sext8_32(unescaped_instr[31:24])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[39:24])) :
    (unescaped_instr[55:24]) :
    (is_imm8) ?
    (sext8_32(unescaped_instr[55:48])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[63:48])) :
    (unescaped_instr[79:48]) :
    (is_imm8) ?
    (sext8_32(unescaped_instr[23:16])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[31:16])) :
    (unescaped_instr[47:16]) :
    (is_imm8) ?
    (sext8_32(unescaped_instr[15:8])) :
    (is_imm16) ?
    (sext16_32(unescaped_instr[23:8])) :
    (unescaped_instr[39:8]) :
    (32'd0);