import 'package:grocerygo/utility/export.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.43,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: placeHolder.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(31, 194, 193, 193),
          highlightColor: const Color.fromARGB(115, 201, 200, 200),
          direction: ShimmerDirection.ltr,
          period: const Duration(seconds: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: context.screenWidth * 0.36,
                  height: context.screenHeight * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  )),
              20.heightBox,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: context.screenWidth * 0.32,
                      height: context.screenHeight * 0.012,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      )),
                  10.heightBox,
                  Container(
                      width: context.screenWidth * 0.28,
                      height: context.screenHeight * 0.012,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      )),
                  10.heightBox,
                  Container(
                      width: context.screenWidth * 0.20,
                      height: context.screenHeight * 0.012,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      )),
                  const Spacer(),
                  Container(
                      width: context.screenWidth * 0.22,
                      height: context.screenHeight * 0.015,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
