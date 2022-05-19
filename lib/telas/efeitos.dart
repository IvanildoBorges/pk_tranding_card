import 'package:flutter/material.dart';

class EfeitosDosPokemons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EfeitosDosPokemonsState();
  }
}

class EfeitosDosPokemonsState extends State<EfeitosDosPokemons>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Efeitos dos Pokemons",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(

      ),
    );
  }
}