import 'dart:convert';

import 'package:clean_architecture_studies/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_studies/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  final datasource = GithubDatasource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch("william");

    expect(future, completes);
  });

  test('Se não for status 200 deve retornar um DatasourceError', () {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch("william");

    expect(future, throwsA(isA<DataSourceError>()));
  });
}
