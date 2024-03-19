import 'package:grocerygo/common/bottomappbar_item.dart';
import 'package:grocerygo/common/custom_searchbar.dart';
import 'package:grocerygo/common/exit_dialog.dart';
import 'package:grocerygo/view/cart/cart_main.dart';
import 'package:grocerygo/view/explore/explore_view.dart';
import 'package:grocerygo/view/profile/profile_details.dart';
import 'package:grocerygo/view/profile/profile_view.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/controllers/home_controller.dart';
import 'package:grocerygo/view/home/home_view.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        showDialog(context: context, builder: (context) => const ExitDialog());
      },
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor:
                  const Color.fromARGB(255, 209, 209, 209).withOpacity(0.2),
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              elevation: 0,
              title: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.7), // Màu nền của ô tròn
                    ),
                    child: Image.asset(
                      icLogoColor,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  10.widthBox,
                  appname.text
                      .size(22)
                      .fontFamily(gilroyBold)
                      .color(primary)
                      .make()
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    icon: Image.asset(
                      icSearch,
                      width: 20,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      icNotifecations,
                      width: 20,
                      color: Colors.black,
                    ))
              ],
              bottom: null,
            ),
          ],
          body: PageView(
            controller: controller.pageController,
            onPageChanged: controller.animateToTab,
            physics: const BouncingScrollPhysics(),
            children: const [
              HomeView(),
              ExploreView(),
              CartMain(),
              ProfileDetails(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          notchMargin: 10,
          elevation: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomAppbarItem(title: home, icon: icHome, page: 0),
                  bottomAppbarItem(title: search, icon: icSearch, page: 1),
                  bottomAppbarItem(title: cart, icon: icCart, page: 2),
                  bottomAppbarItem(title: wishlist, icon: icWishlist, page: 3),
                  bottomAppbarItem(title: profile, icon: icProfile, page: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CircleAvatar(
  //   radius: 18,
  //   backgroundColor: Colors.blue, // Màu nền của ô tròn
  //   backgroundImage: Image.asset(
  //     icLogoColor,
  //     width: 10,
  //     fit: BoxFit.cover,
  //   ).image,
  // ),
  // Scaffold(
  //       body: PageView(
  //         controller: controller.pageController,
  //         onPageChanged: controller.animateToTab,
  //         physics: const BouncingScrollPhysics(),
  //         children: [
  //           const HomeView(),
  //           Container(),
  //           Container(),
  //           Container(),
  //           const ProfileView(),
  //         ],
  //       ),
  //       bottomNavigationBar: BottomAppBar(
  //         color: Colors.transparent,
  //         notchMargin: 10,
  //         elevation: 0,
  //         child: Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black26, blurRadius: 3, offset: Offset(0, -2))
  //             ],
  //           ),
  //           padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
  //           child: Obx(
  //             () => Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 bottomAppbarItem(title: home, icon: icHome, page: 0),
  //                 bottomAppbarItem(title: search, icon: icSearch, page: 1),
  //                 bottomAppbarItem(title: cart, icon: icCart, page: 2),
  //                 bottomAppbarItem(title: wishlist, icon: icWishlist, page: 3),
  //                 bottomAppbarItem(title: profile, icon: icProfile, page: 4),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
}
