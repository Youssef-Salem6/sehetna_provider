import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:http/http.dart' as http;
part 'documents_status_state.dart';

class DocumentsStatusCubit extends Cubit<DocumentsStatusState> {
  DocumentsStatusCubit() : super(DocumentsStatusInitial());

  List documents = [];
  String accountStatus = "";
  getDocumentsStatus({required String email}) async {
    emit(DocumentsStatusLoading());
    try {
      final response = await http.post(
        Uri.parse(decumentsStatusApi),
        body: {"email": email},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        documents = jsonDecode(response.body)["data"]["documents"];
        accountStatus = jsonDecode(response.body)["data"]["account_status"];

        print(accountStatus);
        emit(DocumentsStatusSuccess());
      } else {
        emit(DocumentsStatusFailure());
      }
    } catch (e) {
      emit(DocumentsStatusFailure());
    }
  }
}
