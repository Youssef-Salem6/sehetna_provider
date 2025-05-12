import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'upload_documents_state.dart';

class UploadDocumentsCubit extends Cubit<UploadDocumentsState> {
  UploadDocumentsCubit() : super(UploadDocumentsInitial());

  Future<void> uploadDocuments(List<Map<String, dynamic>> documents) async {
    emit(UploadDocumentsLoading());
    try {
      for (var doc in documents) {
        var request =
            http.MultipartRequest('POST', Uri.parse(uploadDocsApi))
              ..fields['email'] = doc['email']
              ..fields['required_document_id'] =
                  doc['required_document_id'].toString()
              ..files.add(
                await http.MultipartFile.fromPath('document', doc['file'].path),
              );

        var response = await request.send();

        if (response.statusCode != 200) {
          emit(UploadDocumentsFailure());
          return;
        }
      }
      emit(UploadDocumentsSuccess());
    } catch (e) {
      print(e);
      emit(UploadDocumentsFailure());
    }
  }
}
