import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:http/http.dart' as http;

part 'accept_request_state.dart';

class AcceptRequestCubit extends Cubit<AcceptRequestState> {
  AcceptRequestCubit() : super(AcceptRequestInitial());
  acceptRequest({required String requestId}) async {
    emit(AcceptRequestLoading());
    Uri url = Uri.parse("$acceptRequestApi/$requestId");
    var response = await http.post(url, headers: header);
    String message = jsonDecode(response.body)["message"];
    if (response.statusCode == 200) {
      emit(AcceptRequestSuccess(message: message));
    } else {
      emit(AcceptRequestFailure(errorMessage: message));
    }
  }
}
