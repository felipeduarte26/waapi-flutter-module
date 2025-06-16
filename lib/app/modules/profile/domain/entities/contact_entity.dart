import 'package:equatable/equatable.dart';

class ContactEntity<T> extends Equatable {
  final String? typeEdit;
  final T content;

  const ContactEntity({
    this.typeEdit,
    required this.content,
  });

  @override
  List<Object?> get props {
    return [
      typeEdit,
      content,
    ];
  }
}
