# 2026.9.0 Release Notes

2026.9.0 is a minor release with one security fix, adding RFC 9802 LMS public-key encoding and hardening PQC key handling, with fixes for OAEP, state-file durability, packaging and compiler warnings.

**Security note:** PKCS#1 v1.5 decryption could write up to nine attacker-influenced bytes past the end of the output buffer for a malformed ciphertext. Affects every release from 2025.11.0 through 2026.8.1; upstream Crypto++ is not affected. Applications that decrypt untrusted PKCS#1 v1.5 ciphertexts should upgrade. Details in GHSA-9g8r-h7q5-x8pc; a CVE has been requested.

* Fix a heap buffer overflow in PKCS#1 v1.5 decryption of malformed ciphertexts (CVSS 3.1 5.3, GHSA-9g8r-h7q5-x8pc). `PKCS_EncryptionPaddingScheme::Unpad` did not bound the recovered-message copy by the caller's buffer, so a malformed block could write up to nine bytes past the output buffer through the ordinary `RSAES<PKCS1v15>::Decryptor::Decrypt` path.
* Reject undersized PKCS#1 v1.5 encryption blocks before unpadding.
* Encode standalone LMS public keys in the RFC 9802 SubjectPublicKeyInfo form while continuing to accept keys written by earlier releases. Add HSS L=1 parameter sets (#75).
* Leave ML-KEM, ML-DSA, SLH-DSA, LMS and HSS keys unchanged when BER decoding fails, reject encoding unset keys, and leave ML-KEM keys unchanged if generation fails partway (#83, #84).
* Reject undersized OAEP blocks before unpadding (#72; weidai11/cryptopp#1370).
* Flush the parent directory when `FileStateStore` creates a state file on POSIX systems (#78).
* Add `CRYPTOPP_INSTALL_CRYPTEST` and support absolute CMake install directories in pkg-config output (#76, #77).
* Fix C++20 enum arithmetic warnings, BLAKE3 SIMD warnings and x86 feature-test conditions; clean up additional MSVC and Clang warnings and add ML-KEM ACVP decapsulation vectors (#74, #80, #82).

**Upgrade note:** The PKCS#1 v1.5 fix requires no API change; rebuild and redeploy. Applications that decrypt PKCS#1 v1.5 ciphertexts from untrusted sources should upgrade, and where protocol compatibility permits, prefer RSA-OAEP. Existing LMS public keys still load, but `LMSPublicKey::DEREncode` now writes the RFC 9802 form. Consumers that compare encoded keys byte for byte should re-export their stored copies. Applications relying on the new unset-key guards must rebuild against the 2026.9.0 headers. `GetSeedBytePtr()` and `GetIdentifierBytePtr()` return NULL until an LMS or HSS private key is set.

There is no ABI series change. The shared-library SONAME remains `libcryptopp.so.9`.
