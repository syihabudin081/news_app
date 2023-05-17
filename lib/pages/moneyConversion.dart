import 'package:flutter/material.dart';

class MoneyConversion extends StatefulWidget {
  const MoneyConversion({Key? key}) : super(key: key);

  @override
  _MoneyConversionState createState() => _MoneyConversionState();
}

class _MoneyConversionState extends State<MoneyConversion> {
  late double _input;
  late double _output;
  late String _currencyInput;
  late String _currencyOutput;
  late String _result;

  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _input = 0;
    _currencyInput = 'IDR';
    _currencyOutput = 'IDR';
    _result = '';
  }

  void _onInputChanged(String value) {
    setState(() {
      _input = double.tryParse(value) ?? 0;
    });
  }

  void _onCurrencyInputChanged(String? value) {
    setState(() {
      _currencyInput = value ?? 'IDR';
    });
  }

  void _onCurrencyOutputChanged(String? value) {
    setState(() {
      _currencyOutput = value ?? 'IDR';
    });
  }

  void _convert() {
    setState(() {
      switch (_currencyInput) {
        case 'IDR':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input;
              break;
            case 'USD':
              _output = _input / 14200;
              break;
            case 'EUR':
              _output = _input / 17000;
              break;
            case 'JPY':
              _output = _input / 130;
              break;
          }
          break;
        case 'USD':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 14200;
              break;
            case 'USD':
              _output = _input;
              break;
            case 'EUR':
              _output = _input * 0.85;
              break;
            case 'JPY':
              _output = _input * 110;
              break;
          }
          break;
        case 'EUR':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 17000;
              break;
            case 'USD':
              _output = _input * 1.17;
              break;
            case 'EUR':
              _output = _input;
              break;
            case 'JPY':
              _output = _input * 130;
              break;
          }
          break;
        case 'JPY':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 130;
              break;
            case 'USD':
              _output = _input * 0.0091;
              break;
            case 'EUR':
              _output = _input * 0.0077;
              break;
            case 'JPY':
              _output = _input;
              break;
          }
          break;
      }
      _result = _output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Money Conversion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: _onInputChanged,
                controller: _inputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Input',
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(20.0),
              value: _currencyInput,
              alignment: Alignment.center,
              onChanged: _onCurrencyInputChanged,
              items: const <String>['IDR', 'USD', 'EUR', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 20)),
                  alignment: Alignment.center,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(20.0),
              alignment: Alignment.center,
              value: _currencyOutput,
              onChanged: _onCurrencyOutputChanged,
              items: const <String>['IDR', 'USD', 'EUR', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 20)),
                  alignment: Alignment.center,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                primary: Colors.blue,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              '${_getCurrencySymbol(_currencyOutput)} $_result',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode) {
      case 'IDR':
        return 'Rp';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'JPY':
        return '¥';
      default:
        return '';
    }
  }
}
