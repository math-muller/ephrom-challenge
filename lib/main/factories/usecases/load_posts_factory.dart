import 'package:ephrom/main/factories/http/http.dart';

import '../../../data/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';

LoadPosts makeRemoteLoadPosts() {
  return RemoteLoadPosts(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl(),
  );
}
