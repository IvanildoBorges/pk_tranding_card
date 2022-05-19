class SearchPokemons {
  final String nome;
  final dynamic link;

  const SearchPokemons({
    required this.nome,
    required this.link,
  });

  factory SearchPokemons.fromJson(Map<String, dynamic> json) {
    return SearchPokemons(
      nome: json['name'],
      link: json['url'],
    );
  }
}