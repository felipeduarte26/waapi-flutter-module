import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/company.dart';
import '../../domain/input_model/company_dto.dart';

class CompanyMapper {
  static CompanyDto? fromClockToCollectorDto(clock.CompanyDto? companyDto) {
    if (companyDto == null) {
      return null;
    }

    return CompanyDto(
      id: companyDto.id!,
      name: companyDto.name,
      cnpj: companyDto.identifier,
      timeZone: companyDto.timeZone,
      arpId: companyDto.arpId,
      caepf: companyDto.caepf,
      cnoNumber: companyDto.cnoNumber,
    );
  }

  static clock.CompanyDto? fromCollectorDtoToClock(CompanyDto? dto) {
    if (dto == null) {
      return null;
    }
    return clock.CompanyDto(
      id: dto.id,
      identifier: dto.cnpj ?? '',
      caepf: dto.caepf,
      cnoNumber: dto.cnoNumber,
      name: dto.name,
      timeZone: dto.timeZone,
      arpId: dto.arpId,
    );
  }

  static Company? fromDtoToEntityCollector(CompanyDto? companyDto) {
    if (companyDto == null) {
      return null;
    }

    return Company(
      id: companyDto.id,
      name: companyDto.name,
      cnpj: companyDto.cnpj?? '',
      timeZone: companyDto.timeZone,
      arpId: companyDto.arpId,
      caepf: companyDto.caepf,
      cnoNumber: companyDto.cnoNumber,
    );
  }

  static CompanyDto? fromEntityToDtoCollector(Company? company) {
    if (company == null) {
      return null;
    }

    return CompanyDto(
      id: company.id ?? '',
      name: company.name,
      cnpj: company.cnpj,
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );
  }

  static CompanyDto? fromAuthToCollectorDto(auth.CompanyDto? company) {
    if (company == null) {
      return null;
    }
    return CompanyDto(
      id: company.id,
      name: company.name,
      cnpj: company.cnpj,
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );
  }

  static Company? fromClockToCollectorEntity(clock.CompanyDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }
    return Company(
      id: dtoClock.id,
      name: dtoClock.name,
      cnpj: dtoClock.identifier,
      timeZone: dtoClock.timeZone,
      arpId: dtoClock.arpId,
      caepf: dtoClock.caepf,
      cnoNumber: dtoClock.cnoNumber,
    );
  }
}
