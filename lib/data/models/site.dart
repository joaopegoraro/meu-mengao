import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Site {
  Site({
    required this.id,
    required this.nome,
    this.logo,
  });

  final String id;
  final String nome;
  final String? logo;

  bool get isCorrupted => id.isEmpty || nome.isEmpty;

  Site copyWith({
    String? id,
    String? nome,
    String? logo,
  }) {
    return Site(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'logo': logo,
    };
  }

  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id'] ?? "",
      nome: map['nome'] ?? "",
      logo: map['logo'] != null ? map['logo'] ?? "" : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Site(id: $id, nome: $nome, logo: $logo)';

  @override
  bool operator ==(covariant Site other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ logo.hashCode;
}
