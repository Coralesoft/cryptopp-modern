# 2026.9.0 Release Notes

2026.9.0 is a minor release adding RFC 9802 LMS public-key encoding and hardening PQC key handling, with fixes for OAEP, state-file durability, packaging and compiler warnings.

* Encode standalone LMS public keys in the RFC 9802 SubjectPublicKeyInfo form while continuing to accept keys written by earlier releases. Add HSS L=1 parameter sets (#75).
* Leave ML-KEM, ML-DSA, SLH-DSA, LMS and HSS keys unchanged when BER decoding fails, reject encoding unset keys, and leave ML-KEM keys unchanged if generation fails partway (#83, #84).
* Reject undersized OAEP blocks before unpadding (#72; weidai11/cryptopp#1370).
* Flush the parent directory when `FileStateStore` creates a state file on POSIX systems (#78).
* Add `CRYPTOPP_INSTALL_CRYPTEST` and support absolute CMake install directories in pkg-config output (#76, #77).
* Fix C++20 enum arithmetic warnings, BLAKE3 SIMD warnings and x86 feature-test conditions; clean up additional MSVC and Clang warnings and add ML-KEM ACVP decapsulation vectors (#74, #80, #82).
* Correct documentation that described the 2025.11.0 PKCS#1 v1.5 depadding change as fixing the Marvin attack. The change was timing hardening and did not establish resistance to the attack. See `Security.md`.

**Upgrade note:** Existing LMS public keys still load, but `LMSPublicKey::DEREncode` now writes the RFC 9802 form. Consumers that compare encoded keys byte for byte should re-export their stored copies. Applications relying on the new unset-key guards must rebuild against the 2026.9.0 headers. `GetSeedBytePtr()` and `GetIdentifierBytePtr()` return NULL until an LMS or HSS private key is set.

There is no ABI series change. The shared-library SONAME remains `libcryptopp.so.9`.
