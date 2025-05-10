part of 'user_analytics_cubit.dart';

@immutable
sealed class UserAnalyticsState {}

final class UserAnalyticsInitial extends UserAnalyticsState {}

final class UserAnalyticsSuccess extends UserAnalyticsState {}

final class UserAnalyticsFailure extends UserAnalyticsState {
  final String errorMessage;

  UserAnalyticsFailure({required this.errorMessage});
}

final class UserAnalyticsLoading extends UserAnalyticsState {}
