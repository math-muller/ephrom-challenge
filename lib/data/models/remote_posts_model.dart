import '../../domain/entities/entities.dart';
import 'package:meta/meta.dart';

import '../models/models.dart';
import '../http/http.dart';

class RemotePostsModel {
  final List<RemotePostsResultModel> result;

  RemotePostsModel({@required this.result});

  factory RemotePostsModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['result'])) {
      throw HttpError.invalidData;
    }
    return RemotePostsModel(
      result: json['Result']
          .map()<RemotePostsResultModel>(
              (resultJson) => RemotePostsResultModel.fromJson(resultJson))
          .toList(),
    );
  }

  PostEntity toEntity() => PostEntity(
    result: result.map<PostResultEntity>((result) => result.toEntity()).toList(),
  );
}
