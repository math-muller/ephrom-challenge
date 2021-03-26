import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PostResultEntity extends Equatable {
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

  List get props => [
        id,
        codigo,
        respostas,
        dataHora,
        estaLido,
        autorId,
        autorNome,
        autorImageUrl,
        texto,
        versao,
      ];

  PostResultEntity({
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
}
