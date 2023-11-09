package com.pubmatic.sdk.flutter_openwrap_sdk

import com.pubmatic.sdk.common.POBAdSize
import com.pubmatic.sdk.common.POBError

/**
 * Common utility class.
 */
object POBUtils {
  /**
   *  Generic method to get enum from value.
   */
  @JvmStatic
  inline infix fun <reified E : Enum<E>, V> ((E) -> V).findBy(value: V): E? {
    return enumValues<E>().firstOrNull { this(it) == value }
  }

  /**
   * Convert the list of HashMap<String, Int> to array of [POBAdSize]
   *
   * @param sizes list of hash maps
   * @return Array of [POBAdSize]
   */
  @JvmStatic
  fun convertListToPOBAdSizes(sizes: List<HashMap<String, Int>>): Array<POBAdSize?> {
    val adSizes: Array<POBAdSize?> = arrayOfNulls(sizes.size)
    var count = 0
    for (size in sizes) {
      size["w"]?.let { width ->
        size["h"]?.let { height ->
          adSizes[count++] = POBAdSize(width, height)
        }
      }
    }
    return adSizes
  }

  /**
   * Create an argument map with ad id.
   */
  @JvmStatic
  fun getArgumentMap(adId: Int): Map<String, Any> {
    val arguments: HashMap<String, Any> = HashMap()
    arguments[POBFlutterConstants.KEY_AD_ID] = adId
    return arguments
  }

  /**
   * Create an argument map with ad id and error details.
   */
  @JvmStatic
  fun getArgumentMap(adId: Int, error: POBError): Map<String, Any> {
    val arguments: HashMap<String, Any> = HashMap()
    arguments[POBFlutterConstants.KEY_AD_ID] = adId
    arguments[POBFlutterConstants.KEY_ERROR_CODE] = error.errorCode
    arguments[POBFlutterConstants.KEY_ERROR_MESSAGE] = error.errorMessage
    return arguments
  }

  /**
   * Create an argument map with ad id and OpenWrap targeting.
   */
  @JvmStatic
  fun getArgumentMap(adId: Int, openWrapTargeting: Map<String, String>?): Map<String, Any> {
    val arguments: HashMap<String, Any> = HashMap()
    arguments[POBFlutterConstants.KEY_AD_ID] = adId
    openWrapTargeting?.let {
      arguments[POBFlutterConstants.KEY_OW_TARGETING] = it
    }
    return arguments
  }
}