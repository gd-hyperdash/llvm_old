; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;RUN: opt -mem2reg -S < %s | FileCheck %s

declare i1 @cond()

define i32 @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C1]], label [[STORE1:%.*]], label [[STORE2:%.*]]
; CHECK:       Block1:
; CHECK-NEXT:    br label [[JOIN:%.*]]
; CHECK:       Block2:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block3:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block4:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block5:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Store1:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block6:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block7:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block8:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block9:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block10:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Store2:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block11:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block12:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block13:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block14:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block15:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Block16:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       Join:
; CHECK-NEXT:    [[VAL_0:%.*]] = phi i32 [ 1, [[STORE1]] ], [ 2, [[STORE2]] ], [ undef, [[BLOCK1:%.*]] ], [ undef, [[BLOCK2:%.*]] ], [ undef, [[BLOCK3:%.*]] ], [ undef, [[BLOCK4:%.*]] ], [ undef, [[BLOCK5:%.*]] ], [ undef, [[BLOCK6:%.*]] ], [ undef, [[BLOCK7:%.*]] ], [ undef, [[BLOCK8:%.*]] ], [ undef, [[BLOCK9:%.*]] ], [ undef, [[BLOCK10:%.*]] ], [ undef, [[BLOCK11:%.*]] ], [ undef, [[BLOCK12:%.*]] ], [ undef, [[BLOCK13:%.*]] ], [ undef, [[BLOCK14:%.*]] ], [ undef, [[BLOCK15:%.*]] ], [ undef, [[BLOCK16:%.*]] ]
; CHECK-NEXT:    ret i32 [[VAL_0]]
;
Entry:
  %val = alloca i32
  %c1 = call i1 @cond()
  br i1 %c1, label %Store1, label %Store2
Block1:
  br label %Join
Block2:
  br label %Join
Block3:
  br label %Join
Block4:
  br label %Join
Block5:
  br label %Join
Store1:
  store i32 1, i32* %val
  br label %Join
Block6:
  br label %Join
Block7:
  br label %Join
Block8:
  br label %Join
Block9:
  br label %Join
Block10:
  br label %Join
Store2:
  store i32 2, i32* %val
  br label %Join
Block11:
  br label %Join
Block12:
  br label %Join
Block13:
  br label %Join
Block14:
  br label %Join
Block15:
  br label %Join
Block16:
  br label %Join
Join:
; Phi inserted here should have operands appended deterministically
  %result = load i32, i32* %val
  ret i32 %result
}
