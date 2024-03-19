import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/utility/lists.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final splashVM = Get.find<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(children: [
                  20.heightBox,
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset(
                          icProfileFemale,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      15.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              "Trần Văn Trường"
                                  .text
                                  .size(20)
                                  .fontFamily(gilroyBold)
                                  .color(primaryText)
                                  .make(),
                              10.widthBox,
                              const Icon(
                                Icons.edit,
                                color: primary,
                                size: 18,
                              )
                            ],
                          ),
                          2.heightBox,
                          "trantruong2002@gmail.com"
                              .text
                              .size(16)
                              .fontFamily(gilroyMedium)
                              .color(secondaryText)
                              .make(),
                        ],
                      ))
                    ],
                  ),
                  20.heightBox,
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: textListProfile.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.black26,
                        thickness: 1,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.asset(
                          iconListProfile[index],
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                        title: textListProfile[index]
                            .text
                            .size(18)
                            .fontFamily(gilroyBold)
                            .color(primaryText)
                            .make(),
                        trailing: Image.asset(
                          icRightArrow,
                          width: 10,
                          color: primaryText,
                          fit: BoxFit.cover,
                        ),
                        selectedTileColor: redColor,
                        // onTap: () {
                        //   switch (index) {
                        //     // case 0:
                        //     //   Get.to(() => const WishlistScreen());
                        //     //   break;
                        //     // case 1:
                        //     //   Get.to(() => const OrderScreen());
                        //     //   break;
                        //     // case 2:
                        //     //   Get.to(() => const MessageScreen());
                        //     //   break;
                        //   }
                        // },
                      );
                    },
                  ),
                  5.heightBox,
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                ]),
              ),
            ),
          ),
          10.heightBox,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomButton(
                    width: context.screenWidth,
                    height: 60,
                    color: const Color(0xffF2F3F2),
                    title: "Đăng Xuất",
                    textColor: primary,
                    radius: 20,
                    size: 20,
                    onPress: () {
                      splashVM.logout();
                    },
                    icon: icLogout,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
