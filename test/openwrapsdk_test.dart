import 'package:flutter_openwrap_sdk/flutter_openwrap_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

void main() {
  dynamic testData;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_openwrap_sdk'),
            (message) {
      if (message.method.split('#')[0] == 'OpenWrapSDK') {
        testData = message.arguments;
      }
      return null;
    });
  });

  test("OpenWrap SDK API", () {
    //setLogLevel
    OpenWrapSDK.setLogLevel(POBLogLevel.error);
    expect(testData, POBLogLevel.error.index);

    //allowLocationAccess
    testData = false;
    OpenWrapSDK.allowLocationAccess(true);
    expect(testData, isTrue);

    //setUseInternalBrowser
    testData = false;
    OpenWrapSDK.setUseInternalBrowser(true);
    expect(testData, isTrue);

    //setLocation
    OpenWrapSDK.setLocation(POBLocationSource.gps, 12.2, 13.2);
    expect((testData as Map)['source'], POBLocationSource.gps.index);

    //setCoppa
    testData = false;
    OpenWrapSDK.setCoppa(true);
    expect(testData, isTrue);

    //setSSLEnabled
    testData = false;
    OpenWrapSDK.setSSLEnabled(true);
    expect(testData, isTrue);

    //allowAdvertisingId
    testData = false;
    OpenWrapSDK.allowAdvertisingId(true);
    expect(testData, isTrue);

    //ApplicationInfo
    POBApplicationInfo applicationInfo = POBApplicationInfo();
    applicationInfo.categories = 'Games';
    OpenWrapSDK.setApplicationInfo(applicationInfo);
    expect(testData['categories'], applicationInfo.categories);

    //UserInfo
    POBUserInfo userInfo = POBUserInfo();
    userInfo.birthYear = 2000;
    OpenWrapSDK.setUserInfo(userInfo);
    expect(testData['birthYear'], userInfo.birthYear);
  });
}
