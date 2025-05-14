part of 'get_location_cubit.dart';

@immutable
sealed class GetLocationState {}

final class GetLocationInitial extends GetLocationState {}

final class GetLocationLoading extends GetLocationState {}

final class GetLocationLoaded extends GetLocationState {
  final String latitude;
  final String longitude;

  GetLocationLoaded({required this.latitude, required this.longitude});
}

final class GetLocationFailure extends GetLocationState {
  final String errorMessage;

  GetLocationFailure(this.errorMessage);
}
