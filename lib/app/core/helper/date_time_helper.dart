import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

abstract class DateTimeHelper {
  static DateTime convertStringIso8601toDateTime({
    required String stringIso8601,
    bool adjustTimeZone = false,
  }) {
    try {
      final dateWithoutZ = stringIso8601.replaceAll('Z', '');
      if (adjustTimeZone) {
        final timeZone = DateTime.now().timeZoneOffset;
        final dateTime = DateTime.parse(dateWithoutZ);
        final adjustedDateTime = dateTime.add(timeZone);
        return adjustedDateTime;
      }

      return DateTime.parse(dateWithoutZ);
    } catch (_) {
      return DateTime(1970, 1, 1);
    }
  }

  static DateTime convertStringDdMmAaaaToDateTime({
    required String stringDdMmAaaa,
    required String locale,
  }) {
    try {
      return DateFormat.yMd(locale).parse(stringDdMmAaaa);
    } catch (_) {
      return DateTime(1970, 1, 1);
    }
  }

  static DateTime? convertStringAaaaMmDdToDateTime({
    required String? stringToConvert,
  }) {
    try {
      if (stringToConvert == null || stringToConvert.isEmpty) {
        return null;
      }

      return DateTime.parse(stringToConvert);
    } catch (_) {
      return null;
    }
  }

  static String formatWithDefaultDatePattern({
    required DateTime dateTime,
    required String locale,
  }) {
    return DateFormat.yMd(locale).format(dateTime);
  }

  static String formatWithDefaultDateTimePattern({
    required DateTime dateTime,
    required String locale,
    bool adjustTimeZone = false,
  }) {
    if (adjustTimeZone) {
      final timeZone = DateTime.now().timeZoneOffset;
      final adjustedDateTime = dateTime.add(timeZone);
      return DateFormat.yMd(locale).add_jm().format(adjustedDateTime);
    }

    return DateFormat.yMd(locale).add_jm().format(dateTime);
  }

  static String formatWithMMMMdPattern({
    required DateTime dateTime,
    required String locale,
  }) {
    return DateFormat.MMMMd(locale).format(dateTime);
  }

  static String formatToIso8601Date({
    required DateTime dateTime,
  }) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatDateTimeToIso8601({
    required DateTime dateTime,
  }) {
    String isoString = dateTime.toUtc().toIso8601String();
    if (isoString.length == 19) {
      isoString = '$isoString.000Z';
    } else if (isoString.length == 23) {
      isoString = isoString.replaceRange(isoString.length - 1, isoString.length, '000Z');
    }
    return isoString;
  }

  static String formatToMMMdPattern({
    required DateTime dateTime,
    required String locale,
  }) {
    return DateFormat('MMMd', locale).format(dateTime);
  }

  static bool leapYear(int year) {
    return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
  }

  static bool validateDate({
    required String date,
    required String locale,
    bool validateCurrentMajorYear = false,
  }) {
    int count = 0;
    bool isSlash;
    String day = '';
    String month = '';
    String year = '';

    for (var i = 0; i < date.length; i++) {
      if (date[i] == '/') {
        count++;
        isSlash = true;
      } else {
        isSlash = false;
      }

      if (!isSlash) {
        if (locale == 'en-US') {
          if (count == 0) {
            month = month + date[i];
          } else if (count == 1) {
            day = day + date[i];
          } else if (count == 2) {
            year = year + date[i];
          }
        } else {
          if (count == 0) {
            day = day + date[i];
          } else if (count == 1) {
            month = month + date[i];
          } else if (count == 2) {
            year = year + date[i];
          }
        }
      }
    }

    if (month.length == 1) {
      month = '0$month';
    }
    if (day.length == 1) {
      day = '0$day';
    }

    var dateConvert = '$year-$month-$day';

    // validações

    try {
      var monthValidate = int.parse(month);
      var dayValidate = int.parse(day);
      var yearValidate = int.parse(year);

      if (yearValidate == 0000) {
        return false;
      }

      if (yearValidate.toString().length != 4) {
        return false;
      }

      if (validateCurrentMajorYear) {
        return !(DateTime(yearValidate, monthValidate, dayValidate).isAfter(
          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        ));
      }

      if (monthValidate <= 12 && monthValidate > 0) {
        if (dayValidate <= 0) {
          return false;
        }
        if (monthValidate == 2) {
          if (leapYear(yearValidate)) {
            if (dayValidate > 29) {
              return false;
            }
          } else {
            if (dayValidate > 28) {
              return false;
            }
          }
        }

        if ([1, 3, 5, 7, 8, 10, 12].contains(monthValidate)) {
          if (dayValidate > 31) {
            return false;
          }
        } else {
          if (dayValidate > 30) {
            return false;
          }
        }
      } else {
        return false;
      }

      DateTime.parse(dateConvert);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String getNameWeek({
    required int weekDay,
    required AppLocalizations appLocalizations,
  }) {
    switch (weekDay) {
      case 1:
        return appLocalizations.monday;
      case 2:
        return appLocalizations.tuesday;
      case 3:
        return appLocalizations.wednesday;
      case 4:
        return appLocalizations.thursday;
      case 5:
        return appLocalizations.friday;
      case 6:
        return appLocalizations.saturday;
      case 7:
        return appLocalizations.sunday;
      default:
        return '';
    }
  }

  static String getNameMonth({
    required int? month,
    required AppLocalizations appLocalizations,
  }) {
    switch (month) {
      case 1:
        return appLocalizations.january;
      case 2:
        return appLocalizations.february;
      case 3:
        return appLocalizations.march;
      case 4:
        return appLocalizations.april;
      case 5:
        return appLocalizations.may;
      case 6:
        return appLocalizations.june;
      case 7:
        return appLocalizations.july;
      case 8:
        return appLocalizations.august;
      case 9:
        return appLocalizations.september;
      case 10:
        return appLocalizations.october;
      case 11:
        return appLocalizations.november;
      case 12:
        return appLocalizations.december;
      default:
        return '';
    }
  }

  static String formatElapsedTime({
    required DateTime compareDate,
    required AppLocalizations appLocalizations,
    required String locale,
  }) {
    String agoEn = '';
    String ago = '';
    if (locale.substring(0, 2).toLowerCase() == 'en') {
      agoEn = ' ${appLocalizations.ago}';
    } else {
      ago = '${appLocalizations.ago} ';
    }

    final postTimeLocal = compareDate.toLocal();
    Duration timeDifference = DateTime.now().difference(postTimeLocal);

    if (timeDifference.inDays >= 365) {
      final years = (timeDifference.inDays / 365).floor();
      return years > 1 ? '$ago$years ${appLocalizations.years}$agoEn' : '$ago$years ${appLocalizations.year}$agoEn';
    } else if (timeDifference.inDays >= 30) {
      final months = (timeDifference.inDays / 30).floor();
      return months > 1
          ? '$ago$months ${appLocalizations.months}$agoEn'
          : '$ago$months ${appLocalizations.month}$agoEn';
    } else if (timeDifference.inDays >= 1) {
      final days = timeDifference.inDays;
      return days > 1 ? '$ago$days ${appLocalizations.days}$agoEn' : '$ago$days ${appLocalizations.day}$agoEn';
    } else if (timeDifference.inHours >= 1) {
      final hours = timeDifference.inHours;
      return hours > 1 ? '$ago$hours ${appLocalizations.hours}$agoEn' : '$ago$hours ${appLocalizations.hour}$agoEn';
    } else {
      return timeDifference.inMinutes > 1
          ? '$ago${timeDifference.inMinutes} ${appLocalizations.minutes}$agoEn'
          : '$ago${timeDifference.inMinutes} ${appLocalizations.minute}$agoEn';
    }
  }
}
