class Noticia {
  Noticia({
    required this.id,
    required this.link,
    required this.titulo,
    required this.siteId,
    this.foto,
  });

  final String id;
  final String? foto;
  final String link;
  final String titulo;
  final String siteId;

  bool get isCorrupted => id.isEmpty || link.isEmpty || titulo.isEmpty || siteId.isEmpty;

  Noticia copyWith({
    String? id,
    String? foto,
    String? link,
    String? titulo,
    String? siteId,
  }) {
    return Noticia(
      id: id ?? this.id,
      foto: foto ?? this.foto,
      link: link ?? this.link,
      titulo: titulo ?? this.titulo,
      siteId: siteId ?? this.siteId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foto': foto,
      'link': link,
      'titulo': titulo,
      'siteId': siteId,
    };
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    return Noticia(
      id: map['id'] ?? "",
      foto: map['foto'] != null ? map['foto'] ?? "" : null,
      link: map['link'] ?? "",
      titulo: map['titulo'] ?? "",
      siteId: map['siteId'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Noticia(foto: $foto, link: $link, titulo: $titulo, siteId: $siteId)';
  }

  @override
  bool operator ==(covariant Noticia other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.foto == foto &&
        other.link == link &&
        other.titulo == titulo &&
        other.siteId == siteId;
  }

  @override
  int get hashCode {
    return foto.hashCode ^ link.hashCode ^ titulo.hashCode ^ siteId.hashCode;
  }
}
