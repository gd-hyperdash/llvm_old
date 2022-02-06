; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt < %s -passes='module(sancov-module)' -sanitizer-coverage-level=1 -force-opaque-pointers -S | FileCheck %s

;.
; CHECK: @[[__SANCOV_LOWEST_STACK:[a-zA-Z0-9_$"\\.-]+]] = external thread_local(initialexec) global i64
; CHECK: @[[__SANCOV_GEN_:[a-zA-Z0-9_$"\\.-]+]] = private global [1 x i32] zeroinitializer, section "__sancov_guards", comdat($foo), align 4
; CHECK: @[[__START___SANCOV_GUARDS:[a-zA-Z0-9_$"\\.-]+]] = extern_weak hidden global i32
; CHECK: @[[__STOP___SANCOV_GUARDS:[a-zA-Z0-9_$"\\.-]+]] = extern_weak hidden global i32
; CHECK: @[[LLVM_GLOBAL_CTORS:[a-zA-Z0-9_$"\\.-]+]] = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 2, ptr @sancov.module_ctor_trace_pc_guard, ptr @sancov.module_ctor_trace_pc_guard }]
; CHECK: @[[LLVM_COMPILER_USED:[a-zA-Z0-9_$"\\.-]+]] = appending global [1 x ptr] [ptr @__sancov_gen_], section "llvm.metadata"
;.
define void @foo(i32* %a) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    call void @__sanitizer_cov_trace_pc_guard(ptr @__sancov_gen_) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret void
;
  ret void
}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nounwind }
; CHECK: attributes #[[ATTR1]] = { nomerge }
;.
