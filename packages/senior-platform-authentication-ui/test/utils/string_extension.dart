extension ExtendedString on String {
  clearJson() => replaceAll(' ', '')
      .replaceAll('\n', '')
      .replaceAll(r'\', '')
      .replaceAll(r'"{', '{')
      .replaceAll(r'}"', '}');
}
