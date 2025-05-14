import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  Future<void> getLocation() async {
    emit(GetLocationLoading());
    try {
      // Check and request location services
      if (!await _checkLocationServices()) {
        emit(GetLocationFailure("Location services are disabled"));
        return;
      }

      // Check and request permissions
      final permission = await _checkLocationPermissions();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        emit(GetLocationFailure("Location permissions denied"));
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();
      emit(
        GetLocationLoaded(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        ),
      );
    } catch (e) {
      emit(GetLocationFailure(e.toString()));
    }
  }

  Future<bool> _checkLocationServices() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> _checkLocationPermissions() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }
}
