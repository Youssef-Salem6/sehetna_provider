import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'get_feedbacks_state.dart';

class GetFeedbacksCubit extends Cubit<GetFeedbacksState> {
  GetFeedbacksCubit() : super(GetFeedbacksInitial());
  List feedbacks = [];
  getFeedbacks() async {
    emit(GetFeedbacksLoading());
    Uri url = Uri.parse(getFeedBacksApi);
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      feedbacks = jsonDecode(response.body)["data"]["feedbacks"];
      emit(GetFeedbacksSuccess());
    } else {
      emit(
        GetFeedbacksFailure(errorMessage: jsonDecode(response.body)["message"]),
      );
    }
  }
}
