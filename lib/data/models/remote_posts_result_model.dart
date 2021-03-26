import 'package:ephrom/domain/entities/entities.dart';
import 'package:meta/meta.dart';

import '../http/http.dart';

class RemotePostsResultModel {
  final String id;
  final String codigo;
  final int respostas;
  final String dataHora;
  final bool estaLido;
  final String autorId;
  final String autorNome;
  final String autorImageUrl;
  final String texto;
  final int versao;

  RemotePostsResultModel({
    @required this.id,
    @required this.codigo,
    @required this.respostas,
    @required this.dataHora,
    @required this.estaLido,
    @required this.autorId,
    @required this.autorNome,
    @required this.autorImageUrl,
    @required this.texto,
    @required this.versao,
  });

  factory RemotePostsResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'codigo',
      'respostas',
      'dataHora',
      'estaLido',
      'autorId',
      'autorNome',
      'autorImageUrl',
      'texto',
      'versao',
    ])) {
      throw HttpError.invalidData;
    }
    return RemotePostsResultModel(
      id: json["ID"],
      codigo: json["Codigo"],
      respostas: json["Respostas"],
      dataHora: json["DataHora"],
      estaLido: json["EstaLido"],
      autorId: json["AutorID"],
      autorNome: json["AutorNome"],
      autorImageUrl: json["AutorImageUrl"],
      texto: json["Texto"],
      versao: json["Versao"],
    );
  }

  PostResultEntity toEntity() => PostResultEntity(
        id: id,
        codigo: codigo,
        respostas: respostas,
        dataHora: dataHora,
        estaLido: estaLido,
        autorId: autorId,
        autorNome: autorNome,
        autorImageUrl: autorImageUrl,
        texto: texto,
        versao: versao,
      );
}
