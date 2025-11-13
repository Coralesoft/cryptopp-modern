# cryptopp-modern Development Roadmap

**Current Version:** 2025.11.0

---

## Vision

**cryptopp-modern** is an actively maintained, modernized fork of Crypto++ featuring:
- Modern cryptographic algorithms (BLAKE3, Argon2, post-quantum)
- Better code organization and structure
- Comprehensive documentation
- Active development and community engagement
- Calendar versioning for clarity

---

## Phase 1: Foundation ✅ COMPLETE

**Goal:** Establish working fork with essential modern algorithms

### Completed
- ✅ **BLAKE3 Cryptographic Hash** - Modern, fast hash function
- ✅ **Argon2 Password Hashing** - RFC 9106 (Argon2d, Argon2i, Argon2id)
- ✅ **Calendar Versioning** - Clear release dates (YEAR.MONTH.INCREMENT)
- ✅ **Security Patches** - Marvin attack fix (CVE-2022-4304), ESIGN improvements
- ✅ **Repository Setup** - GitHub repository with documentation
- ✅ **Build System** - Working GNUmakefile builds

**Release:** v2025.11.0

---

## Phase 2: Organization 📋 PLANNED

**Goal:** Modernize project structure for better navigation

### Planned
- 📁 Reorganize headers into categories
  - `include/cryptopp/hash/` - Hash functions
  - `include/cryptopp/kdf/` - Key derivation
  - `include/cryptopp/symmetric/` - Block/stream ciphers
  - `include/cryptopp/pubkey/` - Public key cryptography
  - `include/cryptopp/mac/` - Message authentication
  - `include/cryptopp/modes/` - Cipher modes
- 📁 Move implementations to `src/` with matching structure
- 🔧 Update include paths throughout codebase
- 📝 Maintain compatibility headers for drop-in replacement
- ✅ Verify all tests still pass after restructure

---

## Phase 3: CMake Build System 📋 PLANNED

**Goal:** Add CMake alongside existing build system

### Planned
- 🔨 Add modern CMakeLists.txt (CMake 3.15+)
- 📦 Proper target exports and find_package support
- 🔧 Install rules and package configuration
- 📊 CMake presets for common configurations
- ⚙️ Continue maintaining GNUmakefile

**Note:** Both CMake and GNUmakefile will be maintained as build options.

---

## Phase 4: Documentation 📋 PLANNED

**Goal:** Comprehensive, modern documentation site

### Planned
- 🌐 Documentation website (MkDocs Material or Docusaurus)
- 📖 Getting started guide
- 📋 Algorithm reference by category
- 💡 Code examples for every algorithm
- 🔄 Migration guide from Crypto++ 8.9.0
- 🔍 API reference (Doxygen integration)
- 🚀 Publish to Pages

---


## Phase 5: CI/CD & Quality 📋 PLANNED

**Goal:** Automated testing and quality assurance

### Planned
- 🔄 **GitHub Actions Workflows**
  - Multi-platform builds (Windows, Linux, macOS)
  - Multiple compilers (GCC, Clang, MSVC)
- 🛡️ **Security Testing**
  - Address Sanitizer (ASan)
  - UndefinedBehavior Sanitizer (UBSan)
  - Memory Sanitizer (MSan)
- 📊 **Code Quality**
  - Static analysis (clang-tidy, cppcheck)
  - Code coverage reporting
  - Benchmark tracking


---

## Contributing

We welcome contributions in these areas:

- 🐛 **Bug Reports** - Find and report issues
- ✨ **New Algorithms** - Implement modern crypto algorithms
- 📚 **Documentation** - Improve docs and examples
- 🧪 **Testing** - Add tests and test vectors
- 🔧 **Build System** - Improve CMake and cross-platform support
- 📦 **Packaging** - Help with package manager integration

See [FORK.md](FORK.md) for project details and direction.

---

## Version History

### 2025.11.0 (November 2025) - Foundation Release
- 🎉 First release with calendar versioning
- ✨ Added BLAKE3 cryptographic hash
- ✨ Added Argon2 password hashing (d/i/id variants)
- 🔒 Fixed Marvin attack (CVE-2022-4304)
- 🔒 Improved ESIGN static analyzer compatibility

---

## Questions or Suggestions?

- **GitHub Issues:** [Report bugs or request features](https://github.com/Coralesoft/cryptopp-modern/issues)
- **GitHub Discussions:** [Ask questions or discuss ideas](https://github.com/Coralesoft/cryptopp-modern/discussions)

---

**Maintained By:** [CoraleSoft](https://github.com/Coralesoft)
