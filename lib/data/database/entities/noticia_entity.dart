// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meu_mengao/data/models/noticia.dart';

class NoticiaEntity {
  NoticiaEntity({
    required this.id,
    required this.data,
    required this.link,
    required this.titulo,
    required this.logoSite,
    this.foto,
  });

  final int? id;
  final String? data;
  final String? link;
  final String? titulo;
  final String? logoSite;
  final String? foto;

  Noticia toNoticia() {
    return Noticia(
        id: id ?? 0,
        data: DateTime.fromMillisecondsSinceEpoch(int.tryParse(data ?? "") ?? 0),
        link: link ?? "",
        titulo: titulo ?? "",
        logoSite: logoSite ?? "",
        foto: foto);
  }

  factory NoticiaEntity.fromNoticia(Noticia noticia) {
    return NoticiaEntity(
        id: noticia.id,
        data: noticia.data?.millisecondsSinceEpoch.toString() ?? "",
        link: noticia.link,
        titulo: noticia.titulo,
        logoSite: noticia.logoSite,
        foto: noticia.foto);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _idColumn: id,
      _dataColumn: data,
      _linkColumn: link,
      _tituloColumn: titulo,
      _logoSiteColumn: logoSite,
      _fotoColumn: foto,
    };
  }

  factory NoticiaEntity.fromMap(Map<String, dynamic> map) {
    return NoticiaEntity(
      id: map[_idColumn] as int,
      data: map[_dataColumn] as String,
      link: map[_linkColumn] as String,
      titulo: map[_tituloColumn] as String,
      logoSite: map[_logoSiteColumn] as String,
      foto: map[_fotoColumn] != null ? map[_fotoColumn] as String : null,
    );
  }

  static const _idColumn = "id";
  static const _dataColumn = "data";
  static const _linkColumn = "link";
  static const _tituloColumn = "titulo";
  static const _logoSiteColumn = "logoSite";
  static const _fotoColumn = "foto";

  static const tableName = "noticias";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $_idColumn INT(11) PRIMARY KEY, 
    $_dataColumn VARCHAR(255), 
    $_linkColumn VARCHAR(255), 
    $_tituloColumn VARCHAR(255), 
    $_logoSiteColumn TEXT,
    $_fotoColumn TEXT)
  """;
}
