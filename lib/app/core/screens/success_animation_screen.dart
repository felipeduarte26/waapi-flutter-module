import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rive/rive.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../constants/assets_path.dart';
import '../extension/media_query_extension.dart';
import '../widgets/waapi_colorful_header.dart';

class SuccessAnimationScreen extends StatefulWidget {
  const SuccessAnimationScreen({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  SuccessAnimationScreenState createState() {
    return SuccessAnimationScreenState();
  }
}

class SuccessAnimationScreenState extends State<SuccessAnimationScreen> {
  var startedAnimation = false;
  var teste = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hideLeading: true,
        body: Stack(
          children: [
            const Center(
              child: RiveAnimation.asset(
                AssetsPath.successAnimation,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(
                milliseconds: 700,
              ),
              bottom: startedAnimation ? context.heightSize * 0.1 : -100,
              left: startedAnimation ? context.widthSize * 0.1 : -100,
              onEnd: () async {
                await Future.delayed(
                  const Duration(
                    milliseconds: 1250,
                  ),
                );
                Modular.to.pop(true);
              },
              child: RichText(
                text: TextSpan(
                  text: '${widget.title}\n',
                  style: SeniorTypography.h3(
                    color: SeniorColors.neutralColor800,
                  ),
                  children: [
                    TextSpan(
                      text: widget.subTitle,
                      style: SeniorTypography.h3(
                        color: SeniorColors.neutralColor500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initAnimation() async {
    await Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );
    setState(() {
      startedAnimation = true;
    });
  }
}
