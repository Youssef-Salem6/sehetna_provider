import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/fetures/auth/models/required_Docs_Model.dart';
part 'required_documents_state.dart';

class RequiredDocumentsCubit extends Cubit<RequiredDocumentsState> {
  RequiredDocumentsCubit() : super(RequiredDocumentsInitial());

  List<RequiredDocsModel> requiredDocs = [];

  getRequirdesDocs({required String email}) async {
    emit(RequiredDocumentsLoading());
    try {
      var response = await http.post(
        Uri.parse(requiredDocsApi),
        body: {"email": email},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body)["data"];
        requiredDocs = List<RequiredDocsModel>.from(
            data.map((doc) => RequiredDocsModel.fromJson(doc)));
        emit(RequiredDocumentsSuccess());
      } else {
        emit(RequiredDocumentsFailure());
      }
    } catch (e) {
      print(e);
      emit(RequiredDocumentsFailure());
    }
  }
}
