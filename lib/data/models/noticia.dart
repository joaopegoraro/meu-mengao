import 'dart:convert';

class Noticia {
  Noticia({
    this.foto,
    required this.link,
    required this.titulo,
    required this.siteId,
  });

  String? foto;
  String link;
  String titulo;
  String siteId;

  Noticia copyWith({
    String? foto,
    String? link,
    String? titulo,
    String? siteId,
  }) {
    return Noticia(
      foto: foto ?? this.foto,
      link: link ?? this.link,
      titulo: titulo ?? this.titulo,
      siteId: siteId ?? this.siteId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foto': foto,
      'link': link,
      'titulo': titulo,
      'siteId': siteId,
    };
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    return Noticia(
      foto: map['foto'] != null ? map['foto'] as String : null,
      link: map['link'] as String,
      titulo: map['titulo'] as String,
      siteId: map['siteId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Noticia.fromJson(String source) => Noticia.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Noticia(foto: $foto, link: $link, titulo: $titulo, siteId: $siteId)';
  }

  @override
  bool operator ==(covariant Noticia other) {
    if (identical(this, other)) return true;

    return other.foto == foto && other.link == link && other.titulo == titulo && other.siteId == siteId;
  }

  @override
  int get hashCode {
    return foto.hashCode ^ link.hashCode ^ titulo.hashCode ^ siteId.hashCode;
  }
}
