import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_web/homeprovider.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController txtsearch = TextEditingController();

  homeProvider? homeProviderfalse;
  homeProvider? homeProvidertrue;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    homeProviderfalse = Provider.of<homeProvider>(context, listen: false);
    homeProvidertrue = Provider.of<homeProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                children: [

                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      controller: txtsearch,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.google.com/search?q=" + txtsearch.text)));
                    },
                    icon: Icon(Icons.search),
                  ),

                  IconButton(
                    onPressed: () {
                      webViewController!.goBack();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),

                  IconButton(
                    onPressed: () {
                      webViewController!.goForward();
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: homeProvidertrue!.progressbar.toDouble(),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(homeProvidertrue!.url),
                ),
                initialOptions: options,
                androidOnPermissionRequest:
                    (controller, origin, resource) async {
                  return PermissionRequestResponse(
                    resources: resource,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
                onLoadStart: (controller, url) {
                  homeProviderfalse!.changeUrl(url.toString());
                  webViewController = controller;

                  setState(
                        () {
                      txtsearch = TextEditingController(text: url.toString());
                    },
                  );
                },

                onLoadError: (controller, url, code, message){
                  homeProviderfalse!.changeUrl(url.toString());
                  webViewController = controller;

                  setState(
                        () {
                      txtsearch = TextEditingController(text: url.toString());
                    },
                  );
                },

                onLoadStop: (controller, url) {
                  homeProviderfalse!.changeUrl(url.toString());
                  webViewController = controller;

                  setState(
                        () {
                      txtsearch = TextEditingController(text: url.toString());
                    },
                  );
                },

                onProgressChanged: (cotroller,progress) => homeProviderfalse!.changeProgress(progress),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
