enum ExecutionModeEnum {
  none,
  individual,
  driver,
  multiple;

  bool isIndividualOrDriver() {
    return isIndividual() || isDriver();
  }

  bool isNone() {
    return this == ExecutionModeEnum.none;
  }

  bool isIndividual() {
    return this == ExecutionModeEnum.individual;
  }

  bool isDriver() {
    return this == ExecutionModeEnum.driver;
  }

  bool isMultiple() {
    return this == ExecutionModeEnum.multiple;
  }
}
