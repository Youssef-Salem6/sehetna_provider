import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit() : super(RequestDetailsInitial());
  Map request = {};
  getRequestDetails({required String requestId}) async {
    emit(RequestDetailsLoading());
    Uri url = Uri.parse("$requestsBase/$requestId");
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      request = jsonDecode(response.body)["data"];

      emit(RequestDetailsSuccess());
    } else {
      emit(RequestDetailsFailure(
          errorMessage: jsonDecode(response.body)["message"]));
    }
  }
}
