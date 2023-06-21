; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: not llc < %s -mtriple=riscv32 -mattr +reserve-x8 2>&1 \
; RUN:   | FileCheck -check-prefix=NO-RESERVE-A1 %s
; RUN: not llc < %s -mtriple=riscv32 -mattr +reserve-x11 2>&1 \
; RUN:   | FileCheck -check-prefix=NO-RESERVE-FP %s
; RUN: llc < %s -mtriple=riscv32 -mattr +reserve-x8 -mattr +reserve-x11 \
; RUN:   | FileCheck -check-prefix=RESERVE %s

define i32 @get_reg_a1() nounwind {
; NO-RESERVE-A1: Trying to obtain non-reserved register "a1".
; RESERVE-LABEL: get_reg_a1:
; RESERVE:       # %bb.0: # %entry
; RESERVE-NEXT:    mv a0, a1
; RESERVE-NEXT:    ret
entry:
  %a1 = call i32 @llvm.read_register.i32(metadata !0)
  ret i32 %a1
}

define i32 @get_reg_fp() nounwind {
; NO-RESERVE-FP: Trying to obtain non-reserved register "fp".
; RESERVE-LABEL: get_reg_fp:
; RESERVE:       # %bb.0: # %entry
; RESERVE-NEXT:    mv a0, s0
; RESERVE-NEXT:    ret
entry:
  %fp = call i32 @llvm.read_register.i32(metadata !1)
  ret i32 %fp
}

declare i32 @llvm.read_register.i32(metadata) nounwind

!0 = !{!"a1\00"}
!1 = !{!"fp\00"}