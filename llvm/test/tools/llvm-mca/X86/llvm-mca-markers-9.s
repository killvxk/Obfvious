# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 < %s | FileCheck %s

testloop:
# LLVM-MCA-BEGIN outer
  leal 42(%rdi), %eax
# LLVM-MCA-BEGIN inner
  imull %esi, %eax
# LLVM-MCA-END inner
  leal 42(%rdi), %eax
# LLVM-MCA-END outer
  imull %esi, %eax

# CHECK:      [0] Code Region - outer

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      300
# CHECK-NEXT: Total Cycles:      156
# CHECK-NEXT: Total uOps:        300

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    1.92
# CHECK-NEXT: IPC:               1.92
# CHECK-NEXT: Block RThroughput: 1.5

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        leal	42(%rdi), %eax
# CHECK-NEXT:  1      3     1.00                        imull	%esi, %eax
# CHECK-NEXT:  1      1     0.50                        leal	42(%rdi), %eax

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 1.49   1.51    -      -      -      -      -      -     1.00    -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT: 0.99   0.01    -      -      -      -      -      -      -      -      -      -      -      -     leal	42(%rdi), %eax
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%esi, %eax
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -     leal	42(%rdi), %eax

# CHECK:      [1] Code Region - inner

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      100
# CHECK-NEXT: Total Cycles:      303
# CHECK-NEXT: Total uOps:        100

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.33
# CHECK-NEXT: IPC:               0.33
# CHECK-NEXT: Block RThroughput: 1.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%esi, %eax

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%esi, %eax
