import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Utils/colors.dart';
import '../../Widget/custom_text_widget.dart';
import '../../Widget/loader.dart';

import 'controller/map_controller.dart';

class MapScreen extends StatelessWidget {
  final MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: kDarkGreenColor, // نفس لون الخلفية
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: kDarkGreenColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
            backgroundColor: kDarkGreenColor,


      bottomNavigationBar: _buildBottomSheet(context),
      body: SafeArea(
        child: controller.gettingLocation.value
            ? Loader()
            : Stack(
          children: [
            GoogleMap(
              onTap: controller.onMapTap,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              markers: Set<Marker>.of(controller.markers.values),
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: controller.position.value,
                zoom: 14.0,
              ),
              onMapCreated: (mapCtrl) {
                controller.mapController = mapCtrl;
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: InkWell(
                onTap: () => controller.searchAndNavigate(context),
                child: Card(
                  child: ListTile(
                    title: Obx(() => Text(
                      controller.location.value,
                      style: TextStyle(fontSize: 18),
                    )),
                    trailing: Icon(Icons.search),
                    dense: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(10.0),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 1)],
      ),
      child: Column(
        children: [
          CustomText(
            controller.address.value,
            style: const TextStyle(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              controller.choosingTheLocationOfTheCar();
          },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF66a5b4),
              ),
              child: Text(
                Get.locale?.languageCode == 'en' ? 'This is the location' : 'هذا هو المكان',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
