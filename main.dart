import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  int result = 0;

  void calculateResult() {
    int num1 = int.parse(num1Controller.text);
    int num2 = int.parse(num2Controller.text);
    int newResult = num1 + num2;

    saveResult(newResult);

    setState(() {
      result = newResult;
    });
  }

  Future<void> saveResult(int result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('result', result);
  }

  Future<void> loadResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedResult = prefs.getInt('result') ?? 0;
    setState(() {
      result = savedResult;
    });
  }

  @override
  void initState() {
    super.initState();
    loadResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Sederhana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Angka Pertama'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Angka Kedua'),
            ),
            ElevatedButton(
              onPressed: calculateResult,
              child: Text('Hitung'),
            ),
            Text('Hasil: $result'),
          ],
        ),
      ),
    );
  }
}
