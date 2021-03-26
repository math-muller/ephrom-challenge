import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteLoadPosts {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPosts({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  String url;
  RemoteLoadPosts sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteLoadPosts(httpClient: httpClient, url: url);
  });
  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });
}
