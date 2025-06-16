import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pod_player/pod_player.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/translate_extension.dart';
import 'waapi_loading_widget.dart';
import 'web_view_widget.dart';

class WaapiVideoPlayerWidget extends StatefulWidget {
  final bool isVimeo;
  final bool isYoutube;
  final String videoUrl;

  const WaapiVideoPlayerWidget({
    super.key,
    this.isVimeo = false,
    this.isYoutube = false,
    required this.videoUrl,
  });

  @override
  State<WaapiVideoPlayerWidget> createState() => _WaapiVideoPlayerWidgetState();
}

class _WaapiVideoPlayerWidgetState extends State<WaapiVideoPlayerWidget> {
  late PodPlayerController _podPlayerController;
  late String vimeoUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    if (!widget.isVimeo) {
      _podPlayerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          widget.videoUrl,
        ),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
        ),
      )..initialise();
      setState(
        () {
          _isLoading = false;
        },
      );
    } else {
      vimeoUrl = 'https://player.vimeo.com/video/${widget.videoUrl}';
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    if (!widget.isVimeo) {
      _podPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: WaapiLoadingWidget(),
      );
    }

    if (widget.isVimeo) {
      return Container(
        padding: EdgeInsets.zero,
        height: 400,
        width: double.infinity,
        child: WebViewWidget(
          showWebViewNavigationBar: false,
          onLoadErrorMessage: '',
          url: vimeoUrl,
        ),
      );
    }

    return PodVideoPlayer(
      onLoading: (load) {
        return const Center(
          child: WaapiLoadingWidget(),
        );
      },
      onVideoError: () {
        return Container(
          color: SeniorColors.pureBlack,
          width: double.infinity,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidTriangleExclamation,
                style: SeniorIconStyle(
                  color: SeniorColors.manchesterColorYellow,
                ),
                size: SeniorSpacing.xmedium,
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              SeniorText.body(
                context.translate.errorLoadingVideo,
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.pureWhite,
              ),
            ],
          ),
        );
      },
      podProgressBarConfig: const PodProgressBarConfig(
        playingBarColor: SeniorColors.primaryColor500,
        circleHandlerColor: SeniorColors.primaryColor500,
      ),
      controller: _podPlayerController,
    );
  }
}
