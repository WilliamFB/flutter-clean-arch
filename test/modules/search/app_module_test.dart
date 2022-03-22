import 'dart:convert';

import 'package:clean_architecture_studies/app_module.dart';
import 'package:clean_architecture_studies/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_studies/modules/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  // Vai substituir a injeção do dio pelo nosso dio mock.
  // Isso porque vamos precisar do mock do dio, já que não queremos interferência da conexão nesses testes.

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);
  test('Deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();

    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Deve retornar uma lista de ResultSearch', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("William");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
