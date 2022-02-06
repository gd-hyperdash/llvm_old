; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr8 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-aix \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s --check-prefix=CHECK-AIX
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s --check-prefix=CHECK-AIX64

declare void @llvm.ppc.dcbtstt(i8*)
declare void @llvm.ppc.dcbtt(i8*)

@vpa = external local_unnamed_addr global i8*, align 8

define dso_local void @test_dcbtstt() {
; CHECK-LABEL: test_dcbtstt:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis 3, 2, .LC0@toc@ha
; CHECK-NEXT:    ld 3, .LC0@toc@l(3)
; CHECK-NEXT:    ld 3, 0(3)
; CHECK-NEXT:    dcbtstt 0, 3
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test_dcbtstt:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    lwz 3, L..C0(2) # @vpa
; CHECK-AIX-NEXT:    lwz 3, 0(3)
; CHECK-AIX-NEXT:    dcbtstt 0, 3
; CHECK-AIX-NEXT:    blr
;
; CHECK-AIX64-LABEL: test_dcbtstt:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    ld 3, L..C0(2) # @vpa
; CHECK-AIX64-NEXT:    ld 3, 0(3)
; CHECK-AIX64-NEXT:    dcbtstt 0, 3
; CHECK-AIX64-NEXT:    blr
entry:
  %0 = load i8*, i8** @vpa, align 8
  tail call void @llvm.ppc.dcbtstt(i8* %0)
  ret void
}


define dso_local void @test_dcbtt() {
; CHECK-LABEL: test_dcbtt:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis 3, 2, .LC0@toc@ha
; CHECK-NEXT:    ld 3, .LC0@toc@l(3)
; CHECK-NEXT:    ld 3, 0(3)
; CHECK-NEXT:    dcbtt 0, 3
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test_dcbtt:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    lwz 3, L..C0(2) # @vpa
; CHECK-AIX-NEXT:    lwz 3, 0(3)
; CHECK-AIX-NEXT:    dcbtt 0, 3
; CHECK-AIX-NEXT:    blr
;
; CHECK-AIX64-LABEL: test_dcbtt:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    ld 3, L..C0(2) # @vpa
; CHECK-AIX64-NEXT:    ld 3, 0(3)
; CHECK-AIX64-NEXT:    dcbtt 0, 3
; CHECK-AIX64-NEXT:    blr
entry:
  %0 = load i8*, i8** @vpa, align 8
  tail call void @llvm.ppc.dcbtt(i8* %0)
  ret void
}
