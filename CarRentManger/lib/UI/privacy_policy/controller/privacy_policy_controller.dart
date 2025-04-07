import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:carrentmanger/Models/terms_and_privacy_model.dart';
import '../../../Services/app_info_services.dart';

class PrivacyPolicyController extends GetxController {
  late TermsAndPrivacyModel? privacyData;
  bool loading = true;
  bool isOffline = false;
  final BuildContext context;
  @override
  PrivacyPolicyController(this.context);
  @override
  Future<void> onInit() async {

    super.onInit();
    getData();
  }

  getData() async {
    privacyData = await AppInfoServices.getPrivacyPolicy();
    loading = false;
    update();
  }
}