
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {

  const CalculatorPage({super.key});

  @override


  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '0';


  void calculate(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        try {
          final expression = input;
          final parts = expression.split(RegExp(r'[+\-×÷]'));

          if (parts.length == 2) {
            double a = double.parse(parts[0]);
            double b = double.parse(parts[1]);
            String op = expression.replaceAll(
              RegExp(r'[0-9.]'), '',
            );

            double answer = 0;

            switch (op) {
              case '+':
                answer = a + b;
                break;
              case '-':
                answer = a - b;
                break;
              case '×':
                answer = a * b;
                break;
              case '÷':
                if (b == 0) {
                  result = 'Cannot divide by zero';
                  return;
                }
                answer = a / b;
                break;
            }

            result = answer.toString();
            if (result.endsWith('.0')) {
              result = result.substring(0, result.length - 2);
            }
          }
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'C', '⌫', '÷', '×',
      '7', '8', '9', '-',
      '4', '5', '6', '+',
      '1', '2', '3', '=',
      '0', '.', 
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151515),
        title: const Text(
          'MY CALCULATOR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: buttons.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                String button = buttons[index];

                bool isOperator =
                    ['÷', '×', '-', '+', '='].contains(button);

                return ElevatedButton(
                  onPressed: () => calculate(button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOperator
                        ? Colors.orange
                        : const Color(0xFF303030),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    button,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
