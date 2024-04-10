import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '×' ||
          buttonText == '÷' ||
          buttonText == '%') {
        _num1 = double.parse(_output);
        _operator = buttonText;
        _output = '';
      } else if (buttonText == '=') {
        _num2 = double.parse(_output);
        if (_operator == '+') {
          _output = (_num1 + _num2).toString();
        } else if (_operator == '-') {
          _output = (_num1 - _num2).toString();
        } else if (_operator == '×') {
          _output = (_num1 * _num2).toString();
        } else if (_operator == '÷') {
          _output = (_num1 / _num2).toString();
        } else if (_operator == '%') {
          _output = (_num1 * (_num2 / 100)).toString();
        }
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else {
        _output += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, double buttonWidth,
      Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.25 * buttonWidth,
      child: ElevatedButton(
        onPressed: () => _buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonText == '+' ||
                    buttonText == '-' ||
                    buttonText == '×' ||
                    buttonText == '÷'
                ? 50
                : 25),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton('C', 1, 1, Colors.grey),
                  buildButton('/', 1, 1, Colors.grey),
                  buildButton('%', 1, 1, Colors.grey),
                  buildButton('÷', 1, 1, Colors.blue),
                ],
              ),
              Row(
                children: [
                  buildButton('7', 1, 1, Colors.grey),
                  buildButton('8', 1, 1, Colors.grey),
                  buildButton('9', 1, 1, Colors.grey),
                  buildButton('×', 1, 1, Colors.blue),
                ],
              ),
              Row(
                children: [
                  buildButton('4', 1, 1, Colors.grey),
                  buildButton('5', 1, 1, Colors.grey),
                  buildButton('6', 1, 1, Colors.grey),
                  buildButton('-', 1, 1, Colors.blue),
                ],
              ),
              Row(
                children: [
                  buildButton('1', 1, 1, Colors.grey),
                  buildButton('2', 1, 1, Colors.grey),
                  buildButton('3', 1, 1, Colors.grey),
                  buildButton('+', 1, 1, Colors.blue),
                ],
              ),
              Row(
                children: [
                  buildButton('.', 1, 1, Colors.grey),
                  buildButton('0', 1, 2, Colors.grey),
                  buildButton('=', 1, 1, Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
