// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapStore on _MapStore, Store {
  final _$currentPositionAtom = Atom(name: '_MapStore.currentPosition');

  @override
  Position? get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Position? value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  final _$currentAddressAtom = Atom(name: '_MapStore.currentAddress');

  @override
  String get currentAddress {
    _$currentAddressAtom.reportRead();
    return super.currentAddress;
  }

  @override
  set currentAddress(String value) {
    _$currentAddressAtom.reportWrite(value, super.currentAddress, () {
      super.currentAddress = value;
    });
  }

  final _$startAddressAtom = Atom(name: '_MapStore.startAddress');

  @override
  String get startAddress {
    _$startAddressAtom.reportRead();
    return super.startAddress;
  }

  @override
  set startAddress(String value) {
    _$startAddressAtom.reportWrite(value, super.startAddress, () {
      super.startAddress = value;
    });
  }

  final _$destinationAddressAtom = Atom(name: '_MapStore.destinationAddress');

  @override
  String get destinationAddress {
    _$destinationAddressAtom.reportRead();
    return super.destinationAddress;
  }

  @override
  set destinationAddress(String value) {
    _$destinationAddressAtom.reportWrite(value, super.destinationAddress, () {
      super.destinationAddress = value;
    });
  }

  final _$placeDistanceAtom = Atom(name: '_MapStore.placeDistance');

  @override
  String? get placeDistance {
    _$placeDistanceAtom.reportRead();
    return super.placeDistance;
  }

  @override
  set placeDistance(String? value) {
    _$placeDistanceAtom.reportWrite(value, super.placeDistance, () {
      super.placeDistance = value;
    });
  }

  final _$markersAtom = Atom(name: '_MapStore.markers');

  @override
  ObservableSet<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(ObservableSet<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$polylinesAtom = Atom(name: '_MapStore.polylines');

  @override
  ObservableMap<PolylineId, Polyline> get polylines {
    _$polylinesAtom.reportRead();
    return super.polylines;
  }

  @override
  set polylines(ObservableMap<PolylineId, Polyline> value) {
    _$polylinesAtom.reportWrite(value, super.polylines, () {
      super.polylines = value;
    });
  }

  final _$polylineCoordinatesAtom = Atom(name: '_MapStore.polylineCoordinates');

  @override
  ObservableList<LatLng> get polylineCoordinates {
    _$polylineCoordinatesAtom.reportRead();
    return super.polylineCoordinates;
  }

  @override
  set polylineCoordinates(ObservableList<LatLng> value) {
    _$polylineCoordinatesAtom.reportWrite(value, super.polylineCoordinates, () {
      super.polylineCoordinates = value;
    });
  }

  final _$geCurrentLocationAsyncAction =
      AsyncAction('_MapStore.geCurrentLocation');

  @override
  Future geCurrentLocation() {
    return _$geCurrentLocationAsyncAction.run(() => super.geCurrentLocation());
  }

  final _$getAddressAsyncAction = AsyncAction('_MapStore.getAddress');

  @override
  Future<dynamic> getAddress() {
    return _$getAddressAsyncAction.run(() => super.getAddress());
  }

  final _$calculateDistanceAsyncAction =
      AsyncAction('_MapStore.calculateDistance');

  @override
  Future<bool> calculateDistance() {
    return _$calculateDistanceAsyncAction.run(() => super.calculateDistance());
  }

  final _$_createPolylinesAsyncAction =
      AsyncAction('_MapStore._createPolylines');

  @override
  Future _createPolylines(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) {
    return _$_createPolylinesAsyncAction.run(() => super._createPolylines(
        startLatitude,
        startLongitude,
        destinationLatitude,
        destinationLongitude));
  }

  @override
  String toString() {
    return '''
currentPosition: ${currentPosition},
currentAddress: ${currentAddress},
startAddress: ${startAddress},
destinationAddress: ${destinationAddress},
placeDistance: ${placeDistance},
markers: ${markers},
polylines: ${polylines},
polylineCoordinates: ${polylineCoordinates}
    ''';
  }
}
