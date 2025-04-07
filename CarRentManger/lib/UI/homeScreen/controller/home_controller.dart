// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:carrentmanger/Services/app_info_services.dart';
import 'package:carrentmanger/UI/web_view.dart';
import 'package:carrentmanger/models/app_department_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/constant.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';

class HomeController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final BuildContext context;
  ScrollController scrollController = ScrollController();
  HomeController(this.context);
  AppDepartmentModel? data;
  bool isLoading = true;
  @override
  onInit() {
    super.onInit();
    getDepartmentData();
  }
  decideIfThereIsNotificationDetectOrNotAndItIsBehavior() async {
    if((Get
        .find<StorageService>()
        .checkIfThereIsNotificationPage)&&(Get
        .find<StorageService>()
        .checkIfThereIsNotificationPageId)){
      Get.to(  WebViewContainer("https://prog.carrentmanager.com/api/car_request_cars?mem_id=${Get.find<StorageService>().getId}&request_id=${Get
          .find<StorageService>()
          .getNotificationPageId}"));
    }

  }
  getDepartmentData() async {
    data = await AppInfoServices.getAppDepartment();
    isLoading = false;
    update();
  }
}