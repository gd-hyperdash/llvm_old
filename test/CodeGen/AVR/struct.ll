; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=avr < %s | FileCheck %s --check-prefix=CHECKA
; RUN: llc -mtriple=avr -mattr=+movw < %s | FileCheck %s --check-prefix=CHECKB

%struct.s10 = type { i16, i16, i16, i16, i16 }
%struct.s06 = type { i16, i16, i16 }
%struct.s04 = type { i16, i16 }

define void @foo10(%struct.s10* sret(%struct.s10) %0, i16 %1, i16 %2, i16 %3) addrspace(1) {
; CHECKA-LABEL: foo10:
; CHECKA:       ; %bb.0:
; CHECKA-NEXT:    mov r30, r24
; CHECKA-NEXT:    mov r31, r25
; CHECKA-NEXT:    std Z+4, r22
; CHECKA-NEXT:    std Z+5, r23
; CHECKA-NEXT:    std Z+2, r20
; CHECKA-NEXT:    std Z+3, r21
; CHECKA-NEXT:    st Z, r18
; CHECKA-NEXT:    std Z+1, r19
; CHECKA-NEXT:    ret
;
; CHECKB-LABEL: foo10:
; CHECKB:       ; %bb.0:
; CHECKB-NEXT:    movw r30, r24
; CHECKB-NEXT:    std Z+4, r22
; CHECKB-NEXT:    std Z+5, r23
; CHECKB-NEXT:    std Z+2, r20
; CHECKB-NEXT:    std Z+3, r21
; CHECKB-NEXT:    st Z, r18
; CHECKB-NEXT:    std Z+1, r19
; CHECKB-NEXT:    ret
  %5 = getelementptr inbounds %struct.s10, %struct.s10* %0, i16 0, i32 0
  store i16 %3, i16* %5
  %6 = getelementptr inbounds %struct.s10, %struct.s10* %0, i16 0, i32 1
  store i16 %2, i16* %6
  %7 = getelementptr inbounds %struct.s10, %struct.s10* %0, i16 0, i32 2
  store i16 %1, i16* %7
  ret void
}

define %struct.s06 @foo06(i16 %0, i16 %1, i16 %2) addrspace(1) {
; CHECKA-LABEL: foo06:
; CHECKA:       ; %bb.0:
; CHECKA-NEXT:    mov r30, r20
; CHECKA-NEXT:    mov r31, r21
; CHECKA-NEXT:    mov r20, r22
; CHECKA-NEXT:    mov r21, r23
; CHECKA-NEXT:    mov r18, r24
; CHECKA-NEXT:    mov r19, r25
; CHECKA-NEXT:    mov r22, r30
; CHECKA-NEXT:    mov r23, r31
; CHECKA-NEXT:    ret
;
; CHECKB-LABEL: foo06:
; CHECKB:       ; %bb.0:
; CHECKB-NEXT:    movw r30, r20
; CHECKB-NEXT:    movw r20, r22
; CHECKB-NEXT:    movw r18, r24
; CHECKB-NEXT:    movw r22, r30
; CHECKB-NEXT:    ret
  %4 = insertvalue %struct.s06 undef, i16 %0, 0
  %5 = insertvalue %struct.s06 %4, i16 %1, 1
  %6 = insertvalue %struct.s06 %5, i16 %2, 2
  ret %struct.s06 %6
}

define %struct.s04 @foo04(i16 %0, i16 %1) addrspace(1) {
; CHECKA-LABEL: foo04:
; CHECKA:       ; %bb.0:
; CHECKA-NEXT:    mov r18, r22
; CHECKA-NEXT:    mov r19, r23
; CHECKA-NEXT:    mov r22, r24
; CHECKA-NEXT:    mov r23, r25
; CHECKA-NEXT:    mov r24, r18
; CHECKA-NEXT:    mov r25, r19
; CHECKA-NEXT:    ret
;
; CHECKB-LABEL: foo04:
; CHECKB:       ; %bb.0:
; CHECKB-NEXT:    movw r18, r22
; CHECKB-NEXT:    movw r22, r24
; CHECKB-NEXT:    movw r24, r18
; CHECKB-NEXT:    ret
  %3 = insertvalue %struct.s04 undef, i16 %0, 0
  %4 = insertvalue %struct.s04 %3, i16 %1, 1
  ret %struct.s04 %4
}
