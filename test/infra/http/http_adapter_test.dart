import 'package:ephrom/data/http/http.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ephrom/infra/http/http.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdapter sut;
  String url;
  Uri uri;

  PostExpectation mockRequest() => when(client.get(any));

  void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
    mockRequest().thenAnswer((_) async => Response(body, statusCode));
  }

  void mockError() {
    mockRequest().thenThrow(Exception());
  }

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    mockResponse(200);
  });

  group('get', () {
    test('Should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(client.get(uri));
    });

    test('Should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(client.get(uri));
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.request(url: url, method: 'get');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if get returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'get');

      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if get returns 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if get returns 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if get returns 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if get throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
