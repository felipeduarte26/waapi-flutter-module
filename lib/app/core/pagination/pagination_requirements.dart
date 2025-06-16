import 'package:equatable/equatable.dart';

class PaginationRequirements extends Equatable {
  final int page;
  final int limit;
  final String queryText;

  const PaginationRequirements({
    required this.page,
    this.limit = 10,
    this.queryText = '',
  });

  int get offset {
    return (page - 1) * limit;
  }

  @override
  List<Object?> get props {
    return [
      page,
      limit,
      queryText,
    ];
  }
}
