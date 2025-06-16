import 'package:flutter/material.dart';

class SeniorButtonStyle {
  /// Style definitions for the SeniorButton component.
  const SeniorButtonStyle({
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.dangerBackgroundColor,
    this.dangerDisabledBackgroundColor,
    this.contentColor,
    this.disabledContentColor,
    this.dangerContentColor,
    this.dangerDisabledContentColor,
    this.borderColor,
    this.disabledBorderColor,
    this.dangerBorderColor,
    this.dangerDisabledBorderColor,
    this.loaderColor,
    this.dangerLoaderColor,
    this.outlinedContentColor,
    this.outlinedBorderColor,
    this.dangerOutlinedContentColor,
    this.outlinedDisabledContentColor,
    this.dangerOutlinedDisabledContentColor,
  });

  /// Defines the button background color.
  final Color? backgroundColor;

  /// Defines the button background color when it's disabled.
  final Color? disabledBackgroundColor;

  /// Defines the button background color when it's in danger state.
  final Color? dangerBackgroundColor;

  /// Defines the button background color when it's disabled and in danger state.
  final Color? dangerDisabledBackgroundColor;

  /// Defines the button content color.
  final Color? contentColor;

  /// Defines the button content color when it's disabled.
  final Color? disabledContentColor;

  /// Defines the button content color when it's in danger state.
  final Color? dangerContentColor;

  /// Defines the button content color when it's disabled and in danger state.
  final Color? dangerDisabledContentColor;

  /// Defines the button border color.
  final Color? borderColor;

  /// Defines the button border color when it's disabled.
  final Color? disabledBorderColor;

  /// Defines the button border color when it's in danger state.
  final Color? dangerBorderColor;

  /// Defines the button border color when it's disabled and in danger state.
  final Color? dangerDisabledBorderColor;

  /// Defines the loader color.
  final Color? loaderColor;

  /// Defines the loader color when it's in danger state.
  final Color? dangerLoaderColor;

  /// Defines the button content color when it's in outlined state.
  final Color? outlinedContentColor;

  /// Defines the button border color when it's in outlined state.
  final Color? outlinedBorderColor;

  /// Defines the button content color when it's in danger and outlined state.
  final Color? dangerOutlinedContentColor;

  /// Defines the button content color when it's in outlined and disabled state.
  final Color? outlinedDisabledContentColor;

  /// Defines the button content color when it's in danger, outlined, and disabled state.
  final Color? dangerOutlinedDisabledContentColor;

  /// Creates a copy of this [SeniorButtonStyle] but with
  /// the given fields replaced with the new values.
  SeniorButtonStyle copyWith({
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? dangerBackgroundColor,
    Color? dangerDisabledBackgroundColor,
    Color? contentColor,
    Color? disabledContentColor,
    Color? dangerContentColor,
    Color? dangerDisabledContentColor,
    Color? borderColor,
    Color? disabledBorderColor,
    Color? dangerBorderColor,
    Color? dangerDisabledBorderColor,
    Color? loaderColor,
    Color? dangerLoaderColor,
    Color? outlinedContentColor,
    Color? outlinedBorderColor,
    Color? dangerOutlinedContentColor,
    Color? outlinedDisabledContentColor,
    Color? dangerOutlinedDisabledContentColor,
  }) {
    return SeniorButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      dangerBackgroundColor: dangerBackgroundColor ?? this.dangerBackgroundColor,
      dangerDisabledBackgroundColor: dangerDisabledBackgroundColor ?? this.dangerDisabledBackgroundColor,
      contentColor: contentColor ?? this.contentColor,
      disabledContentColor: disabledContentColor ?? this.disabledContentColor,
      dangerContentColor: dangerContentColor ?? this.dangerContentColor,
      dangerDisabledContentColor: dangerDisabledContentColor ?? this.dangerDisabledContentColor,
      borderColor: borderColor ?? this.borderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      dangerBorderColor: dangerBorderColor ?? this.dangerBorderColor,
      dangerDisabledBorderColor: dangerDisabledBorderColor ?? this.dangerDisabledBorderColor,
      loaderColor: loaderColor ?? this.loaderColor,
      dangerLoaderColor: dangerLoaderColor ?? this.dangerLoaderColor,
      outlinedContentColor: outlinedContentColor ?? this.outlinedContentColor,
      outlinedBorderColor: outlinedBorderColor ?? this.outlinedBorderColor,
      dangerOutlinedContentColor: dangerOutlinedContentColor ?? this.dangerOutlinedContentColor,
      outlinedDisabledContentColor: outlinedDisabledContentColor ?? this.outlinedDisabledContentColor,
      dangerOutlinedDisabledContentColor: dangerOutlinedDisabledContentColor ?? this.dangerOutlinedDisabledContentColor,
    );
  }
}