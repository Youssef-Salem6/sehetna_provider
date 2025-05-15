import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'complete_request_state.dart';

class CompleteRequestCubit extends Cubit<CompleteRequestState> {
  CompleteRequestCubit() : super(CompleteRequestInitial());
  completeRequest({required String requestId}) async {
    emit(CompleteRequestLoading());
    Uri url = Uri.parse("$completeRequestApi/$requestId");
    var response = await http.post(url, headers: header);
    String message = jsonDecode(response.body)["message"];
    if (response.statusCode == 200) {
      emit(CompleteRequestSuccess(message: message));
    } else {
      emit(CompleteRequestFailure(errorMessage: message));
    }
  }
}
