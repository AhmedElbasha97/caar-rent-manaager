import 'package:carrentmanger/Models/terms_and_privacy_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Services/app_info_services.dart';

class TermsAndConditionController extends GetxController{
  late TermsAndPrivacyModel? termsData;
  bool loading = true;
  bool isOffline = false;

  final BuildContext context;
  @override
  TermsAndConditionController(this.context);
  @override
  Future<void> onInit() async {

    super.onInit();
    getData();
  }

  getData() async {
    termsData = await AppInfoServices.getTermsAndConditions();
    loading = false;
    update();
  }
}