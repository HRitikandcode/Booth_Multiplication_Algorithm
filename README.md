# Booth_Multiplication_Algorithm
Booth Algorithm Multiplier (Verilog HDL) This repository contains a parameterized and synthesizable Verilog implementation of the Booth multiplication algorithm for signed numbers. The design supports configurable bit width, handles two’s complement arithmetic, and uses a clocked sequential approach suitable for FPGA and ASIC design


# Booth Algorithm Multiplier – Verilog HDL

## 📌 Overview
This project implements the **Booth multiplication algorithm** using **Verilog HDL**.  
Booth’s algorithm is an efficient technique for multiplying **signed binary numbers** in two’s complement representation. It reduces the number of addition and subtraction operations compared to conventional multiplication methods.

The design is:
- Parameterized (configurable bit width)
- Fully synthesizable
- Suitable for FPGA / ASIC implementation
- Based on sequential logic with clock and reset

---

## ✨ Features
- Signed multiplication support
- Parameterized data width (`N`)
- Clocked sequential design
- Arithmetic right shifting
- Start/Done control signals
- Two’s complement arithmetic

---

## 🧠 Booth Algorithm – Concept

Booth’s algorithm examines **two bits at a time**:
- The current LSB of the multiplier (`Q[0]`)
- An extra bit (`Q-1`) representing the previous LSB

Based on these two bits, the algorithm decides whether to:
- Add the multiplicand
- Subtract the multiplicand
- Do nothing

This reduces unnecessary operations, especially when the multiplier contains consecutive 1s.

---

## 🔢 Booth Encoding Rules

| Q[0] | Q-1 | Operation        |
|-----|-----|------------------|
| 0   | 0   | No operation     |
| 0   | 1   | Add multiplicand|
| 1   | 0   | Subtract multiplicand |
| 1   | 1   | No operation     |

---

## 🏗️ Internal Registers

| Register | Description |
|--------|-------------|
| `A` | Accumulator (partial sum) |
| `Q` | Multiplier |
| `M` | Multiplicand |
| `Q_1` | Extra bit (previous LSB of Q) |
| `count` | Iteration counter |

---

## 🔄 Algorithm Steps (Detailed)

### Step 1: Initialization
- Clear accumulator `A = 0`
- Load multiplier into `Q`
- Load multiplicand into `M`
- Set `Q_1 = 0`
- Set iteration count = `N`

---

### Step 2: Booth Decision
At each clock cycle:
- Check `{Q[0], Q_1}`
- Perform:
  - `A = A + M` if `01`
  - `A = A - M` if `10`
  - No operation if `00` or `11`

---

### Step 3: Arithmetic Right Shift
Perform an arithmetic right shift on the combined register `{A, Q, Q_1}`:
- MSB of `A` is preserved (sign extension)
- LSB of `A` shifts into MSB of `Q`
- LSB of `Q` shifts into `Q_1`

This preserves the sign of the partial result.

---

### Step 4: Iteration
- Decrement the counter
- Repeat Steps 2 and 3 until `count = 0`

---

### Step 5: Result
- Concatenate `{A, Q}` to form the final product
- Assert `done` signal




