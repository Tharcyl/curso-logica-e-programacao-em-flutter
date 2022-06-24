class Produto {
  Produto(this.title, this.quantidade, this.valor);

  final String title;
  final String valor;
  final String quantidade;
  bool done = false;

  void toggleDone() {
    done = !done;
  }
}