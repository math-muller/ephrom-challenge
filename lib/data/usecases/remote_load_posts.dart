import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

import '../models/models.dart';
import '../http/http.dart';

class RemoteLoadPosts implements LoadPosts {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPosts({
    @required this.httpClient,
    @required this.url,
  });

  Future<PostEntity> load() async {
    try {
      final json = await httpClient.request(url: url, method: 'get');
      return RemotePostsModel.fromJson(json).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
