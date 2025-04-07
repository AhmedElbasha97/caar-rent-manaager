import 'package:carrentmanger/Services/car_services.dart';
import 'package:carrentmanger/models/car_rented_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CarRentListController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

 late  List<CarRentedModel>? carData ;
  bool isLoading = true;
  @override
  onInit() {
    super.onInit();
    gettingRequsetsData();
  }
  //getting data from api
  gettingRequsetsData() async {
    carData = await CarServices.getRentedCarsList();
    isLoading = false;
    update();
  }
}