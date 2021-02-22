; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -ipsccp -S | FileCheck %s

declare void @use(i1)
declare void @llvm.assume(i1)

define void @basic(i32 %v) {
; CHECK-LABEL: @basic(
; CHECK-NEXT:    [[A1:%.*]] = icmp ult i32 [[V:%.*]], 10
; CHECK-NEXT:    call void @llvm.assume(i1 [[A1]])
; CHECK-NEXT:    [[A2:%.*]] = icmp ugt i32 [[V]], 5
; CHECK-NEXT:    call void @llvm.assume(i1 [[A2]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[C2:%.*]] = icmp ult i32 [[V]], 9
; CHECK-NEXT:    call void @use(i1 [[C2]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C4:%.*]] = icmp ugt i32 [[V]], 8
; CHECK-NEXT:    call void @use(i1 [[C4]])
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[C6:%.*]] = icmp ugt i32 [[V]], 6
; CHECK-NEXT:    call void @use(i1 [[C6]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C8:%.*]] = icmp ult i32 [[V]], 7
; CHECK-NEXT:    call void @use(i1 [[C8]])
; CHECK-NEXT:    ret void
;
  %a1 = icmp ult i32 %v, 10
  call void @llvm.assume(i1 %a1)
  %a2 = icmp ugt i32 %v, 5
  call void @llvm.assume(i1 %a2)
  %c1 = icmp ult i32 %v, 10
  call void @use(i1 %c1)
  %c2 = icmp ult i32 %v, 9
  call void @use(i1 %c2)
  %c3 = icmp ugt i32 %v, 9
  call void @use(i1 %c3)
  %c4 = icmp ugt i32 %v, 8
  call void @use(i1 %c4)
  %c5 = icmp ugt i32 %v, 5
  call void @use(i1 %c5)
  %c6 = icmp ugt i32 %v, 6
  call void @use(i1 %c6)
  %c7 = icmp ult i32 %v, 6
  call void @use(i1 %c7)
  %c8 = icmp ult i32 %v, 7
  call void @use(i1 %c8)
  ret void
}

define void @nonnull(i32* %v) {
; CHECK-LABEL: @nonnull(
; CHECK-NEXT:    [[A:%.*]] = icmp ne i32* [[V:%.*]], null
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
;
  %a = icmp ne i32* %v, null
  call void @llvm.assume(i1 %a)
  %c1 = icmp eq i32* %v, null
  call void @use(i1 %c1)
  %c2 = icmp ne i32* %v, null
  call void @use(i1 %c2)
  %c3 = icmp eq i32* null, %v
  call void @use(i1 %c3)
  %c4 = icmp ne i32* null, %v
  call void @use(i1 %c4)
  ret void
}
