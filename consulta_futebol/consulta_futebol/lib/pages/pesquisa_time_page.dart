import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PesquisaTimePage extends StatelessWidget {
  const PesquisaTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Futebol Consulta',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Buscar Ligas'),
            ),
          ),
        ],
      ),
    );
  }
}
