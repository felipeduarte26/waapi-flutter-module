enum HappinessIndexMoodEnum {
  great,
  fine,
  neutral,
  upset,
  angry;

  double valueOfChartLine() {
    switch (this) {
      case great:
        return 5.0;
      case fine:
        return 4.0;
      case neutral:
        return 3.0;
      case upset:
        return 2.0;
      case angry:
        return 1.0;
    }
  }
}
