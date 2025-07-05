// تأكد إن flutter_inappwebview >= 6.4.0
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late InAppWebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.storage,
    ].request();
  }



  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: kDarkGreenColor, // نفس لون الخلفية
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: kDarkGreenColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: kDarkGreenColor,

        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
                return false;
              }
              return true;
            },
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    geolocationEnabled: true,
                    allowsInlineMediaPlayback: true,
                    mediaPlaybackRequiresUserGesture: false,
                    useOnDownloadStart: true,
                      allowUniversalAccessFromFileURLs: true,
                      allowFileAccess: true,
                      allowContentAccess: true,
                    domStorageEnabled: true,
                    databaseEnabled: true,
                    clearSessionCache: true,
                    thirdPartyCookiesEnabled: true,
                  ),

                  onWebViewCreated: (c) => webViewController = c,
                  androidOnGeolocationPermissionsShowPrompt: (ctrl, origin) async {
                    return GeolocationPermissionShowPromptResponse(
                        origin: origin, allow: true, retain: true);
                  },
                  onLoadStart: (_, __) => setState(() => isLoading = true),
                  onLoadStop: (_, __) => setState(() => isLoading = false),
                  androidOnPermissionRequest: (_, __, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  onProgressChanged: (_, prog) {
                    if (prog < 100 && !isLoading) setState(() => isLoading = true);
                    else if (prog == 100) setState(() => isLoading = false);
                  },

                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    final url = navigationAction.request.url.toString().toLowerCase();
                    print("Trying to open URL: $url");

                    final externalSchemes = [
                      "wa.me", "whatsapp", "facebook.com", "m.me", "fb.me",
                      "fb-messenger", "instagram.com", "youtube.com",
                      "mailto:", "tel:", "twitter.com", "t.me", "snapchat.com","www.google.com/maps"
                    ];

                    final shouldOpenExternally = externalSchemes.any((scheme) => url.contains(scheme));

                    if (shouldOpenExternally) {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        print("❌ Can't launch $url");
                      }
                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                ),

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


              ],
            ),
          ),
        ),
      ),
    );
  }
}
