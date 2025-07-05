
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';

import '../../aadding_car_for_rent/controller/adding_car_for_rent_controller.dart';
import '../widget/location_pin.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  final googleApikey = "AIzaSyD04ljszRU7P1ImArt4MPcobozVR258FXY"; // ضع مفتاحك هنا

  var gettingLocation = true.obs;
  var location = "Search Location".obs;
  var address = "".obs;
  var countryCode = "".obs;
  LatLng? positionOfTheCar;
  var position = const LatLng(0, 0).obs;
  late BitmapDescriptor customIcon;


  Map<MarkerId, Marker> markers = {};
  String previousMarkerId = "";
  int markerIdCounter = 1;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final res = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position.value = LatLng(res.latitude, res.longitude);
    await addMarker(position.value.latitude, position.value.longitude);
    gettingLocation.value = false;
  }

  Future<void> addMarker(double lat, double lng) async {
    final markerIdVal = 'marker_id_$markerIdCounter';
    previousMarkerId = markerIdVal;
    markerIdCounter++;
    final markerId = MarkerId(markerIdVal);
    Uint8List? icon = await MarkersWithLabel.getBytesFromCanvasDynamic(
        iconPath: 'assets/images/location_pin.png', plateReg:Get.locale?.languageCode == 'en' ? "my car":"سياراتى", fontSize: 35, iconSize:  const Size(120,145));
    final marker = Marker(
      icon: BitmapDescriptor.fromBytes(icon!),
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: Get.locale?.languageCode == 'en' ? 'Your Current Location' : 'مكانك الحالى',
        snippet: Get.locale?.languageCode == 'en'
            ? 'This is the location of the car you want to add'
            : 'هذا هو مكان السيارة التى تريد أضافتها',
      ),
    );
    position.value = LatLng(lat, lng);
    positionOfTheCar = LatLng(lat, lng);
    markers.clear();
    markers[markerId] = marker;
    await getAddress(lat, lng);
    update();
  }

  Future<void> getAddress(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark placeMark = placemarks.first;
    countryCode.value = placeMark.isoCountryCode ?? "";
    address.value = "${placeMark.street}, ${placeMark.subAdministrativeArea}, ${placeMark.subLocality}, ${placeMark.country}";
  }

  Future<void> onMapTap(LatLng pos) async {
    if (pos.latitude != position.value.latitude || pos.longitude != position.value.longitude) {
      await addMarker(pos.latitude, pos.longitude);
    }
  }

  Future<void> searchAndNavigate(BuildContext context) async {
    var place = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApikey,
      mode: Mode.overlay,
      types: [],
      strictbounds: false,
      onError: (err) {
        print("PlacesAutocomplete error: ${err.errorMessage}");
      },
    );

    if (place != null && place.placeId != null) {
      location.value = place.description ?? "";
      final places = GoogleMapsPlaces(apiKey: googleApikey);
      final detail = await places.getDetailsByPlaceId(place.placeId!);
      final geometry = detail.result.geometry;
      if (geometry != null) {
        final lat = geometry.location.lat;
        final lng = geometry.location.lng;
        final newLatLng = LatLng(lat, lng);
        await addMarker(lat, lng);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: newLatLng, zoom: 17),
          ),
        );
      }
    }
  }
  choosingTheLocationOfTheCar(){
    Get.find<AddingCarForRentController>().choosingLocationOfTheCar(positionOfTheCar);
    Get.back();
  }
}