import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';
import 'package:http/http.dart' as http;

// Định nghĩa kiểu hàm lấy Map<String, dynamic> (đối tượng JSON) làm đầu vào và trả về Future<void>.
// Nó được sử dụng để xử lý dữ liệu phản hồi thành công.
typedef ResSuccess = Future<void> Function(Map<String, dynamic>);

// Định nghĩa kiểu hàm lấy dynamic (bất kỳ thông báo lỗi nào) làm đầu vào và trả về Future<void>.
// Nó được sử dụng để xử lý lỗi.
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  // Gửi yêu cầu POST đến điểm cuối API được chỉ định với các tham số được cung cấp
  /*
    parameter: Bản đồ các tham số sẽ được gửi trong phần thân yêu cầu.
    path: Đường dẫn URL của điểm cuối API.
    isToken: Giá trị boolean cho biết có bao gồm mã thông báo truy cập trong tiêu đề yêu cầu hay không (tùy chọn).
    withSuccess: Hàm ResSuccess tùy chọn để xử lý các phản hồi thành công.
    failure: Hàm ResFailure tùy chọn để xử lý lỗi.
  */

  static Future<void> post(Map<String, String> parameter, String path,
      {bool isToken = false,
      ResSuccess? withSuccess,
      ResFailure? failure}) async {
    try {
      // Đặt tiêu đề mặc định với Content-Type
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

      if (isToken) {
        var token = Get.find<SplashViewModel>().userModel.value.uAccessToken;
        headers["access_token"] = token ?? "";
      }

      await http
          .post(Uri.parse(path), body: parameter, headers: headers)
          .then((value) {
        // Giải mã dữ liệu trả về
        if (kDebugMode) {
          print(value.body);
        }
        try {
          var jsonObj = json.decode(value.body) as Map<String, dynamic>? ?? {};
          if (withSuccess != null) withSuccess(jsonObj);
        } catch (err) {
          if (failure != null) failure(err.toString());
        }
        // Nếu yêu cầu post thất bại
      }).catchError((e) {
        if (failure != null) failure(e.toString());
      });
    } catch (err) {
      if (failure != null) failure(err.toString());
    }
  }
}
