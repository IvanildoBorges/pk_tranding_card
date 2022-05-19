import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pk_tranding_card/model/searchPokemon.dart';
import 'package:pk_tranding_card/telas/classificacao.dart';
import 'package:pk_tranding_card/telas/favoritos.dart';
import 'package:pk_tranding_card/telas/pesquisarPokemon.dart';
import 'package:pk_tranding_card/telas/pokedex.dart';

import '../data/apiData.dart';
import '../model/pokemon.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  List<SearchPokemons> lista = <SearchPokemons>[];
  List<SearchPokemons> listaAux = <SearchPokemons>[];
  List<Pokemons> favoritos = <Pokemons>[];
  TextEditingController _nome = TextEditingController();
  String filterText = '';

  //Pesquisa na API a lista de pesquisa de pokemons
  void _iniciaLista() async {
    await HttpService.getPokemons().then((response) {
      setState(() {
        Iterable listando = json.decode(response.body)['results'];
        lista = listando.map((model) => SearchPokemons.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _iniciaLista();
  }

  //Limpa a caixa de texto e as variaveis de pesquisa
  void limparCaixa() {
    setState(() {
      filterText = '';
      _nome.clear();
      listaAux.clear();
    });
  }

  //Procura na lista o pokemon digitado na caixa de pesquisa
  void _procuraPokemon() {
    if (filterText.isNotEmpty) {
      listaAux.clear();
      for (SearchPokemons item in lista) {
        String nome = item.nome.toLowerCase();
        if (nome.contains(filterText.toLowerCase(), 0)) {
          listaAux.add(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Pokemon Battle Cards",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff353D64),
          ),
        ),
        backgroundColor: Color(0xffebeeff),
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xff353D64),
          ),
          Transform.translate(
            offset: Offset(100.0, 200.0),
            child: Transform.rotate(
              angle: pi/-4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Color(0xff353D64),
                      BlendMode.dstATop
                    ),
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 360.0,
                  decoration: BoxDecoration(
                    color: Color(0xffebeeff),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text("Procurando por um pokémon em especial?",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff353D64),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 55.0,
                                child: TextField(
                                  controller: _nome,
                                  cursorColor: Color(0xff353D64),
                                  style: TextStyle(
                                    color: Color(0xff353D64),
                                    fontSize: 16,
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Pesquisar Pokémon",
                                    hintText: "Digite o nome...",
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.close),
                                      color: filterText.isNotEmpty
                                          ? Color(0xff353D64)
                                          : Colors.transparent,
                                      iconSize: 25.0,
                                      onPressed: () {
                                        limparCaixa();
                                      },
                                    ),
                                    prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(0xff353D64),
                                        size: 25.0
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff353D64),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xff353D64),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff353D64),
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff353D64),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    if (text.isNotEmpty) {
                                      setState(() {
                                        filterText = text;
                                      });
                                      _procuraPokemon();
                                    } else {
                                      limparCaixa();
                                    }
                                  },
                                  // onSubmitted: (text) {
                                  //   if (text.isNotEmpty) {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder:(context) =>ItemPage(
                                  //             pokemon: lista,
                                  //             nome: filterText.toLowerCase(),
                                  //             box: favoritos,
                                  //         ),
                                  //       ),
                                  //     ).then((value) => {
                                  //       favoritos = value,
                                  //     });
                                  //   }
                                  // },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      filterText.isNotEmpty
                        ?
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
                            child: Container(
                              height: 180.0,
                              child: ListView.builder(
                                itemCount: listaAux.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                          padding: const EdgeInsets.only(bottom: 3.0),
                                          child: Container(
                                            height:45.0,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              child: Text("${listaAux[index].nome.toUpperCase()}",
                                                style: TextStyle(
                                                  color: Color(0xff8AFFFF),
                                                  fontSize: 14.0
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                elevation: 0.0,
                                                primary: Color(0xff353D64),
                                                side: BorderSide(
                                                  color: Color(0xff8AFFFF),
                                                  style: BorderStyle.solid,
                                                  width: 2
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:(context) =>ItemPage(
                                                      pokemon: lista,
                                                      nome: listaAux[index].nome,
                                                      box: favoritos,
                                                    ),
                                                  ),
                                                ).then((value) => {
                                                  favoritos = value,
                                                });
                                              },
                                            ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          )
                        :
                          Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 9.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Pokedex(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 10.0,
                                      //fixedSize: Size(150, 60),
                                      shadowColor: Color(0xff8400ff),
                                      side: BorderSide(
                                        color: Color(0xff1c2733),
                                        style: BorderStyle.solid,
                                        width: double.minPositive,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0)
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFEF9A9A),
                                            Color(0xFFE57373),
                                            Color(0xFFEF5350),
                                            Color(0xFFE53935),
                                            Color(0xFFD32F2F),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      child: Container(
                                        width: 160.0,
                                        height: 60,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Pokedex"),
                                              Image.asset("assets/logo.png",
                                                height: 50.0,
                                                width: 50.0,
                                                fit: BoxFit.fitWidth,
                                                colorBlendMode: BlendMode.dstATop,
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Pokedex(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 10.0,
                                      //fixedSize: Size(150, 60),
                                      shadowColor: Color(0xff8400ff),
                                      side: BorderSide(
                                        color: Color(0xff1c2733),
                                        style: BorderStyle.solid,
                                        width: double.minPositive,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0)
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFFB74D),
                                            Color(0xFFFFA726),
                                            Color(0xFFFB8C00),
                                            Color(0xFFF57C00),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      child: Container(
                                        width: 160.0,
                                        height: 60,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Localizações"),
                                              Image.asset("assets/logo.png",
                                                height: 50.0,
                                                width: 50.0,
                                                fit: BoxFit.fitWidth,
                                                colorBlendMode: BlendMode.dstATop,
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 9.0, 20.0, 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Pokedex(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 10.0,
                                      //fixedSize: Size(150, 60),
                                      shadowColor: Color(0xff8400ff),
                                      side: BorderSide(
                                        color: Color(0xff1c2733),
                                        style: BorderStyle.solid,
                                        width: double.minPositive,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0)
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF81C784),
                                            Color(0xFF66BB6A),
                                            Color(0xFF43A047),
                                            Color(0xFF388E3C),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      child: Container(
                                        width: 160.0,
                                        height: 60,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Evoluções"),
                                              Image.asset("assets/logo.png",
                                                height: 50.0,
                                                width: 50.0,
                                                fit: BoxFit.fitWidth,
                                                colorBlendMode: BlendMode.dstATop,
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FavoritosPage(box: favoritos),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 10.0,
                                      //fixedSize: Size(150, 60),
                                      shadowColor: Color(0xff8400ff),
                                      side: BorderSide(
                                        color: Color(0xff1c2733),
                                        style: BorderStyle.solid,
                                        width: double.minPositive,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0)
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF7986CB),
                                            Color(0xFF5C6BC0),
                                            Color(0xFF3949AB),
                                            Color(0xFF303F9F),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      child: Container(
                                        width: 160.0,
                                        height: 60,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Favoritos"),
                                              Image.asset("assets/logo.png",
                                                height: 50.0,
                                                width: 50.0,
                                                fit: BoxFit.fitWidth,
                                                colorBlendMode: BlendMode.dstATop,
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 18.0),
                  child: Text(
                    "Opções disponíveis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Tipos",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Habilidades",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Efeitos",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Localizações",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Especies",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Evoluções",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Idiomas",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Maquinas",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, right: 20.0, left: 20.0, bottom: 50.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide(
                            color: Color(0xff8AFFFF),
                            style: BorderStyle.solid,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassificacaoDePokemons(),
                          ),
                        );
                      },
                      child: Text(
                        "Itens",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Perfil",
          ),
        ],
        selectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        selectedItemColor: Color(0xff8AFFFF),
        unselectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        showUnselectedLabels: true,
        unselectedItemColor: Color(0x888AFFFF),
        backgroundColor: Color(0xff1c2733),
      ),
    );
  }
}


