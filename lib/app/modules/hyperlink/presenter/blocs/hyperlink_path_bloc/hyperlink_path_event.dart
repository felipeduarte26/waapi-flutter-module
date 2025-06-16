import 'package:equatable/equatable.dart';

abstract class HyperlinkPathEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetHyperlinkPathEvent extends HyperlinkPathEvent {
  final String pdfLink;
  final String integrationLink;

  GetHyperlinkPathEvent({
    required this.pdfLink,
    required this.integrationLink,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      pdfLink,
      integrationLink,
    ];
  }
}
