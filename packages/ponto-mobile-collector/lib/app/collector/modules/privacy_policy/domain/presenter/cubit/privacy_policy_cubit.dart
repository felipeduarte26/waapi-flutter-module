import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/domain/entities/privacy_policy_entity.dart';
import '../../../../../core/domain/repositories/database/privacy_policy_repository.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../../core/domain/usecases/get_last_version_privacy_policy_usecase.dart';
import 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyBaseState> {
  final GetLastVersionPrivacyPolicyUsecase getLastVersionPrivacyPolicyUseCase;
  final PrivacyPolicyRepository privacyPolicyRepository;
  final HasConnectivityUsecase hasConnectivityUsecase;
  final bool isTest;

  PrivacyPolicyCubit({
    required this.getLastVersionPrivacyPolicyUseCase,
    required this.privacyPolicyRepository,
    required this.hasConnectivityUsecase,
    this.isTest = false,
  }) : super(LoadingContentState());

  Future<void> initialize() async {
    var lastVersionSaved = await getLastVersionPrivacyPolicyUseCase.call();
    bool hasConnectivity = await hasConnectivityUsecase.call();
    if (lastVersionSaved != null && hasConnectivity) {
      String formattedDate = '';
      if (lastVersionSaved.dateTimeEventRead != null) {
        final String defaultLocale = Platform.localeName;
        formattedDate = formatDateTime(
          dateTime: lastVersionSaved.dateTimeEventRead!,
          locale: defaultLocale,
        );
      }

      return emit(
        ReadContentState(
          dateTimeEventRead: formattedDate,
          privacyPolicyEntity: PrivacyPolicyEntity(
            dateTimeEventRead: lastVersionSaved.dateTimeEventRead,
            urlVersion: lastVersionSaved.urlVersion,
            version: lastVersionSaved.version,
          ),
        ),
      );
    }
    return emit(HasNoConectionState());
  }

  Future<void> goToPrivacyPolicyPage({
    required PrivacyPolicyEntity lastVersionSaved,
  }) async {
    if (lastVersionSaved.dateTimeEventRead == null) {
      lastVersionSaved.dateTimeEventRead = DateTime.now();

      await privacyPolicyRepository.save(
        privacyPolicy: lastVersionSaved,
      );
    }

    Uri url = Uri.parse(
      lastVersionSaved.urlVersion,
    );
    if(!isTest) {
      await launchUrl(url);
    }

    emit(
      ReadContentState(
        dateTimeEventRead: formatDateTime(
          dateTime: lastVersionSaved.dateTimeEventRead!,
          locale: Platform.localeName,
        ),
        privacyPolicyEntity: lastVersionSaved,
      ),
    );
  }

  String formatDateTime({required DateTime dateTime, required String locale}) {
    String formattedDate;
    if (locale.contains('en')) {
      formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(dateTime);
    } else {
      formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
    return formattedDate;
  }
}
