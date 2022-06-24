import 'package:flutter/material.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/pages/edit_produto_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Produto> produtos = [];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //LINHA DA PARTE SUPERIOR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lista de Compras',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final value = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProdutoPage(),
                        ),
                      );
                      if (value != null) {
                        setState(() {
                          produtos.add(value);
                        });
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            //TEXTOS DAS COLUNAS(PRODUTO, VALOR, QUANTIDADE)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PRODUTO',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Big Shoulders Display',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'QUANTIDADE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Big Shoulders Display',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'VALOR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Big Shoulders Display',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            //CARD ONDE ESTÃO AS INFORMAÇÕES DOS PRODUTOS
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 16,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          produto.toggleDone();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  produto.title,
                                  style: TextStyle(
                                    color: produto.done
                                        ? Colors.green[300]
                                        : Colors.black,
                                    decoration: produto.done
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                produto.quantidade,
                                style: TextStyle(
                                  color: produto.done
                                      ? Colors.green[300]
                                      : Colors.black,
                                  decoration: produto.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                produto.valor,
                                style: TextStyle(
                                  color: produto.done
                                      ? Colors.green[300]
                                      : Colors.black,
                                  decoration: produto.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            //LINHA DE BAIXO ONDE MOSTRA O VALOR TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Valor total:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Big Shoulders Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

