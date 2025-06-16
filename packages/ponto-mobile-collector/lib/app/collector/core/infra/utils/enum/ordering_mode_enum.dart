enum OrderingModeEnum {
  asc,
  desc;

  static OrderingModeEnum build(String name) {
    if (name == OrderingModeEnum.asc.name) {
      return OrderingModeEnum.asc;
    }

    if (name ==
        OrderingModeEnum.desc.name) {
      return OrderingModeEnum.desc;
    }

    throw Exception('OrderingModeEnum not found.');
  }
}
