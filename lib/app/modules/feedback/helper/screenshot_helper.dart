import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class ScreenshotHelper {
  ///
  /// Value for [delay] should increase with widget tree size. Preferred value is 1 seconds
  ///
  ///[context] parameter is used to Inherit App Theme and MediaQuery data.
  ///
  ///
  ///

  Future<Uint8List> captureFromWidget(
    Widget widget,
    BuildContext context, {
    Duration delay = const Duration(
      milliseconds: 10,
    ),
    double? pixelRatio,
    Size? targetSize,
  }) async {
    ui.Image image = await widgetToUiImage(
      widget,
      delay: delay,
      pixelRatio: pixelRatio,
      context: context,
      targetSize: targetSize,
    );

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  static Future<Uint8List> captureFromWidgetWithSize(
    Widget widget,
    BuildContext context, {
    Duration delay = const Duration(
      milliseconds: 10,
    ),
    double? pixelRatio,
  }) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final targetSize = await getWidgetSize(
      widget,
      context,
    );

    final size = Size(
      640,
      targetSize?.height ?? 1024,
    );

    if (context.mounted) {
      ui.Image image = await widgetToUiImage(
        widget,
        delay: delay,
        pixelRatio: pixelRatio,
        context: context,
        targetSize: size,
      );

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return byteData!.buffer.asUint8List();
    }
    return Uint8List(0);
  }

  static Future<ui.Image> widgetToUiImage(
    Widget widget, {
    Duration delay = const Duration(
      milliseconds: 10,
    ),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    ///
    ///Retry counter
    ///
    final window = WidgetsBinding.instance.platformDispatcher.views.first;
    int retryCounter = 3;
    bool isDirty = false;

    Widget child = widget;

    if (context != null) {
      ///
      ///Inherit Theme and MediaQuery of app
      ///
      ///
      child = InheritedTheme.captureAll(
        context,
        MediaQuery(
          data: MediaQuery.of(context),
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        ),
      );
    }

    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    Size logicalSize = targetSize ?? window.physicalSize / window.devicePixelRatio; // Adapted
    Size imageSize = targetSize ?? window.physicalSize; // Adapted

    assert(
      logicalSize.aspectRatio.toStringAsPrecision(5) == imageSize.aspectRatio.toStringAsPrecision(5),
    ); // Adapted (toPrecision was not available)

    final RenderView renderView = RenderView(
      view: window,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(imageSize),
        devicePixelRatio: pixelRatio ?? 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(
      focusManager: FocusManager(),
      onBuildScheduled: () {
        ///
        ///current render is dirty, mark it.
        ///
        isDirty = true;
      },
    );

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: child,
      ),
    ).attachToRenderTree(
      buildOwner,
    );
    ////
    ///Render Widget
    ///
    ///

    buildOwner.buildScope(
      rootElement,
    );
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    ui.Image? image;

    do {
      ///
      ///Reset the dirty flag
      ///
      ///
      isDirty = false;

      image = await repaintBoundary.toImage(pixelRatio: pixelRatio ?? (imageSize.width / logicalSize.width));

      ///
      ///This delay should increase with Widget tree Size
      ///

      await Future.delayed(delay);

      ///
      ///Check does this require rebuild
      ///
      ///
      if (isDirty) {
        ///
        ///Previous capture has been updated, re-render again.
        ///
        ///
        buildOwner.buildScope(
          rootElement,
        );
        buildOwner.finalizeTree();
        pipelineOwner.flushLayout();
        pipelineOwner.flushCompositingBits();
        pipelineOwner.flushPaint();
      }
      retryCounter--;

      ///
      ///retry until capture is successful
      ///
    } while (isDirty && retryCounter >= 0);

    return image; // Adapted to directly return the image and not the Uint8List
  }

  static Future<Size?> getWidgetSize(
    Widget widget,
    BuildContext context, {
    Alignment alignment = Alignment.center,
    Size size = const Size(
      double.maxFinite,
      double.maxFinite,
    ),
    double devicePixelRatio = 1.0,
    double pixelRatio = 1.0,
  }) async {
    Widget child = widget;

    child = InheritedTheme.captureAll(
      context,
      MediaQuery(
        data: MediaQuery.of(context),
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );

    RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    RenderView renderView = RenderView(
      child: RenderPositionedBox(
        alignment: alignment,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(size),
        devicePixelRatio: devicePixelRatio,
      ),
      view: WidgetsBinding.instance.platformDispatcher.views.first,
    );

    PipelineOwner pipelineOwner = PipelineOwner();
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    BuildOwner buildOwner = BuildOwner(
      focusManager: FocusManager(),
    );

    //Ajuste aqui
    final RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    ).attachToRenderTree(
      buildOwner,
    );

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    return rootElement.size;
  }
}
