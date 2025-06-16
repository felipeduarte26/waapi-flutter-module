import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_backdrop_style.dart';
import './models/senior_backdrop_tab_bar_info.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorBackdrop extends StatefulWidget {
  /// Creates the SDS Backdrop component.
  ///
  /// The [body] and [title] parameters are required.
  const SeniorBackdrop({
    Key? key,
    this.actions,
    this.backdropTabBarInfo,
    required this.body,
    this.centerTitle,
    this.hasTopPadding = true,
    this.hideLeading = false,
    this.leadingWidth = 56,
    this.leading,
    this.onRefresh,
    this.onTapBack,
    this.systemOverlayStyle,
    this.style,
    required this.title,
  }) : super(key: key);

  /// The value that will be passed to the [SliverAppBar.actions] parameter.
  /// A list of Widgets to display in a row after the title widget.
  final List<Widget>? actions;

  /// Tab settings for the backdrop.
  final SeniorBackdropTabBarInfo? backdropTabBarInfo;

  /// The content displayed on the backdrop.
  /// The body is displayed on the front layer.
  final Widget body;

  /// The value that will be passed to the [SliverAppBar.centerTitle] parameter.
  /// Whether the title should be centered.
  final bool? centerTitle;

  /// Defines whether to add a padding to the top of the front layer.
  ///
  /// The default value is true.
  final bool hasTopPadding;

  /// Defines whether leading will be omitted.
  ///
  /// The default value is false.
  final bool hideLeading;

  /// The value that will be passed to the [SliverAppBar.leading] parameter.
  /// A widget to display before the toolbar's title.
  final Widget? leading;

  /// The value that will be passed to the [SliverAppBar.leadingWidth] parameter.
  /// A widget to display before the toolbar's title.
  final double? leadingWidth;

  /// Event of reloading the view in a RefreshIndicator.
  /// When this parameter is null, a RefreshIndicator is not created.
  final RefreshCallback? onRefresh;

  /// Event fired when leading returns is tapped.
  /// The return leading is created when the value of the [leading] parameter is null.
  final Function()? onTapBack;

  /// The value that will be passed to the [SliverAppBar.systemOverlayStyle] parameter.
  /// Specifies the style to use for the system overlays that overlap the AppBar.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorBackdropStyle.bodyColor] the body color of the backdrop.
  /// [SeniorBackdropStyle.headerColors] the color of the backdrop header. Component top.
  /// [SeniorBackdropStyle.selectedLabelColor] the color of the selected labels.
  /// [SeniorBackdropStyle.tabIndicatorColor] the indicator color of the selected tab on the backdrop.
  /// [SeniorBackdropStyle.unselectedLabelColor] the color of unselected labels.
  final SeniorBackdropStyle? style;

  /// The value that will be passed to the [SliverAppBar.title] parameter.
  /// The primary widget displayed in the app bar.
  final Widget title;

  @override
  State<SeniorBackdrop> createState() => _SeniorBackdropState();
}

class _SeniorBackdropState extends State<SeniorBackdrop> {
  late final ScrollController backdropController;
  late final bool hasTabs;
  final double appBarHeight = 56.0;
  final double tabBarHeight = 48.0;
  bool hasPadding = false;
  double appBarCurrentHeight = 0.0;

  @override
  void initState() {
    super.initState();
    backdropController = ScrollController(keepScrollOffset: false);
    hasTabs = widget.backdropTabBarInfo != null;
  }

  @override
  void dispose() {
    backdropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: _buildBoxDecoration(theme),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: !hasTabs ? _buildAppBarWhenItHasNoTabs(theme) : null,
        body: hasTabs
            ? _buildAppBarAndBodyWhenItHasTabs(theme)
            : _buildBody(theme),
      ),
    );
  }

  AppBar _buildAppBarWhenItHasNoTabs(SeniorThemeData theme) {
    return AppBar(
      primary: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: widget.actions,
      title: widget.title,
      centerTitle: widget.centerTitle,
      bottom: widget.backdropTabBarInfo != null ? _buildTabBar(theme) : null,
      systemOverlayStyle: widget.systemOverlayStyle,
      leadingWidth: widget.hideLeading ? 0 : widget.leadingWidth,
      leading: widget.hideLeading
          ? const SizedBox.shrink()
          : widget.leading == null
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.angleLeft),
                  onPressed: widget.onTapBack ??
                      () {
                        Navigator.pop(context);
                      },
                )
              : widget.leading,
    );
  }

  SafeArea _buildAppBarAndBodyWhenItHasTabs(SeniorThemeData theme) {
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notify) {
          //This delayed is necessary because of the refreshIndicator used in the body.
          //When using a setState in a build process it gives a problem
          //keep the duration as zero ALWAYS.
          Future.delayed(Duration.zero, () {
            setStateIfMounted(() {
              if (widget.backdropTabBarInfo == null) {
                _updateAppBarCurrentHeight();
              }
              if (notify is ScrollUpdateNotification) {
                if (widget.backdropTabBarInfo != null) {
                  _updateAppBarCurrentHeight();
                }
                hasPadding = _hasPadding(
                  appBarCurrentHeight,
                  backdropController.position.userScrollDirection,
                );
              }
            });
          });

          return true;
        },
        child: NestedScrollView(
          controller: backdropController,
          floatHeaderSlivers: true,
          physics: const PageScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBar(theme),
            ];
          },
          body: _buildBody(theme),
        ),
      ),
    );
  }

  Widget _buildBody(SeniorThemeData theme) {
    const borderRadius = const BorderRadius.vertical(
      top: const Radius.circular(SeniorRadius.huge),
    );

    final body = ClipRRect(
      borderRadius: !widget.hasTopPadding ? borderRadius : BorderRadius.zero,
      child: widget.body,
    );

    return Padding(
      padding: EdgeInsets.only(
          top: (hasPadding)
              ? _getPadding(widget.backdropTabBarInfo == null)
              : 0),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.hasTopPadding ? SeniorRadius.huge : 0,
        ),
        decoration: BoxDecoration(
          color: widget.style?.bodyColor ??
              theme.backdropTheme?.style?.bodyColor ??
              SeniorColors.pureWhite,
          borderRadius: borderRadius,
        ),
        child: widget.onRefresh != null
            ? RefreshIndicator(
                notificationPredicate: (_) =>
                    true, // will always run regardless of depth
                color: SeniorColors.primaryColor,
                onRefresh: widget.onRefresh!,
                child: body,
              )
            : body,
      ),
    );
  }

  SliverAppBar _buildAppBar(SeniorThemeData theme) {
    return SliverAppBar(
      pinned: true,
      primary: true,
      floating: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: widget.actions,
      title: widget.title,
      centerTitle: widget.centerTitle,
      bottom: widget.backdropTabBarInfo != null ? _buildTabBar(theme) : null,
      systemOverlayStyle: widget.systemOverlayStyle,
      leadingWidth: widget.hideLeading ? 0 : widget.leadingWidth,
      leading: widget.hideLeading
          ? const SizedBox.shrink()
          : widget.leading == null
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.angleLeft),
                  onPressed: widget.onTapBack ??
                      () {
                        Navigator.pop(context);
                      },
                )
              : widget.leading,
    );
  }

  TabBar _buildTabBar(SeniorThemeData theme) {
    final Color labelColor = widget.style?.selectedLabelColor ??
        theme.backdropTheme?.style?.selectedLabelColor ??
        SeniorColors.pureWhite;

    final Color unselectedLabelColor = widget.style?.unselectedLabelColor ??
        theme.backdropTheme?.style?.unselectedLabelColor ??
        SeniorColors.pureWhite.withOpacity(.6);

    final Color indicatorColor = widget.style?.tabIndicatorColor ??
        theme.backdropTheme?.style?.tabIndicatorColor ??
        SeniorColors.pureWhite;

    return TabBar(
      tabs:
          widget.backdropTabBarInfo!.tabs.map((tab) => Tab(text: tab)).toList(),
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: SeniorTypography.bodyBold(color: labelColor),
      indicator: SeniorTabIndicator(color: indicatorColor),
      physics: const BouncingScrollPhysics(),
      isScrollable: widget.backdropTabBarInfo!.isScrollable,
      onTap: widget.backdropTabBarInfo!.onTap,
      controller: widget.backdropTabBarInfo!.controller,
    );
  }

  BoxDecoration _buildBoxDecoration(SeniorThemeData theme) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: widget.style?.headerColors ??
            theme.backdropTheme?.style?.headerColors ??
            SeniorColors.primaryGradientColors,
      ),
    );
  }

  void setStateIfMounted(function) {
    if (mounted) {
      setState(function);
    }
  }

  double _getPadding(bool noHasBottomBar) {
    return hasTabs
        ? noHasBottomBar
            ? (appBarHeight - appBarCurrentHeight)
            : (tabBarHeight - appBarCurrentHeight)
        : 0;
  }

  bool _hasPadding(
      double appBarScrollPosition, ScrollDirection scrollDirection) {
    return (widget.backdropTabBarInfo == null)
        ? (appBarScrollPosition < appBarHeight)
        : (appBarScrollPosition < tabBarHeight);
  }

  double _updateAppBarCurrentHeight() =>
      appBarCurrentHeight = backdropController.position.extentAfter;
}

class SeniorTabIndicator extends Decoration {
  final BoxPainter _painter;
  final Color color;

  SeniorTabIndicator({required this.color}) : _painter = _SeniorPainter(color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _SeniorPainter extends BoxPainter {
  final Paint _paint;

  _SeniorPainter(Color color)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Rect rect =
        Offset(offset.dx + cfg.size!.width / 2 - 12, (cfg.size!.height - 10)) &
            const Size(24, 2);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        bottomLeft: const Radius.circular(1),
        bottomRight: const Radius.circular(1),
        topLeft: const Radius.circular(1),
        topRight: const Radius.circular(1),
      ),
      _paint,
    );
  }
}
