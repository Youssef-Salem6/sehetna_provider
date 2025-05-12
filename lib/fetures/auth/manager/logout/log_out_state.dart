part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}

final class LogOutSuccess extends LogOutState {}

final class LogOutFailure extends LogOutState {
  final String errorMessage;

  LogOutFailure({required this.errorMessage});
}

final class LogOutLodaing extends LogOutState {}
