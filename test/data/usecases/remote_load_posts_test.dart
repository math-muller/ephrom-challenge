import 'package:ephrom/domain/entities/entities.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ephrom/data/http/http.dart';
import 'package:ephrom/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  String url;
  RemoteLoadPosts sut;
  Map postResult;

  Map mockValidData() => {
        'Result': [
          {
            {
              "ID": "4590d445-77a7-43a5-8279-785b494d7577",
              "Codigo": "PS006",
              "Respostas": 1,
              "DataHora": "1616502241000",
              "EstaLido": false,
              "AutorID": "465bc8d5-ca8e-4c00-a6e6-de48d6479571",
              "AutorNome": "Beatriz Barbosa",
              "AutorImageUrl":
                  "https://randomuser.me/api/portraits/women/1.jpg",
              "Texto":
                  "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              "Versao": 3
            },
            {
              "ID": "2df65442-2650-4fae-b7c9-8dce6c18cbb0",
              "Codigo": "PS005",
              "Respostas": 0,
              "DataHora": "1616451300000",
              "EstaLido": false,
              "AutorID": "8b9f6b85-d73f-426b-8406-4e612d1293cf",
              "AutorNome": "Rodrigo Azevedo",
              "AutorImageUrl": "https://randomuser.me/api/portraits/men/73.jpg",
              "Texto":
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
              "Versao": 1
            }
          }
        ]
      };

  PostExpectation mockRequest() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      ));

  void mockHttpData(Map data) {
    postResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadPosts(httpClient: httpClient, url: url);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });

  test('Should return PostsResult on 200', () async {
    final result = await sut.load();

    expect(
        result,
        PostEntity(result: [
          PostResultEntity(
            id: postResult['result'][0]['ID'],
            codigo: postResult['result'][0]['Codigo'],
            respostas: postResult['result'][0]['Respostas'],
            dataHora: postResult['result'][0]['DataHora'],
            estaLido: postResult['result'][0]['EstaLido'],
            autorId: postResult['result'][0]['AutorID'],
            autorNome: postResult['result'][0]['AutorNome'],
            autorImageUrl: postResult['result'][0]['AutorImageUrl'],
            texto: postResult['result'][0]['Texto'],
            versao: postResult['result'][0]['Versao'],
          ),
          PostResultEntity(
            id: postResult['result'][1]['ID'],
            codigo: postResult['result'][1]['Codigo'],
            respostas: postResult['result'][1]['Respostas'],
            dataHora: postResult['result'][1]['DataHora'],
            estaLido: postResult['result'][1]['EstaLido'],
            autorId: postResult['result'][1]['AutorID'],
            autorNome: postResult['result'][1]['AutorNome'],
            autorImageUrl: postResult['result'][1]['AutorImageUrl'],
            texto: postResult['result'][1]['Texto'],
            versao: postResult['result'][1]['Versao'],
          )
        ]));
  });

  
}
