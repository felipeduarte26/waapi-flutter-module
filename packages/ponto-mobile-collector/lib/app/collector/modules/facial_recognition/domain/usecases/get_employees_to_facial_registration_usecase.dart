import '../../../../core/domain/enums/token_type.dart';
import '../../../../core/domain/usecases/get_access_token_usecase.dart';
import '../entities/pagination_employee_item_entity.dart';
import '../repositories/get_employees_to_facial_registration_repository.dart';

/// Default pageSize and pageNumber to search
const pageSize = 15;
const pageNumber = 0;

abstract class GetEmployeesToFacialRegistrationUsecase {
  Future<PaginationEmployeeItemEntity> call({
    String? name,
    int pageNumber = pageNumber,
    int pageSize = pageSize,
  });
}

class GetEmployeesToFacialRegistrationUsecaseImpl
    implements GetEmployeesToFacialRegistrationUsecase {
  final GetEmployeesToFacialRegistrationRepository
      getEmployeesToFacialRegistrationRepository;
  final GetAccessTokenUsecase _getAccessTokenUsecase;

  const GetEmployeesToFacialRegistrationUsecaseImpl({
    required this.getEmployeesToFacialRegistrationRepository,
    required GetAccessTokenUsecase getAccessTokenUsecase,
  }) : _getAccessTokenUsecase = getAccessTokenUsecase;

  @override
  Future<PaginationEmployeeItemEntity> call({
    String? name,
    int pageNumber = pageNumber,
    int pageSize = pageSize,
  }) async {
    String? token =
        await _getAccessTokenUsecase.call(tokenType: TokenType.user);
    token ??= await _getAccessTokenUsecase.call(tokenType: TokenType.key);

    return getEmployeesToFacialRegistrationRepository.call(
      name: name,
      pageNumber: pageNumber,
      pageSize: pageSize,
      token: token!,
    );
  }
}
