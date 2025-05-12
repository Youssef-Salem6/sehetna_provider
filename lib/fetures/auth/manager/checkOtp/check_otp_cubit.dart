import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  CheckOtpCubit() : super(CheckOtpInitial());
  checkCode({required String email, required String code}) async {
    emit(CheckOtpLoading());
    Uri url = Uri.parse(otpApi);
    var response = await http.post(url, body: {
      "email": email,
      "reset_code": code,
    });
    if (response.statusCode == 200) {
      emit(CheckOtpSuccess());
    } else {
      print(response.statusCode);
      emit(CheckOtpFailure());
    }
  }
}
