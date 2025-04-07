import 'package:carrentmanger/Services/car_services.dart';
import 'package:carrentmanger/models/car_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CarRequestListController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  late List<CarRequestModel>? carData ;
  bool isLoading = true;
  @override
  onInit() {
    super.onInit();
    gettingRequsetsData();
  }
  //getting data from api
  gettingRequsetsData() async {
    carData = await CarServices.getCarRequestsList();
    isLoading = false;
    update();
  }

}