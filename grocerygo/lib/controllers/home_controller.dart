import 'package:grocerygo/utility/export.dart';

class HomeController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}