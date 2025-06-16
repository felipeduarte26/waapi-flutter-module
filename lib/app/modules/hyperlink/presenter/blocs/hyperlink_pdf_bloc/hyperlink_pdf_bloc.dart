import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_hyperlink_pdf_usecase.dart';
import 'hyperlink_pdf_event.dart';
import 'hyperlink_pdf_state.dart';

class HyperlinkPdfBloc extends Bloc<GetHyperlinkPdfEvent, HyperlinkPdfState> {
  final GetHyperlinkPdfUsecase _getHyperlinkPdfUsecase;

  HyperlinkPdfBloc({
    required GetHyperlinkPdfUsecase getHyperlinkPdfUsecase,
  })  : _getHyperlinkPdfUsecase = getHyperlinkPdfUsecase,
        super(InitialHyperlinkPdfState()) {
    on<GetHyperlinkPdfEvent>(_getHyperlinkPdfEvent);
  }

  Future<void> _getHyperlinkPdfEvent(
    GetHyperlinkPdfEvent event,
    Emitter<HyperlinkPdfState> emit,
  ) async {
    emit(LoadingHyperlinkPdfState());

    final pdf = await _getHyperlinkPdfUsecase.call(
      pdfLink: event.pdfLink,
    );

    pdf.fold(
      (left) {
        emit(ErrorHyperlinkPdfState());
      },
      (right) {
        emit(
          LoadedHyperlinkPdfState(
            path: right,
          ),
        );
      },
    );
  }
}
