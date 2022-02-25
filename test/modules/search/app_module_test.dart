import 'package:clean_architecture_studies/app_module.dart';
import 'package:clean_architecture_studies/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  // initModule(AppModule());
  test('Deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();

    expect(usecase, isA<SearchByTextImpl>());
  });
}
