import '../extension/string_extension.dart';

class EnumHelper<T extends Enum?> {
  T? stringToEnum({
    required String? stringToParse,
    required List<T> values,
  }) {
    final formattedString = stringToParse?.toCamelCase ?? '';

    final matchValues = values.where(
      (value) {
        return (value as Enum).name == formattedString ||
            value.name ==
                formattedString.replaceAll(
                  '_',
                  '',
                );
      },
    );

    if (matchValues.isEmpty) {
      return null;
    }

    return matchValues.first;
  }

  String enumToString({
    required T enumToParse,
  }) {
    return enumToParse?.name.toSnakeCase ?? '';
  }
}
