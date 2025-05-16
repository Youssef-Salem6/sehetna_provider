import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehetne_provider/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/push_notification_services.dart';
part 'update_fcm_token_state.dart';

class UpdateFcmTokenCubit extends Cubit<UpdateFcmTokenState> {
  UpdateFcmTokenCubit() : super(UpdateFcmTokenInitial());
  updateFcmToken({required String email}) async {
    Uri url = Uri.parse(updateFcmTokenApi);
    var response = await http.post(
      url,
      body: {
        "email": email,
        "fcm_token": PushNotificationServices.myToken,
        "device_type": "android",
      },
    );
    if (response.statusCode == 200) {
      emit(UpdateFcmTokenSuccess());
      print("send fcm done");
    } else {
      emit(UpdateFcmTokenFailure());
      print("send fcm fail");
    }
  }
}
