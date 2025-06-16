class ZipCodeFormatter {
  String formatZipCode({
    required String zipCode,
    String? country,
  }) {
    if (country != null && country.toUpperCase() == 'BRASIL' && zipCode.length == 8) {
      final partOne = zipCode.substring(0, 5);
      final partTwo = zipCode.substring(5, 8);

      return '$partOne-$partTwo';
    }

    return zipCode;
  }
}
