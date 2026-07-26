# 2026.8.0 Release Notes

2026.8.0 is a minor release: Unix shared libraries, mixed-parameter HSS, a ChaCha SIMD correctness fix, and input-validation hardening across BLAKE3, AEAD, and PBKDF.

* Fix ChaCha counter carry in the NEON, SSE2, and Altivec backends. The keystream was wrong when the 32-bit block counter overflowed inside a multi-block request (weidai11/cryptopp#1362, fixed upstream via weidai11/cryptopp#1363).
* Add Unix shared-library builds; the SONAME starts an independent ABI series at `libcryptopp.so.9` (#48).
* Add mixed-parameter HSS: per-level LMS/LM-OTS parameters, `HSS_SHA256_H10W4_H5W8_L2`, LM-OTS W1/W2/W4, verified against RFC 8554 Appendix F Test Case 2 (#56).
* Validate BLAKE3 public inputs at runtime: invalid keys, KDF contexts, digest sizes, and truncation sizes throw; keyed-mode `MIN_KEYLENGTH` now correctly advertises 32; `AlgorithmProvider` no longer reports NEON on ARM (#57).
* Reject zero-length AEAD authentication tags (#58; weidai11/cryptopp#1364).
* Reject zero PBKDF iterations without a positive time budget (#59; weidai11/cryptopp#1366).
* Fix MSVC MASM object paths under CMake and add Windows ARM64 CI coverage (#43).
* Fix variable collisions in `setenv-ios.sh`.

## Upgrade notes

* Direct `HSS_Params<LMS, OTS, LEVELS>` users must migrate to the new variadic `HSS_Params<HSSLevel<...>, ...>` form. The `LMSParameters` and `OTSParameters` aliases were replaced by `LMSParamsAt<I>` and `OTSParamsAt<I>`. The named `HSS_*` typedefs, existing wire formats, key encodings, and state files are unchanged.
* BLAKE3 keyed mode now advertises and enforces its 32-byte key requirement (`MIN_KEYLENGTH` was incorrectly 0). Invalid keys, KDF contexts, digest sizes, and truncation sizes now throw in release builds.
* Zero-length AEAD tags now throw during finalisation. The one-shot APIs may have written output before the exception; callers must discard that output.
* First release with Unix shared libraries. The SONAME ABI series is independent of the calendar version and starts at `libcryptopp.so.9`.
