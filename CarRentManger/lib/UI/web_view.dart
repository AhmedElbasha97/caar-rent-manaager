// ignore_for_file: deprecated_member_use, unused_local_variable, depend_on_referenced_packages

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
as webview_flutter_android;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../Utils/colors.dart';
import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';
import '../Widget/custom_text_widget.dart';

class WebViewContainer extends StatefulWidget {
  final String url;

  const WebViewContainer(this.url, {super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    // Platform-specific WebView controller
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
            ''');
            setState(() {
              isLoading = false;
              hasError = true;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https://carrentmanager.com/")) {
              return NavigationDecision.navigate;
            } else {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is webview_flutter_android.AndroidWebViewController) {
      webview_flutter_android.AndroidWebViewController.enableDebugging(true);
      (controller.platform as webview_flutter_android.AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
    initFilePicker();
  }

  _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri);
  }

  /// Set up file picker for Android
  initFilePicker() async {
    if (Platform.isAndroid) {
      final androidController =
      (_controller.platform as webview_flutter_android.AndroidWebViewController);
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    if (params.acceptTypes.any((type) => type == 'image/*')) {
      final picker = image_picker.ImagePicker();
      final photo = await picker.pickImage(source: image_picker.ImageSource.camera);
      if (photo == null) return [];
      return [Uri.file(photo.path).toString()];
    } else if (params.acceptTypes.any((type) => type == 'video/*')) {
      final picker = image_picker.ImagePicker();
      final vidFile = await picker.pickVideo(
        source: image_picker.ImageSource.camera,
        maxDuration: const Duration(seconds: 10),
      );
      if (vidFile == null) return [];
      return [Uri.file(vidFile.path).toString()];
    } else {
      try {
        if (params.mode == webview_flutter_android.FileSelectorMode.openMultiple) {
          final attachments = await FilePicker.platform.pickFiles(allowMultiple: true);
          if (attachments == null) return [];
          return attachments.files
              .where((element) => element.path != null)
              .map((e) => File(e.path!).uri.toString())
              .toList();
        } else {
          final attachment = await FilePicker.platform.pickFiles();
          if (attachment == null) return [];
          File file = File(attachment.files.single.path!);
          return [file.uri.toString()];
        }
      } catch (e) {
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
            return false;
          } else {
            debugPrint('No history available');
            return true;
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),

              // Loading indicator
              if (isLoading)
                Container(
                  height: MediaQuery.of(context).size.height ,
                  width: MediaQuery.of(context).size.width,
                  color:const Color(0x80000000),
                  child: Center(
                    child: Container(
                      height:  MediaQuery.of(context).size.height *0.3,
                      width: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [kWhiteColor,kDarkGreenColor],
                        ),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5, //soften the shadow
                            spreadRadius: 0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              3.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,height: 150,
                              child: Image.asset("assets/images/app_logo.png",fit: BoxFit.fitWidth,),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkGreenColor)
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                                .slide(),
                            const SizedBox(height:10),
                            CustomText(
                              Get.find<StorageService>().activeLocale == SupportedLocales.english?"Loading...":"جار التحميل...",
                              style:  TextStyle(
                                fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkGreenColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,

                                height: 1,
                                letterSpacing: -1,
                              ),
                            ) .animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color: kDarkGreenColor)
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                                .slide(),
                            const SizedBox(height: 10,),

                          ],
                        ),
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())

                        .animate() // this wraps the previous Animate in another Animate
                        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                        .slide(),
                  ),
                ),

              // Error overlay
              if (hasError)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 60),
                      const SizedBox(height: 10),
                      const Text(
                        "حدث خطأ أثناء تحميل الصفحة",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hasError = false;
                            isLoading = true;
                          });
                          _controller.loadRequest(Uri.parse(widget.url));
                        },
                        child: const Text("إعادة المحاولة"),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}