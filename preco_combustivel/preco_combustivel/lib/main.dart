import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_masked_text2/flutter_masked_text2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var _gasCtrl = new MoneyMaskedTextController();
  //var _alcCtrl = new MoneyMaskedTextController();

  final formkey = GlobalKey<FormState>();

  late double? valorGasolina;
  late double? valorAlcool;
  String compensa = 'Álcool';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Preço Combustível!'),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                //controller: _gasCtrl,
                maxLength: 4,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),

                decoration: const InputDecoration(
                  labelText: 'Gasolina',
                  hintText: 'Gasolina',
                  suffixText: "Reais",
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) return 'Campo obrigatório';
                  double? valorGasolina = double.tryParse(text);
                  if (valorGasolina == null) return 'Valor inválido!';
                  if (valorGasolina < 0 || valorGasolina > 10)
                    return 'Esse valor parece estar incorreto';
                  /*valorGasolina = double.parse(
                    _gasCtrl.text.replaceAll(new RegExp(r'[,]'), '.'),
                  );*/
                  this.valorGasolina = valorGasolina;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                //controller: _alcCtrl,
                maxLength: 4,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
                decoration: const InputDecoration(
                  labelText: 'Álcool',
                  hintText: 'Alcool',
                  suffixText: "Reais",
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) return 'Campo obrigatório';
                  double? valorAlcool = double.tryParse(text);
                  if (valorAlcool == null) return 'Valor inválido!';
                  if (valorAlcool < 0 || valorAlcool > 10)
                    return 'Esse valor parece estar incorreto';
                  /* valorAlcool = double.parse(
                    _alcCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
                  );*/
                  this.valorAlcool = valorAlcool;
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      if (valorAlcool! <= (valorGasolina! * 0.7)) {
                        setState(() {
                          compensa = 'Etanol';
                        });
                      } else {
                        compensa = 'Gasolina';
                      }
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Vale mais a pena usar: '),
                          content: Text('$compensa'),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Calcular'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
