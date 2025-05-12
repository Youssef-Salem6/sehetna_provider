part of 'documents_status_cubit.dart';

@immutable
sealed class DocumentsStatusState {}

final class DocumentsStatusInitial extends DocumentsStatusState {}

final class DocumentsStatusLoading extends DocumentsStatusState {}

final class DocumentsStatusSuccess extends DocumentsStatusState {}

final class DocumentsStatusFailure extends DocumentsStatusState {}
