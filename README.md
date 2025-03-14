# **PolCalc: A Polynomial Calculator Built with Flutter**

## 📌 **Overview**
PolCalc is a **Flutter-based polynomial calculator** designed for efficient algebraic operations, including computations in **finite fields (GF(q))**. It supports various polynomial operations and provides a clean, interactive user experience.

## 🚀 **Features**
- **Polynomial Arithmetic** – Addition, subtraction, multiplication, and division
- **Efficient Evaluation** – Uses **Horner’s Method** for fast polynomial evaluation
- **Derivative & Irreducibility Tests** – Formal differentiation and polynomial analysis
- **Finite Field Arithmetic** – Supports operations in **GF(p)** for cryptographic applications
- **Modern UI** – Dark Mode, smooth animations, and a typewriter-style splash screen

## 🔧 **Installation**
### **1. Clone the Repository**
```sh
git clone https://github.com/Khaymat/polcalc.git
cd polcalc
```

### **2. Install Dependencies**
```sh
flutter pub get
```

### **3. Run the App**
```sh
flutter run
```

## 🛠 **How It Works**
### **Polynomial Arithmetic**
PolCalc performs addition and subtraction by aligning terms based on their degrees and combining coefficients. Multiplication follows the distributive property, and division is handled using **long division**.

**Addition & Subtraction Formula:**
```
(P ± Q)(x) = (a_n ± b_n)x^n + (a_{n-1} ± b_{n-1})x^{n-1} + ... + (a_1 ± b_1)x + (a_0 ± b_0)
```

**Multiplication Formula:**
```
(P ⋅ Q)(x) = Σ (a_i ⋅ b_j)x^{i+j}
```

**Division Formula:**
```
P(x) / D(x) = Q(x) + R(x) / D(x)
```

where:
- `P(x)` is the dividend,
- `D(x)` is the divisor,
- `Q(x)` is the quotient,
- `R(x)` is the remainder.

### **Efficient Polynomial Evaluation**
Instead of direct substitution, PolCalc uses **Horner’s Method**, reducing computational complexity from **O(n²) to O(n)**.

**Horner’s Method Formula:**
```
P(x) = (((a_n x + a_{n-1}) x + a_{n-2}) x + ... + a_1) x + a_0
```

### **Derivative & Irreducibility Tests**
The calculator supports **formal differentiation** and **irreducibility tests**, crucial in cryptography and coding theory.

**Derivative Formula:**
```
d/dx (a_nx^n) = n a_n x^{n-1}
```

## 📲 **Download APK**
📥 **Download APK**: [Click Here](https://drive.google.com/uc?export=download&id=1TjMrRI_CbTyrd0ZwP8Ln07ExxcehISJ2)

## 🔜 **Future Plans**
- Implement **polynomial factorization over GF(q)**
- Optimize multiplication using **Fast Fourier Transform (FFT)**
- Add **graphing support** for polynomial visualization

## 📝 **License**
This project is licensed under the **Apache License 2.0 with Attribution Requirement** – see the [LICENSE](LICENSE) file for details.

## 🤝 **Contributing**
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to modify.

## 🔗 **Connect with Me**
- **GitHub:** [Khaymat](https://github.com/Khaymat)
- **LinkedIn:** [Rafi Khairan](https://www.linkedin.com/in/rafikhairan/) 
