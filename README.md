# AES-128 Iterative Encryption & Decryption Core

A fully synthesizable **AES-128 Encryption and Decryption Core** implemented in **Verilog HDL** using an **iterative architecture**. The design performs one AES round per clock cycle, providing a hardware-efficient implementation while maintaining compliance with the AES-128 specification defined in **FIPS-197**.

The project includes complete implementations of both encryption and decryption datapaths, on-the-fly key expansion, finite state machine (FSM) based control logic, and individual verification of every AES transformation before full-system integration.

---

# Features

* Fully synthesizable Verilog implementation
* AES-128 Encryption
* AES-128 Decryption
* Iterative architecture (one round per clock cycle)
* FSM-based control unit
* On-the-fly AES-128 Key Expansion
* Complete inverse transformations for decryption
* Modular RTL design
* Individual testbenches for each AES transformation
* Full-system verification using standard AES-128 test vectors

---

# AES Algorithm

AES-128 operates on a 128-bit data block using a 128-bit secret key.

### Encryption Flow

```text
Plaintext
    │
AddRoundKey
    │
──────────────────────────────
9 Rounds
──────────────────────────────
SubBytes
ShiftRows
MixColumns
AddRoundKey
    │
──────────────────────────────
Final Round
──────────────────────────────
SubBytes
ShiftRows
AddRoundKey
    │
Ciphertext
```

---

### Decryption Flow

```text
Ciphertext
    │
AddRoundKey
    │
──────────────────────────────
9 Rounds
──────────────────────────────
InvShiftRows
InvSubBytes
AddRoundKey
InvMixColumns
    │
──────────────────────────────
Final Round
──────────────────────────────
InvShiftRows
InvSubBytes
AddRoundKey
    │
Plaintext
```

---

# Project Structure

```text
AES_128_Iterative/
│
├── Encryption/
│   ├── aes_iterative_encrypt.v
│   ├── aes_round_encrypt.v
│   ├── final_round_encrypt.v
│   ├── keyExpansion.v
│   ├── sub_box.v
│   ├── subBytes.v
│   ├── shiftRow.v
│   ├── mixColumn.v
│   └── addRoundKey.v
│
├── Decryption/
│   ├── aes_iterative_decrypt.v
│   ├── aes_round_decrypt.v
│   ├── final_round_decrypt.v
│   ├── inv_keyExpansion.v
│   ├── inv_sub_box.v
│   ├── inv_subBytes.v
│   ├── inv_shiftRow.v
│   ├── inv_mixColumn.v
│   └── addRoundKey.v
│
├── Memory/
│   ├── s_box.mem
│   └── inv_s_box.mem
│
├── Testbenches/
│   ├── tb_encrypt.v
│   ├── tb_decrypt.v
│   ├── tb_mixColumn.v
│   ├── tb_inv_mixColumn.v
│   ├── tb_shiftRow.v
│   ├── tb_inv_shiftRow.v
│   ├── tb_subBytes.v
│   └── tb_inv_subBytes.v
│
└── README.md
```

---

# Design Overview

The implementation follows an **iterative architecture**, where a single AES round hardware block is reused across multiple clock cycles.

Instead of instantiating ten separate AES rounds, the design stores the intermediate state in registers and repeatedly processes it through the same round logic under FSM control. This significantly reduces hardware utilization while preserving functional correctness.

Each encryption or decryption operation progresses through:

* Idle
* Initialization
* Nine Iterative Rounds
* Final Round
* Finish

This approach offers an excellent trade-off between area and throughput, making it suitable for FPGA implementations where logic resources are limited.

---

# Major Modules

## Encryption

* Key Expansion
* SubBytes
* ShiftRows
* MixColumns
* AddRoundKey
* AES Round
* Final AES Round
* Iterative Encryption Wrapper

---

## Decryption

* Inverse Key Expansion
* Inverse SubBytes
* Inverse ShiftRows
* Inverse MixColumns
* AddRoundKey
* AES Inverse Round
* Final Inverse Round
* Iterative Decryption Wrapper

---

# Finite State Machine

```text
        +------+
        | Idle |
        +------+
            |
         start
            |
            v
      +-----------+
      | Initialize|
      +-----------+
            |
            v
      +-----------+
      |  Rounds   |
      +-----------+
            |
     Round Count
            |
            v
      +-----------+
      |Final Round|
      +-----------+
            |
            v
      +-----------+
      |  Finish   |
      +-----------+
            |
            v
          Idle
```

---

# Verification

Every AES transformation was verified independently before integration.

The complete encryption and decryption cores were validated using standard AES-128 Known Answer Tests (KATs) from FIPS-197/NIST.

Example test vector:

| Parameter  | Value                              |
| ---------- | ---------------------------------- |
| Key        | `000102030405060708090A0B0C0D0E0F` |
| Plaintext  | `00112233445566778899AABBCCDDEEFF` |
| Ciphertext | `69C4E0D86A7B0430D8CDB78070B4C55A` |

The implementation successfully reproduces the expected ciphertext during encryption and the original plaintext during decryption.

---

# Synthesis

The RTL is written using synthesizable Verilog constructs and is suitable for FPGA synthesis using tools such as:

* Xilinx Vivado
* Intel Quartus
* Synopsys Design Compiler (ASIC flow)

---

# Learning Outcomes

This project demonstrates practical experience with:

* RTL Design
* Verilog HDL
* AES-128 Cryptographic Algorithm
* FSM Design
* Sequential and Combinational Logic
* Resource-Efficient Hardware Architectures
* On-the-Fly Key Expansion
* Functional Verification
* Testbench Development
* FPGA-Oriented Digital Design
* RTL Debugging
* Hardware Timing Concepts

---

# Future Improvements

Potential enhancements include:

* Fully Unrolled AES Architecture
* Partially Unrolled AES Architecture
* Pipelined AES Core
* CBC, CTR, and GCM operating modes
* AXI4-Lite/APB Interface
* DMA Integration
* FPGA implementation with timing and resource analysis

---

# Author

**Sai Shubham Biswal**

If you find this project useful, feel free to fork the repository or use it as a reference for learning RTL design and hardware cryptography.
