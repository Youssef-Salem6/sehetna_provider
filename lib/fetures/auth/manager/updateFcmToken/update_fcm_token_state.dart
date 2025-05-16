part of 'update_fcm_token_cubit.dart';

@immutable
sealed class UpdateFcmTokenState {}

final class UpdateFcmTokenInitial extends UpdateFcmTokenState {}

final class UpdateFcmTokenSuccess extends UpdateFcmTokenState {}

final class UpdateFcmTokenFailure extends UpdateFcmTokenState {}

final class UpdateFcmTokenLoading extends UpdateFcmTokenState {}
