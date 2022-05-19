import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pk_tranding_card/model/tipos.dart';

import '../data/apiData.dart';

class ClassificacaoDePokemons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClassificacaoDePokemonsState();
  }
}

class ClassificacaoDePokemonsState extends State<ClassificacaoDePokemons> {
  List<TiposPokemons> tipos = <TiposPokemons>[];
  String _valor = '';

  void getTiposFromAPI() async {
    await HttpService.getTiposPokemons(_valor).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body)['results'];
        tipos = lista.map((model) => TiposPokemons.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    getTiposFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Pokemons",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: tipos.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 125,
                      width: 125,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(tipos[index].nome,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}