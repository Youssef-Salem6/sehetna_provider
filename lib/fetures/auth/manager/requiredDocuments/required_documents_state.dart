part of 'required_documents_cubit.dart';

@immutable
sealed class RequiredDocumentsState {}

final class RequiredDocumentsInitial extends RequiredDocumentsState {}

final class RequiredDocumentsSuccess extends RequiredDocumentsState {}

final class RequiredDocumentsFailure extends RequiredDocumentsState {}

final class RequiredDocumentsLoading extends RequiredDocumentsState {}
