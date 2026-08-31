# cryptopp-modern

**A maintained, modernized fork of Crypto++ with new algorithms and security improvements**

[![Version](https://img.shields.io/badge/version-2026.8.1-blue.svg)](https://github.com/cryptopp-modern/cryptopp-modern/releases)
[![License](https://img.shields.io/badge/license-Boost-green.svg)](LICENSE)

---

## Overview

**Website:** [cryptopp-modern.com](https://cryptopp-modern.com)

**cryptopp-modern** is an actively maintained fork of [Crypto++ 8.9.0](https://github.com/weidai11/cryptopp) featuring:

- **Post-Quantum Cryptography** - ML-KEM (FIPS 203), ML-DSA (FIPS 204), SLH-DSA (FIPS 205), LMS/HSS (SP 800-208), X-Wing hybrid KEM
- **BLAKE3** - Modern, fast cryptographic hash function
- **Argon2** - RFC 9106 password hashing (Argon2d, Argon2i, Argon2id)
- **Security Patches** - PKCS#1 v1.5 depadding timing hardening, fault injection fix (CVE-2024-28285), F(2^m) and Rabin/ModularSquareRoot hardening (CVE-2023-50980, CVE-2023-50981), ESIGN improvements
- **Calendar Versioning** - Clear release dates (YEAR.MONTH.INCREMENT format)
- **Active Maintenance** - Regular updates and improvements
- **Crypto++ Compatibility** - Uses the same `CryptoPP` namespace and preserves most existing APIs

---


## What's New in 2026.8.1

- **BLAKE3 multi-chunk fixes** - Parent chaining-value byte order on big-endian targets, zero padding of partial final blocks, and an out-of-bounds read in the wide hashing paths (#65). Digests over 1024 bytes from earlier releases may be incorrect; see the release notes.
- **DEFLATE HLIT rejection** - A malformed stream could trigger an out-of-bounds write in the inflator (#67, weidai11/cryptopp#1368).
- **Shared-build cryptest fix** - `dynamic_cast` failures against hidden-visibility shared builds, seen on FreeBSD with Clang and libc++ (#64).

### Previously in 2026.8.0

- **Unix shared libraries** - CMake and GNUmakefile build `libcryptopp.so`/`.dylib`; the SONAME starts an independent ABI series at `libcryptopp.so.9` (#48).
- **Mixed-parameter HSS** - Per-level LMS/LM-OTS parameters, `HSS_SHA256_H10W4_H5W8_L2`, LM-OTS W1/W2/W4 (#56). Source break for direct `HSS_Params` users; named typedefs and wire formats unchanged.
- **ChaCha SIMD fix** - Counter carry in the NEON, SSE2, and Altivec backends (weidai11/cryptopp#1362).
- **Input validation** - BLAKE3 public inputs checked at runtime (#57), zero-length AEAD tags rejected (#58), zero PBKDF iterations rejected (#59).

### Previously in 2026.7.x

- **2026.7.1 packaging** - CMake/pkg-config install locations (#47), `libcryptopp.pc` alias (#51), `.tar.gz` releases (#49), and the release-signing key (#46).
- **2026.7.0 SLH-DSA interface** - Added FIPS 205 external pure signatures. SLH-DSA signatures from 2026.3.0 through 2026.6.0 use the internal message form and are not interoperable with the external-interface format introduced in 2026.7.0.
- **Stateful-signing hardening** - Added one-time-key safety checks for LMS/HSS.

---

## Quick Build

### CMake (Recommended)

```bash
cmake --preset=default
cmake --build build/default
./build/default/cryptest.exe v
```

### GNUmakefile

```bash
make -j$(nproc)
./cryptest.exe v
```

See [CMAKE.md](CMAKE.md) or [GNUMAKEFILE.md](GNUMAKEFILE.md) for detailed build instructions.

---

## Documentation

- **[cryptopp-modern.com](https://cryptopp-modern.com)** - Full API and algorithm documentation
- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Quick start guide with code examples
- **[CMAKE.md](CMAKE.md)** - CMake build system documentation
- **[GNUMAKEFILE.md](GNUMAKEFILE.md)** - GNUmakefile build system documentation
- **[ROADMAP.md](ROADMAP.md)** - Development roadmap and future plans
- **[FORK.md](FORK.md)** - Relationship to upstream Crypto++
- **[Readme.txt](Readme.txt)** - Complete algorithm list and instructions
- **[Install.txt](Install.txt)** - Detailed installation guide
- **[LICENSE](LICENSE)** - Boost Software License 1.0

---

## Why Fork?

**Upstream Crypto++ Status:**
- Last release: 8.9.0 (October 1, 2023)
- Version encoding limitation (cannot represent 8.10.0)
- Slower development pace

**cryptopp-modern Goals:**
- Active maintenance and regular releases
- Modern algorithm support (BLAKE3, Argon2, post-quantum cryptography)
- Better code organization
- Modern CMake build system
- Calendar versioning
- Community-driven development

See [FORK.md](FORK.md) for detailed explanation.

---

## Features

### Cryptographic Algorithms

**Hash Functions:**
- SHA-2, SHA-3, BLAKE2b/s, **BLAKE3** ⭐
- MD5, RIPEMD, Tiger, Whirlpool, SipHash

**Password Hashing / KDF:**
- **Argon2 (d/i/id)** ⭐ RFC 9106
- PBKDF2, Scrypt, HKDF

**Symmetric Encryption:**
- AES, ChaCha20, Serpent, Twofish, Camellia, ARIA
- Modes: GCM, CCM, EAX, CBC, CTR, and more

**Post-Quantum Cryptography:**
- **ML-KEM** (FIPS 203) - Key encapsulation ⭐
- **ML-DSA** (FIPS 204) - Digital signatures ⭐
- **SLH-DSA** (FIPS 205) - Hash-based signatures (stateless) ⭐
- **LMS/HSS** (SP 800-208) - Hash-based signatures (stateful) ⭐
- **X-Wing** - Hybrid KEM (X25519 + ML-KEM-768) ⭐

**Public Key Cryptography:**
- RSA, DSA, ECDSA, Ed25519
- Diffie-Hellman, ECIES, ElGamal

**Message Authentication:**
- HMAC, CMAC, GMAC, Poly1305

See [Readme.txt](Readme.txt) for complete algorithm list.

---

## Migration from Crypto++ 8.9.0

**Good news:** Most code works unchanged!

### Compatible
- Most existing Crypto++ 8.9.0 algorithms and APIs
- Same `CryptoPP` namespace
- Version checks: `#if CRYPTOPP_VERSION >= N`

### Changed
- Version encoding: Now `YEAR*10000 + MONTH*100 + INCREMENT`
- Version parsing: Use `/10000` for year, `(n/100)%100` for month

**Example:**
```cpp
// Old (8.9.0)
const int major = CRYPTOPP_VERSION / 100;  // Gets 8

// New (2025.11.0)
const int year = CRYPTOPP_VERSION / 10000;  // Gets 2025
const int month = (CRYPTOPP_VERSION / 100) % 100;  // Gets 11
```

---

## Contributing

Contributions are welcome! Areas where you can help:

- Bug reports and fixes
- New algorithm implementations
- Documentation improvements
- Tests and test vectors
- Build system enhancements

If you're migrating from Crypto++ 8.9.0 and encounter any issues, please open an issue. Migration feedback is especially valuable.

Please:
1. Fork the repository
2. Create a feature branch
3. Follow existing code style
4. Add tests for new features
5. Submit a pull request

---


## License

Like the original Crypto++, this library uses:
- **Compilation:** Boost Software License 1.0
- **Individual files:** Public domain

See [LICENSE](LICENSE) for details.

---

## Contact

- **Issues:** [GitHub Issues](https://github.com/cryptopp-modern/cryptopp-modern/issues)
- **Discussions:** [GitHub Discussions](https://github.com/cryptopp-modern/cryptopp-modern/discussions)

---

## Acknowledgments

**cryptopp-modern** builds upon the excellent work of:
- **Wei Dai** - Original Crypto++ creator and maintainer
- **The Crypto++ team** - All contributors to upstream Crypto++
- **BLAKE3 team** - Modern cryptographic hash design
- **Argon2 team** - Password hashing competition winner

---

**Maintained by [CoraleSoft](https://github.com/Coralesoft)**
