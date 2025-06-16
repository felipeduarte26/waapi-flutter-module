import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/translate_extension.dart';

import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../enums/hyperlink_state_enum.dart';

class HyperlinkStateScreen extends StatelessWidget {
  final HyperlinkStateEnum stateEnum;
  final VoidCallback? onTapTryAgain;

  const HyperlinkStateScreen({
    super.key,
    required this.stateEnum,
    this.onTapTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          titleLabel: context.translate.quickAccess,
          body: Builder(
            builder: (context) {
              switch (stateEnum) {
                case HyperlinkStateEnum.emptyState:
                  return EmptyStateWidget(
                    title: context.translate.hyperlinksEmptyState,
                    subTitle: context.translate.hyperlinksEmptyStateHelp,
                    imagePath: AssetsPath.generalEmptyState,
                  );
                case HyperlinkStateEnum.notFound:
                  return ErrorStateWidget(
                    title: context.translate.hyperlinkOpenError,
                    subTitle: context.translate.couldNotLoadInformationTryAgain,
                    onTapTryAgain: () {
                      if (onTapTryAgain != null) {
                        Modular.to.pop();
                        onTapTryAgain!.call();
                      }
                    },
                    imagePath: AssetsPath.generalErrorState,
                  );
                case HyperlinkStateEnum.errorState:
                default:
                  return ErrorStateWidget(
                    title: context.translate.hyperlinksErrorState,
                    subTitle: context.translate.hyperlinksErrorStateHelp,
                    onTapTryAgain: () {
                      if (onTapTryAgain != null) {
                        Modular.to.pop();
                        onTapTryAgain!.call();
                      }
                    },
                    imagePath: AssetsPath.generalErrorState,
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  void onWillPop() {
    Modular.to.pop();
    if (stateEnum != HyperlinkStateEnum.emptyState) {
      Modular.to.pop();
    }
  }
}
