import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/controllers/home_controller.dart';

Widget bottomAppbarItem(
    {required String title, required String icon, required int page}) {
  var controllor = Get.find<HomeController>();
  return ZoomTapAnimation(
    onTap: () => controllor.goToTab(page),
    child: Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 25,
            height: 25,
            color:
                controllor.currentPage.value == page ? primary : Colors.black,
          ),
          5.heightBox,
          Text(
            title,
            style: TextStyle(
                color: controllor.currentPage.value == page
                    ? primary
                    : Colors.black,
                fontFamily: gilroyBold,
                fontSize: 10.5),
          )
        ],
      ),
    ),
  );
}
