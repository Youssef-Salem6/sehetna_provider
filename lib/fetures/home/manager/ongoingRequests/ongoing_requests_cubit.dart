import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'ongoing_requests_state.dart';

class OngoingRequestsCubit extends Cubit<OngoingRequestsState> {
  OngoingRequestsCubit() : super(OngoingRequestsInitial());

  List ongoingRequests = [];
  getOngoningRequests() async {
    emit(OngoingRequestsLoading());
    try {
      Uri uri = Uri.parse(getOngoingRequestsApi);
      var response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        ongoingRequests = jsonDecode(response.body)["data"];
        if (ongoingRequests.isEmpty) {
          emit(OngoingRequestsEmpty());
        } else {
          emit(OngoingRequestsSuccess());
        }
      } else {
        emit(OngoingRequestsFailure(jsonDecode(response.body)["message"]));
      }
    } catch (e) {
      emit(OngoingRequestsFailure(e.toString()));
    }
  }
}
