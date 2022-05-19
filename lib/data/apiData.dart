import 'package:http/http.dart' as http;

class HttpService {
  static Future getTiposPokemons(String? valor) async {
    final String _postURL = "https://pokeapi.co/api/v2";
    http.Response res = await http.get(
        Uri.parse("$_postURL/type/$valor"),
        headers: {"Accept": "application/json"}
    );
    return res;
  }

  static Future getPokedex() async {
    final String _postURL = "https://pokeapi.co/api/v2";
    http.Response res = await http.get(
        Uri.parse("$_postURL/pokedex/"),
        headers: {"Accept": "application/json"}
    );
    return res;
  }

  static Future getPokemons() async {
    final String _postURL = "https://pokeapi.co/api/v2";
    http.Response res = await http.get(
        Uri.parse("$_postURL/pokemon?offset=0&limit=1126"),
        headers: {"Accept": "application/json"}
    );
    return res;
  }

  static Future getPokemon(String url) async {
    http.Response res = await http.get(
        Uri.parse(url),
        headers: {"Accept": "application/json"}
    );

    return res;
  }

  static Future getSpeciePokemon(String url) async {
    http.Response res = await http.get(
        Uri.parse(url),
        headers: {"Accept": "application/json"}
    );

    return res;
  }

}