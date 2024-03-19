import 'package:grocerygo/utility/export.dart';

class ExploreShimmer extends StatelessWidget {
  const ExploreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: placeHolder.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(31, 194, 193, 193),
        highlightColor: const Color.fromARGB(115, 201, 200, 200),
        direction: ShimmerDirection.ltr,
        period: const Duration(seconds: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Container(
                    width: context.screenWidth * 0.32,
                    height: context.screenHeight * 0.01,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    )))
          ],
        ),
      ),
    );
  }
}
