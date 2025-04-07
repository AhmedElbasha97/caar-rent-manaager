import 'dart:io';

import 'package:carrentmanger/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ImageShowWidget extends StatefulWidget {
  const ImageShowWidget({super.key, required this.images, required this.chooseAnotherImage, required this.deleteImage, required this.getNextImage, required this.getPreviousImage, required this.index});
  final List<File> images ;
  final VoidCallback chooseAnotherImage;
  final VoidCallback deleteImage;
  final VoidCallback getNextImage;
  final VoidCallback getPreviousImage;
  final int index;
  @override
  State<ImageShowWidget> createState() => _ImageShowWidgetState();
}

class _ImageShowWidgetState extends State<ImageShowWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget.images.length == 1?const SizedBox():  InkWell(
          onTap: (){
            widget.getPreviousImage();
          },

          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.white
            ),
            child: const Center(
              child: Icon(Icons.arrow_back_ios_new_rounded,color: kDarkGreenColor,),
            ),
          ),
        ),
        Stack(
          children: [

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
                child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Image.file(
                        width: Get.width*0.6,
                        height: Get.height*0.5,
                        widget.images[widget.index],
                        fit: BoxFit.contain,
                      ),
                    )
                )),

            Positioned(
              top: 5,
              left: 5,
              child: InkWell(
                onTap: (){
                 widget.chooseAnotherImage();
                },
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.white
                    ),
                    child: const Center(
                      child: Icon(Icons.edit,color: kDarkBlueColor,),
                    ),
                  ),
              ),
            ),
            widget.images.length==1?const SizedBox():Positioned(
              top: 5,
              right: 5,
              child:InkWell(
                onTap: (){
                  widget.deleteImage();
                },

                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.white
                  ),
                  child: const Center(
                    child: Icon(Icons.delete_outline,color: kDarkBlueColor,),
                  ),
                ),
              ),

            ),

          ],
        ),
        widget.images.length == 1?const SizedBox():  InkWell(
          onTap: (){
          widget.getNextImage();
            },

          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.white
            ),
            child: const Center(
              child: Icon(Icons.arrow_forward_ios_rounded,color: kDarkBlueColor,),
            ),
          ),
        )
      ],
    );
  }
}
