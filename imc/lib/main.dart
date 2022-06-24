import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late int peso;
  late int altura;

  double? imc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              formKey.currentState!.reset();
              setState(() {
                imc = null;
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Peso',
                    hintText: 'Insira seu peso',
                    suffixText: 'kg',
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return 'Campo obrigatório';
                    int? peso = int.tryParse(text);
                    if (peso == null) return 'Número inválido';
                    if (peso < 10 || peso > 500)
                      return 'Acho que você bateu um record';
                    this.peso = peso;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Altura',
                    hintText: 'Insira sua altura',
                    suffixText: 'cm',
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return 'Campo obrigatório';
                    int? altura = int.tryParse(text);
                    if (altura == null) return 'Número inválido';
                    if (altura < 10 || altura > 300)
                      return 'Acho que você bateu um record';
                    this.altura = altura;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        imc = 10000 * peso / (altura * altura);
                      });
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Seu IMC é:'),
                          content: Text(imc!.toStringAsFixed(1)),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('OK'),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Calcular'),
                ),
                const SizedBox(height: 32),
                if (imc != null) ...[
                  Text(
                    'Seu IMC é:',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    imc!.toStringAsFixed(1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blue,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
