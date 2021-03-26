import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'entities.dart';

class PostEntity extends Equatable {
  final List<PostResultEntity> result;

  List get props => [result];

  PostEntity({@required this.result});
}
