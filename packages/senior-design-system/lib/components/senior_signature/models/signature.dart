import 'dart:io';

import 'package:signature/signature.dart';

class SignatureData {
  /// Object that contains the data of a SeniorSignature signature.
  const SignatureData({
    required this.points,
    required this.file,
  });

  /// The collected signature points.
  final List<Point>? points;

  /// An image file corresponding to the collected signature.
  final File? file;
}
