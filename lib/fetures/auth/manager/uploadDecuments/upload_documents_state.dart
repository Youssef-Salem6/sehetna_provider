part of 'upload_documents_cubit.dart';

@immutable
sealed class UploadDocumentsState {}

final class UploadDocumentsInitial extends UploadDocumentsState {}

final class UploadDocumentsSuccess extends UploadDocumentsState {}

final class UploadDocumentsLoading extends UploadDocumentsState {}

final class UploadDocumentsFailure extends UploadDocumentsState {}
