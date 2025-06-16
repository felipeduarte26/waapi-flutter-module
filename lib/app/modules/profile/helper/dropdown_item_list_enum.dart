import 'package:senior_design_system/components/senior_dropdown_button/senior_dropdown_button_item.dart';

class DropdownItemListEnum<T> {
  List<SeniorDropdownButtonItem> dropdownItemList({
    required List<T> values,
    required String Function(T) title,
  }) {
    List<SeniorDropdownButtonItem> seniorDropdownButtonItem = [];
    for (var element in values) {
      seniorDropdownButtonItem.add(
        SeniorDropdownButtonItem(
          value: element,
          title: title(element),
        ),
      );
    }
    return seniorDropdownButtonItem;
  }
}
