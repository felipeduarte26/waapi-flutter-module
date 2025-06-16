import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_hyperlinks_usecase.dart';
import 'hyperlink_event.dart';
import 'hyperlink_state.dart';

class HyperlinkBloc extends Bloc<HyperlinkEvent, HyperlinkState> {
  final GetHyperlinksUsecase _getHyperlinksUsecase;

  HyperlinkBloc({
    required GetHyperlinksUsecase getHyperlinkUsecase,
  })  : _getHyperlinksUsecase = getHyperlinkUsecase,
        super(InitialHyperlinkState()) {
    on<GetHyperlinkEvent>(_getHyperlinkEvent);
  }

  Future<void> _getHyperlinkEvent(
    GetHyperlinkEvent event,
    Emitter<HyperlinkState> emit,
  ) async {
    emit(LoadingHyperlinkState());

    final hyperlink = await _getHyperlinksUsecase.call(
      employeeId: event.employeeId,
      userRoleId: event.userRoleId,
    );

    hyperlink.fold(
      (left) {
        emit(ErrorHyperlinkState());
      },
      (right) {
        emit(
          LoadedHyperlinkState(
            hyperlinksEntity: right,
          ),
        );
      },
    );
  }
}
