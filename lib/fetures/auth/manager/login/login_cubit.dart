import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  List missingList = [];
  login(String email, String password) async {
    emit(LoginLoading());
    Uri url = Uri.parse(loginApi);
    var response = await http.post(
      url,
      body: {"email": email, "password": password, "user_type": "provider"},
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      print(data["data"]["token"]);
      pref.setString("id", data["data"]["user"]["id"].toString());
      pref.setString("email", data["data"]["user"]["email"]);
      pref.setString("firstName", data["data"]["user"]["first_name"]);
      pref.setString("lastName", data["data"]["user"]["last_name"]);
      pref.setString("phone", data["data"]["user"]["phone"]);
      pref.setString("address", data["data"]["user"]["address"]);
      pref.setString("token", data["data"]["token"]);
      pref.setString(
        "provider_type",
        data["data"]["user"]["provider"]["provider_type"],
      );
      pref.setString("image", data["data"]["user"]["profile_image"] ?? "");
      pref.setString("gender", data["data"]["user"]["gender"]);
      pref.setBool("isActive", false);
      emit(LoginSuccess());
    } else if (response.statusCode == 422) {
      emit(LoginWrongUserType());
    } else if (response.statusCode == 403) {
      missingList = jsonDecode(response.body)["message"]["missing_documents"];
      emit(LoginFailurePendingAccount());
    } else if (response.statusCode == 401) {
      emit(LoginWrongAccount());
    } else {
      emit(LoginFailure());
    }
  }
}
