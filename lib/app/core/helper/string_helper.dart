import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/patterns.dart';

abstract class StringHelper {
  static String removeAllLineBreaks({
    required String value,
    String defaultValue = ' ',
  }) {
    final captureAllTheLineBreaksInGroups = RegExp(r'(\n){1,}');
    return value.replaceAll(captureAllTheLineBreaksInGroups, defaultValue);
  }

  static String doubleToStringFormatter({
    required double value,
  }) {
    final valueAsString = value.toStringAsFixed(1);
    if (valueAsString.endsWith('.0')) {
      return valueAsString.replaceAll('.0', '');
    }
    return valueAsString.replaceAll('.', ',');
  }

  static String parseHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  ///  return "•";
  static String bulletPoint() {
    return '\u2022';
  }

  ///return "..."
  static String ellipsis = '\u2026';

  static String getInitials(String name) {
    Characters firstChar = Characters('');
    Characters secondChar = Characters('');
    final List<String> names = name.split(' ');
    names.retainWhere((e) => e.isNotEmpty);

    final List<String> prepositions = ['da', 'de', 'do', 'dos', 'das'];

    String initials = '';

    if (names.length == 1) {
      firstChar = Characters(names.first[0]);

      for (int i = 0; i < names.first.length; i++) {
        if (names.first[i] == '.' || names.first[i] == '-') {
          secondChar = Characters(names.first[i + 1]);
          break;
        }
      }

      initials += firstChar.toString() + secondChar.toString();

      if (names.first.length > 1 && secondChar.toString() == '') {
        secondChar = Characters(names.first[1]);
        initials += secondChar.toString();
      }
    } else {
      names.remove('-');
      names.remove('.');
      for (var preposition in prepositions) {
        names.remove(preposition);
      }

      if (names.length == 1) {
        return (Characters(names.first[0]).toString() + Characters(names.first[1]).toString()).toUpperCase();
      }

      for (var i = 0; i < names.length; i++) {
        if (prepositions.contains(names[i])) {
          i++;
          if (i < names.length) {
            Characters firstChar = Characters(names[i][0]);
            initials += firstChar.toString();
          }
        } else if (initials.length < 2) {
          Characters firstChar = Characters(names[i][0]);
          initials += firstChar.toString();
        }
      }
    }

    return initials.toUpperCase();
  }

  static String formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    List<String> sufixos = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).floor()} ${sufixos[i]}';
  }

  static String getFileType(String fileName) {
    var nameFile = fileName.split('.').last;

    if (nameFile == 'jpg' ||
        nameFile == 'jpeg' ||
        nameFile == 'png' ||
        nameFile == 'bmp' ||
        nameFile == 'gif' ||
        nameFile == 'tiff') {
      return 'image/jpeg';
    } else if (nameFile == 'docx') {
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    } else if (nameFile == 'xlsx') {
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    } else if (nameFile == 'pptx') {
      return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
    } else if (nameFile == 'xls') {
      return 'application/vnd.ms-excel';
    } else if (nameFile == 'txt') {
      return 'text/plain';
    } else if (nameFile == 'pdf') {
      return 'application/pdf';
    } else if (nameFile == 'doc') {
      return 'application/msword';
    }

    return '';
  }

  static List<String> extractLinks(String text) {
    final RegExp regex = Patterns.link;
    final Iterable<RegExpMatch> matches = regex.allMatches(text);

    List<String> links = [];
    for (var match in matches) {
      links.add(match.group(0)!);
    }

    return links;
  }
}
