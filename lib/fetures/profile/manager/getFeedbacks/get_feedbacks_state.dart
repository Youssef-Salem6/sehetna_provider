part of 'get_feedbacks_cubit.dart';

@immutable
sealed class GetFeedbacksState {}

final class GetFeedbacksInitial extends GetFeedbacksState {}

final class GetFeedbacksLoading extends GetFeedbacksState {}

final class GetFeedbacksSuccess extends GetFeedbacksState {}

final class GetFeedbacksFailure extends GetFeedbacksState {
  final String errorMessage;

  GetFeedbacksFailure({required this.errorMessage});
}
