// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meu_mengao/data/models/noticia.dart';

class NoticiaEntity {
  NoticiaEntity({
    required this.id,
    required this.index,
    required this.link,
    required this.titulo,
    required this.logoSite,
    this.foto,
  });

  final int id;
  final int index;
  final String link;
  final String titulo;
  final String logoSite;
  final String? foto;

  Noticia toNoticia() {
    return Noticia(
      id: id,
      link: link,
      titulo: titulo,
      logoSite: logoSite,
    );
  }

  factory NoticiaEntity.fromNoticia(Noticia noticia) {
    return NoticiaEntity(
      id: noticia.id,
      index: 0,
      link: noticia.link,
      titulo: noticia.titulo,
      logoSite: noticia.logoSite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _idColumn: id,
      _indexColumn: id,
      _linkColumn: link,
      _tituloColumn: titulo,
      _logoSiteColumn: logoSite,
      _fotoColumn: foto,
    };
  }

  factory NoticiaEntity.fromMap(Map<String, dynamic> map) {
    return NoticiaEntity(
      id: map[_idColumn] as int,
      index: map[_indexColumn] as int,
      link: map[_linkColumn] as String,
      titulo: map[_tituloColumn] as String,
      logoSite: map[_logoSiteColumn] as String,
      foto: map[_fotoColumn] != null ? map[_fotoColumn] as String : null,
    );
  }

  static const _idColumn = "id";
  static const _indexColumn = "index";
  static const _linkColumn = "link";
  static const _tituloColumn = "titulo";
  static const _logoSiteColumn = "logoSite";
  static const _fotoColumn = "foto";

  static const tableName = "noticias";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $_idColumn INT(11) PRIMARY KEY, 
    $_indexColumn INT(11), 
    $_linkColumn VARCHAR(255), 
    $_tituloColumn VARCHAR(255), 
    $_logoSiteColumn TEXT,
    $_fotoColumn TEXT)
  """;
}
