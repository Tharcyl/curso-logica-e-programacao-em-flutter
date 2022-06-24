import 'package:flutter/material.dart';
import 'package:lista_compras/models/produto.dart';

class EditProdutoPage extends StatefulWidget {
  @override
  _EditProdutoPageState createState() => _EditProdutoPageState();
}

class _EditProdutoPageState extends State<EditProdutoPage> {
  String produtoText = '';
  String produtoQuantidade = '';
  String produtoValor = '';

  late double calcTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adicionar produto',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  //BOTÃO QUE VERIFICA SE O CAMPO DE TEXTO DO NOME DO PRODUTO ESTÁ VAZIO.
                  IconButton(
                    onPressed: (produtoText.isEmpty ||
                            produtoQuantidade.isEmpty ||
                            produtoValor.isEmpty)
                        ? null
                        : () {
                            final Produto newProduto = Produto(
                                produtoText, produtoQuantidade, produtoValor);
                            Navigator.of(context).pop(newProduto);
                          },
                    color: Colors.green[400],
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    //CAMPO DE TEXTO DE INSERIR PRODUTO
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Insira o produto',
                          ),
                          cursorColor: Colors.cyan,
                          onChanged: (text) {
                            setState(() {
                              produtoText = text;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  //CAMPO DE TEXTO DE INSERIR QUANTIDADE DE PRODUTOS
                  Card(
                    margin: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Insira a quantidade de produtos',
                        ),
                        cursorColor: Colors.cyan,
                        onChanged: (text) {
                          setState(() {
                            produtoQuantidade = text;
                          });
                        },
                      ),
                    ),
                  ),
                  //CAMPO DE TEXTO DE INSERIR VALOR DO PRODUTO
                  Card(
                    margin: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Insira o valor do produto',
                        ),
                        cursorColor: Colors.cyan,
                        onChanged: (text) {
                          setState(() {
                            produtoValor = text;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void calculo(String text, String text2) {
  double? valor01 = double.tryParse(text);
  double? valor02 = double.tryParse(text2);

  double total = valor01! * valor02!;

  return total;
}
