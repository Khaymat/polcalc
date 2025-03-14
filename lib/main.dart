import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io' show Platform, exit;

void main() {
  runApp(PolCalc());
}

class PolCalc extends StatefulWidget {
  @override
  _PolCalcState createState() => _PolCalcState();
}

class _PolCalcState extends State<PolCalc> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          // If you need add more text styles with the custom font
          titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontFamily: 'Montserrat'),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.lightGreenAccent.shade700,
              width: 2.5,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        ),
        // Add dropdown theme for light mode
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: Colors.black87, fontFamily: 'Montserrat'),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.green, fontFamily: 'Montserrat'),
          // Add more text styles with the custom font
          titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.green.shade300,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Colors.green.shade300,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.green.shade100,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black87,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade400, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.5),
          ),
          labelStyle: TextStyle(
            color: Colors.green.shade300,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(
        onComplete: () {
          return CalculatorScreen(
            toggleTheme: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            isDarkMode: isDarkMode,
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function onComplete;

  SplashScreen({required this.onComplete});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isTypingComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 3500), () {
      setState(() {
        _isTypingComplete = true;
      });
      _controller.forward().then((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => widget.onComplete(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 800),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or icon
                  Icon(
                    Icons.calculate_outlined,
                    size: 80,
                    color: Colors.green.shade400,
                  ),
                  SizedBox(height: 30),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'W E L C O M E',
                        textStyle: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade400,
                          letterSpacing: 4.0,
                          fontFamily: 'Montserrat',
                        ),
                        speed: Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (_isTypingComplete)
                    Text(
                      'PolCalc',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green.shade300,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  CalculatorScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController poly1Ctrl = TextEditingController();
  final TextEditingController poly2Ctrl = TextEditingController();
  final TextEditingController modCtrl = TextEditingController();
  final TextEditingController pointCtrl = TextEditingController();
  final TextEditingController fieldSizeCtrl = TextEditingController(text: "2");

  String result = "";
  String error = "";
  List<String> steps = [];
  String op = "Add";
  int gf = 2;
  bool showSteps = true;
  bool isCalculating = false;

  final List<String> operations = [
    "Add",
    "Subtract",
    "Multiply",
    "Divide",
    "Modulo",
    "GCD",
    "Derivative",
    "Evaluate",
    "Irreducibility Test",
  ];

  @override
  void initState() {
    super.initState();
    fieldSizeCtrl.addListener(_updateFieldSize);
  }

  @override
  void dispose() {
    fieldSizeCtrl.removeListener(_updateFieldSize);
    poly1Ctrl.dispose();
    poly2Ctrl.dispose();
    modCtrl.dispose();
    pointCtrl.dispose();
    fieldSizeCtrl.dispose();
    super.dispose();
  }

  void _updateFieldSize() {
    if (fieldSizeCtrl.text.isNotEmpty) {
      try {
        int newSize = int.parse(fieldSizeCtrl.text);
        if (newSize > 1 && isPrime(newSize)) {
          setState(() {
            gf = newSize;
          });
        }
      } catch (e) {
        // Invalid input, ignore
      }
    }
  }

  // Function to exit
  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      exit(0); // For other platforms
    }
  }

  bool isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    int i = 5;
    while (i * i <= n) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
      i += 6;
    }
    return true;
  }

  Map<int, int> parsePoly(String input) {
    Map<int, int> poly = {};

    if (input.trim().isEmpty) {
      return poly;
    }

    try {
      steps.add("Parsing polynomial: $input");

      input.replaceAll(' ', '').replaceAll('-', '+-').split('+').forEach((
        term,
      ) {
        term = term.trim();
        if (term.isEmpty) return;

        if (term.contains('x')) {
          int coef = 1;
          int exp = 1;

          if (term.startsWith('x')) {
            coef = 1;
          } else if (term.startsWith('-x')) {
            coef = -1;
          } else {
            String coefStr = term.split('x')[0].replaceAll('*', '');
            coef = int.parse(coefStr);
          }

          if (term.contains('^')) {
            exp = int.parse(term.split('^')[1]);
          } else {
            exp = term.contains('x') ? 1 : 0;
          }

          poly[exp] = ((poly[exp] ?? 0) + coef) % gf;
          if (poly[exp] == 0) poly.remove(exp);

          steps.add("  Term: $term → coefficient: $coef, exponent: $exp");
        } else if (term.isNotEmpty) {
          int constant = int.parse(term);
          poly[0] = ((poly[0] ?? 0) + constant) % gf;
          if (poly[0] == 0) poly.remove(0);

          steps.add("  Constant term: $constant");
        }
      });

      steps.add("Parsed polynomial: ${polyStr(poly)}");
    } catch (e) {
      throw FormatException('Invalid polynomial format: $input');
    }

    return poly;
  }

  Map<int, int> add(Map<int, int> f, Map<int, int> g) {
    Map<int, int> r = {};

    steps.add("Adding polynomials:");
    steps.add("  P1(x) = ${polyStr(f)}");
    steps.add("  P2(x) = ${polyStr(g)}");

    for (var k in {...f.keys, ...g.keys}) {
      int fVal = f[k] ?? 0;
      int gVal = g[k] ?? 0;
      int sum = (fVal + gVal) % gf;

      steps.add("  Term x^$k: $fVal + $gVal = $sum (mod $gf)");

      if (sum != 0) {
        r[k] = sum;
      }
    }

    steps.add("Result: ${polyStr(r)}");
    return r;
  }

  Map<int, int> subtract(Map<int, int> f, Map<int, int> g) {
    Map<int, int> r = {};

    steps.add("Subtracting polynomials:");
    steps.add("  P1(x) = ${polyStr(f)}");
    steps.add("  P2(x) = ${polyStr(g)}");

    for (var k in {...f.keys, ...g.keys}) {
      int fVal = f[k] ?? 0;
      int gVal = g[k] ?? 0;
      int diff = (fVal - gVal) % gf;
      if (diff < 0) diff += gf;

      steps.add("  Term x^$k: $fVal - $gVal = $diff (mod $gf)");

      if (diff != 0) {
        r[k] = diff;
      }
    }

    steps.add("Result: ${polyStr(r)}");
    return r;
  }

  Map<int, int> mul(Map<int, int> f, Map<int, int> g) {
    Map<int, int> r = {};

    steps.add("Multiplying polynomials:");
    steps.add("  P1(x) = ${polyStr(f)}");
    steps.add("  P2(x) = ${polyStr(g)}");

    f.forEach((ef, cf) {
      g.forEach((eg, cg) {
        int ne = ef + eg;
        int nc = (cf * cg) % gf;

        steps.add(
          "  Term x^$ef * x^$eg = x^$ne with coefficient $cf * $cg = $nc (mod $gf)",
        );

        r[ne] = ((r[ne] ?? 0) + nc) % gf;
        if (r[ne] == 0) r.remove(ne);
      });
    });

    steps.add("Result: ${polyStr(r)}");
    return r;
  }

  Map<int, int> derivative(Map<int, int> p) {
    Map<int, int> r = {};

    steps.add("Computing derivative of polynomial:");
    steps.add("  P(x) = ${polyStr(p)}");

    p.forEach((exp, coef) {
      if (exp > 0) {
        int newCoef = (coef * exp) % gf;
        int newExp = exp - 1;

        steps.add(
          "  Term $coef·x^$exp → derivative: $coef * $exp = $newCoef coefficient, exponent: $newExp",
        );

        if (newCoef != 0) {
          r[newExp] = newCoef;
        }
      } else {
        steps.add("  Constant term $coef → derivative: 0");
      }
    });

    steps.add("Result: ${polyStr(r)}");
    return r;
  }

  int evaluate(Map<int, int> p, int x) {
    int result = 0;

    steps.add("Evaluating polynomial at x = $x:");
    steps.add("  P(x) = ${polyStr(p)}");

    p.forEach((exp, coef) {
      int term = 1;
      for (int i = 0; i < exp; i++) {
        term = (term * x) % gf;
      }
      int value = (coef * term) % gf;

      steps.add(
        "  Term $coef·x^$exp = $coef * $x^$exp = $coef * $term = $value (mod $gf)",
      );

      result = (result + value) % gf;
      steps.add("  Running sum: $result");
    });

    steps.add("Result: P($x) = $result");
    return result;
  }

  Map<int, int> mod(Map<int, int> p, Map<int, int> m) {
    if (m.isEmpty) {
      throw Exception('Modulo polynomial cannot be empty');
    }

    steps.add("Computing polynomial modulo:");
    steps.add("  P(x) = ${polyStr(p)}");
    steps.add("  M(x) = ${polyStr(m)}");

    // Create a copy of p to avoid modifying the original
    Map<int, int> result = Map.from(p);

    // Sort keys in descending order
    List<int> pKeys = result.keys.toList()..sort((a, b) => b.compareTo(a));
    List<int> mKeys = m.keys.toList()..sort((a, b) => b.compareTo(a));

    if (mKeys.isEmpty || mKeys.first == 0) {
      throw Exception('Modulo polynomial must have degree > 0');
    }

    int iteration = 1;
    while (result.isNotEmpty &&
        pKeys.isNotEmpty &&
        mKeys.isNotEmpty &&
        pKeys.first >= mKeys.first) {
      steps.add("Iteration $iteration:");

      int leadExp = pKeys.first;
      int modLeadExp = mKeys.first;

      if (leadExp < modLeadExp) {
        steps.add(
          "  Leading term degree ${pKeys.first} < modulo polynomial degree ${mKeys.first}, done.",
        );
        break;
      }

      int e = leadExp - modLeadExp;
      int leadCoef = result[leadExp]!;
      int modLeadCoef = m[modLeadExp]!;

      steps.add("  Leading term: ${leadCoef}x^${leadExp}");
      steps.add("  Modulo leading term: ${modLeadCoef}x^${modLeadExp}");
      steps.add("  Subtract: ${leadCoef}x^${e} * (${polyStr(m)})");

      // Calculate the multiplier
      int multiplier = leadCoef;

      // Subtract the multiple of the modulo polynomial
      Map<int, int> subtractPoly = {};
      m.forEach((exp, coef) {
        int targetExp = exp + e;
        int targetCoef = (multiplier * coef) % gf;
        subtractPoly[targetExp] = targetCoef;
      });

      steps.add("  Subtracting: ${polyStr(subtractPoly)}");

      // Perform the subtraction
      subtractPoly.forEach((exp, coef) {
        result[exp] = ((result[exp] ?? 0) - coef) % gf;
        if (result[exp] == 0) {
          result.remove(exp);
        } else if (result[exp]! < 0) {
          result[exp] = (result[exp]! + gf) % gf;
        }
      });

      steps.add("  After subtraction: ${polyStr(result)}");

      // Update the keys list
      pKeys = result.keys.toList()..sort((a, b) => b.compareTo(a));
      iteration++;
    }

    steps.add("Final result: ${polyStr(result)}");
    return result;
  }

  List<Map<int, int>> divide(Map<int, int> p, Map<int, int> d) {
    if (d.isEmpty) {
      throw Exception('Divisor polynomial cannot be empty');
    }

    steps.add("Polynomial division:");
    steps.add("  Dividend P(x) = ${polyStr(p)}");
    steps.add("  Divisor D(x) = ${polyStr(d)}");

    // Create copies to avoid modifying originals
    Map<int, int> remainder = Map.from(p);
    Map<int, int> quotient = {};

    // Sort keys in descending order
    List<int> rKeys = remainder.keys.toList()..sort((a, b) => b.compareTo(a));
    List<int> dKeys = d.keys.toList()..sort((a, b) => b.compareTo(a));

    if (dKeys.isEmpty || dKeys.first == 0) {
      throw Exception('Divisor polynomial must have degree > 0');
    }

    int iteration = 1;
    while (remainder.isNotEmpty &&
        rKeys.isNotEmpty &&
        dKeys.isNotEmpty &&
        rKeys.first >= dKeys.first) {
      steps.add("Iteration $iteration:");

      int leadRemExp = rKeys.first;
      int leadDivExp = dKeys.first;

      if (leadRemExp < leadDivExp) {
        steps.add(
          "  Remainder degree ${rKeys.first} < divisor degree ${dKeys.first}, done.",
        );
        break;
      }

      int e = leadRemExp - leadDivExp;
      int leadRemCoef = remainder[leadRemExp]!;
      int leadDivCoef = d[leadDivExp]!;

      // Calculate the quotient term
      int qCoef = 1;
      for (int i = 1; i < gf; i++) {
        if ((i * leadDivCoef) % gf == leadRemCoef) {
          qCoef = i;
          break;
        }
      }

      steps.add("  Leading term of remainder: ${leadRemCoef}x^${leadRemExp}");
      steps.add("  Leading term of divisor: ${leadDivCoef}x^${leadDivExp}");
      steps.add("  Quotient term: ${qCoef}x^${e}");

      // Add to quotient
      quotient[e] = qCoef;

      // Subtract the multiple of the divisor
      Map<int, int> subtractPoly = {};
      d.forEach((exp, coef) {
        int targetExp = exp + e;
        int targetCoef = (qCoef * coef) % gf;
        subtractPoly[targetExp] = targetCoef;
      });

      steps.add("  Subtracting: ${polyStr(subtractPoly)}");

      // Perform the subtraction
      subtractPoly.forEach((exp, coef) {
        remainder[exp] = ((remainder[exp] ?? 0) - coef) % gf;
        if (remainder[exp] == 0) {
          remainder.remove(exp);
        } else if (remainder[exp]! < 0) {
          remainder[exp] = (remainder[exp]! + gf) % gf;
        }
      });

      steps.add("  Remainder after subtraction: ${polyStr(remainder)}");

      // Update the keys list
      rKeys = remainder.keys.toList()..sort((a, b) => b.compareTo(a));
      iteration++;
    }

    steps.add("Final quotient: ${polyStr(quotient)}");
    steps.add("Final remainder: ${polyStr(remainder)}");

    return [quotient, remainder];
  }

  Map<int, int> gcd(Map<int, int> a, Map<int, int> b) {
    steps.add("Computing GCD of polynomials:");
    steps.add("  A(x) = ${polyStr(a)}");
    steps.add("  B(x) = ${polyStr(b)}");

    if (a.isEmpty) return b;
    if (b.isEmpty) return a;

    // Make copies to avoid modifying originals
    Map<int, int> r1 = Map.from(a);
    Map<int, int> r2 = Map.from(b);

    int iteration = 1;
    while (!r2.isEmpty) {
      steps.add("Iteration $iteration:");
      steps.add("  r1 = ${polyStr(r1)}");
      steps.add("  r2 = ${polyStr(r2)}");

      List<Map<int, int>> divResult = divide(r1, r2);
      Map<int, int> quotient = divResult[0];
      Map<int, int> remainder = divResult[1];

      steps.add("  quotient = ${polyStr(quotient)}");
      steps.add("  remainder = ${polyStr(remainder)}");

      r1 = r2;
      r2 = remainder;

      iteration++;
    }

    // Normalize the GCD to have leading coefficient 1
    if (r1.isNotEmpty) {
      List<int> keys = r1.keys.toList()..sort((a, b) => b.compareTo(a));
      int leadExp = keys.first;
      int leadCoef = r1[leadExp]!;

      // Find multiplicative inverse of leadCoef in GF(p)
      int inverse = 1;
      for (int i = 1; i < gf; i++) {
        if ((i * leadCoef) % gf == 1) {
          inverse = i;
          break;
        }
      }

      steps.add("Normalizing GCD by multiplying with ${inverse}:");

      Map<int, int> normalized = {};
      r1.forEach((exp, coef) {
        normalized[exp] = (coef * inverse) % gf;
      });

      steps.add("Normalized GCD: ${polyStr(normalized)}");
      return normalized;
    }

    return r1;
  }

  bool isIrreducible(Map<int, int> p) {
    if (p.isEmpty) return false;

    steps.add("Testing irreducibility of polynomial:");
    steps.add("  P(x) = ${polyStr(p)}");

    // Get the degree of the polynomial
    List<int> keys = p.keys.toList()..sort((a, b) => b.compareTo(a));
    int degree = keys.first;

    if (degree <= 1) {
      steps.add("Polynomials of degree 0 or 1 are irreducible by definition.");
      return true;
    }

    // For degree 2 and 3, we can use a simpler test
    if (degree == 2 || degree == 3) {
      steps.add("Testing all possible factors of degree 1...");

      // Try all possible linear factors (x - a) where a is in GF(p)
      for (int a = 0; a < gf; a++) {
        Map<int, int> factor = {1: 1, 0: (gf - a) % gf}; // x - a

        steps.add("  Testing factor: ${polyStr(factor)}");

        List<Map<int, int>> divResult = divide(p, factor);
        Map<int, int> remainder = divResult[1];

        if (remainder.isEmpty) {
          steps.add(
            "  ${polyStr(factor)} is a factor, so the polynomial is reducible.",
          );
          return false;
        }
      }

      steps.add("No linear factors found, the polynomial is irreducible.");
      return true;
    }

    // For higher degrees, we can use the fact that all irreducible polynomials, divide x^(p^n) - x for some n
    steps.add("Using advanced irreducibility test for degree > 3...");

    // This is a simplified test and not complete for higher degrees
    // A complete test would be more complex

    // Check if p divides x^p - x
    Map<int, int> xp = {gf: 1, 1: gf - 1}; // x^p - x

    List<Map<int, int>> divResult = divide(xp, p);
    Map<int, int> remainder = divResult[1];

    bool result = remainder.isNotEmpty;
    steps.add(
      result
          ? "The polynomial does not divide x^p - x, suggesting it may be irreducible."
          : "The polynomial divides x^p - x, it is reducible.",
    );

    return result;
  }

  void calc() {
    setState(() {
      error = "";
      result = "";
      steps = [];
      isCalculating = true;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      try {
        if (poly1Ctrl.text.trim().isEmpty) {
          throw FormatException('First polynomial cannot be empty');
        }

        var p1 = parsePoly(poly1Ctrl.text);

        if (op == "Derivative") {
          var res = derivative(p1);
          setState(() {
            result = "Result: ${polyStr(res)}";
            isCalculating = false;
          });
        } else if (op == "Evaluate") {
          if (pointCtrl.text.trim().isEmpty) {
            throw FormatException('Evaluation point cannot be empty');
          }
          int point = int.parse(pointCtrl.text);
          int res = evaluate(p1, point);
          setState(() {
            result = "Result: P($point) = $res";
            isCalculating = false;
          });
        } else if (op == "Irreducibility Test") {
          bool res = isIrreducible(p1);
          setState(() {
            result = "Result: ${res ? 'Irreducible' : 'Reducible'}";
            isCalculating = false;
          });
        } else {
          if (poly2Ctrl.text.trim().isEmpty) {
            throw FormatException('Second polynomial cannot be empty');
          }

          var p2 = parsePoly(poly2Ctrl.text);

          if (op == "Add") {
            var res = add(p1, p2);
            setState(() {
              result = "Result: ${polyStr(res)}";
              isCalculating = false;
            });
          } else if (op == "Subtract") {
            var res = subtract(p1, p2);
            setState(() {
              result = "Result: ${polyStr(res)}";
              isCalculating = false;
            });
          } else if (op == "Multiply") {
            var res = mul(p1, p2);
            setState(() {
              result = "Result: ${polyStr(res)}";
              isCalculating = false;
            });
          } else if (op == "Divide") {
            var res = divide(p1, p2);
            setState(() {
              result =
                  "Quotient: ${polyStr(res[0])}\nRemainder: ${polyStr(res[1])}";
              isCalculating = false;
            });
          } else if (op == "Modulo") {
            if (modCtrl.text.trim().isEmpty) {
              throw FormatException('Modulo polynomial cannot be empty');
            }
            var m = parsePoly(modCtrl.text);
            var res = mod(p1, m);
            setState(() {
              result = "Result: ${polyStr(res)}";
              isCalculating = false;
            });
          } else if (op == "GCD") {
            var res = gcd(p1, p2);
            setState(() {
              result = "Result: ${polyStr(res)}";
              isCalculating = false;
            });
          }
        }
      } catch (e) {
        setState(() {
          error = e.toString();
          isCalculating = false;
        });
      }
    });
  }

  String polyStr(Map<int, int> p) {
    if (p.isEmpty) return "0";

    List<String> terms = [];
    List<int> sortedExponents = p.keys.toList()..sort((b, a) => a.compareTo(b));

    for (int exp in sortedExponents) {
      int coef = p[exp]!;
      String term;

      if (exp == 0) {
        term = "$coef";
      } else if (exp == 1) {
        term = coef == 1 ? "x" : (coef == -1 ? "-x" : "${coef}x");
      } else {
        term =
            coef == 1 ? "x^$exp" : (coef == -1 ? "-x^$exp" : "${coef}x^$exp");
      }

      terms.add(term);
    }

    return terms.join(' + ').replaceAll("+ -", "- ");
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final primaryColor = isDark ? Colors.green.shade400 : Colors.green.shade700;
    final accentColor =
        isDark ? Colors.lightGreenAccent : Colors.lightGreenAccent.shade700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        actions: [
          // Exit button
          IconButton(
            icon: Icon(Icons.exit_to_app, color: primaryColor),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      backgroundColor: isDark ? Colors.black87 : Colors.white,
                      title: Text(
                        "Exit Application",
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        "Want to exit?",
                        style: TextStyle(
                          color: isDark ? Colors.green[100] : Colors.green[800],
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _exitApp(),
                          child: Text(
                            "Exit",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
              );
            },
            tooltip: 'Exit Application',
          ),
          // Theme toggle button
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: primaryColor,
            ),
            onPressed: () => widget.toggleTheme(),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          IconButton(
            icon: Icon(Icons.help_outline, color: primaryColor),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      backgroundColor: isDark ? Colors.black87 : Colors.white,
                      title: Text(
                        "Help",
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Polynomial Input Format:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Example: x^2 + 3x + 1",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Use x for the variable",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Use ^ for exponents",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Operations:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Add: adds two polynomials",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Subtract: subtracts second from first",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Multiply: multiplies two polynomials",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Divide: divides first by second",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Modulo: remainder when dividing first by modulo",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• GCD: greatest common divisor",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Derivative: computes the formal derivative",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Evaluate: evaluates at a point",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Irreducibility Test: tests if polynomial is irreducible",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "GF(q):",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• Coefficients are computed in Galois Field with p elements",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              "• q must be a prime number",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? Colors.green[100]
                                        : Colors.green[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Close",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input fields with enhanced styling
              TextField(
                controller: poly1Ctrl,
                style: TextStyle(fontFamily: 'Montserrat'),
                decoration: InputDecoration(
                  labelText: "Polynomial 1",
                  hintText: "Example: x^2 + 3x + 1",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.functions, color: primaryColor),
                ),
              ),
              SizedBox(height: 16),
              AnimatedOpacity(
                opacity:
                    !["Derivative", "Irreducibility Test"].contains(op)
                        ? 1.0
                        : 0.5,
                duration: Duration(milliseconds: 300),
                child: TextField(
                  controller: poly2Ctrl,
                  style: TextStyle(fontFamily: 'Montserrat'),
                  enabled: !["Derivative", "Irreducibility Test"].contains(op),
                  decoration: InputDecoration(
                    labelText: "Polynomial 2",
                    hintText: "Example: 2x + 1",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.functions, color: primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              AnimatedOpacity(
                opacity: op == "Modulo" ? 1.0 : 0.5,
                duration: Duration(milliseconds: 300),
                child: TextField(
                  controller: modCtrl,
                  style: TextStyle(fontFamily: 'Montserrat'),
                  enabled: op == "Modulo",
                  decoration: InputDecoration(
                    labelText: "Modulo Polynomial",
                    hintText: "Example: x^3 + x + 1",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.percent, color: primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              AnimatedOpacity(
                opacity: op == "Evaluate" ? 1.0 : 0.5,
                duration: Duration(milliseconds: 300),
                child: TextField(
                  controller: pointCtrl,
                  style: TextStyle(fontFamily: 'Montserrat'),
                  enabled: op == "Evaluate",
                  decoration: InputDecoration(
                    labelText: "Evaluation Point",
                    hintText: "Example: 2",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.pin, color: primaryColor),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: op,
                        decoration: InputDecoration(
                          labelText: "Operation",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          labelStyle: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        dropdownColor: isDark ? Colors.black87 : Colors.white,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? v) => setState(() => op = v!),
                        items:
                            operations
                                .map(
                                  (v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(v),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: fieldSizeCtrl,
                      style: TextStyle(fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        labelText: "Galois Field (GF(q))",
                        hintText: "Prime number",
                        prefixIcon: Icon(Icons.numbers, color: primaryColor),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: showSteps,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        showSteps = value!;
                      });
                    },
                  ),
                  Text(
                    "Show calculation steps",
                    style: TextStyle(
                      color: isDark ? Colors.green[100] : Colors.green[800],
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: isCalculating ? null : calc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child:
                    isCalculating
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Processing...",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        )
                        : Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
              ),
              SizedBox(height: 24),
              if (error.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[300]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.red[300],
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Add a animation effect to result
              if (result.isNotEmpty)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.green.withOpacity(0.1)
                            : Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: primaryColor),
                          SizedBox(width: 8),
                          Text(
                            "Calculation Result",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        result.replaceAll("Result: ", ""),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),

              if (showSteps && steps.isNotEmpty)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.blue.withOpacity(0.05)
                            : Colors.blue.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timeline,
                            color: isDark ? Colors.blue[300] : Colors.blue[700],
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Calculation Steps",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark ? Colors.blue[300] : Colors.blue[700],
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      ...steps
                          .map(
                            (step) => Padding(
                              padding: EdgeInsets.only(
                                left: step.startsWith("  ") ? 16 : 0,
                                bottom: 6,
                              ),
                              child: Text(
                                step,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color:
                                      step.startsWith("  ")
                                          ? (isDark
                                              ? Colors.blue[200]
                                              : Colors.blue[700])
                                          : (isDark
                                              ? Colors.blue[100]
                                              : Colors.blue[800]),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),

              // Footer
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Follow me on",
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: FaIcon(FontAwesomeIcons.github, size: 16),
                          label: Text(
                            "GitHub",
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          onPressed:
                              () => _launchURL("https://github.com/Khaymat"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark ? Colors.grey[800] : Colors.grey[200],
                            foregroundColor:
                                isDark ? Colors.white : Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          icon: FaIcon(FontAwesomeIcons.linkedin, size: 16),
                          label: Text(
                            "LinkedIn",
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          onPressed:
                              () => _launchURL(
                                "https://www.linkedin.com/in/rafikhairan/",
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark ? Colors.blue[900] : Colors.blue[50],
                            foregroundColor:
                                isDark ? Colors.white : Colors.blue[700],
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
