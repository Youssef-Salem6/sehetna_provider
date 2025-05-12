import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/fetures/profile/models/analytics_model.dart';

part 'user_analytics_state.dart';

class UserAnalyticsCubit extends Cubit<UserAnalyticsState> {
  UserAnalyticsCubit() : super(UserAnalyticsInitial());
  late AnalyticsModel analyticsModel;
  getUserAnalytics() async {
    emit(UserAnalyticsLoading());
    Uri url = Uri.parse(getAnalyticsApi);
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      analyticsModel = AnalyticsModel.fromJson(
        json: jsonDecode(response.body)["data"],
      );
      emit(UserAnalyticsSuccess());
    } else {
      emit(
        UserAnalyticsFailure(
          errorMessage: jsonDecode(response.body)["message"],
        ),
      );
    }
  }
}
