import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/apiData.dart';
import '../model/cores/listaDeCores.dart';
import '../model/pokemon.dart';

class PokemonDetalhes extends StatefulWidget {
  final String link;
  final List<Pokemons> box;

  PokemonDetalhes({
    required this.box,
    required this.link
  });

  @override
  State<StatefulWidget> createState() {
    return PokemonDetalhesState();
  }
}

class PokemonDetalhesState extends State<PokemonDetalhes>{
  Pokemons pokemonEncontrado = Pokemons(
    id: 0,
    nome: '-',
    habilidades: ['-', '-'],
    experiencia: 0,
    altura: 0,
    peso: 0,
    especie: {'key': '-', 'key2': '-'},
    imagens: {'key': '-', 'key2': '-'},
    tipos: [{'type': {'name': '-'}},],
  );
  String imagemEncontrada = "https://logodownload.org/wp-content/uploads/2017/08/pokemon-logo-0.png";
  CoresLista palheta = CoresLista();
  bool temNosFavoritos = false;
  final int tamanho = 1;
  bool _loader = true;
  String about = '';

  void _iniciaLista() async {
    await HttpService.getPokemon(widget.link).then((response) {
      setState(() {
        Map<String, dynamic> resultados = json.decode(response.body);

        if (resultados.isNotEmpty) {
          pokemonEncontrado = Pokemons(
              id: resultados['id'],
              nome: resultados['name'],
              habilidades: resultados['abilities'],
              experiencia: resultados['base_experience'],
              altura: resultados['height'],
              peso: resultados['weight'],
              especie: resultados['species'],
              imagens: resultados['sprites'],
              tipos: resultados['types']
          );
          _loader = false;
          _checarFavorito();
          imagemEncontrada = pokemonEncontrado.imagens["other"]["official-artwork"]["front_default"];
          _sobre();
        }
      });
    });
  }

  Widget _loading() {
    return Container(
      height: MediaQuery.of(context).size.shortestSide,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: CircularProgressIndicator(
              color: Color(0xff8AFFFF),
              strokeWidth: 5.0,
            ),
            height: 150.0,
            width: 150.0,
          ),
        ],
      ),
    );
  }

  void _checarFavorito() {
    for(var i=0; i < widget.box.length; i++) {
      if (widget.box[i].id == pokemonEncontrado.id) {
        setState(() {
          temNosFavoritos = true;
        });
        break;
      } else {
        setState(() {
          temNosFavoritos = false;
        });
      }
    }
  }

  void _sobre() async {
    await HttpService.getSpeciePokemon(pokemonEncontrado.especie['url']).
    then((response) {
      setState(() {
        Map<String, dynamic> resultados = json.decode(response.body);
        //print('Resultados:  ${resultados}');
        List<String> especie = resultados['flavor_text_entries'][7]['flavor_text'].toString().split('\n');
        for (String palavra in especie) {
          about += palavra + " ";
        }
      });
    });
  }

  List<Color> _setarCor(List<dynamic> tipo, int indice) {
    List<Color> cor = <Color>[];

    switch(tipo[indice]['type']['name']) {
      case "grass":
        cor = palheta.cores[0];
        break;

      case "normal":
        cor = palheta.cores[1];
        break;

      case "fighting":
        cor = palheta.cores[2];
        break;

      case "fire":
        cor = palheta.cores[3];
        break;

      case "flying":
        cor = palheta.cores[4];
        break;

      case "poison":
        cor = palheta.cores[5];
        break;

      case "ground":
        cor = palheta.cores[6];
        break;

      case "rock":
        cor = palheta.cores[7];
        break;

      case "bug":
        cor = palheta.cores[8];
        break;

      case "ghost":
        cor = palheta.cores[9];
        break;

      case "steel":
        cor = palheta.cores[10];
        break;

      case "water":
        cor = palheta.cores[11];
        break;

      case "electric":
        cor = palheta.cores[12];
        break;

      case "psychic":
        cor = palheta.cores[13];
        break;

      case "ice":
        cor = palheta.cores[14];
        break;

      case "dragon":
        cor = palheta.cores[15];
        break;

      case "dark":
        cor = palheta.cores[16];
        break;

      case "fairy":
        cor = palheta.cores[17];
        break;

      case "unknown":
        cor = palheta.cores[18];
        break;

      case "shadow":
        cor = palheta.cores[19];
        break;

      default:
        cor.clear();
        cor = [Color(0xff353D64), Color(0xff353D64)];
        break;
    }
    return cor;
  }

  String _formatarNome(String name) {
    String nome = '';
    List<String> nomeEditado = name.split('-');
    for (String a in nomeEditado) {
      nome += a + " ";
    }

    return nome;
  }

  String _formatarAltura(int _height) {
    String altura = '';
    altura = "${(_height/10).toStringAsFixed(2)} m";
    return altura;
  }

  String _formatarPeso(int weight) {
    String peso = '';
    peso = "${weight/10} Kg (${((weight/10)/0.45359237).toStringAsFixed(1)} lbs)";  //valor de 1kg em libras: 0,45359237
    return peso;
  }

  Widget _widgetTipos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 31.0,
        width: 300.0,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pokemonEncontrado.tipos.length,
            itemBuilder: (contexto, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Container(
                  height: 30.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: _setarCor(pokemonEncontrado.tipos, index),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 92.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Color(0xffebeeff),
                    ),
                    alignment: Alignment.center,
                    child: Text("${pokemonEncontrado.tipos[index]['type']['name']}",
                      style: TextStyle(
                        color: Color(0xff353D64),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  void _addInfo(Pokemons poke) {
    int aux = 0;
    for(var i=0; i < widget.box.length; i++) {
      if (widget.box[i].id == poke.id) {
        aux++;
      }
    }
    if (aux == 0) {
      setState(() {
        widget.box.add(poke);
        temNosFavoritos = true;
      });
    }
  }

  void _deleteInfo(Pokemons poke) {
    int aux = 0;
    for(var i=0; i < widget.box.length; i++) {
      if (widget.box[i].id == poke.id) {
        setState(() {
          widget.box.remove(widget.box[i]);
          temNosFavoritos = false;
        });
      }
    }
  }

  @override
  void initState() {
    _iniciaLista();
    _formatarNome(pokemonEncontrado.nome);
    _formatarPeso(pokemonEncontrado.altura);
    _formatarPeso(pokemonEncontrado.peso);
    _widgetTipos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Pokémon",
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
            Navigator.of(context).pop([widget.box, temNosFavoritos]);
          },
        ),
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
            children: [
              _loader
                ? _loading()
                : Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 300.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                //center: Alignment(0.7, -0.6),
                                radius: 0.5,
                                colors: _setarCor(pokemonEncontrado.tipos, 0),
                              ),
                              borderRadius: BorderRadius.circular(150.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 225.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 450.0,
                        maxHeight: double.infinity,
                        minWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffebeeff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: tamanho,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 40.0, bottom: 18.0),
                              child: Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 50.0,
                                              width: MediaQuery.of(context).size.shortestSide/1.25, // imprime o tamanho da largura da tela
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 80.0),
                                                child: Text(_formatarNome(pokemonEncontrado.nome.toUpperCase()),
                                                  style: TextStyle(
                                                    color: Color(0xff353D64),
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                temNosFavoritos
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                              ),
                                              iconSize: 40.0,
                                              color: Color(0xff353D64),
                                              onPressed: () {
                                                if (!temNosFavoritos) {
                                                  _addInfo(pokemonEncontrado);
                                                } else {
                                                  _deleteInfo(pokemonEncontrado);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text("#${pokemonEncontrado.id}",
                                        style: TextStyle(
                                          color: Color(0xff353D64),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Altura: ${_formatarAltura(pokemonEncontrado.altura)}",
                                        style: TextStyle(
                                          color: Color(0xff353D64),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Peso: ${_formatarPeso(pokemonEncontrado.peso)}",
                                        style: TextStyle(
                                          color: Color(0xff353D64),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _widgetTipos(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text(about,
                                          style: TextStyle(
                                            color: Color(0xff353D64),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Image.network("$imagemEncontrada",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}