import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

auth.CompanyDto companyDtoMock = auth.CompanyDto(
  cnpj: 'cnpj',
  id: 'id',
  name: 'name',
  timeZone: '-0300',
  dataOrigin: auth.DataOriginType.manual,
);
