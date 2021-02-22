; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -fast-isel -fast-isel-abort=1 -mtriple=x86_64-unknown-unknown -mattr=+sse2 < %s | FileCheck %s --check-prefix=SSE
; RUN: llc -O0 -fast-isel -fast-isel-abort=1 -mtriple=x86_64-unknown-unknown -mattr=+avx < %s | FileCheck %s --check-prefix=AVX --check-prefix=AVXONLY
; RUN: llc -O0 -fast-isel -fast-isel-abort=1 -mtriple=x86_64-unknown-unknown -mattr=+avx512f < %s | FileCheck %s --check-prefix=AVX --check-prefix=AVX512 --check-prefix=KNL
; RUN: llc -O0 -fast-isel -fast-isel-abort=1 -mtriple=x86_64-unknown-unknown -mattr=+avx512dq,+avx512bw,+avx512vl < %s | FileCheck %s --check-prefix=AVX --check-prefix=AVX512 --check-prefix=SKX

; Verify that fast-isel knows how to select aligned/unaligned vector loads.
; Also verify that the selected load instruction is in the correct domain.

define <16 x i8> @test_v16i8(<16 x i8>* %V) {
; SSE-LABEL: test_v16i8:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i8:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <16 x i8>, <16 x i8>* %V, align 16
  ret <16 x i8> %0
}

define <8 x i16> @test_v8i16(<8 x i16>* %V) {
; SSE-LABEL: test_v8i16:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i16:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i16>, <8 x i16>* %V, align 16
  ret <8 x i16> %0
}

define <4 x i32> @test_v4i32(<4 x i32>* %V) {
; SSE-LABEL: test_v4i32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x i32>, <4 x i32>* %V, align 16
  ret <4 x i32> %0
}

define <2 x i64> @test_v2i64(<2 x i64>* %V) {
; SSE-LABEL: test_v2i64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2i64:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x i64>, <2 x i64>* %V, align 16
  ret <2 x i64> %0
}

define <16 x i8> @test_v16i8_unaligned(<16 x i8>* %V) {
; SSE-LABEL: test_v16i8_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqu (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i8_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <16 x i8>, <16 x i8>* %V, align 4
  ret <16 x i8> %0
}

define <8 x i16> @test_v8i16_unaligned(<8 x i16>* %V) {
; SSE-LABEL: test_v8i16_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqu (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i16_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i16>, <8 x i16>* %V, align 4
  ret <8 x i16> %0
}

define <4 x i32> @test_v4i32_unaligned(<4 x i32>* %V) {
; SSE-LABEL: test_v4i32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqu (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i32_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x i32>, <4 x i32>* %V, align 4
  ret <4 x i32> %0
}

define <2 x i64> @test_v2i64_unaligned(<2 x i64>* %V) {
; SSE-LABEL: test_v2i64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqu (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2i64_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x i64>, <2 x i64>* %V, align 4
  ret <2 x i64> %0
}

define <4 x float> @test_v4f32(<4 x float>* %V) {
; SSE-LABEL: test_v4f32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x float>, <4 x float>* %V, align 16
  ret <4 x float> %0
}

define <2 x double> @test_v2f64(<2 x double>* %V) {
; SSE-LABEL: test_v2f64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f64:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x double>, <2 x double>* %V, align 16
  ret <2 x double> %0
}

define <4 x float> @test_v4f32_unaligned(<4 x float>* %V) {
; SSE-LABEL: test_v4f32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f32_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovups (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x float>, <4 x float>* %V, align 4
  ret <4 x float> %0
}

define <2 x double> @test_v2f64_unaligned(<2 x double>* %V) {
; SSE-LABEL: test_v2f64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movupd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f64_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovupd (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x double>, <2 x double>* %V, align 4
  ret <2 x double> %0
}

define <16 x i8> @test_v16i8_abi_alignment(<16 x i8>* %V) {
; SSE-LABEL: test_v16i8_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i8_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <16 x i8>, <16 x i8>* %V
  ret <16 x i8> %0
}

define <8 x i16> @test_v8i16_abi_alignment(<8 x i16>* %V) {
; SSE-LABEL: test_v8i16_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i16_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i16>, <8 x i16>* %V
  ret <8 x i16> %0
}

define <4 x i32> @test_v4i32_abi_alignment(<4 x i32>* %V) {
; SSE-LABEL: test_v4i32_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i32_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x i32>, <4 x i32>* %V
  ret <4 x i32> %0
}

define <2 x i64> @test_v2i64_abi_alignment(<2 x i64>* %V) {
; SSE-LABEL: test_v2i64_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2i64_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x i64>, <2 x i64>* %V
  ret <2 x i64> %0
}

define <4 x float> @test_v4f32_abi_alignment(<4 x float>* %V) {
; SSE-LABEL: test_v4f32_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f32_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x float>, <4 x float>* %V
  ret <4 x float> %0
}

define <2 x double> @test_v2f64_abi_alignment(<2 x double>* %V) {
; SSE-LABEL: test_v2f64_abi_alignment:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f64_abi_alignment:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %0 = load <2 x double>, <2 x double>* %V
  ret <2 x double> %0
}

define <32 x i8> @test_v32i8(<32 x i8>* %V) {
; SSE-LABEL: test_v32i8:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v32i8:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <32 x i8>, <32 x i8>* %V, align 32
  ret <32 x i8> %0
}

define <16 x i16> @test_v16i16(<16 x i16>* %V) {
; SSE-LABEL: test_v16i16:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i16:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <16 x i16>, <16 x i16>* %V, align 32
  ret <16 x i16> %0
}

define <8 x i32> @test_v8i32(<8 x i32>* %V) {
; SSE-LABEL: test_v8i32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i32>, <8 x i32>* %V, align 32
  ret <8 x i32> %0
}

define <4 x i64> @test_v4i64(<4 x i64>* %V) {
; SSE-LABEL: test_v4i64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i64:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqa (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x i64>, <4 x i64>* %V, align 32
  ret <4 x i64> %0
}

define <32 x i8> @test_v32i8_unaligned(<32 x i8>* %V) {
; SSE-LABEL: test_v32i8_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v32i8_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <32 x i8>, <32 x i8>* %V, align 4
  ret <32 x i8> %0
}

define <16 x i16> @test_v16i16_unaligned(<16 x i16>* %V) {
; SSE-LABEL: test_v16i16_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i16_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <16 x i16>, <16 x i16>* %V, align 4
  ret <16 x i16> %0
}

define <8 x i32> @test_v8i32_unaligned(<8 x i32>* %V) {
; SSE-LABEL: test_v8i32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i32_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i32>, <8 x i32>* %V, align 4
  ret <8 x i32> %0
}

define <4 x i64> @test_v4i64_unaligned(<4 x i64>* %V) {
; SSE-LABEL: test_v4i64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i64_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovdqu (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x i64>, <4 x i64>* %V, align 4
  ret <4 x i64> %0
}

define <8 x float> @test_v8f32(<8 x float>* %V) {
; SSE-LABEL: test_v8f32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8f32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovaps (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x float>, <8 x float>* %V, align 32
  ret <8 x float> %0
}

define <4 x double> @test_v4f64(<4 x double>* %V) {
; SSE-LABEL: test_v4f64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    movapd 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f64:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovapd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x double>, <4 x double>* %V, align 32
  ret <4 x double> %0
}

define <8 x float> @test_v8f32_unaligned(<8 x float>* %V) {
; SSE-LABEL: test_v8f32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8f32_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovups (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x float>, <8 x float>* %V, align 4
  ret <8 x float> %0
}

define <4 x double> @test_v4f64_unaligned(<4 x double>* %V) {
; SSE-LABEL: test_v4f64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movupd (%rdi), %xmm0
; SSE-NEXT:    movupd 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f64_unaligned:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovupd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <4 x double>, <4 x double>* %V, align 4
  ret <4 x double> %0
}

define <64 x i8> @test_v64i8(<64 x i8>* %V) {
; SSE-LABEL: test_v64i8:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    movaps 32(%rdi), %xmm2
; SSE-NEXT:    movaps 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v64i8:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovaps (%rdi), %ymm0
; AVXONLY-NEXT:    vmovaps 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v64i8:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <64 x i8>, <64 x i8>* %V, align 64
  ret <64 x i8> %0
}

define <32 x i16> @test_v32i16(<32 x i16>* %V) {
; SSE-LABEL: test_v32i16:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    movaps 32(%rdi), %xmm2
; SSE-NEXT:    movaps 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v32i16:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovaps (%rdi), %ymm0
; AVXONLY-NEXT:    vmovaps 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v32i16:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <32 x i16>, <32 x i16>* %V, align 64
  ret <32 x i16> %0
}

define <16 x i32> @test_v16i32(<16 x i32>* %V) {
; SSE-LABEL: test_v16i32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    movaps 32(%rdi), %xmm2
; SSE-NEXT:    movaps 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v16i32:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovaps (%rdi), %ymm0
; AVXONLY-NEXT:    vmovaps 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v16i32:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <16 x i32>, <16 x i32>* %V, align 64
  ret <16 x i32> %0
}

define <8 x i64> @test_v8i64(<8 x i64>* %V) {
; SSE-LABEL: test_v8i64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    movaps 32(%rdi), %xmm2
; SSE-NEXT:    movaps 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v8i64:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovaps (%rdi), %ymm0
; AVXONLY-NEXT:    vmovaps 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v8i64:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <8 x i64>, <8 x i64>* %V, align 64
  ret <8 x i64> %0
}

define <64 x i8> @test_v64i8_unaligned(<64 x i8>* %V) {
; SSE-LABEL: test_v64i8_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    movups 32(%rdi), %xmm2
; SSE-NEXT:    movups 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v64i8_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovups (%rdi), %ymm0
; AVXONLY-NEXT:    vmovups 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v64i8_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <64 x i8>, <64 x i8>* %V, align 4
  ret <64 x i8> %0
}

define <32 x i16> @test_v32i16_unaligned(<32 x i16>* %V) {
; SSE-LABEL: test_v32i16_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    movups 32(%rdi), %xmm2
; SSE-NEXT:    movups 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v32i16_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovups (%rdi), %ymm0
; AVXONLY-NEXT:    vmovups 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v32i16_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <32 x i16>, <32 x i16>* %V, align 4
  ret <32 x i16> %0
}

define <16 x i32> @test_v16i32_unaligned(<16 x i32>* %V) {
; SSE-LABEL: test_v16i32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    movups 32(%rdi), %xmm2
; SSE-NEXT:    movups 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v16i32_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovups (%rdi), %ymm0
; AVXONLY-NEXT:    vmovups 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v16i32_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <16 x i32>, <16 x i32>* %V, align 4
  ret <16 x i32> %0
}

define <8 x i64> @test_v8i64_unaligned(<8 x i64>* %V) {
; SSE-LABEL: test_v8i64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    movups 32(%rdi), %xmm2
; SSE-NEXT:    movups 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v8i64_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovups (%rdi), %ymm0
; AVXONLY-NEXT:    vmovups 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v8i64_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <8 x i64>, <8 x i64>* %V, align 4
  ret <8 x i64> %0
}

define <8 x float> @test_v16f32(<8 x float>* %V) {
; SSE-LABEL: test_v16f32:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16f32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovaps (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %0 = load <8 x float>, <8 x float>* %V, align 64
  ret <8 x float> %0
}

define <8 x double> @test_v8f64(<8 x double>* %V) {
; SSE-LABEL: test_v8f64:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    movapd 16(%rdi), %xmm1
; SSE-NEXT:    movapd 32(%rdi), %xmm2
; SSE-NEXT:    movapd 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v8f64:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovapd (%rdi), %ymm0
; AVXONLY-NEXT:    vmovapd 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v8f64:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovapd (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <8 x double>, <8 x double>* %V, align 64
  ret <8 x double> %0
}

define <16 x float> @test_v16f32_unaligned(<16 x float>* %V) {
; SSE-LABEL: test_v16f32_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups 16(%rdi), %xmm1
; SSE-NEXT:    movups 32(%rdi), %xmm2
; SSE-NEXT:    movups 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v16f32_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovups (%rdi), %ymm0
; AVXONLY-NEXT:    vmovups 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v16f32_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovups (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <16 x float>, <16 x float>* %V, align 4
  ret <16 x float> %0
}

define <8 x double> @test_v8f64_unaligned(<8 x double>* %V) {
; SSE-LABEL: test_v8f64_unaligned:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movupd (%rdi), %xmm0
; SSE-NEXT:    movupd 16(%rdi), %xmm1
; SSE-NEXT:    movupd 32(%rdi), %xmm2
; SSE-NEXT:    movupd 48(%rdi), %xmm3
; SSE-NEXT:    retq
;
; AVXONLY-LABEL: test_v8f64_unaligned:
; AVXONLY:       # %bb.0: # %entry
; AVXONLY-NEXT:    vmovupd (%rdi), %ymm0
; AVXONLY-NEXT:    vmovupd 32(%rdi), %ymm1
; AVXONLY-NEXT:    retq
;
; AVX512-LABEL: test_v8f64_unaligned:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovupd (%rdi), %zmm0
; AVX512-NEXT:    retq
entry:
  %0 = load <8 x double>, <8 x double>* %V, align 4
  ret <8 x double> %0
}

