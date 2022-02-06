; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=gfx900 < %s | FileCheck -check-prefix=GFX9 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=fiji < %s | FileCheck -check-prefix=GFX8 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=gfx1010 < %s | FileCheck -check-prefix=GFX10 %s

define <2 x i16> @v_add_v2i16(<2 x i16> %a, <2 x i16> %b) {
; GFX9-LABEL: v_add_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_add_u16_e32 v2, v0, v1
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v0, v2, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, v0, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %add = add <2 x i16> %a, %b
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_fneg_lhs(<2 x half> %a, <2 x i16> %b) {
; GFX9-LABEL: v_add_v2i16_fneg_lhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[1,0] neg_hi:[1,0]
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_fneg_lhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_xor_b32_e32 v0, 0x80008000, v0
; GFX8-NEXT:    v_add_u16_e32 v2, v0, v1
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v0, v2, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_fneg_lhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[1,0] neg_hi:[1,0]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.a = fneg <2 x half> %a
  %cast.neg.a = bitcast <2 x half> %neg.a to <2 x i16>
  %add = add <2 x i16> %cast.neg.a, %b
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_fneg_rhs(<2 x i16> %a, <2 x half> %b) {
; GFX9-LABEL: v_add_v2i16_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[0,1] neg_hi:[0,1]
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_xor_b32_e32 v1, 0x80008000, v1
; GFX8-NEXT:    v_add_u16_e32 v2, v0, v1
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v0, v2, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_fneg_rhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[0,1] neg_hi:[0,1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.b = fneg <2 x half> %b
  %cast.neg.b = bitcast <2 x half> %neg.b to <2 x i16>
  %add = add <2 x i16> %a, %cast.neg.b
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_fneg_lhs_fneg_rhs(<2 x half> %a, <2 x half> %b) {
; GFX9-LABEL: v_add_v2i16_fneg_lhs_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[1,1] neg_hi:[1,1]
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_fneg_lhs_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    s_mov_b32 s4, 0x80008000
; GFX8-NEXT:    v_xor_b32_e32 v0, s4, v0
; GFX8-NEXT:    v_xor_b32_e32 v1, s4, v1
; GFX8-NEXT:    v_add_u16_e32 v2, v0, v1
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; GFX8-NEXT:    v_or_b32_e32 v0, v2, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_fneg_lhs_fneg_rhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, v0, v1 neg_lo:[1,1] neg_hi:[1,1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.a = fneg <2 x half> %a
  %neg.b = fneg <2 x half> %b
  %cast.neg.a = bitcast <2 x half> %neg.a to <2 x i16>
  %cast.neg.b = bitcast <2 x half> %neg.b to <2 x i16>
  %add = add <2 x i16> %cast.neg.a, %cast.neg.b
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_neg_inline_imm_splat(<2 x i16> %a) {
; GFX9-LABEL: v_add_v2i16_neg_inline_imm_splat:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, 0xffc0ffc0
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_neg_inline_imm_splat:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    s_movk_i32 s4, 0xffc0
; GFX8-NEXT:    v_mov_b32_e32 v2, s4
; GFX8-NEXT:    v_add_u16_e32 v1, s4, v0
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; GFX8-NEXT:    v_or_b32_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_neg_inline_imm_splat:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, 0xffc0, v0 op_sel_hi:[0,1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %add = add <2 x i16> %a, <i16 -64, i16 -64>
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_neg_inline_imm_lo(<2 x i16> %a) {
; GFX9-LABEL: v_add_v2i16_neg_inline_imm_lo:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, 0x4ffc0
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_neg_inline_imm_lo:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v2, 4
; GFX8-NEXT:    v_add_u16_e32 v1, 0xffc0, v0
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; GFX8-NEXT:    v_or_b32_e32 v0, v1, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_neg_inline_imm_lo:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, 0x4ffc0, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %add = add <2 x i16> %a, <i16 -64, i16 4>
  ret <2 x i16> %add
}

define <2 x i16> @v_add_v2i16_neg_inline_imm_hi(<2 x i16> %a) {
; GFX9-LABEL: v_add_v2i16_neg_inline_imm_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, 0xffc00004
; GFX9-NEXT:    v_pk_add_u16 v0, v0, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_add_v2i16_neg_inline_imm_hi:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v1, 0xffffffc0
; GFX8-NEXT:    v_add_u16_e32 v2, 4, v0
; GFX8-NEXT:    v_add_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; GFX8-NEXT:    v_or_b32_e32 v0, v2, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_add_v2i16_neg_inline_imm_hi:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_pk_add_u16 v0, 0xffc00004, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %add = add <2 x i16> %a, <i16 4, i16 -64>
  ret <2 x i16> %add
}

define amdgpu_ps i32 @s_add_v2i16_neg_inline_imm_splat(<2 x i16> inreg %a) {
; GFX9-LABEL: s_add_v2i16_neg_inline_imm_splat:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshr_b32 s1, s0, 16
; GFX9-NEXT:    s_add_i32 s0, s0, 0xffc0ffc0
; GFX9-NEXT:    s_add_i32 s1, s1, 0xffc0
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_neg_inline_imm_splat:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_mov_b32 s3, 0xffff
; GFX8-NEXT:    s_lshr_b32 s2, s0, 16
; GFX8-NEXT:    s_mov_b32 s1, 0xffc0
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    s_add_i32 s2, s2, s1
; GFX8-NEXT:    s_lshl_b32 s1, s2, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_neg_inline_imm_splat:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshr_b32 s1, s0, 16
; GFX10-NEXT:    s_add_i32 s0, s0, 0xffc0ffc0
; GFX10-NEXT:    s_add_i32 s1, s1, 0xffc0
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %add = add <2 x i16> %a, <i16 -64, i16 -64>
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16_neg_inline_imm_lo(<2 x i16> inreg %a) {
; GFX9-LABEL: s_add_v2i16_neg_inline_imm_lo:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshr_b32 s1, s0, 16
; GFX9-NEXT:    s_add_i32 s0, s0, 0x4ffc0
; GFX9-NEXT:    s_add_i32 s1, s1, 4
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_neg_inline_imm_lo:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_mov_b32 s2, 0xffff
; GFX8-NEXT:    s_lshr_b32 s1, s0, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s0, s0, 0xffc0
; GFX8-NEXT:    s_add_i32 s1, s1, 4
; GFX8-NEXT:    s_lshl_b32 s1, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s2
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_neg_inline_imm_lo:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshr_b32 s1, s0, 16
; GFX10-NEXT:    s_add_i32 s0, s0, 0x4ffc0
; GFX10-NEXT:    s_add_i32 s1, s1, 4
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %add = add <2 x i16> %a, <i16 -64, i16 4>
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16_neg_inline_imm_hi(<2 x i16> inreg %a) {
; GFX9-LABEL: s_add_v2i16_neg_inline_imm_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshr_b32 s1, s0, 16
; GFX9-NEXT:    s_add_i32 s0, s0, 0xffc00004
; GFX9-NEXT:    s_add_i32 s1, s1, 0xffc0
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_neg_inline_imm_hi:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_mov_b32 s2, 0xffff
; GFX8-NEXT:    s_lshr_b32 s1, s0, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s2
; GFX8-NEXT:    s_add_i32 s0, s0, 4
; GFX8-NEXT:    s_add_i32 s1, s1, 0xffc0
; GFX8-NEXT:    s_lshl_b32 s1, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s2
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_neg_inline_imm_hi:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshr_b32 s1, s0, 16
; GFX10-NEXT:    s_add_i32 s0, s0, 0xffc00004
; GFX10-NEXT:    s_add_i32 s1, s1, 0xffc0
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s1
; GFX10-NEXT:    ; return to shader part epilog
  %add = add <2 x i16> %a, <i16 4, i16 -64>
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16(<2 x i16> inreg %a, <2 x i16> inreg %b) {
; GFX9-LABEL: s_add_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_lshr_b32 s2, s0, 16
; GFX9-NEXT:    s_lshr_b32 s3, s1, 16
; GFX9-NEXT:    s_add_i32 s0, s0, s1
; GFX9-NEXT:    s_add_i32 s2, s2, s3
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_mov_b32 s3, 0xffff
; GFX8-NEXT:    s_lshr_b32 s2, s0, 16
; GFX8-NEXT:    s_lshr_b32 s4, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_and_b32 s1, s1, s3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    s_add_i32 s2, s2, s4
; GFX8-NEXT:    s_lshl_b32 s1, s2, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_lshr_b32 s2, s0, 16
; GFX10-NEXT:    s_lshr_b32 s3, s1, 16
; GFX10-NEXT:    s_add_i32 s0, s0, s1
; GFX10-NEXT:    s_add_i32 s2, s2, s3
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX10-NEXT:    ; return to shader part epilog
  %add = add <2 x i16> %a, %b
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16_fneg_lhs(<2 x half> inreg %a, <2 x i16> inreg %b) {
; GFX9-LABEL: s_add_v2i16_fneg_lhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_xor_b32 s0, s0, 0x80008000
; GFX9-NEXT:    s_lshr_b32 s2, s0, 16
; GFX9-NEXT:    s_lshr_b32 s3, s1, 16
; GFX9-NEXT:    s_add_i32 s0, s0, s1
; GFX9-NEXT:    s_add_i32 s2, s2, s3
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_fneg_lhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_xor_b32 s0, s0, 0x80008000
; GFX8-NEXT:    s_mov_b32 s3, 0xffff
; GFX8-NEXT:    s_lshr_b32 s2, s0, 16
; GFX8-NEXT:    s_lshr_b32 s4, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_and_b32 s1, s1, s3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    s_add_i32 s2, s2, s4
; GFX8-NEXT:    s_lshl_b32 s1, s2, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_fneg_lhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_xor_b32 s0, s0, 0x80008000
; GFX10-NEXT:    s_lshr_b32 s3, s1, 16
; GFX10-NEXT:    s_lshr_b32 s2, s0, 16
; GFX10-NEXT:    s_add_i32 s0, s0, s1
; GFX10-NEXT:    s_add_i32 s2, s2, s3
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX10-NEXT:    ; return to shader part epilog
  %neg.a = fneg <2 x half> %a
  %cast.neg.a = bitcast <2 x half> %neg.a to <2 x i16>
  %add = add <2 x i16> %cast.neg.a, %b
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16_fneg_rhs(<2 x i16> inreg %a, <2 x half> inreg %b) {
; GFX9-LABEL: s_add_v2i16_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_xor_b32 s1, s1, 0x80008000
; GFX9-NEXT:    s_lshr_b32 s2, s0, 16
; GFX9-NEXT:    s_lshr_b32 s3, s1, 16
; GFX9-NEXT:    s_add_i32 s0, s0, s1
; GFX9-NEXT:    s_add_i32 s2, s2, s3
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_xor_b32 s1, s1, 0x80008000
; GFX8-NEXT:    s_mov_b32 s3, 0xffff
; GFX8-NEXT:    s_lshr_b32 s2, s0, 16
; GFX8-NEXT:    s_lshr_b32 s4, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_and_b32 s1, s1, s3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    s_add_i32 s2, s2, s4
; GFX8-NEXT:    s_lshl_b32 s1, s2, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_fneg_rhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_xor_b32 s1, s1, 0x80008000
; GFX10-NEXT:    s_lshr_b32 s2, s0, 16
; GFX10-NEXT:    s_lshr_b32 s3, s1, 16
; GFX10-NEXT:    s_add_i32 s0, s0, s1
; GFX10-NEXT:    s_add_i32 s2, s2, s3
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX10-NEXT:    ; return to shader part epilog
  %neg.b = fneg <2 x half> %b
  %cast.neg.b = bitcast <2 x half> %neg.b to <2 x i16>
  %add = add <2 x i16> %a, %cast.neg.b
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}

define amdgpu_ps i32 @s_add_v2i16_fneg_lhs_fneg_rhs(<2 x half> inreg %a, <2 x half> inreg %b) {
; GFX9-LABEL: s_add_v2i16_fneg_lhs_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s2, 0x80008000
; GFX9-NEXT:    s_xor_b32 s1, s1, s2
; GFX9-NEXT:    s_xor_b32 s0, s0, s2
; GFX9-NEXT:    s_lshr_b32 s2, s0, 16
; GFX9-NEXT:    s_lshr_b32 s3, s1, 16
; GFX9-NEXT:    s_add_i32 s0, s0, s1
; GFX9-NEXT:    s_add_i32 s2, s2, s3
; GFX9-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: s_add_v2i16_fneg_lhs_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_mov_b32 s2, 0x80008000
; GFX8-NEXT:    s_xor_b32 s1, s1, s2
; GFX8-NEXT:    s_xor_b32 s0, s0, s2
; GFX8-NEXT:    s_mov_b32 s3, 0xffff
; GFX8-NEXT:    s_lshr_b32 s2, s0, 16
; GFX8-NEXT:    s_lshr_b32 s4, s1, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_and_b32 s1, s1, s3
; GFX8-NEXT:    s_add_i32 s0, s0, s1
; GFX8-NEXT:    s_add_i32 s2, s2, s4
; GFX8-NEXT:    s_lshl_b32 s1, s2, 16
; GFX8-NEXT:    s_and_b32 s0, s0, s3
; GFX8-NEXT:    s_or_b32 s0, s1, s0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: s_add_v2i16_fneg_lhs_fneg_rhs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s2, 0x80008000
; GFX10-NEXT:    s_xor_b32 s1, s1, s2
; GFX10-NEXT:    s_xor_b32 s0, s0, s2
; GFX10-NEXT:    s_lshr_b32 s3, s1, 16
; GFX10-NEXT:    s_lshr_b32 s2, s0, 16
; GFX10-NEXT:    s_add_i32 s0, s0, s1
; GFX10-NEXT:    s_add_i32 s2, s2, s3
; GFX10-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX10-NEXT:    ; return to shader part epilog
  %neg.a = fneg <2 x half> %a
  %neg.b = fneg <2 x half> %b
  %cast.neg.a = bitcast <2 x half> %neg.a to <2 x i16>
  %cast.neg.b = bitcast <2 x half> %neg.b to <2 x i16>
  %add = add <2 x i16> %cast.neg.a, %cast.neg.b
  %cast = bitcast <2 x i16> %add to i32
  ret i32 %cast
}
