import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_hyperlink_path_usecase.dart';
import 'hyperlink_path_event.dart';
import 'hyperlink_path_state.dart';

class HyperlinkPathBloc extends Bloc<GetHyperlinkPathEvent, HyperlinkPathState> {
  final GetHyperlinkPathUsecase _getHyperlinkPathUsecase;

  HyperlinkPathBloc({
    required GetHyperlinkPathUsecase getHyperlinkPathUsecase,
  })  : _getHyperlinkPathUsecase = getHyperlinkPathUsecase,
        super(InitialHyperlinkPathState()) {
    on<GetHyperlinkPathEvent>(_getHyperlinkPathEvent);
  }

  Future<void> _getHyperlinkPathEvent(
    GetHyperlinkPathEvent event,
    Emitter<HyperlinkPathState> emit,
  ) async {
    emit(LoadingHyperlinkPathState());

    final path = await _getHyperlinkPathUsecase.call(
      pdfLink: event.pdfLink,
      integrationLink: event.integrationLink,
    );

    path.fold(
      (l) {
        emit(
          ErrorGetHyperlinkPath(),
        );
      },
      (right) {
        emit(
          LoadedHyperlinkPathState(
            path: right,
          ),
        );
      },
    );
  }
}
