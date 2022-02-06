; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=ALL,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=ALL,SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=ALL,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=ALL,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefixes=ALL,AVX512
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefixes=ALL,AVX512

;
; vXf32
;

define float @test_v1f32(<1 x float> %a0) {
; ALL-LABEL: test_v1f32:
; ALL:       # %bb.0:
; ALL-NEXT:    retq
  %1 = call nnan float @llvm.vector.reduce.fmax.v1f32(<1 x float> %a0)
  ret float %1
}

define float @test_v2f32(<2 x float> %a0) {
; SSE2-LABEL: test_v2f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v2f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v2f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call nnan float @llvm.vector.reduce.fmax.v2f32(<2 x float> %a0)
  ret float %1
}

define float @test_v4f32(<4 x float> %a0) {
; SSE2-LABEL: test_v4f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v4f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call nnan float @llvm.vector.reduce.fmax.v4f32(<4 x float> %a0)
  ret float %1
}

define float @test_v8f32(<8 x float> %a0) {
; SSE2-LABEL: test_v8f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v8f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v8f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v8f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan float @llvm.vector.reduce.fmax.v8f32(<8 x float> %a0)
  ret float %1
}

define float @test_v16f32(<16 x float> %a0) {
; SSE2-LABEL: test_v16f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    maxps %xmm3, %xmm1
; SSE2-NEXT:    maxps %xmm2, %xmm0
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v16f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    maxps %xmm3, %xmm1
; SSE41-NEXT:    maxps %xmm2, %xmm0
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v16f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmaxps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v16f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vmaxps %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan float @llvm.vector.reduce.fmax.v16f32(<16 x float> %a0)
  ret float %1
}

;
; vXf64
;

define double @test_v2f64(<2 x double> %a0) {
; SSE-LABEL: test_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call nnan double @llvm.vector.reduce.fmax.v2f64(<2 x double> %a0)
  ret double %1
}

define double @test_v3f64(<3 x double> %a0) {
; SSE2-LABEL: test_v3f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    shufpd {{.*#+}} xmm2 = xmm2[0],mem[1]
; SSE2-NEXT:    maxpd %xmm2, %xmm0
; SSE2-NEXT:    movapd %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v3f64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE41-NEXT:    blendpd {{.*#+}} xmm2 = xmm2[0],mem[1]
; SSE41-NEXT:    maxpd %xmm2, %xmm0
; SSE41-NEXT:    movapd %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxsd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v3f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm1
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm0
; AVX-NEXT:    vmaxsd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v3f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm1
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm0
; AVX512-NEXT:    vmaxsd %xmm0, %xmm1, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan double @llvm.vector.reduce.fmax.v3f64(<3 x double> %a0)
  ret double %1
}

define double @test_v4f64(<4 x double> %a0) {
; SSE-LABEL: test_v4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    maxpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v4f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan double @llvm.vector.reduce.fmax.v4f64(<4 x double> %a0)
  ret double %1
}

define double @test_v8f64(<8 x double> %a0) {
; SSE-LABEL: test_v8f64:
; SSE:       # %bb.0:
; SSE-NEXT:    maxpd %xmm3, %xmm1
; SSE-NEXT:    maxpd %xmm2, %xmm0
; SSE-NEXT:    maxpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmaxpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v8f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vmaxpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan double @llvm.vector.reduce.fmax.v8f64(<8 x double> %a0)
  ret double %1
}

define double @test_v16f64(<16 x double> %a0) {
; SSE-LABEL: test_v16f64:
; SSE:       # %bb.0:
; SSE-NEXT:    maxpd %xmm6, %xmm2
; SSE-NEXT:    maxpd %xmm4, %xmm0
; SSE-NEXT:    maxpd %xmm2, %xmm0
; SSE-NEXT:    maxpd %xmm7, %xmm3
; SSE-NEXT:    maxpd %xmm5, %xmm1
; SSE-NEXT:    maxpd %xmm3, %xmm1
; SSE-NEXT:    maxpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmaxpd %ymm3, %ymm1, %ymm1
; AVX-NEXT:    vmaxpd %ymm2, %ymm0, %ymm0
; AVX-NEXT:    vmaxpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v16f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmaxpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vmaxpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call nnan double @llvm.vector.reduce.fmax.v16f64(<16 x double> %a0)
  ret double %1
}

define half @test_v2f16(<2 x half> %a0) nounwind {
; SSE-LABEL: test_v2f16:
; SSE:       # %bb.0:
; SSE-NEXT:    pushq %rbp
; SSE-NEXT:    pushq %r14
; SSE-NEXT:    pushq %rbx
; SSE-NEXT:    subq $16, %rsp
; SSE-NEXT:    movl %esi, %ebx
; SSE-NEXT:    movl %edi, %r14d
; SSE-NEXT:    movzwl %bx, %ebp
; SSE-NEXT:    movl %ebp, %edi
; SSE-NEXT:    callq __gnu_h2f_ieee@PLT
; SSE-NEXT:    movss %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; SSE-NEXT:    movzwl %r14w, %edi
; SSE-NEXT:    callq __gnu_h2f_ieee@PLT
; SSE-NEXT:    ucomiss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 4-byte Folded Reload
; SSE-NEXT:    movw %bp, {{[0-9]+}}(%rsp)
; SSE-NEXT:    cmoval %r14d, %ebx
; SSE-NEXT:    movw %bx, (%rsp)
; SSE-NEXT:    movl (%rsp), %eax
; SSE-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE-NEXT:    addq $16, %rsp
; SSE-NEXT:    popq %rbx
; SSE-NEXT:    popq %r14
; SSE-NEXT:    popq %rbp
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f16:
; AVX:       # %bb.0:
; AVX-NEXT:    pushq %rbp
; AVX-NEXT:    pushq %r14
; AVX-NEXT:    pushq %rbx
; AVX-NEXT:    subq $16, %rsp
; AVX-NEXT:    movl %esi, %ebx
; AVX-NEXT:    movl %edi, %r14d
; AVX-NEXT:    movzwl %bx, %ebp
; AVX-NEXT:    movl %ebp, %edi
; AVX-NEXT:    callq __gnu_h2f_ieee@PLT
; AVX-NEXT:    vmovss %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; AVX-NEXT:    movzwl %r14w, %edi
; AVX-NEXT:    callq __gnu_h2f_ieee@PLT
; AVX-NEXT:    vucomiss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 4-byte Folded Reload
; AVX-NEXT:    movw %bp, {{[0-9]+}}(%rsp)
; AVX-NEXT:    cmoval %r14d, %ebx
; AVX-NEXT:    movw %bx, (%rsp)
; AVX-NEXT:    movl (%rsp), %eax
; AVX-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX-NEXT:    addq $16, %rsp
; AVX-NEXT:    popq %rbx
; AVX-NEXT:    popq %r14
; AVX-NEXT:    popq %rbp
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2f16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movzwl %si, %eax
; AVX512-NEXT:    vmovd %eax, %xmm0
; AVX512-NEXT:    vcvtph2ps %xmm0, %xmm0
; AVX512-NEXT:    movzwl %di, %ecx
; AVX512-NEXT:    vmovd %ecx, %xmm1
; AVX512-NEXT:    vcvtph2ps %xmm1, %xmm1
; AVX512-NEXT:    vucomiss %xmm0, %xmm1
; AVX512-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    cmoval %edi, %esi
; AVX512-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; AVX512-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512-NEXT:    retq
  %1 = call nnan half @llvm.vector.reduce.fmax.v2f16(<2 x half> %a0)
  ret half %1
}
declare float @llvm.vector.reduce.fmax.v1f32(<1 x float>)
declare float @llvm.vector.reduce.fmax.v2f32(<2 x float>)
declare float @llvm.vector.reduce.fmax.v4f32(<4 x float>)
declare float @llvm.vector.reduce.fmax.v8f32(<8 x float>)
declare float @llvm.vector.reduce.fmax.v16f32(<16 x float>)

declare double @llvm.vector.reduce.fmax.v2f64(<2 x double>)
declare double @llvm.vector.reduce.fmax.v3f64(<3 x double>)
declare double @llvm.vector.reduce.fmax.v4f64(<4 x double>)
declare double @llvm.vector.reduce.fmax.v8f64(<8 x double>)
declare double @llvm.vector.reduce.fmax.v16f64(<16 x double>)

declare half @llvm.vector.reduce.fmax.v2f16(<2 x half>)
