; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mem2reg -S | FileCheck %s

; Testing conversion from dbg.declare to dbg.value when the variable is a VLA.
;
; We can't derive the size of the variable simply by looking at the
; metadata. But we can find out the size by examining the alloca, so we should
; know that the load/store instructions are referencing the whole variable,
; and we expect to get dbg.value intrinsics that maps %entryN (aka %[[PHI]])
; and %t0 to the variable allocated as %vla1.

; ModuleID = 'debug-alloca-vla.ll'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define void @scan() #0 !dbg !4 {
; CHECK-LABEL: @scan(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]], !dbg [[DBG10:![0-9]+]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[VLA1_0:%.*]] = phi i32 [ undef, [[ENTRY:%.*]] ], [ [[T0:%.*]], [[FOR_COND]] ]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[VLA1_0]], metadata [[META11:![0-9]+]], metadata !DIExpression()), !dbg [[DBG19:![0-9]+]]
; CHECK-NEXT:    [[T0]] = add i32 [[VLA1_0]], 1
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[T0]], metadata [[META11]], metadata !DIExpression()), !dbg [[DBG19]]
; CHECK-NEXT:    br label [[FOR_COND]], !dbg [[DBG10]]
;
entry:
  %vla1 = alloca i32, i32 1, align 8
  call void @llvm.dbg.declare(metadata i32* %vla1, metadata !10, metadata !DIExpression()), !dbg !18
  br label %for.cond, !dbg !18

for.cond:                                         ; preds = %for.cond, %entry
  %entryN = load i32, i32* %vla1, align 8, !dbg !18
  %t0 = add i32 %entryN, 1
  store i32 %t0, i32* %vla1, align 8, !dbg !18
  br label %for.cond, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { nounwind ssp uwtable }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "adrian", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "<stdin>", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 7, !"PIC Level", i32 2}
!4 = distinct !DISubprogram(name: "scan", scope: !1, file: !1, line: 4, type: !5, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !8)
!5 = !DISubroutineType(types: !6)
!6 = !{null, !7, !7}
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{!9}
!9 = !DILocalVariable(name: "entry", scope: !4, file: !1, line: 6, type: !7)
!10 = !DILocalVariable(name: "ptr32", scope: !4, file: !1, line: 240, type: !11)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, elements: !14)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !1, line: 41, baseType: !13)
!13 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!14 = !{!15}
!15 = !DISubrange(count: !16)
!16 = !DILocalVariable(name: "__vla_expr", scope: !4, type: !17, flags: DIFlagArtificial)
!17 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!18 = !DILocation(line: 6, scope: !4)
