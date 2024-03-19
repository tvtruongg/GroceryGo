import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class ExploreViewModel extends GetxController {

  //ServiceCall
  Future<List<CategoryModel>> serviceCallList() async {
    List<CategoryModel> data = [];
    await ServiceCall.post({}, SVKey.svExploreList, isToken: true,
        withSuccess: (resObj) async {
      if (resObj[KKey.status] == "1") {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return CategoryModel.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
