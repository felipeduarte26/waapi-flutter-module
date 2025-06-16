abstract class CPFFormatter {
  static String cpfFormatter({
    required String cpf,
  }) {
    String stringCpf = cpf.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');

    if (stringCpf.length == 11) {
      final partOne = stringCpf.substring(0, 3);
      final partTwo = stringCpf.substring(3, 6);
      final partTree = stringCpf.substring(6, 9);
      final partFour = stringCpf.substring(9, 11);

      return '$partOne.$partTwo.$partTree-$partFour';
    }

    return stringCpf;
  }
}
