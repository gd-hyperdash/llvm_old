; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr9 < %s | FileCheck %s
%0 = type { double, [0 x %1] }
%1 = type { i32 }

@f = external dso_local thread_local local_unnamed_addr global %0, align 8
@g = external dso_local local_unnamed_addr global i32, align 4

; Function Attrs: nounwind
define dso_local void @h() local_unnamed_addr #0 {
; CHECK-LABEL: h:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -64(1)
; CHECK-NEXT:    addis 3, 2, g@toc@ha
; CHECK-NEXT:    std 30, 48(1) # 8-byte Folded Spill
; CHECK-NEXT:    lwz 3, g@toc@l(3)
; CHECK-NEXT:    extswsli 30, 3, 2
; CHECK-NEXT:    addis 3, 2, f@got@tlsld@ha
; CHECK-NEXT:    addi 3, 3, f@got@tlsld@l
; CHECK-NEXT:    bl __tls_get_addr(f@tlsld)
; CHECK-NEXT:    nop
; CHECK-NEXT:    addis 3, 3, f@dtprel@ha
; CHECK-NEXT:    addi 3, 3, f@dtprel@l
; CHECK-NEXT:    add 3, 3, 30
; CHECK-NEXT:    lwz 3, 8(3)
; CHECK-NEXT:    cmplwi 3, 0
; CHECK-NEXT:    bne- 0, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %bb6
; CHECK-NEXT:    ld 30, 48(1) # 8-byte Folded Reload
; CHECK-NEXT:    addi 1, 1, 64
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB0_2: # %bb5
bb:
  %i = load i32, i32* @g, align 4
  %i1 = sext i32 %i to i64
  %i2 = getelementptr inbounds [0 x %1], [0 x %1]* bitcast (double* getelementptr inbounds (%0, %0* @f, i64 1, i32 0) to [0 x %1]*), i64 0, i64 %i1, i32 0
  %i3 = load i32, i32* %i2, align 4
  %i4 = icmp eq i32 %i3, 0
  br i1 %i4, label %bb6, label %bb5

bb5:                                              ; preds = %bb
  unreachable

bb6:                                              ; preds = %bb
  ret void
}

attributes #0 = { nounwind }
