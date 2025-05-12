import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'get_complaints_state.dart';

class GetComplaintsCubit extends Cubit<GetComplaintsState> {
  GetComplaintsCubit() : super(GetComplaintsInitial());
  List complaints = [];

  getComplaints() async {
    emit(GetComplaintsLoading());
    Uri url = Uri.parse("https://api.sehtnaa.com/api/provider/complaints");
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      print(response.body);
      complaints = jsonDecode(response.body)["data"]["complaints"];
      emit(GetComplaintsSuccess());
    } else {
      emit(GetComplaintsFailure(
          errorMessage: jsonDecode(response.body)["message"]));
    }
  }
}
