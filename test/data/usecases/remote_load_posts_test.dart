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
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({@required String url});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct URL', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteLoadPosts(httpClient: httpClient, url: url);
    await sut.load();

    verify(httpClient.request(url: url));
  });
}