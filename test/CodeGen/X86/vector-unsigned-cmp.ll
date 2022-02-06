; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2

; PR33276 - https://bugs.llvm.org/show_bug.cgi?id=33276
; If both operands of an unsigned icmp are known non-negative, then
; we don't need to flip the sign bits in order to map to signed pcmpgt*.

define <2 x i1> @ugt_v2i64(<2 x i64> %x, <2 x i64> %y) {
; SSE-LABEL: ugt_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE-NEXT:    pand %xmm3, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ugt_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <2 x i64> %x, <i64 1, i64 1>
  %sh2 = lshr <2 x i64> %y, <i64 1, i64 1>
  %cmp = icmp ugt <2 x i64> %sh1, %sh2
  ret <2 x i1> %cmp
}

define <2 x i1> @ult_v2i64(<2 x i64> %x, <2 x i64> %y) {
; SSE-LABEL: ult_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE-NEXT:    pand %xmm3, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE-NEXT:    por %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ult_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <2 x i64> %x, <i64 1, i64 1>
  %sh2 = lshr <2 x i64> %y, <i64 1, i64 1>
  %cmp = icmp ult <2 x i64> %sh1, %sh2
  ret <2 x i1> %cmp
}

define <2 x i1> @uge_v2i64(<2 x i64> %x, <2 x i64> %y) {
; SSE-LABEL: uge_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE-NEXT:    pand %xmm3, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: uge_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <2 x i64> %x, <i64 1, i64 1>
  %sh2 = lshr <2 x i64> %y, <i64 1, i64 1>
  %cmp = icmp uge <2 x i64> %sh1, %sh2
  ret <2 x i1> %cmp
}

define <2 x i1> @ule_v2i64(<2 x i64> %x, <2 x i64> %y) {
; SSE-LABEL: ule_v2i64:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $1, %xmm0
; SSE-NEXT:    psrlq $1, %xmm1
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE-NEXT:    pand %xmm3, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE-NEXT:    por %xmm0, %xmm1
; SSE-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE-NEXT:    pxor %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ule_v2i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlq $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <2 x i64> %x, <i64 1, i64 1>
  %sh2 = lshr <2 x i64> %y, <i64 1, i64 1>
  %cmp = icmp ule <2 x i64> %sh1, %sh2
  ret <2 x i1> %cmp
}

define <4 x i1> @ugt_v4i32(<4 x i32> %x, <4 x i32> %y) {
; SSE-LABEL: ugt_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ugt_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %sh2 = lshr <4 x i32> %y, <i32 1, i32 1, i32 1, i32 1>
  %cmp = icmp ugt <4 x i32> %sh1, %sh2
  ret <4 x i1> %cmp
}

define <4 x i1> @ult_v4i32(<4 x i32> %x, <4 x i32> %y) {
; SSE-LABEL: ult_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    psrld $1, %xmm0
; SSE-NEXT:    psrld $1, %xmm1
; SSE-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ult_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %sh2 = lshr <4 x i32> %y, <i32 1, i32 1, i32 1, i32 1>
  %cmp = icmp ult <4 x i32> %sh1, %sh2
  ret <4 x i1> %cmp
}

define <4 x i1> @uge_v4i32(<4 x i32> %x, <4 x i32> %y) {
; SSE2-LABEL: uge_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $1, %xmm0
; SSE2-NEXT:    psrld $1, %xmm1
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: uge_v4i32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    psrld $1, %xmm0
; SSE41-NEXT:    psrld $1, %xmm1
; SSE41-NEXT:    pmaxud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: uge_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX-NEXT:    vpmaxud %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %sh2 = lshr <4 x i32> %y, <i32 1, i32 1, i32 1, i32 1>
  %cmp = icmp uge <4 x i32> %sh1, %sh2
  ret <4 x i1> %cmp
}

define <4 x i1> @ule_v4i32(<4 x i32> %x, <4 x i32> %y) {
; SSE2-LABEL: ule_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $1, %xmm0
; SSE2-NEXT:    psrld $1, %xmm1
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ule_v4i32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    psrld $1, %xmm0
; SSE41-NEXT:    psrld $1, %xmm1
; SSE41-NEXT:    pminud %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: ule_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrld $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $1, %xmm1, %xmm1
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %sh2 = lshr <4 x i32> %y, <i32 1, i32 1, i32 1, i32 1>
  %cmp = icmp ule <4 x i32> %sh1, %sh2
  ret <4 x i1> %cmp
}

define <8 x i1> @ugt_v8i16(<8 x i16> %x, <8 x i16> %y) {
; SSE-LABEL: ugt_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ugt_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %sh2 = lshr <8 x i16> %y, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %cmp = icmp ugt <8 x i16> %sh1, %sh2
  ret <8 x i1> %cmp
}

define <8 x i1> @ult_v8i16(<8 x i16> %x, <8 x i16> %y) {
; SSE-LABEL: ult_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pcmpgtw %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ult_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtw %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %sh2 = lshr <8 x i16> %y, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %cmp = icmp ult <8 x i16> %sh1, %sh2
  ret <8 x i1> %cmp
}

define <8 x i1> @uge_v8i16(<8 x i16> %x, <8 x i16> %y) {
; SSE2-LABEL: uge_v8i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlw $1, %xmm0
; SSE2-NEXT:    psrlw $1, %xmm1
; SSE2-NEXT:    pcmpgtw %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: uge_v8i16:
; SSE41:       # %bb.0:
; SSE41-NEXT:    psrlw $1, %xmm0
; SSE41-NEXT:    psrlw $1, %xmm1
; SSE41-NEXT:    pmaxuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: uge_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpmaxuw %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %sh2 = lshr <8 x i16> %y, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %cmp = icmp uge <8 x i16> %sh1, %sh2
  ret <8 x i1> %cmp
}

define <8 x i1> @ule_v8i16(<8 x i16> %x, <8 x i16> %y) {
; SSE2-LABEL: ule_v8i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlw $1, %xmm0
; SSE2-NEXT:    psrlw $1, %xmm1
; SSE2-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: ule_v8i16:
; SSE41:       # %bb.0:
; SSE41-NEXT:    psrlw $1, %xmm0
; SSE41-NEXT:    psrlw $1, %xmm1
; SSE41-NEXT:    pminuw %xmm0, %xmm1
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: ule_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpminuw %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %sh2 = lshr <8 x i16> %y, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %cmp = icmp ule <8 x i16> %sh1, %sh2
  ret <8 x i1> %cmp
}

define <16 x i1> @ugt_v16i8(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: ugt_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pand %xmm2, %xmm1
; SSE-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ugt_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; AVX-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %sh2 = lshr <16 x i8> %y, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp ugt <16 x i8> %sh1, %sh2
  ret <16 x i1> %cmp
}

define <16 x i1> @ult_v16i8(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: ult_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pand %xmm1, %xmm2
; SSE-NEXT:    pcmpgtb %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ult_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; AVX-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpcmpgtb %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %sh2 = lshr <16 x i8> %y, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp ult <16 x i8> %sh1, %sh2
  ret <16 x i1> %cmp
}

define <16 x i1> @uge_v16i8(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: uge_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pand %xmm2, %xmm1
; SSE-NEXT:    pmaxub %xmm0, %xmm1
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: uge_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; AVX-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpmaxub %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %sh2 = lshr <16 x i8> %y, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp uge <16 x i8> %sh1, %sh2
  ret <16 x i1> %cmp
}

define <16 x i1> @ule_v16i8(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: ule_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $1, %xmm0
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    psrlw $1, %xmm1
; SSE-NEXT:    pand %xmm2, %xmm1
; SSE-NEXT:    pminub %xmm0, %xmm1
; SSE-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: ule_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa {{.*#+}} xmm2 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; AVX-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpminub %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %sh1 = lshr <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %sh2 = lshr <16 x i8> %y, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp ule <16 x i8> %sh1, %sh2
  ret <16 x i1> %cmp
}

define <8 x i16> @PR47448_uge(i16 signext %0) {
; SSE2-LABEL: PR47448_uge:
; SSE2:       # %bb.0:
; SSE2-NEXT:    andl $7, %edi
; SSE2-NEXT:    movd %edi, %xmm0
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,2,3,4,5,6,7]
; SSE2-NEXT:    pcmpgtw %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: PR47448_uge:
; SSE41:       # %bb.0:
; SSE41-NEXT:    andl $7, %edi
; SSE41-NEXT:    movd %edi, %xmm0
; SSE41-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,0,0,0]
; SSE41-NEXT:    movdqa {{.*#+}} xmm0 = [0,1,2,3,4,5,6,7]
; SSE41-NEXT:    pmaxuw %xmm1, %xmm0
; SSE41-NEXT:    pcmpeqw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: PR47448_uge:
; AVX1:       # %bb.0:
; AVX1-NEXT:    andl $7, %edi
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    vpmaxuw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR47448_uge:
; AVX2:       # %bb.0:
; AVX2-NEXT:    andl $7, %edi
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpbroadcastw %xmm0, %xmm0
; AVX2-NEXT:    vpmaxuw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX2-NEXT:    vpcmpeqw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
  %2 = and i16 %0, 7
  %3 = insertelement <8 x i16> undef, i16 %2, i32 0
  %4 = shufflevector <8 x i16> %3, <8 x i16> undef, <8 x i32> zeroinitializer
  %5 = icmp uge <8 x i16> %4, <i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7>
  %6 = sext <8 x i1> %5 to <8 x i16>
  ret <8 x i16> %6
}

define <8 x i16> @PR47448_ugt(i16 signext %0) {
; SSE-LABEL: PR47448_ugt:
; SSE:       # %bb.0:
; SSE-NEXT:    andl $7, %edi
; SSE-NEXT:    movd %edi, %xmm0
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR47448_ugt:
; AVX1:       # %bb.0:
; AVX1-NEXT:    andl $7, %edi
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    vpcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR47448_ugt:
; AVX2:       # %bb.0:
; AVX2-NEXT:    andl $7, %edi
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpbroadcastw %xmm0, %xmm0
; AVX2-NEXT:    vpcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    retq
  %2 = and i16 %0, 7
  %3 = insertelement <8 x i16> undef, i16 %2, i32 0
  %4 = shufflevector <8 x i16> %3, <8 x i16> undef, <8 x i32> zeroinitializer
  %5 = icmp ugt <8 x i16> %4, <i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7>
  %6 = sext <8 x i1> %5 to <8 x i16>
  ret <8 x i16> %6
}
