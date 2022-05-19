import 'package:flutter/material.dart';
import 'telas/favoritos.dart';
import 'telas/pesquisarPokemon.dart';
import 'telas/pokemonDetails.dart';
import 'telas/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50:Color.fromRGBO(136,14,79, .1),
      100:Color.fromRGBO(136,14,79, .2),
      200:Color.fromRGBO(136,14,79, .3),
      300:Color.fromRGBO(136,14,79, .4),
      400:Color.fromRGBO(136,14,79, .5),
      500:Color.fromRGBO(136,14,79, .6),
      600:Color.fromRGBO(136,14,79, .7),
      700:Color.fromRGBO(136,14,79, .8),
      800:Color.fromRGBO(136,14,79, .9),
      900:Color.fromRGBO(136,14,79, 1),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PK Battle',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff1c2733, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //brightness: Brightness.dark,
      ),
      initialRoute: "/",
      routes: {
        MyHomePage.routeName: (context) => MyHomePage(),
        '/favoritos': (context) => FavoritosPage(box: []),
        '/search': (context) => ItemPage(pokemon: [], nome: 'nome', box: []),
        '/details': (context) => PokemonDetalhes(box: [], link: 'link'),
      },
      //home: MyHomePage(),
    );
  }
}