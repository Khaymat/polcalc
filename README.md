
# **PolCalc: A Polynomial Calculator Built with Flutter**

## 📌 **Overview**
PolCalc is a **Flutter-based polynomial calculator** designed for efficient algebraic operations, including computations in **finite fields (GF(p))**—where p is a prime number. It supports various polynomial operations while providing a clean, interactive user experience.

## 🚀 **Features**
- **Polynomial Arithmetic** – Addition, subtraction, multiplication, and division (all performed modulo p)
- **Efficient Evaluation** – Uses **Horner’s Method** for fast polynomial evaluation (complexity 𝒪(n))
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
PolCalc performs addition and subtraction by aligning terms based on their degrees and combining coefficients. Multiplication follows the distributive property, and division is handled using **long division**, yielding both a quotient and a remainder.  
All operations are performed **modulo p** (with p being prime), which is essential for computations in GF(p).

**Addition & Subtraction Formula:**
```
(P ± Q)(x) = (aₙ ± bₙ)xⁿ + (aₙ₋₁ ± bₙ₋₁)xⁿ⁻¹ + ... + (a₁ ± b₁)x + (a₀ ± b₀)
```

**Multiplication Formula:**
```
(P ⋅ Q)(x) = Σ (aᵢ ⋅ bⱼ)x^(i+j)
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
Instead of direct substitution, PolCalc uses **Horner’s Method**, which reduces the computational complexity from **O(n²)** to **O(n)**.

**Horner’s Method Formula:**
```
P(x) = (((aₙx + aₙ₋₁)x + aₙ₋₂)x + ... + a₁)x + a₀
```

### **Derivative & Irreducibility Tests**
PolCalc supports **formal differentiation** and **irreducibility tests**, which are crucial in cryptographic and coding-theoretic contexts.

**Derivative Formula:**
```
d/dx (aₙxⁿ) = n aₙ xⁿ⁻¹
```

## 📲 **Download APK**
📥 **Download APK**: [Click Here](https://drive.google.com/uc?export=download&id=1Xt2EDz036-CtrkSXNnyId-RjKVXY4JwT)

## 🔜 **Future Plans**
- Implement **polynomial factorization over GF(p)**
- Optimize multiplication using **Fast Fourier Transform (FFT)**
- Add **graphing support** for polynomial visualization
- Extend finite field support to **GF(pⁿ)** for more advanced cryptographic applications

## 📝 **License**
This project is licensed under the **Apache License 2.0 with Attribution Requirement** – see the [LICENSE](LICENSE) file for details.

## 🤝 **Contributing**
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to modify.

## 🔗 **Connect with Me**
- **GitHub:** [Khaymat](https://github.com/Khaymat)
- **LinkedIn:** [Rafi Khairan](https://www.linkedin.com/in/rafikhairan/)
- **Email:** [My Email](mailto:rafikhairan120@gmail.com)

