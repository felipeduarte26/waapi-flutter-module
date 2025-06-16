import 'package:equatable/equatable.dart';

import '../../../domain/entities/happiness_index_group_entity.dart';

abstract class RetrieveAllReasonsState extends Equatable {
  final List<HappinessIndexGroupEntity> groupList;

  const RetrieveAllReasonsState({
    this.groupList = const [],
  });

  @override
  List<Object?> get props {
    return [
      groupList,
    ];
  }
}

class InitialRetrieveAllReasonsState extends RetrieveAllReasonsState {
  const InitialRetrieveAllReasonsState() : super(groupList: const []);
}

class LoadingRetrieveAllReasonsState extends RetrieveAllReasonsState {
  const LoadingRetrieveAllReasonsState() : super(groupList: const []);
}

class EmptyRetrieveAllReasonsState extends RetrieveAllReasonsState {
  const EmptyRetrieveAllReasonsState() : super(groupList: const []);
}

class LoadedRetrieveAllReasonsState extends RetrieveAllReasonsState {
  const LoadedRetrieveAllReasonsState({
    required List<HappinessIndexGroupEntity> groupList,
  }) : super(groupList: groupList);
}

class ErrorRetrieveAllReasonsState extends RetrieveAllReasonsState {
  final String? message;

  const ErrorRetrieveAllReasonsState({
    required this.message,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
