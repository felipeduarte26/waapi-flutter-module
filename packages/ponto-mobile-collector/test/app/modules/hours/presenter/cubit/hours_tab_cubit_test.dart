import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/hours/presenter/cubit/hours_tab_cubit.dart';

void main() {
  late HoursTabCubit hoursTabCubit;

  setUp(() {
    hoursTabCubit = HoursTabCubit();
  });

  group('HoursTabCubit', () {
    blocTest(
      'emits [1] when CounterIncrementPressed is added',
      build: () => hoursTabCubit,
      act: (bloc) => bloc.changToTab(1),
      expect: () => [1],
    );
  });
}
