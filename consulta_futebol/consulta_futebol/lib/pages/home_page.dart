//import 'package:consulta_futebol/pages/pesquisa_time_page.dart';
//import 'package:dio/dio.dart';
import 'package:consulta_futebol/pages/pesquisa_time_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

//import 'liga_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    getLiga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Futebol Consulta',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PesquisaTimePage()));
          }, child: Text('Buscar Liga'),),
        ],
      ),
    );
  }
}

void getLiga() async {
  try {
    var response =
        await Dio().get('https://api.football-data.org/v2/competitions/2000');
    print(response);
  } catch (e) {
    print(e);
  }
}
