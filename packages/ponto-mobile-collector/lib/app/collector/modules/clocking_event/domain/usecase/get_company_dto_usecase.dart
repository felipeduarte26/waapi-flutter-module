import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/company_dto.dart';
import '../../../../core/external/mappers/company_mapper.dart';

abstract class IGetCompanyDtoUsecase {
  Future<CompanyDto?> call({required String id});
}

class GetCompanyDtoUsecase implements IGetCompanyDtoUsecase {
  final ICompanyRepository _companyRepository;

  const GetCompanyDtoUsecase({
    required ICompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  @override
  Future<CompanyDto?> call({required String id}) async {
    var entity = await _companyRepository.findById(id: id);
    return CompanyMapper.fromEntityToDtoCollector(entity);
  }
}
