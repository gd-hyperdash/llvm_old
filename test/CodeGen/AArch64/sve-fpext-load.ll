; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; fpext <vscale x 2 x half> -> <vscale x 2 x double>
define <vscale x 2 x double> @ext2_f16_f64(<vscale x 2 x half> *%ptr, i64 %index) {
; CHECK-LABEL: ext2_f16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.h
; CHECK-NEXT:    ret
  %load = load <vscale x 2 x half>, <vscale x 2 x half>* %ptr, align 4
  %load.ext = fpext <vscale x 2 x half> %load to <vscale x 2 x double>
  ret <vscale x 2 x double> %load.ext
}

; fpext <vscale x 4 x half> -> <vscale x 4 x double>
define <vscale x 4 x double> @ext4_f16_f64(<vscale x 4 x half> *%ptr, i64 %index) {
; CHECK-LABEL: ext4_f16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    uunpklo z1.d, z0.s
; CHECK-NEXT:    uunpkhi z2.d, z0.s
; CHECK-NEXT:    fcvt z0.d, p0/m, z1.h
; CHECK-NEXT:    fcvt z1.d, p0/m, z2.h
; CHECK-NEXT:    ret
  %load = load <vscale x 4 x half>, <vscale x 4 x half>* %ptr, align 4
  %load.ext = fpext <vscale x 4 x half> %load to <vscale x 4 x double>
  ret <vscale x 4 x double> %load.ext
}

; fpext <vscale x 8 x half> -> <vscale x 8 x double>
define <vscale x 8 x double> @ext8_f16_f64(<vscale x 8 x half> *%ptr, i64 %index) {
; CHECK-LABEL: ext8_f16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    uunpklo z1.s, z0.h
; CHECK-NEXT:    uunpkhi z0.s, z0.h
; CHECK-NEXT:    uunpklo z2.d, z1.s
; CHECK-NEXT:    uunpkhi z1.d, z1.s
; CHECK-NEXT:    uunpklo z3.d, z0.s
; CHECK-NEXT:    uunpkhi z4.d, z0.s
; CHECK-NEXT:    fcvt z0.d, p0/m, z2.h
; CHECK-NEXT:    fcvt z1.d, p0/m, z1.h
; CHECK-NEXT:    fcvt z2.d, p0/m, z3.h
; CHECK-NEXT:    fcvt z3.d, p0/m, z4.h
; CHECK-NEXT:    ret
  %load = load <vscale x 8 x half>, <vscale x 8 x half>* %ptr, align 4
  %load.ext = fpext <vscale x 8 x half> %load to <vscale x 8 x double>
  ret <vscale x 8 x double> %load.ext
}

; fpext <vscale x 2 x float> -> <vscale x 2 x double>
define <vscale x 2 x double> @ext2_f32_f64(<vscale x 2 x float> *%ptr, i64 %index) {
; CHECK-LABEL: ext2_f32_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.s
; CHECK-NEXT:    ret
  %load = load <vscale x 2 x float>, <vscale x 2 x float>* %ptr, align 4
  %load.ext = fpext <vscale x 2 x float> %load to <vscale x 2 x double>
  ret <vscale x 2 x double> %load.ext
}

; fpext <vscale x 4 x float> -> <vscale x 4 x double>
define <vscale x 4 x double> @ext4_f32_f64(<vscale x 4 x float> *%ptr, i64 %index) {
; CHECK-LABEL: ext4_f32_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    uunpklo z1.d, z0.s
; CHECK-NEXT:    uunpkhi z2.d, z0.s
; CHECK-NEXT:    fcvt z0.d, p0/m, z1.s
; CHECK-NEXT:    fcvt z1.d, p0/m, z2.s
; CHECK-NEXT:    ret
  %load = load <vscale x 4 x float>, <vscale x 4 x float>* %ptr, align 4
  %load.ext = fpext <vscale x 4 x float> %load to <vscale x 4 x double>
  ret <vscale x 4 x double> %load.ext
}
