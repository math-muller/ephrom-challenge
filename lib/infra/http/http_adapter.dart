import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final Uri uri = Uri.parse(url);
    var response = Response('', 500);
    try {
      if (method == 'get') {
        response = await client.get(uri);
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }
}

Map _handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return response.body.isEmpty ? null : jsonDecode(response.body);
    case 204:
      return null;
    case 400:
      throw HttpError.badRequest;
    case 401:
      throw HttpError.unauthorized;
    case 403:
      throw HttpError.forbidden;
    case 404:
      throw HttpError.notFound;
    default:
      throw HttpError.serverError;
  }
}
