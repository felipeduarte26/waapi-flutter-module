import 'package:flutter/material.dart';

abstract class ScrollHelper {
  static bool reachedListEnd({
    required ScrollController scrollController,
    double maximumScrollExtent = 0.8,
  }) {
    if (!scrollController.hasClients) {
      return false;
    }

    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.offset;

    return currentScroll >= (maxScroll * maximumScrollExtent);
  }
}
