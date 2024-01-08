part of 'bloc.dart';

class LocationEvents {}

class GetCurrentLocationEvent extends LocationEvents {}

class GetAddressEvent extends LocationEvents {}

class AddAddressEvent extends LocationEvents {
  final String type;
  final String description;
  final String phone, location;
  final bool isDefault;

  AddAddressEvent({
    required this.type,
    required this.description,
    required this.location,
    required this.phone,
    required this.isDefault,
  });
}

class DeleteAddressEvent extends LocationEvents {
  final int id;

  DeleteAddressEvent({
    required this.id,
  });
}

class UpdateAddressEvent extends LocationEvents {
  final int id;
  final String type;
  final String description;
  final String phone, location;
  final bool isDefault;

  UpdateAddressEvent({
    required this.id,
    required this.type,
    required this.description,
    required this.location,
    required this.phone,
    required this.isDefault,
  });
}
