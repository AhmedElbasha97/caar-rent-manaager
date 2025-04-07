import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrentmanger/Services/car_services.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/models/car_requests_result_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarRequestDetailsController extends GetxController{
  final int requestId;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  bool isSendingData =false;
  bool isLoading = true;
  late List<CarRequestResultModel>? carData ;

  CarRequestDetailsController(this.requestId);
  pausingCarRequest(BuildContext context,String requestId) async {
    if(isSendingData){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? "please wait ...":"انتظر من فضلك ...",
        desc: Get
            .find<StorageService>()
            .activeLocale ==
            SupportedLocales.english
            ? "we are pausing your request":"نحن نوقف طلبك مؤقتًا",

        btnCancelText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"no":"لا",
        btnOkText: Get
            .find<StorageService>()
            .activeLocale == SupportedLocales.english
            ?"yes":"نعم",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }else {
      isSendingData = true;
      update();

      ResponseModel? data = await CarServices.pausingCarRequest(requestId);

      print(data?.msg);
      if (data?.msg == "succeeded") {
        final snackBar = SnackBar(content:
        Row(children: [
          const Icon(Icons.check, color: Colors.white,),
          const SizedBox(width: 10,),
          Text(Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? 'the request has been paused successfully'
              : 'تم إيقاف الطلب بنجاح', style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ],),
            backgroundColor: Colors.green
        );
        isSendingData = true;
        update();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
      else {
        isSendingData = true;
        update();
        final snackBar = SnackBar(content:
        Row(children: [
          const Icon(Icons.close, color: Colors.white,),
          const SizedBox(width: 10,),
          Text(Get
              .find<StorageService>()
              .activeLocale ==
              SupportedLocales.english
              ? 'An error occurred while pausing the request'
              : 'حدث خطأ أثناء إيقاف الطلب', style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ],),
            backgroundColor: Colors.red
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
  onInit() {
    super.onInit();
    gettingRequestsResultsData();
  }
  //getting data from api
  gettingRequestsResultsData() async {
    carData = await CarServices.getCarRequestsResultsList("$requestId");
    isLoading = false;
    update();
  }
}