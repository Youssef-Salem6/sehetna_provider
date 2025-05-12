import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  resetPassword({
    required String email,
    required String password,
    required String confirmationPassword,
  }) async {
    emit(ResetPasswordLoading());
    Uri url = Uri.parse(resetPasswordApi);
    var respose = await http.post(url, body: {
      "email": email,
      "password": password,
      "password_confirmation": confirmationPassword,
    });
    if (respose.statusCode == 200) {
      emit(ResetPasswordSuccess());
    } else {
      emit(ResetPasswordFailure());
    }
  }
}
