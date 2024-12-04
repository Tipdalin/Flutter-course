import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Currency {
  dollar,
  dong,
  riel,
}

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  Currency? selectedCurrency = Currency.dollar;
  String inputValue = '';

  void selectCurrency(Currency? currency) {
    setState(() {
      selectedCurrency = currency;
    });

    
  }

  String converted = '';

  void convert({required String input}) {
    if (input.isEmpty) {
      setState(() => converted == '');
      return;
    }

    inputValue = input;
    double value = double.parse(input);

    switch (selectedCurrency!) {
      case Currency.dollar:
        value = value;
        break;
      case Currency.riel:
        value = value * 4000;
        break;
      case Currency.dong:
        value = value * 25400;
        break;
    }
    setState(() 
      => converted = value as String);
  }

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:",
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          TextField( 
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
              decoration: InputDecoration(
                  prefix: const Text('\$ '),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: ('Enter an amount in dollar'),
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => convert(input: value),
              ),
          const SizedBox(height: 30),

          DropdownButton(
              value: selectedCurrency,
              items: Currency.values.map((Currency currency) {
                return DropdownMenuItem<Currency>(
                  value: currency,
                  child:
                      Text(currency.toString().split(".").last.toUpperCase(), style: const TextStyle( backgroundColor:  Color.fromARGB(255, 148, 17, 224),color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: selectCurrency),
          
          const SizedBox(height: 30),
          const Text("Amount in selected device:",
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child:  Text(converted.isEmpty ? '' : converted))
        ],
      )),
    );
  }
}
