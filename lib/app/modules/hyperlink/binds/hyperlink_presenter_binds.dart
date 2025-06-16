import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/hyperlink_bloc/hyperlink_bloc.dart';
import '../presenter/blocs/hyperlink_path_bloc/hyperlink_path_bloc.dart';
import '../presenter/blocs/hyperlink_pdf_bloc/hyperlink_pdf_bloc.dart';

class HyperlinkPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.factory(
      (i) {
        return HyperlinkBloc(
          getHyperlinkUsecase: i.get(),
        );
      },
    ),

    Bind.factory(
      (i) {
        return HyperlinkPathBloc(
          getHyperlinkPathUsecase: i.get(),
        );
      },
    ),

    Bind.factory(
      (i) {
        return HyperlinkPdfBloc(
          getHyperlinkPdfUsecase: i.get(),
        );
      },
    ),
  ];
}
