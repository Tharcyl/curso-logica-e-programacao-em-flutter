import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fromCurrency;
  String? toCurrency;

  late Future<Response> dioFuture;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  num? fromValue;

  void calculate(Map<String, num> rates) {
    if (fromCurrency != null && toCurrency != null && fromValue != null) {
      final inEur = fromValue! / rates[fromCurrency]!;
      final toValue = inEur * rates[toCurrency]!;
      toController.text = toValue.toStringAsFixed(2);
    } else if (fromValue == null) {
      toController.clear();
    }
  }

  @override
  void initState() {
    super.initState();

    dioFuture = Dio().get(
        'http://api.exchangeratesapi.io/v1/latest?access_key=be1cb4ffd26c7bfbb10495ded7e1f626');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor'),
        centerTitle: true,
      ),
      body: FutureBuilder<Response>(
        future: dioFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.amber),
              ),
            );
          }

          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  'Erro ao buscar informações.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            );
          }

          final rates = Map<String, num>.from(snapshot.data!.data['rates']);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: fromController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          items: [
                            for (final key in rates.keys)
                              DropdownMenuItem(
                                child: Text('$key'),
                                value: '$key',
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              fromCurrency = value;
                              calculate(rates);
                            });
                          },
                          value: fromCurrency,
                          isDense: true,
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          underline: Container(),
                        ),
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      fromValue = num.tryParse(text);
                      calculate(rates);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Icon(
                      Icons.compare_arrows,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: toController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          items: [
                            for (final key in rates.keys)
                              DropdownMenuItem(
                                child: Text('$key'),
                                value: '$key',
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              toCurrency = value;
                              calculate(rates);
                            });
                          },
                          value: toCurrency,
                          isDense: true,
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          underline: Container(),
                        ),
                      ),
                    ),
                  ),
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
