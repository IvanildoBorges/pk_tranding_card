import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pk_tranding_card/data/apiData.dart';
import 'package:pk_tranding_card/model/pokedex.dart';

class Pokedex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PokedexState();
  }
}

class PokedexState extends State<Pokedex> {
  List<ModelPokedex> lista = <ModelPokedex>[];

  void _iniciaPokedex() {
    HttpService.getPokedex().then((response) {
      setState(() {
        Iterable listaAux = json.decode(response.body)['results'];
        lista = listaAux.map((model) => ModelPokedex.fromJson(model)).toList();
        print(lista);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _iniciaPokedex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff353D64),
      appBar: AppBar(
        title: Text("Pokedex",
          style: TextStyle(
            color: Color(0xff8AFFFF),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text("${lista[index].nome}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text("${lista[index].url}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}