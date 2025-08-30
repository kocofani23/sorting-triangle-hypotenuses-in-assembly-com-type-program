# Classifying Right Triangles Based on Hypotenuse Lengths (Assembly)

This project was developed as a **COM-type Assembly (ASM)** program. It aims to calculate the hypotenuse lengths of all possible right triangles with integer side lengths between 1 and 50 and classify them according to certain conditions.

## 📌 Assignment Description
The program calculates the hypotenuse `c` for each integer pair (a, b):

\[
c^2 = a^2 + b^2
\]

and then performs the following checks:

1. **Condition 1:** Is hypotenuse `c` prime?

2. **Condition 2:** Is the sum of the legs `(a + b)` even?

### Classifying Results
- Hypotenuses that meet both conditions are added to the `primeEvenSum` array.
- Hypotenuses that do not meet at least one condition are added to the array → `nonPrimeOrOddSum`.

👉 Only these two arrays are used, and the array size is limited to a maximum of 15**.

---

## 🛠️ Technical Details
- **Program Type:** Assembly (ASM) in COM format.
- **Range:** 1 ≤ a, b ≤ 50.
- **Hypotenuse Limit:** If `c > 50` → the triangle is considered invalid and is skipped.
- **Primality Check:** If `c` is not prime → `nonPrimeOrOddSum`.
- **Side Sum Check:** If `(a + b)` is odd → `nonPrimeOrOddSum`.
- **If both conditions are met:** `primeEvenSum`.

The program automatically terminates after all possible triangle combinations have been examined.

---

## 📊 Data Structure
- `primeEvenSum` → array storing the hypotenuse values ​​(maximum 15 elements).
- `nonPrimeOrOddSum` → array storing the hypotenuse values ​​(maximum 15 elements).

---

## 🚀 Execution
1. Write the `.asm` file and compile it with an assembler such as NASM/TASM/MASM.
2. Generate the COM output.
3. When the program is run, the hypotenuse values ​​are automatically calculated and classified into the relevant arrays.

---

## ✅ Summary
This ASM program:
- Tries all integer combinations of vertical sides between 1–50.
- Calculates the hypotenuses (`c^2 = a^2 + b^2`).
- Checks for primality and even sum conditions.

- Stores results in `primeEvenSum` or `nonPrimeOrOddSum` arrays.

- Automatically terminates when the operation is complete.

---
