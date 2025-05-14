import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'change_status_state.dart';

class ChangeStatusCubit extends Cubit<ChangeStatusState> {
  ChangeStatusCubit() : super(ChangeStatusInitial());
  bool isActive = false;
  changeStatus({required double lati, required double long}) async {
    emit(ChangeStatusLoading());
    Uri url = Uri.parse(changeStatusApi);
    var response = await http.post(
      url,
      headers: header,
      body: {
        "is_available": isActive ? 0.toString() : 1.toString(),
        "latitude": lati.toString(),
        "longitude": long.toString(),
      },
    );
    if (response.statusCode == 200) {
      isActive = !isActive;
      emit(ChangeStatusSuccess(message: jsonDecode(response.body)["message"]));
    } else {
      emit(
        ChangeStatusFailure(errorMessage: jsonDecode(response.body)["message"]),
      );
    }
  }
}
