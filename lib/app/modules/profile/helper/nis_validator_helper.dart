class NisValidatorHelper {
  static const List<int> weigths = [
    3,
    2,
    9,
    8,
    7,
    6,
    5,
    4,
    3,
    2,
  ];

  static const stripRegex = r'[^\d]';

  static const nisLength = 11;

  static bool isValid(String? nis, [stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      nis = strip(
        nis,
      );
    }

    // NIS must be defined
    if (nis == null || nis.isEmpty) {
      return false;
    }

    // NIS must have 11 chars
    if (nis.length != nisLength) {
      return false;
    }

    List<int> numbers = nis.split('').map((number) => int.parse(number, radix: 10)).toList();

    List<int> multiplied = [];

    for (var i = 0; i < weigths.length; i++) {
      multiplied.add(numbers[i] * weigths[i]);
    }

    int mod = multiplied.reduce((buffer, number) => buffer + number) % nisLength;

    int digit = nisLength - mod;

    if (digit == 10 || digit == 11) {
      digit = 0;
    }

    return digit == numbers[10];
  }

  static String format(String nis) {
    RegExp regExp = RegExp(
      r'^(\d{3})(\d{5})(\d{2})(\d{1})$',
    );

    return strip(nis).replaceAllMapped(
      regExp,
      (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}',
    );
  }

  static String strip(String? nis) {
    RegExp regExp = RegExp(
      stripRegex,
    );
    nis = nis ?? '';

    return nis.replaceAll(
      regExp,
      '',
    );
  }
}
