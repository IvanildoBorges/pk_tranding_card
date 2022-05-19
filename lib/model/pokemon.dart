class Pokemons {
  final int id;
  final String nome;
  final List<dynamic> habilidades;
  final int experiencia;
  final int altura;
  final int peso;
  final Map<String, dynamic> especie;
  final Map<String, dynamic> imagens;
  final List<dynamic> tipos;

  const Pokemons({
    required this.id,
    required this.nome,
    required this.habilidades,
    required this.experiencia,
    required this.altura,
    required this.peso,
    required this.especie,
    required this.imagens,
    required this.tipos,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json) {
    return Pokemons(
      id: json['id'],
      nome: json['name'],
      habilidades: json['abilities'],
      experiencia: json['"base_experience'],
      altura: json['height'],
      peso: json['weight'],
      especie: json['"species'],
      imagens: json['sprites'],
      tipos: json['types']
    );
  }
}