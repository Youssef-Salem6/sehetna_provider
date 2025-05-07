import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetna_provider/constants/apis.dart';
part 'get_complaints_state.dart';

class GetComplaintsCubit extends Cubit<GetComplaintsState> {
  GetComplaintsCubit() : super(GetComplaintsInitial());
  List complaints = [];

  getComplaints() async {
    Uri url = Uri.parse(getComplaintApi);
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {}
  }
}
