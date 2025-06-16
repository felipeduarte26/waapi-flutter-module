import 'package:equatable/equatable.dart';

abstract class AddressByPostalCodeEvent extends Equatable {
  const AddressByPostalCodeEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetAddressByPostalCodeEvent extends AddressByPostalCodeEvent {
  final String postalCode;

  const GetAddressByPostalCodeEvent({
    required this.postalCode,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      postalCode,
    ];
  }
}
