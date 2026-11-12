import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:persistence/persistence.dart';

/// [LocationService] con el paquete `geolocator`.
class GeolocatorLocationService implements LocationService {
  const new({this.timeout = const Duration(seconds: 30)});

  /// Tiempo máximo de espera de la lectura.
  final Duration timeout;

  @override
  Future<LocationCandidate> currentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationException(LocationFailure.serviceDisabled);
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationFailure.permissionDeniedForever);
    }
    if (permission == LocationPermission.denied) {
      throw const LocationException(LocationFailure.permissionDenied);
    }
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(timeLimit: timeout),
      );
      return _toCandidate(position);
    } on TimeoutException {
      throw const LocationException(LocationFailure.timeout);
    }
  }

  @override
  Future<LocationCandidate?> lastKnownPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        return null;
      }
      final position = await Geolocator.getLastKnownPosition();
      return position == null ? null : _toCandidate(position);
    } on Object {
      return null;
    }
  }

  static LocationCandidate _toCandidate(Position p) => LocationCandidate(
    latitude: p.latitude,
    longitude: p.longitude,
    source: LocationSource.gps,
    // Android devuelve 0 cuando no conoce la altitud.
    altitudeM: p.altitude == 0 ? null : p.altitude,
    accuracyM: p.accuracy,
  );
}
