import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/main.dart';
part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  logout() async {
    emit(LogOutLodaing());
    Uri url = Uri.parse(logOutApi);

    // Retrieve the token from SharedPreferences
    final token = pref.getString("token");
    if (token == null) {
      emit(LogOutFailure(errorMessage: "Token not found"));
      return;
    }

    http.Response response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    if (response.statusCode == 200) {
      await pref.clear();
      emit(LogOutSuccess());
      print("log out done");
    } else {
      emit(LogOutFailure(errorMessage: jsonDecode(response.body)["message"]));
    }
  }
}
