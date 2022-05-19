import 'package:flutter/material.dart';

import '../model/pokemon.dart';

class FavoritosPage extends StatefulWidget {
  final List<Pokemons> box;

  FavoritosPage({
    required this.box
  });

  @override
  State<StatefulWidget> createState() {
    return FavoritosPageState();
  }
}

class FavoritosPageState extends State<FavoritosPage> {
  List<Pokemons> lista = <Pokemons>[];

  String _setarImagem(int i) {
    String imagemEncontrada = "";
    imagemEncontrada = widget.box[i].imagens["other"]["official-artwork"]["front_default"];
    return imagemEncontrada;
  }

  void atualizaLista() {
    setState(() {
      lista = widget.box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Favoritos",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff8AFFFF),
          ),
        ),
        backgroundColor: Color(0xff353D64),
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff8AFFFF),
              size: 30.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(lista);
            //Navigator.of(context).popAndPushNamed('/', result: box);
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.box.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(_setarImagem(index)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Container(
                      child: Text("${widget.box[index].nome}",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xff353D64),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}