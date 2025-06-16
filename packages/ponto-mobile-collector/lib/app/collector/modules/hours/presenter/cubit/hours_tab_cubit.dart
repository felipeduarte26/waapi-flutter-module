import 'package:flutter_bloc/flutter_bloc.dart';

class HoursTabCubit extends Cubit<int> {
  int selectedTab = 0;

  HoursTabCubit() : super(0);

  void changToTab(int newTab) {
    selectedTab = newTab;
    emit(selectedTab);
  }
}
