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
      idColumn: id,
      dataColumn: data,
      linkColumn: link,
      tituloColumn: titulo,
      logoSiteColumn: logoSite,
      fotoColumn: foto,
    };
  }

  factory NoticiaEntity.fromMap(Map<String, dynamic> map) {
    return NoticiaEntity(
      id: map[idColumn] as int,
      data: map[dataColumn] as String,
      link: map[linkColumn] as String,
      titulo: map[tituloColumn] as String,
      logoSite: map[logoSiteColumn] as String,
      foto: map[fotoColumn] != null ? map[fotoColumn] as String : null,
    );
  }

  static const idColumn = "id";
  static const dataColumn = "data";
  static const linkColumn = "link";
  static const tituloColumn = "titulo";
  static const logoSiteColumn = "logoSite";
  static const fotoColumn = "foto";

  static const tableName = "noticias";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $idColumn INT(11) PRIMARY KEY, 
    $dataColumn VARCHAR(255), 
    $linkColumn VARCHAR(255), 
    $tituloColumn VARCHAR(255), 
    $logoSiteColumn TEXT,
    $fotoColumn TEXT)
  """;
}
