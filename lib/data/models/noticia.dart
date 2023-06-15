// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Noticia {
  Noticia({
    required this.id,
    required this.link,
    required this.titulo,
    required this.logoSite,
    this.foto,
  });

  final int id;
  final String link;
  final String titulo;
  final String logoSite;
  final String? foto;

  bool get isCorrupted => link.isEmpty || titulo.isEmpty;

  Noticia copyWith({
    int? id,
    String? link,
    String? titulo,
    String? logoSite,
    String? foto,
  }) {
    return Noticia(
      id: id ?? this.id,
      link: link ?? this.link,
      titulo: titulo ?? this.titulo,
      logoSite: logoSite ?? this.logoSite,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'link': link,
      'titulo': titulo,
      'logoSite': logoSite,
      'foto': foto,
    };
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    return Noticia(
      id: map['id'] as int,
      link: map['link'] as String,
      titulo: map['titulo'] as String,
      logoSite: map['logoSite'] as String,
      foto: map['foto'] != null ? map['foto'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Noticia(id: $id, link: $link, titulo: $titulo, logoSite: $logoSite, foto: $foto)';
  }

  @override
  bool operator ==(covariant Noticia other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.link == link &&
        other.titulo == titulo &&
        other.logoSite == logoSite &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return id.hashCode ^ link.hashCode ^ titulo.hashCode ^ logoSite.hashCode ^ foto.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Noticia.fromJson(String source) => Noticia.fromMap(json.decode(source) as Map<String, dynamic>);
}
