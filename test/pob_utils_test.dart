import 'package:test/test.dart';
import 'package:flutter_openwrap_sdk/flutter_openwrap_sdk.dart';
import 'package:flutter_openwrap_sdk/src/helpers/pob_utils.dart';

void main() {
  group('convertMapToPOBError method tests', () {
    test('Testing with valid errorCode and message', () {
      int errorCode = 1001;
      String errorMessage = 'Server error';
      Map errorMap = {'errorCode': errorCode, 'errorMessage': errorMessage};
      POBError? error = POBUtils.convertMapToPOBError(errorMap);
      expect(error, isNotNull);
      expect(error.errorCode, errorCode);
      expect(error.errorMessage, errorMessage);
    });

    test('Testing with invalid errorCode', () {
      double errorCode = 10.5;
      String errorMessage = 'Server error';
      Map errorMap = {'errorCode': errorCode, 'errorMessage': errorMessage};
      POBError? error = POBUtils.convertMapToPOBError(errorMap);
      expect(error, isNotNull);
      expect(error.errorCode, POBError.internalError);
      expect(error.errorMessage, 'Server error');
    });

    test('Testing with invalid message', () {
      int errorCode = 1001;
      int errorMessage = 999;
      Map errorMap = {'errorCode': errorCode, 'errorMessage': errorMessage};
      POBError? error = POBUtils.convertMapToPOBError(errorMap);
      expect(error, isNotNull);
      expect(error.errorCode, errorCode);
      expect(error.errorMessage, "Internal Error Occurred");
    });

    test('Testing with null errorCode', () {
      int? errorCode;
      String errorMessage = 'Server error';
      Map errorMap = {'errorCode': errorCode, 'errorMessage': errorMessage};
      POBError? error = POBUtils.convertMapToPOBError(errorMap);
      expect(error, isNotNull);
      expect(error.errorCode, POBError.internalError);
      expect(error.errorMessage, "Server error");
    });

    test('Testing with null message', () {
      int errorCode = 1001;
      String? errorMessage;
      Map errorMap = {'errorCode': errorCode, 'errorMessage': errorMessage};
      POBError? error = POBUtils.convertMapToPOBError(errorMap);
      expect(error, isNotNull);
      expect(error.errorCode, errorCode);
      expect(error.errorMessage, "Internal Error Occurred");
    });
  });

  group('convertAdSizesToListOfMap method tests', () {
    test('Testing count of items in returned list', () {
      POBAdSize adSize1 = POBAdSize(width: 100, height: 100);
      POBAdSize adSize2 = POBAdSize(width: 200, height: 200);
      List convertedAdSizes =
          POBUtils.convertAdSizesToListOfMap([adSize1, adSize2]);
      expect(convertedAdSizes, isNotNull);
      expect(convertedAdSizes.length, 2);
    });

    test('Testing values of returned list', () {
      int width = 100;
      int height = 50;
      POBAdSize pobAdSize = POBAdSize(width: width, height: height);
      List convertedAdSizes = POBUtils.convertAdSizesToListOfMap([pobAdSize]);
      expect(convertedAdSizes.length, 1);
      Map<String, int> expectedAdSize =
          convertedAdSizes.first as Map<String, int>;
      expect(expectedAdSize, isNotNull);
      expect(expectedAdSize["w"], 100);
      expect(expectedAdSize["h"], 50);
    });
  });

  test('Convert map of object to map of string util method test', () {
    //Return null case.
    expect(POBUtils.convertMapOfObjectToMapOfString(null), isNull);
    expect(POBUtils.convertMapOfObjectToMapOfString({}), isNull);

    //Passing targeting.
    Map<Object?, Object?> targeting = {
      'a': 'b',
      'c': null,
      null: null,
      // ignore: equal_keys_in_map
      null: 'd',
      3: 5,
      4.5: true
    };
    expect(POBUtils.convertMapOfObjectToMapOfString(targeting),
        <String, String>{'a': 'b', '3': '5', '4.5': 'true'});
  });
}
