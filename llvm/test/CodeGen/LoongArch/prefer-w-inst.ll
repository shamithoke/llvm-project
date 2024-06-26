; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --verify-machineinstrs < %s \
; RUN:   | FileCheck --check-prefixes=NO-PREFER-W-INST %s
; RUN: llc --mtriple=loongarch64 --loongarch-disable-cvt-to-d-suffix --verify-machineinstrs < %s \
; RUN:   | FileCheck --check-prefixes=NO-CVT-D-INST %s
; RUN: llc --mtriple=loongarch64 --mattr=+prefer-w-inst --verify-machineinstrs < %s \
; RUN:   | FileCheck --check-prefixes=PREFER-W-INST %s

define signext i32 @addw(i32 %x) {
; NO-PREFER-W-INST-LABEL: addw:
; NO-PREFER-W-INST:       # %bb.0:
; NO-PREFER-W-INST-NEXT:    addi.d $a0, $a0, 2047
; NO-PREFER-W-INST-NEXT:    addi.w $a0, $a0, 2033
; NO-PREFER-W-INST-NEXT:    ret
;
; NO-CVT-D-INST-LABEL: addw:
; NO-CVT-D-INST:       # %bb.0:
; NO-CVT-D-INST-NEXT:    addi.w $a0, $a0, 2047
; NO-CVT-D-INST-NEXT:    addi.w $a0, $a0, 2033
; NO-CVT-D-INST-NEXT:    ret
;
; PREFER-W-INST-LABEL: addw:
; PREFER-W-INST:       # %bb.0:
; PREFER-W-INST-NEXT:    addi.w $a0, $a0, 2047
; PREFER-W-INST-NEXT:    addi.w $a0, $a0, 2033
; PREFER-W-INST-NEXT:    ret
  %add = add i32 %x, 4080
  ret i32 %add
}
