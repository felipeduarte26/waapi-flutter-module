import 'package:flutter/material.dart';

/// The possible elevations for the SeniorElevatedElement component.
/// It can be [dp0], [dp01], [dp02], [dp03], [dp04], [dp06], [dp08], [dp09], [dp12], [dp16] and [dp24].
enum SeniorElevations {
  dp0,
  dp01,
  dp02,
  dp03,
  dp04,
  dp06,
  dp08,
  dp09,
  dp12,
  dp16,
  dp24,
}

class SeniorElevatedElement extends StatelessWidget {
  /// Creates a component that allows you to add SDS elevation definitions.
  ///
  /// The [elevation], [borderRadius] and [child] parameters are required.
  const SeniorElevatedElement({
    required this.elevation,
    required this.borderRadius,
    required this.child,
  }) : super();

  /// The elevation that will be assigned to the component.
  final SeniorElevations elevation;

  /// The component's border radius.
  /// When the [child] component has a border radius, it is necessary to assign the same value to this parameter.
  final double borderRadius;

  /// The element that needs the elevation effect. The component's child element.
  final Widget child;

  BoxShadow _generateBoxShadow(double offsetX, offsetY, blurRadius, opacity) {
    return BoxShadow(
      offset: Offset(offsetX, offsetY),
      blurRadius: blurRadius,
      color: Color.fromRGBO(0, 0, 0, opacity),
    );
  }

  List<BoxShadow> _getBoxShadows() {
    switch (elevation) {
      case SeniorElevations.dp01:
        return <BoxShadow>[
          _generateBoxShadow(0, 1.0, 3.0, 0.2),
          _generateBoxShadow(0, 2.0, 1.0, 0.12),
          _generateBoxShadow(0, 1.0, 1.0, 0.14),
        ];
      case SeniorElevations.dp02:
        return <BoxShadow>[
          _generateBoxShadow(0, 1.0, 5.0, 0.2),
          _generateBoxShadow(0, 3.0, 1.0, 0.12),
          _generateBoxShadow(0, 2.0, 2.0, 0.14),
        ];
      case SeniorElevations.dp03:
        return <BoxShadow>[
          _generateBoxShadow(0, 1.0, 8.0, 0.2),
          _generateBoxShadow(0, 3.0, 3.0, 0.12),
          _generateBoxShadow(0, 3.0, 4.0, 0.14),
        ];
      case SeniorElevations.dp04:
        return <BoxShadow>[
          _generateBoxShadow(0, 2.0, 4.0, 0.2),
          _generateBoxShadow(0, 1.0, 10.0, 0.12),
          _generateBoxShadow(0, 4.0, 5.0, 0.14),
        ];
      case SeniorElevations.dp06:
        return <BoxShadow>[
          _generateBoxShadow(0, 3.0, 5.0, 0.2),
          _generateBoxShadow(0, 1.0, 18.0, 0.12),
          _generateBoxShadow(0, 6.0, 10.0, 0.14),
        ];
      case SeniorElevations.dp08:
        return <BoxShadow>[
          _generateBoxShadow(0, 5.0, 5.0, 0.2),
          _generateBoxShadow(0, 3.0, 14.0, 0.12),
          _generateBoxShadow(0, 8.0, 10.0, 0.14),
        ];
      case SeniorElevations.dp09:
        return <BoxShadow>[
          _generateBoxShadow(0, 5.0, 6.0, 0.2),
          _generateBoxShadow(0, 3.0, 16.0, 0.12),
          _generateBoxShadow(0, 9.0, 12.0, 0.14),
        ];
      case SeniorElevations.dp12:
        return <BoxShadow>[
          _generateBoxShadow(0, 7.0, 8.0, 0.2),
          _generateBoxShadow(0, 5.0, 22.0, 0.12),
          _generateBoxShadow(0, 12.0, 17.0, 0.14),
        ];
      case SeniorElevations.dp16:
        return <BoxShadow>[
          _generateBoxShadow(0, 8.0, 10.0, 0.2),
          _generateBoxShadow(0, 6.0, 30.0, 0.12),
          _generateBoxShadow(0, 16.0, 24.0, 0.14),
        ];
      case SeniorElevations.dp24:
        return <BoxShadow>[
          _generateBoxShadow(0, 11.0, 15.0, 0.2),
          _generateBoxShadow(0, 9.0, 46.0, 0.12),
          _generateBoxShadow(0, 24.0, 38.0, 0.14),
        ];
      case SeniorElevations.dp0:
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.all(
      Radius.circular(borderRadius),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        boxShadow: _getBoxShadows(),
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: child,
      ),
    );
  }
}
