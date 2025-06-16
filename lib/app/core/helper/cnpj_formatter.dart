abstract class CnpjFormatter {
  static String cnpjFormatter({
    required String cnpj,
  }) {
    String stringCnpj = cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');

    if (stringCnpj.length == 14) {
      final partOne = stringCnpj.substring(0, 2);
      final partTwo = stringCnpj.substring(2, 5);
      final partTree = stringCnpj.substring(5, 8);
      final partFour = stringCnpj.substring(8, 12);
      final partFive = stringCnpj.substring(12, 14);

      return '$partOne.$partTwo.$partTree/$partFour-$partFive';
    }

    return stringCnpj;
  }
}
