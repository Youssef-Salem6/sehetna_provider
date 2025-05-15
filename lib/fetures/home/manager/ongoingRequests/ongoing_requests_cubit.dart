import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:sehetne_provider/constants/apis.dart';
part 'ongoing_requests_state.dart';

class OngoingRequestsCubit extends Cubit<OngoingRequestsState> {
  OngoingRequestsCubit() : super(OngoingRequestsInitial());

  List ongoingRequests = [];

  getOngoningRequests() async {
    emit(OngoingRequestsLoading());
    try {
      Uri uri = Uri.parse(getOngoingRequestsApi);
      var response = await http.get(uri, headers: header);

      if (response.statusCode == 200) {
        // Add debug print to inspect data
        debugPrint("API Response: ${response.body}");

        var responseData = jsonDecode(response.body);
        if (responseData["data"] == null) {
          emit(OngoingRequestsFailure("Invalid data format"));
          return;
        }

        ongoingRequests = responseData["data"];

        if (ongoingRequests.isEmpty) {
          emit(OngoingRequestsEmpty());
        } else {
          // Print first request to debug
          debugPrint("First request: ${ongoingRequests[0]}");
          emit(OngoingRequestsSuccess());
        }
      } else {
        emit(
          OngoingRequestsFailure(
            jsonDecode(response.body)["message"] ??
                "Error ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      debugPrint("Exception in getOngoningRequests: $e");
      emit(OngoingRequestsFailure(e.toString()));
    }
  }
}
