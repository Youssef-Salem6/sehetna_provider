part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailurePendingAccount extends LoginState {}

final class LoginWrongAccount extends LoginState {}

final class LoginWrongUserType extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {}
