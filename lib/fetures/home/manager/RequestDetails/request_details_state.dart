part of 'request_details_cubit.dart';

@immutable
sealed class RequestDetailsState {}

final class RequestDetailsInitial extends RequestDetailsState {}

final class RequestDetailsLoading extends RequestDetailsState {}

final class RequestDetailsSuccess extends RequestDetailsState {}

final class RequestDetailsFailure extends RequestDetailsState {
  final String errorMessage;
  RequestDetailsFailure({required this.errorMessage});
}
