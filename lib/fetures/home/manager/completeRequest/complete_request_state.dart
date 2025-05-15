part of 'complete_request_cubit.dart';

@immutable
sealed class CompleteRequestState {}

final class CompleteRequestInitial extends CompleteRequestState {}

final class CompleteRequestSuccess extends CompleteRequestState {
  final String message;

  CompleteRequestSuccess({required this.message});
}

final class CompleteRequestFailure extends CompleteRequestState {
  final String errorMessage;

  CompleteRequestFailure({required this.errorMessage});
}

final class CompleteRequestLoading extends CompleteRequestState {}
