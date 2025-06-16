import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_carousel_slider_style.dart';
import '../senior_modal/senior_modal.dart';
import '../senior_slider_dots/senior_slider_dots_widget.dart';
import '../senior_icon_button/senior_icon_button.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorCarouselSlider extends StatefulWidget {
  /// Creates a slider carousel component.
  /// The [images] and [emptyLabel] parameters are required.
  /// The [deleteDialogDefinition] parameter must be informed whenever [onDelete] is also informed and only in this
  /// situation.
  const SeniorCarouselSlider({
    Key? key,
    this.deleteDialogDefinition,
    required this.emptyLabel,
    required this.images,
    this.initialPage = 0,
    this.onDelete,
    this.showDots = true,
    this.showPageInfo = true,
    this.style,
    this.toLabelWord = '/',
  })  : assert(onDelete == null && deleteDialogDefinition == null ||
            onDelete != null && deleteDialogDefinition != null),
        assert(initialPage <= images.length),
        super(key: key);

  /// The message dialog settings when the delete option is triggered.
  final SeniorModalDefinitions? deleteDialogDefinition;

  /// The text displayed when there is no image to display.
  final String emptyLabel;

  /// The images that will be displayed on the carousel.
  final List<ImageProvider> images;

  /// The index of the image that will be displayed initially.
  final int initialPage;

  /// Callback function executed when the delete image action is triggered.
  final Function(int)? onDelete;

  /// If the dots representing the index of the images will be displayed.
  /// Default value is true.
  final bool showDots;

  /// If the page information will be displayed.
  /// Default value is true.
  final bool showPageInfo;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorCarouselSliderStyle.activeDotColor] the color of the active bullet that represents the image being displayed.
  /// [SeniorCarouselSliderStyle.backgroundImageColor] the background color of the images.
  /// [SeniorCarouselSliderStyle.defaultDotColor] the color of the bullets that represent the images.
  /// [SeniorCarouselSliderStyle.emptyAreaColor] the color of empty area.
  /// [SeniorCarouselSliderStyle.emptyBorderColor] the border color of the empty state.
  /// [SeniorCarouselSliderStyle.emptyLabelColor] the label color of the empty state.
  /// [SeniorCarouselSliderStyle.pageInfoColor] the color os the page information.
  /// [SeniorCarouselSliderStyle.pictureBorderColor] the border color of images.
  /// [SeniorCarouselSliderStyle.pictureShadowColor] the shadow color of the images.
  final SeniorCarouselSliderStyle? style;

  /// The word displayed between the current page and the total number of pages in the page information.
  /// The default value is "/".
  final String toLabelWord;

  @override
  State<SeniorCarouselSlider> createState() => _SeniorCarouselSliderState();
}

class _SeniorCarouselSliderState extends State<SeniorCarouselSlider> {
  late int _currentPage = widget.initialPage;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: widget.initialPage,
    );

    _pageController.addListener(() {
      final int next = _pageController.page?.round() ?? 0;
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  void _showModal({
    required BuildContext context,
    required SeniorModalDefinitions modalDefinitions,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return SeniorModal(
          title: modalDefinitions.title,
          content: modalDefinitions.content,
          defaultAction: SeniorModalAction(
            label: modalDefinitions.cancelLabel,
            action: onCancel,
          ),
          otherAction: SeniorModalAction(
            label: modalDefinitions.confirmLabel,
            action: onConfirm,
            danger: true,
          ),
        );
      },
    );
  }

  Widget _buildSlideTile({
    required SeniorThemeData theme,
    required bool activePage,
    required ImageProvider image,
  }) {
    final double verticalPadding =
        activePage ? SeniorSpacing.xsmall : SeniorSpacing.xbig;
    final double offset = activePage ? 4.0 : 2.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(
        horizontal: SeniorSpacing.medium,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: widget.style?.backgroundImageColor ??
            theme.carouselSliderTheme?.style?.backgroundImageColor ??
            SeniorColors.pureWhite,
        border: Border.all(
          color: widget.style?.pictureBorderColor ??
              theme.carouselSliderTheme?.style?.pictureBorderColor ??
              SeniorColors.grayscale50,
        ),
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.style?.pictureShadowColor ??
                theme.carouselSliderTheme?.style?.pictureShadowColor ??
                SeniorColors.grayscale50,
            blurRadius: 4.0,
            offset: Offset(0, offset),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(SeniorThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.xxbig,
        right: SeniorSpacing.xxbig,
        top: SeniorSpacing.normal,
        bottom: SeniorSpacing.xxhuge,
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: widget.style?.emptyBorderColor ??
            theme.carouselSliderTheme?.style?.emptyBorderColor ??
            SeniorColors.grayscale50,
        child: Container(
          color: widget.style?.emptyAreaColor ??
              theme.carouselSliderTheme?.style?.emptyAreaColor ??
              SeniorColors.grayscale10,
          child: Center(
            child: Text(
              widget.emptyLabel,
              style: SeniorTypography.body(
                color: widget.style?.emptyLabelColor ??
                    theme.carouselSliderTheme?.style?.emptyLabelColor ??
                    SeniorColors.grayscale50,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageInfo(SeniorThemeData theme) {
    return widget.images.isNotEmpty && widget.showPageInfo
        ? Text(
            '${_currentPage + 1} ${widget.toLabelWord} ${widget.images.length}',
            style: SeniorTypography.label(
              color: widget.style?.pageInfoColor ??
                  theme.carouselSliderTheme?.style?.pageInfoColor ??
                  SeniorColors.grayscale90,
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return widget.images.isEmpty
        ? _buildEmptyState(theme)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.images.length,
                    itemBuilder: (_, currentIndex) {
                      final bool activePage = currentIndex == _currentPage;
                      return _buildSlideTile(
                        theme: theme,
                        activePage: activePage,
                        image: widget.images[currentIndex],
                      );
                    },
                  ),
                ),
                widget.onDelete != null && widget.images.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.xsmall,
                          bottom: SeniorSpacing.normal,
                        ),
                        child: SeniorIconButton(
                          icon: FontAwesomeIcons.trash,
                          onTap: () {
                            _showModal(
                              context: context,
                              modalDefinitions: widget.deleteDialogDefinition!,
                              onConfirm: () {
                                widget.onDelete?.call(_currentPage);
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                          size: SeniorIconButtonSize.small,
                          style: SeniorIconButtonStyle(
                            iconColor: widget.style?.deleteOptionIconColor ??
                                theme.carouselSliderTheme?.style
                                    ?.deleteOptionIconColor ??
                                SeniorColors.manchesterColorRed,
                            buttonColor: widget.style?.deleteOptionColor ??
                                theme.carouselSliderTheme?.style
                                    ?.deleteOptionColor ??
                                SeniorColors.pureWhite,
                            borderColor:
                                widget.style?.deleteOptionBorderColor ??
                                    theme.carouselSliderTheme?.style
                                        ?.deleteOptionBorderColor ??
                                    SeniorColors.grayscale20,
                          ),
                          type: SeniorIconButtonType.danger,
                        ),
                      )
                    : const SizedBox.shrink(),
                SeniorSliderDots(
                  currentPage: _currentPage,
                  length: widget.images.length,
                ),
                _buildPageInfo(theme),
              ],
            ),
          );
  }
}
