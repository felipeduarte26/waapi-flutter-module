import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/environment/environment_variables.dart';
import '../../../../core/extension/translate_extension.dart';

import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../domain/entities/hyperlink_entity.dart';
import '../blocs/hyperlink_path_bloc/hyperlink_path_bloc.dart';
import '../blocs/hyperlink_path_bloc/hyperlink_path_event.dart';
import '../blocs/hyperlink_path_bloc/hyperlink_path_state.dart';

class HyperlinkWebViewWidget extends StatefulWidget {
  final HyperlinkEntity hyperlink;

  const HyperlinkWebViewWidget({
    Key? key,
    required this.hyperlink,
  }) : super(key: key);

  @override
  State<HyperlinkWebViewWidget> createState() {
    return _HyperlinkWebViewWidgetState();
  }
}

class _HyperlinkWebViewWidgetState extends State<HyperlinkWebViewWidget> {
  late HyperlinkPathBloc _hyperlinkPathBloc;

  @override
  void initState() {
    super.initState();
    _hyperlinkPathBloc = Modular.get<HyperlinkPathBloc>();
    _hyperlinkPathBloc.add(
      GetHyperlinkPathEvent(
        pdfLink: widget.hyperlink.url,
        integrationLink: EnvironmentVariables.integrationLink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _hyperlinkPathBloc,
          listener: (context, state) async {
            if (state is LoadedHyperlinkPathState) {
              if (await launchUrl(Uri.parse(state.path))) {
                Modular.to.pop();
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: context.translate.genericErrorAndTryAgain,
                    ),
                  );
                  Modular.to.pop();
                }
              }
            }
            if (state is ErrorGetHyperlinkPath) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.genericErrorAndTryAgain,
                  ),
                );
                Modular.to.pop();
              }
            }
          },
        ),
      ],
      child: const WaapiLoadingWidget(),
    );
  }
}
