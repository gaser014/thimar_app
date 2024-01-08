import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/logic/dio_helper.dart';
import 'model.dart';

part 'states.dart';

part 'events.dart';

class LocationBloc extends Bloc<LocationEvents, LocationState> {
  late Marker marker;
  late LocationData locationModel;
  LocationBloc() : super(LocationState()) {
    on<GetCurrentLocationEvent>(_getLocation);
    on<GetAddressEvent>(_getAddress);
    on<AddAddressEvent>(_addAddress);
    on<DeleteAddressEvent>(_deleteAddress);
    on<UpdateAddressEvent>(_updateAddress);
  }

  Future<void> _getLocation(
    GetCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(CurrentLocationLoadingState());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(CurrentLocationFieldsState(
          massage: 'Location services are disabled.'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(CurrentLocationFieldsState(
            massage: 'Location services are disabled.'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(CurrentLocationFieldsState(
          massage: 'Location services are disabled.'));
    }

    Position position = await Geolocator.getCurrentPosition();
    marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      markerId: const MarkerId('1'),
      position: LatLng(position.latitude, position.longitude),
    );

    emit(CurrentLocationSuccessState(position: position));
  }

  Future<void> _getAddress(
      GetAddressEvent event, Emitter<LocationState> emit) async {
    emit(AddressLoadingState());

    final response = await DioHelper().getData(
      endPoint: 'client/addresses',
      haveToken: true,
    );
    if (response.isSuccess) {
      final model = LocationData.fromJson(response.response!.data);
      locationModel = model;
      emit(AddressSuccessState(model: locationModel.list));
    } else {
      emit(AddressFieldsState(massage: response.message.toString()));
    }
  }

  Future<void> _addAddress(
      AddAddressEvent event, Emitter<LocationState> emit) async {
    emit(AddressLoadingState());

    final response = await DioHelper().sendData(
      endPoint: 'client/addresses',
      haveToken: true,
      data: {
        'type': event.type,
        'phone': event.phone,
        'description': event.description,
        'location': event.location,
        'lat': marker.position.latitude.toString(),
        'lng': marker.position.longitude.toString(),
        'is_default': event.isDefault ? 1 : 0,
      },
    );
    if (response.isSuccess) {
      final model = LocationModel.fromJson(response.response!.data);
locationModel.list.add(model);
      emit(AddressSuccessState(model: locationModel.list));
    } else {
      emit(AddressFieldsState(massage: response.message.toString()));
    }
  }

  Future<void> _deleteAddress(
      DeleteAddressEvent event, Emitter<LocationState> emit) async {
    emit(AddressLoadingState());

    final response = await DioHelper().deleteData(
      endPoint: 'client/addresses/${event.id}',
      haveToken: true,
    );
    if (response.isSuccess) {
      locationModel.list.removeWhere((element) => element.id == event.id);
      emit(AddressSuccessState(model: locationModel.list));
    } else {
      emit(AddressFieldsState(massage: response.message.toString()));
    }
  }

  Future<void> _updateAddress(
      UpdateAddressEvent event, Emitter<LocationState> emit) async {
    emit(AddressLoadingState());

    final response = await DioHelper().upDateData(
      endPoint: 'client/addresses/${event.id}',
      haveToken: true,
      data: {
        'type': event.type,
        'phone': event.phone,
        'description': event.description,
        'location': event.location,
        'lat': marker.position.latitude.toString(),
        'lng': marker.position.longitude.toString(),
        'is_default': event.isDefault ? 1 : 0,
      },
    );
    if (response.isSuccess) {
      emit(AddressUpdateSuccessState());
    } else {
      emit(AddressFieldsState(massage: response.message.toString()));
    }
  }
}
