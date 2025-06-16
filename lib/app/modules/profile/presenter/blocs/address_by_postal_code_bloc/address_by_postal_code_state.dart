import 'package:equatable/equatable.dart';

import '../../../domain/entities/address_entity.dart';

abstract class AddressByPostalCodeState extends Equatable {
  final AddressEntity? addressByPostalCodeEntity;

  const AddressByPostalCodeState({
    required this.addressByPostalCodeEntity,
  });

  LoadingAddressByPostalCodeState loadingAddressByPostalCodeState() {
    return LoadingAddressByPostalCodeState(
      addressByPostalCodeEntity: addressByPostalCodeEntity,
    );
  }

  LoadedAddressByPostalCodeState loadedAddressByPostalCodeState({
    required AddressEntity addressByPostalCodeEntity,
  }) {
    return LoadedAddressByPostalCodeState(
      addressByPostalCodeEntity: addressByPostalCodeEntity,
    );
  }

  ErrorAddressByPostalCodeState errorAddressByPostalCodeState() {
    return ErrorAddressByPostalCodeState(
      addressByPostalCodeEntity: addressByPostalCodeEntity,
    );
  }

  ErrorUpdateAddressByPostalCodeState errorUpdateAddressByPostalCodeState() {
    return ErrorUpdateAddressByPostalCodeState(
      addressByPostalCodeEntity: addressByPostalCodeEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      addressByPostalCodeEntity,
    ];
  }
}

class InitialAddressByPostalCodeState extends AddressByPostalCodeState {
  const InitialAddressByPostalCodeState({
    AddressEntity? addressByPostalCodeEntity,
  }) : super(addressByPostalCodeEntity: addressByPostalCodeEntity);
}

class LoadingAddressByPostalCodeState extends AddressByPostalCodeState {
  const LoadingAddressByPostalCodeState({
    AddressEntity? addressByPostalCodeEntity,
  }) : super(addressByPostalCodeEntity: addressByPostalCodeEntity);
}

class LoadedAddressByPostalCodeState extends AddressByPostalCodeState {
  const LoadedAddressByPostalCodeState({
    required AddressEntity addressByPostalCodeEntity,
  }) : super(addressByPostalCodeEntity: addressByPostalCodeEntity);
}

class ErrorAddressByPostalCodeState extends AddressByPostalCodeState {
  const ErrorAddressByPostalCodeState({
    AddressEntity? addressByPostalCodeEntity,
  }) : super(addressByPostalCodeEntity: addressByPostalCodeEntity);
}

class ErrorUpdateAddressByPostalCodeState extends AddressByPostalCodeState {
  const ErrorUpdateAddressByPostalCodeState({
    AddressEntity? addressByPostalCodeEntity,
  }) : super(addressByPostalCodeEntity: addressByPostalCodeEntity);
}
