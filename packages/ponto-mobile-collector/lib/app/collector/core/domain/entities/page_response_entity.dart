class PageResponseEntity<T> {
  final int pageNumber;
  final int totalElements;
  final List<T> content;

  PageResponseEntity({
    required this.pageNumber,
    required this.totalElements,
    required this.content,
  });
}
