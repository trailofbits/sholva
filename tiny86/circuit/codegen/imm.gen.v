
// this file was generated by codegen.py on 2023-07-20 15:24:12.319963
// do NOT edit it by hand

assign imm = (has_imm) ?
    (has_modrm) ?
    (has_sib) ?
    (has_disp) ?
    (is_disp8) ?
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[39:32])) :
    (zext8_32(unescaped_instr[39:32])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[47:32])) :
    (zext16_32(unescaped_instr[47:32])) :
    (unescaped_instr[63:32]) :
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[63:56])) :
    (zext8_32(unescaped_instr[63:56])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[71:56])) :
    (zext16_32(unescaped_instr[71:56])) :
    (unescaped_instr[87:56]) :
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[31:24])) :
    (zext8_32(unescaped_instr[31:24])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[39:24])) :
    (zext16_32(unescaped_instr[39:24])) :
    (unescaped_instr[55:24]) :
    (has_disp) ?
    (is_disp8) ?
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[31:24])) :
    (zext8_32(unescaped_instr[31:24])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[39:24])) :
    (zext16_32(unescaped_instr[39:24])) :
    (unescaped_instr[55:24]) :
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[55:48])) :
    (zext8_32(unescaped_instr[55:48])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[63:48])) :
    (zext16_32(unescaped_instr[63:48])) :
    (unescaped_instr[79:48]) :
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[23:16])) :
    (zext8_32(unescaped_instr[23:16])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[31:16])) :
    (zext16_32(unescaped_instr[31:16])) :
    (unescaped_instr[47:16]) :
    (is_imm8) ?
    (source_is_sext) ?
    (sext8_32(unescaped_instr[15:8])) :
    (zext8_32(unescaped_instr[15:8])) :
    (is_imm16) ?
    (source_is_sext) ?
    (sext16_32(unescaped_instr[23:8])) :
    (zext16_32(unescaped_instr[23:8])) :
    (unescaped_instr[39:8]) :
    (32'd0);
