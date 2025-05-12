import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
import 'package:sehetne_provider/main.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  register({required Map body}) async {
    emit(RegisterLoading());
    Uri url = Uri.parse(registerApi);
    print(body);
    var response = await http.post(url, body: body);
    if (response.statusCode == 201) {
      Map body = jsonDecode(response.body);
      print(response.body);
      pref.setString("id", body["data"]["user"]["id"].toString());
      pref.setString("email", body["data"]["user"]["email"]);
      pref.setString("firstName", body["data"]["user"]["first_name"]);
      pref.setString("lastName", body["data"]["user"]["last_name"]);
      pref.setString("phone", body["data"]["user"]["phone"]);
      pref.setString("address", body["data"]["user"]["address"]);
      emit(RegisterSuccess());
    } else {
      emit(RegisterFailure(error: jsonDecode(response.body)["message"]));
    }
  }
}
