# 2026.8.1 Release Notes

2026.8.1 is a patch release focused on BLAKE3 multi-chunk hashing correctness.

**Upgrade note:** BLAKE3 digests of messages longer than 1024 bytes produced by releases from 2025.11.0 through 2026.8.0 may be incorrect. Users with stored BLAKE3 digests should review the affected ranges below and recompute affected values after upgrading.

* Fix three defects in BLAKE3 multi-chunk hashing (#65). Parent chaining values were serialised in native byte order, so digests of messages longer than 1024 bytes were wrong on big-endian targets. Partial final blocks were not zero padded, so those digests could depend on uninitialised stack contents on any architecture. The SSE4.1, AVX2, and AVX512 paths could also read outside the chaining-value stack for single-call `Update` lengths at power-of-two chunk counts.
* Reject invalid DEFLATE HLIT values. A malformed stream could trigger an out-of-bounds write in the inflator (#67; weidai11/cryptopp#1368, fixed upstream via weidai11/cryptopp#1371). Upstream's follow-up hardening is mirrored for parity (#70).
* Fix `cryptest` `dynamic_cast` failures against shared-library builds with hidden visibility, seen on FreeBSD with Clang and libc++ (#64).

## Upgrade notes

* BLAKE3 digests of messages longer than 1024 bytes produced by earlier releases may be incorrect:
  * On big-endian platforms, all such digests from 2025.11.0 through 2026.8.0 are affected.
  * On every platform, the partial-block defect affects message lengths that are not multiples of 64.
  * On x86 builds using the SSE4.1, AVX2, or AVX512 paths, single-call `Update` lengths of 4096, 8192, and larger power-of-two byte lengths may hit the out-of-bounds read. This applies from 2025.12.0 through 2026.8.0.
* Stored digests from affected builds should be recomputed.
* These BLAKE3 defects do not affect messages up to 1024 bytes or any other algorithm.
* No API or ABI changes. The shared-library SONAME remains `libcryptopp.so.9`.
