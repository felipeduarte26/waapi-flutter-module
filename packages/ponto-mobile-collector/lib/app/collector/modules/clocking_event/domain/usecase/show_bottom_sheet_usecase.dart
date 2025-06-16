import 'package:flutter/material.dart';

import '../../../../core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';


abstract class IShowBottomSheetUsecase {
  Future<dynamic> call({
    required BuildContext context,
    required List<Widget> content,
    userRootContext = true,
  });
}

class ShowBottomSheetUsecase implements IShowBottomSheetUsecase {
  final IBottomSheetService _bottomSheetService;

  const ShowBottomSheetUsecase({
    required IBottomSheetService bottomSheetService,
  }) : _bottomSheetService = bottomSheetService;

  @override
  Future<dynamic> call({
    required BuildContext context,
    required List<Widget> content,
    userRootContext = true,
  }) {
    return _bottomSheetService.show(
      context: context,
      content: content,
      userRootContext: userRootContext,
    );
  }
}
