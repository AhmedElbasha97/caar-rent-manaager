import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carrentmanger/Services/car_services.dart';

import 'package:carrentmanger/Utils/colors.dart';
import 'package:carrentmanger/Utils/localization_services.dart';
import 'package:carrentmanger/Utils/memory.dart';
import 'package:carrentmanger/models/car_rented_model.dart';
import 'package:carrentmanger/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarRentedDetailsController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  List<Widget> dotsList = [];
  bool gettingLocation = true;
  final CarRentedModel? carData;
  bool isSendingData =false;

  CarouselSliderController carouselController = CarouselSliderController();
  int activeIndex = 0;

  ScrollController scrollController = ScrollController();




  CarRentedDetailsController(this.carData);
  @override
  Future<void> onInit() async {
    super.onInit();

    makingDotsForCarouselSlider();
  }

  makingDotsForCarouselSlider(){
    int productLength = carData?.imgs?.length??0;
    dotsList = [];
    for(int i=0;i<productLength;i++){
      dotsList.add(
          InkWell(
            onTap:(){
              onImageChange(i);
            },
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                  width:10,
                  height:10,
                  decoration:BoxDecoration(
                    shape:BoxShape.circle,
                    color:i==activeIndex?kDarkBlueColor:kWhiteColor,
                  )


              ),
            ),
          )
      );
    }
  }
  onImageChange(int index){
    activeIndex = index;
    carouselController.jumpToPage(index);
    makingDotsForCarouselSlider();
    update(["Carsoul"]);
  }
  pausingCarRenting(BuildContext context,String requestId) async {
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
            ? "We are stopping your car rental.":"نحن نوقف تأجير سيارتك ",

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

      ResponseModel? data = await CarServices.pausingRentingCar(requestId);

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
              ? 'the car rental has been stopped successfully'
              : 'تم إيقاف تأجير سيارتك بنجاح', style: const TextStyle(
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
              ? 'An error occurred while stopping the car rental'
              : 'حدث خطأ أثناء إيقاف تأجير سيارتك', style: const TextStyle(
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
}