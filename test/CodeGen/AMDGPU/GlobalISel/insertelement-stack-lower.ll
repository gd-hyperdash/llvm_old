; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN %s

; Check lowering of some large insertelement that use the stack
; instead of register indexing.

define amdgpu_kernel void @v_insert_v64i32_varidx(<64 x i32> addrspace(1)* %out.ptr, <64 x i32> addrspace(1)* %ptr, i32 %val, i32 %idx) #0 {
; GCN-LABEL: v_insert_v64i32_varidx:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_add_u32 s0, s0, s7
; GCN-NEXT:    s_load_dwordx4 s[8:11], s[4:5], 0x0
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x10
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    v_mov_b32_e32 v16, 0x100
; GCN-NEXT:    v_mov_b32_e32 v64, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx16 s[36:51], s[10:11], 0x0
; GCN-NEXT:    s_load_dwordx16 s[52:67], s[10:11], 0x40
; GCN-NEXT:    s_load_dwordx16 s[12:27], s[10:11], 0x80
; GCN-NEXT:    s_and_b32 s4, s7, 63
; GCN-NEXT:    s_lshl_b32 s4, s4, 2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s36
; GCN-NEXT:    v_mov_b32_e32 v1, s37
; GCN-NEXT:    v_mov_b32_e32 v2, s38
; GCN-NEXT:    v_mov_b32_e32 v3, s39
; GCN-NEXT:    v_mov_b32_e32 v4, s40
; GCN-NEXT:    v_mov_b32_e32 v5, s41
; GCN-NEXT:    v_mov_b32_e32 v6, s42
; GCN-NEXT:    v_mov_b32_e32 v7, s43
; GCN-NEXT:    v_mov_b32_e32 v8, s44
; GCN-NEXT:    v_mov_b32_e32 v9, s45
; GCN-NEXT:    v_mov_b32_e32 v10, s46
; GCN-NEXT:    v_mov_b32_e32 v11, s47
; GCN-NEXT:    v_mov_b32_e32 v12, s48
; GCN-NEXT:    v_mov_b32_e32 v13, s49
; GCN-NEXT:    v_mov_b32_e32 v14, s50
; GCN-NEXT:    v_mov_b32_e32 v15, s51
; GCN-NEXT:    s_load_dwordx16 s[36:51], s[10:11], 0xc0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:256
; GCN-NEXT:    buffer_store_dword v1, off, s[0:3], 0 offset:260
; GCN-NEXT:    buffer_store_dword v2, off, s[0:3], 0 offset:264
; GCN-NEXT:    buffer_store_dword v3, off, s[0:3], 0 offset:268
; GCN-NEXT:    buffer_store_dword v4, off, s[0:3], 0 offset:272
; GCN-NEXT:    buffer_store_dword v5, off, s[0:3], 0 offset:276
; GCN-NEXT:    buffer_store_dword v6, off, s[0:3], 0 offset:280
; GCN-NEXT:    buffer_store_dword v7, off, s[0:3], 0 offset:284
; GCN-NEXT:    buffer_store_dword v8, off, s[0:3], 0 offset:288
; GCN-NEXT:    buffer_store_dword v9, off, s[0:3], 0 offset:292
; GCN-NEXT:    buffer_store_dword v10, off, s[0:3], 0 offset:296
; GCN-NEXT:    buffer_store_dword v11, off, s[0:3], 0 offset:300
; GCN-NEXT:    buffer_store_dword v12, off, s[0:3], 0 offset:304
; GCN-NEXT:    buffer_store_dword v13, off, s[0:3], 0 offset:308
; GCN-NEXT:    buffer_store_dword v14, off, s[0:3], 0 offset:312
; GCN-NEXT:    buffer_store_dword v15, off, s[0:3], 0 offset:316
; GCN-NEXT:    v_mov_b32_e32 v0, s52
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:320
; GCN-NEXT:    v_mov_b32_e32 v0, s53
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:324
; GCN-NEXT:    v_mov_b32_e32 v0, s54
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:328
; GCN-NEXT:    v_mov_b32_e32 v0, s55
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:332
; GCN-NEXT:    v_mov_b32_e32 v0, s56
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:336
; GCN-NEXT:    v_mov_b32_e32 v0, s57
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:340
; GCN-NEXT:    v_mov_b32_e32 v0, s58
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:344
; GCN-NEXT:    v_mov_b32_e32 v0, s59
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:348
; GCN-NEXT:    v_mov_b32_e32 v0, s60
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:352
; GCN-NEXT:    v_mov_b32_e32 v0, s61
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:356
; GCN-NEXT:    v_mov_b32_e32 v0, s62
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:360
; GCN-NEXT:    v_mov_b32_e32 v0, s63
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:364
; GCN-NEXT:    v_mov_b32_e32 v0, s64
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:368
; GCN-NEXT:    v_mov_b32_e32 v0, s65
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:372
; GCN-NEXT:    v_mov_b32_e32 v0, s66
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:376
; GCN-NEXT:    v_mov_b32_e32 v0, s67
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:380
; GCN-NEXT:    v_mov_b32_e32 v0, s12
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:384
; GCN-NEXT:    v_mov_b32_e32 v0, s13
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:388
; GCN-NEXT:    v_mov_b32_e32 v0, s14
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:392
; GCN-NEXT:    v_mov_b32_e32 v0, s15
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:396
; GCN-NEXT:    v_mov_b32_e32 v0, s16
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:400
; GCN-NEXT:    v_mov_b32_e32 v0, s17
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:404
; GCN-NEXT:    v_mov_b32_e32 v0, s18
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:408
; GCN-NEXT:    v_mov_b32_e32 v0, s19
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:412
; GCN-NEXT:    v_mov_b32_e32 v0, s20
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:416
; GCN-NEXT:    v_mov_b32_e32 v0, s21
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:420
; GCN-NEXT:    v_mov_b32_e32 v0, s22
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:424
; GCN-NEXT:    v_mov_b32_e32 v0, s23
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:428
; GCN-NEXT:    v_mov_b32_e32 v0, s24
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:432
; GCN-NEXT:    v_mov_b32_e32 v0, s25
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:436
; GCN-NEXT:    v_mov_b32_e32 v0, s26
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:440
; GCN-NEXT:    v_mov_b32_e32 v0, s27
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:444
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s36
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:448
; GCN-NEXT:    v_mov_b32_e32 v0, s37
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:452
; GCN-NEXT:    v_mov_b32_e32 v0, s38
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:456
; GCN-NEXT:    v_mov_b32_e32 v0, s39
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:460
; GCN-NEXT:    v_mov_b32_e32 v0, s40
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:464
; GCN-NEXT:    v_mov_b32_e32 v0, s41
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:468
; GCN-NEXT:    v_mov_b32_e32 v0, s42
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:472
; GCN-NEXT:    v_mov_b32_e32 v0, s43
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:476
; GCN-NEXT:    v_mov_b32_e32 v0, s44
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:480
; GCN-NEXT:    v_mov_b32_e32 v0, s45
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:484
; GCN-NEXT:    v_mov_b32_e32 v0, s46
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:488
; GCN-NEXT:    v_mov_b32_e32 v0, s47
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:492
; GCN-NEXT:    v_mov_b32_e32 v0, s48
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:496
; GCN-NEXT:    v_mov_b32_e32 v0, s49
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:500
; GCN-NEXT:    v_mov_b32_e32 v0, s50
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:504
; GCN-NEXT:    v_mov_b32_e32 v0, s51
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:508
; GCN-NEXT:    v_add_u32_e32 v0, s4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], 0 offset:256
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], 0 offset:260
; GCN-NEXT:    buffer_load_dword v2, off, s[0:3], 0 offset:264
; GCN-NEXT:    buffer_load_dword v3, off, s[0:3], 0 offset:268
; GCN-NEXT:    buffer_load_dword v4, off, s[0:3], 0 offset:272
; GCN-NEXT:    buffer_load_dword v5, off, s[0:3], 0 offset:276
; GCN-NEXT:    buffer_load_dword v6, off, s[0:3], 0 offset:280
; GCN-NEXT:    buffer_load_dword v7, off, s[0:3], 0 offset:284
; GCN-NEXT:    buffer_load_dword v8, off, s[0:3], 0 offset:288
; GCN-NEXT:    buffer_load_dword v9, off, s[0:3], 0 offset:292
; GCN-NEXT:    buffer_load_dword v10, off, s[0:3], 0 offset:296
; GCN-NEXT:    buffer_load_dword v11, off, s[0:3], 0 offset:300
; GCN-NEXT:    buffer_load_dword v12, off, s[0:3], 0 offset:304
; GCN-NEXT:    buffer_load_dword v13, off, s[0:3], 0 offset:308
; GCN-NEXT:    buffer_load_dword v14, off, s[0:3], 0 offset:312
; GCN-NEXT:    buffer_load_dword v15, off, s[0:3], 0 offset:316
; GCN-NEXT:    buffer_load_dword v16, off, s[0:3], 0 offset:320
; GCN-NEXT:    buffer_load_dword v17, off, s[0:3], 0 offset:324
; GCN-NEXT:    buffer_load_dword v18, off, s[0:3], 0 offset:328
; GCN-NEXT:    buffer_load_dword v19, off, s[0:3], 0 offset:332
; GCN-NEXT:    buffer_load_dword v20, off, s[0:3], 0 offset:336
; GCN-NEXT:    buffer_load_dword v21, off, s[0:3], 0 offset:340
; GCN-NEXT:    buffer_load_dword v22, off, s[0:3], 0 offset:344
; GCN-NEXT:    buffer_load_dword v23, off, s[0:3], 0 offset:348
; GCN-NEXT:    buffer_load_dword v24, off, s[0:3], 0 offset:352
; GCN-NEXT:    buffer_load_dword v25, off, s[0:3], 0 offset:356
; GCN-NEXT:    buffer_load_dword v26, off, s[0:3], 0 offset:360
; GCN-NEXT:    buffer_load_dword v27, off, s[0:3], 0 offset:364
; GCN-NEXT:    buffer_load_dword v28, off, s[0:3], 0 offset:368
; GCN-NEXT:    buffer_load_dword v29, off, s[0:3], 0 offset:372
; GCN-NEXT:    buffer_load_dword v30, off, s[0:3], 0 offset:376
; GCN-NEXT:    buffer_load_dword v31, off, s[0:3], 0 offset:380
; GCN-NEXT:    buffer_load_dword v32, off, s[0:3], 0 offset:384
; GCN-NEXT:    buffer_load_dword v33, off, s[0:3], 0 offset:388
; GCN-NEXT:    buffer_load_dword v34, off, s[0:3], 0 offset:392
; GCN-NEXT:    buffer_load_dword v35, off, s[0:3], 0 offset:396
; GCN-NEXT:    buffer_load_dword v36, off, s[0:3], 0 offset:400
; GCN-NEXT:    buffer_load_dword v37, off, s[0:3], 0 offset:404
; GCN-NEXT:    buffer_load_dword v38, off, s[0:3], 0 offset:408
; GCN-NEXT:    buffer_load_dword v39, off, s[0:3], 0 offset:412
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], 0 offset:416
; GCN-NEXT:    buffer_load_dword v41, off, s[0:3], 0 offset:420
; GCN-NEXT:    buffer_load_dword v42, off, s[0:3], 0 offset:424
; GCN-NEXT:    buffer_load_dword v43, off, s[0:3], 0 offset:428
; GCN-NEXT:    buffer_load_dword v44, off, s[0:3], 0 offset:432
; GCN-NEXT:    buffer_load_dword v45, off, s[0:3], 0 offset:436
; GCN-NEXT:    buffer_load_dword v46, off, s[0:3], 0 offset:440
; GCN-NEXT:    buffer_load_dword v47, off, s[0:3], 0 offset:444
; GCN-NEXT:    buffer_load_dword v48, off, s[0:3], 0 offset:448
; GCN-NEXT:    buffer_load_dword v49, off, s[0:3], 0 offset:452
; GCN-NEXT:    buffer_load_dword v50, off, s[0:3], 0 offset:456
; GCN-NEXT:    buffer_load_dword v51, off, s[0:3], 0 offset:460
; GCN-NEXT:    buffer_load_dword v52, off, s[0:3], 0 offset:464
; GCN-NEXT:    buffer_load_dword v53, off, s[0:3], 0 offset:468
; GCN-NEXT:    buffer_load_dword v54, off, s[0:3], 0 offset:472
; GCN-NEXT:    buffer_load_dword v55, off, s[0:3], 0 offset:476
; GCN-NEXT:    buffer_load_dword v56, off, s[0:3], 0 offset:480
; GCN-NEXT:    buffer_load_dword v57, off, s[0:3], 0 offset:484
; GCN-NEXT:    buffer_load_dword v58, off, s[0:3], 0 offset:488
; GCN-NEXT:    buffer_load_dword v59, off, s[0:3], 0 offset:492
; GCN-NEXT:    buffer_load_dword v60, off, s[0:3], 0 offset:496
; GCN-NEXT:    buffer_load_dword v61, off, s[0:3], 0 offset:500
; GCN-NEXT:    buffer_load_dword v62, off, s[0:3], 0 offset:504
; GCN-NEXT:    buffer_load_dword v63, off, s[0:3], 0 offset:508
; GCN-NEXT:    s_waitcnt vmcnt(60)
; GCN-NEXT:    global_store_dwordx4 v64, v[0:3], s[8:9]
; GCN-NEXT:    s_waitcnt vmcnt(57)
; GCN-NEXT:    global_store_dwordx4 v64, v[4:7], s[8:9] offset:16
; GCN-NEXT:    s_waitcnt vmcnt(54)
; GCN-NEXT:    global_store_dwordx4 v64, v[8:11], s[8:9] offset:32
; GCN-NEXT:    s_waitcnt vmcnt(51)
; GCN-NEXT:    global_store_dwordx4 v64, v[12:15], s[8:9] offset:48
; GCN-NEXT:    s_waitcnt vmcnt(48)
; GCN-NEXT:    global_store_dwordx4 v64, v[16:19], s[8:9] offset:64
; GCN-NEXT:    s_waitcnt vmcnt(45)
; GCN-NEXT:    global_store_dwordx4 v64, v[20:23], s[8:9] offset:80
; GCN-NEXT:    s_waitcnt vmcnt(42)
; GCN-NEXT:    global_store_dwordx4 v64, v[24:27], s[8:9] offset:96
; GCN-NEXT:    s_waitcnt vmcnt(39)
; GCN-NEXT:    global_store_dwordx4 v64, v[28:31], s[8:9] offset:112
; GCN-NEXT:    s_waitcnt vmcnt(36)
; GCN-NEXT:    global_store_dwordx4 v64, v[32:35], s[8:9] offset:128
; GCN-NEXT:    s_waitcnt vmcnt(33)
; GCN-NEXT:    global_store_dwordx4 v64, v[36:39], s[8:9] offset:144
; GCN-NEXT:    s_waitcnt vmcnt(30)
; GCN-NEXT:    global_store_dwordx4 v64, v[40:43], s[8:9] offset:160
; GCN-NEXT:    s_waitcnt vmcnt(27)
; GCN-NEXT:    global_store_dwordx4 v64, v[44:47], s[8:9] offset:176
; GCN-NEXT:    s_waitcnt vmcnt(24)
; GCN-NEXT:    global_store_dwordx4 v64, v[48:51], s[8:9] offset:192
; GCN-NEXT:    s_waitcnt vmcnt(21)
; GCN-NEXT:    global_store_dwordx4 v64, v[52:55], s[8:9] offset:208
; GCN-NEXT:    s_waitcnt vmcnt(18)
; GCN-NEXT:    global_store_dwordx4 v64, v[56:59], s[8:9] offset:224
; GCN-NEXT:    s_waitcnt vmcnt(15)
; GCN-NEXT:    global_store_dwordx4 v64, v[60:63], s[8:9] offset:240
; GCN-NEXT:    s_endpgm
  %vec = load <64 x i32>, <64 x i32> addrspace(1)* %ptr
  %insert = insertelement <64 x i32> %vec, i32 %val, i32 %idx
  store <64 x i32> %insert, <64 x i32> addrspace(1)* %out.ptr
  ret void
}

attributes #0 = { "amdgpu-waves-per-eu"="1,10" }
