import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  setUp(
    () {},
  );

  test(
    'TabActionBloc bloc Test',
    () async {
      TabActionBloc bloc = TabActionBloc();

      // Assert
      expect(bloc.state.tabIndex, 0);

      bloc.add(ChangeTabActionEvent(tabIndexToChange: 1));

      await Future.delayed(const Duration(milliseconds: 100));
      expect(bloc.state.tabIndex, 1);
    },
  );
}
