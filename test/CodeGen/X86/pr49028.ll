; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=X64

define zeroext i16 @PR49028(i16 zeroext %0, i8* %1) {
; X86-LABEL: PR49028:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    sete (%ecx)
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: PR49028:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    sete (%rsi)
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %3 = lshr i16 %0, 1
  %4 = icmp eq i16 %3, 0
  %5 = zext i1 %4 to i8
  store i8 %5, i8* %1, align 1
  ret i16 %3
}
