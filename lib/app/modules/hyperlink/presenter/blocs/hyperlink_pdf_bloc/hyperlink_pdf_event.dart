import 'package:equatable/equatable.dart';

abstract class HyperlinkPdfEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetHyperlinkPdfEvent extends HyperlinkPdfEvent {
  final String pdfLink;

  GetHyperlinkPdfEvent({
    required this.pdfLink,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      pdfLink,
    ];
  }
}
