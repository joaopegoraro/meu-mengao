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

  final String id;
  final String link;
  final String titulo;
  final String logoSite;
  final String? foto;

  bool get isCorrupted => id.isEmpty || link.isEmpty || titulo.isEmpty;

  Noticia copyWith({
    String? id,
    String? foto,
    String? link,
    String? titulo,
    String? logoSite,
  }) {
    return Noticia(
      id: id ?? this.id,
      foto: foto ?? this.foto,
      link: link ?? this.link,
      titulo: titulo ?? this.titulo,
      logoSite: logoSite ?? this.logoSite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foto': foto,
      'link': link,
      'titulo': titulo,
      'logoSite': logoSite,
    };
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    return Noticia(
      id: map['id'] as String,
      foto: map['foto'] != null ? map['foto'] as String : null,
      link: map['link'] as String,
      titulo: map['titulo'] as String,
      logoSite: map['logoSite'] as String,
    );
  }

  @override
  String toString() {
    return 'Noticia(id: $id, foto: $foto, link: $link, titulo: $titulo, logoSite: $logoSite)';
  }

  @override
  bool operator ==(covariant Noticia other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.foto == foto &&
        other.link == link &&
        other.titulo == titulo &&
        other.logoSite == logoSite;
  }

  @override
  int get hashCode {
    return id.hashCode ^ foto.hashCode ^ link.hashCode ^ titulo.hashCode ^ logoSite.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Noticia.fromJson(String source) => Noticia.fromMap(json.decode(source) as Map<String, dynamic>);
}
