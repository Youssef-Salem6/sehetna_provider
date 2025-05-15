part of 'accept_request_cubit.dart';

@immutable
sealed class AcceptRequestState {}

final class AcceptRequestInitial extends AcceptRequestState {}

final class AcceptRequestSuccess extends AcceptRequestState {
  final String message;

  AcceptRequestSuccess({required this.message});
}

final class AcceptRequestLoading extends AcceptRequestState {}

final class AcceptRequestFailure extends AcceptRequestState {
  final String errorMessage;

  AcceptRequestFailure({required this.errorMessage});
}
