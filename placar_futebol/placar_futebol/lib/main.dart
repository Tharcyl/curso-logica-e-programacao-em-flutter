import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  String vencendo = 'Jogo está empatado';

  int golsTime01 = 0;
  int golsTime02 = 0;

  void calcTime01(int valor) {
    setState(() {
      golsTime01 += valor;
      if (golsTime01 < golsTime02) {
        vencendo = 'Barcelona está vencendo';
      }
      if (golsTime01 > golsTime02) {
        vencendo = 'PSG está vencendo';
      }
      else if (golsTime01 == golsTime02) {
        vencendo = 'Jogo está empatado';
      }
    });
  }

  void calcTime02(int valor) {
    setState(() {
      golsTime02 += valor;
      if (golsTime01 < golsTime02) {
        vencendo = 'Barcelona está vencendo';
      }
      if (golsTime01 > golsTime02) {
        vencendo = 'PSG está vencendo';
      }
      else if (golsTime01 == golsTime02) {
        vencendo = 'Jogo está empatado';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.asset("images/campo_de_futebol.png")),
            Column(
              //Na linha abaixo centralizo na vertical
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Text(
                  'PSG: \n    $golsTime01',
                  style: TextStyle(fontSize: 25),
                ),
                Row(
                  //Na linha abaixo centralizo na horizontal
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        calcTime01(-1);
                      },
                      child: Text('-1'),
                    ),
                    //Abaixo está a largura entre os botões
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        calcTime01(1);
                      },
                      child: Text('+1'),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(vencendo, style: TextStyle(fontSize: 23, color: Colors.yellow),),
                  ],
                ),

                //Abaixo está a \altura entre os contadores
                SizedBox(height: 120),

                Text(
                  'Barcelona: \n         $golsTime02',
                  style: TextStyle(fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        calcTime02(-1);
                      },
                      child: Text('-1'),
                    ),
                    //Abaixo está a largura entre os botões
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        calcTime02(1);
                      },
                      child: Text('+1'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
