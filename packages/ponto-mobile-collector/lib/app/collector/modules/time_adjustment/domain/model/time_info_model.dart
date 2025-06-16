class TimeInfoModel {
  final String clockingEventId;
  final DateTime dateTime;
  final bool isBold;
  final bool isPhoneOrigin;
  final bool isPlatformOrigin;
  final bool isManual;
  final bool isRemoteness;
  final bool isSynchronized;
  final int use;
  final bool isMealBreak;

  TimeInfoModel({
    required this.clockingEventId,
    required this.dateTime,
    required this.isBold,
    required this.isPhoneOrigin,
    required this.isPlatformOrigin,
    required this.isManual,
    required this.isRemoteness,
    required this.isSynchronized,
    required this.use,
    required this.isMealBreak,
  });
}
