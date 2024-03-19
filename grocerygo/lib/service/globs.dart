import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import '../main.dart';

class Globs {
  // Các key lưu trữ bộ nhớ cục bộ
  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ..."}) async {
    // tạo khoảng thời gian ngắn trước khi hiển thị chỉ báo tải
    await Future.delayed(const Duration(milliseconds: 1));
    // Hiển thị chỉ báo tải
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  // Lưu trữ dữ liệu bất kỳ (dynamic) vào bộ nhớ cục bộ với khóa (key) đã cho.
  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  // lưu chữ chuỗi
  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  // lưu chữ boolean
  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  // lưu chữ số nguyên
  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  // lưu số thực
  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  // Truy xuất dữ liệu đã lưu theo khóa (key) và giải mã từ JSON thành kiểu dữ liệu ban đầu.
  static dynamic udValue(String key) {
    return json.decode(prefs?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs?.get(key) as String? ?? "";
  }

  static bool udValueBool(String key) {
    return prefs?.get(key) as bool? ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs?.get(key) as bool? ?? true;
  }

  static int udValueInt(String key) {
    return prefs?.get(key) as int? ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs?.get(key) as double? ?? 0.0;
  }

  // Xóa dữ liệu đã lưu theo khóa (key) khỏi bộ nhớ cục bộ.
  static void udRemove(String key) {
    prefs?.remove(key);
  }

  // Lấy múi giờ hiện tại của thiết bị
  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } on PlatformException {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://192.168.1.89:2002";
  // static const mainUrl = "http://10.40.16.169:2002";
  static const baseUrl = '$mainUrl/api/grocerygo/';
  static const nodeUrl = mainUrl;

  static const svLogin = '${baseUrl}login';
  static const svSignUp = '${baseUrl}signup';
  static const svHome = '${baseUrl}home';
  static const svProductDetail = '${baseUrl}product/detail';
  static const svReviewDetail = '${baseUrl}commnet';
  static const svAddRemoveFavorite = '${baseUrl}add_remove_favorite';
  static const svFavorite = '${baseUrl}favorite_list';
  static const svExploreList = '${baseUrl}explore/list';
  static const svExploreItemList = '${baseUrl}explore/product/list';

  static const svAllExclusiveOffer = '${baseUrl}home/all/exclusive/offer';
  static const svAllBestSelling = '${baseUrl}home/all/best/selling';
  static const svAllFavoriteProduct = '${baseUrl}home/all/favorite/product';
  static const svAllCategory = '${baseUrl}home/all/category';
  static const svAllProductNew = '${baseUrl}home/all/product/new';

  static const svAddToCart = '${baseUrl}add_to_cart';
  static const svUpdateCart = '${baseUrl}update_cart';
  static const svRemoveCart = '${baseUrl}remove_cart';
  static const svCartList = '${baseUrl}cart_list';
  static const svOrderPlace = '${baseUrl}order_place';

  static const svAddDeliveryAddress = '${baseUrl}add_delivery_address';
  static const svUpdateDeliveryAddress = '${baseUrl}update_delivery_address';
  static const svDeleteDeliveryAddress = '${baseUrl}delete_delivery_address';
  static const svDeliveryAddress = '${baseUrl}delivery_address';

  static const svAddPaymentMethod = '${baseUrl}add_payment_method';
  static const svRemovePaymentMethod = '${baseUrl}remove_payment_method';
  static const svPaymentMethodList = '${baseUrl}payment_method';

  static const svMarkDefaultDeliveryAddress =
      '${baseUrl}mark_default_delivery_address';

  static const svPromoCodeList = '${baseUrl}promo_code_list';
  static const svMyOrders = '${baseUrl}my_order';
  static const svMyOrdersDetail = '${baseUrl}my_order_detail';

  static const svNotificationList = '${baseUrl}notification_list';
  static const svNotificationReadAll = '${baseUrl}notification_read_all';

  static const svUpdateProfile = '${baseUrl}update_profile';
  static const svChangePassword = '${baseUrl}change_password';
  static const svForgotPasswordRequest = '${baseUrl}forgot_password_request';
  static const svForgotPasswordVerify = '${baseUrl}forgot_password_verify';
  static const svForgotPasswordSetPassword =
      '${baseUrl}forgot_password_set_password';
}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
  static const authToken = "auth_token";
  static const name = "name";
  static const email = "email";
  static const mobile = "mobile";
  static const address = "address";
  static const userId = "user_id";
  static const resetCode = "reset_code";
}

class MSG {
  static const enterEmail = "Please enter your valid email address.";
  static const enterName = "Please enter your name.";
  static const enterCode = "Please enter valid reset code.";

  static const enterMobile = "Please enter your valid mobile number.";
  static const enterAddress = "Please enter your address.";
  static const enterPassword =
      "Please enter password minimum 6 characters at least.";
  static const enterPasswordNotMatch = "Please enter password not match.";
  static const success = "success";
  static const fail = "fail";
}
