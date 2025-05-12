part of 'change_status_cubit.dart';

@immutable
sealed class ChangeStatusState {}

final class ChangeStatusInitial extends ChangeStatusState {}

final class ChangeStatusSuccess extends ChangeStatusState {
  final String message;
  ChangeStatusSuccess({required this.message});
}

final class ChangeStatusLoading extends ChangeStatusState {}

final class ChangeStatusFailure extends ChangeStatusState {
  final String errorMessage;
  ChangeStatusFailure({required this.errorMessage});
}
