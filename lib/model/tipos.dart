class TiposPokemons {
  final String nome;
  final dynamic url;

  const TiposPokemons({
    required this.nome,
    required this.url,
  });

  factory TiposPokemons.fromJson(Map<String, dynamic> json) {
    return TiposPokemons(
      nome: json['name'],
      url: json['url'],
    );
  }
}