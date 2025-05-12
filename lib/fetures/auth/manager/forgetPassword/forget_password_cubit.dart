import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    Uri url = Uri.parse(sendCodeApi);
    http.Response response = await http.post(url, body: {"email": email});

    if (response.statusCode == 200) {
      emit(ForgetPasswordSuccess());
    } else {
      emit(ForgetPasswordFailure());
    }
  }
}
