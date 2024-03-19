import 'package:grocerygo/model/review_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:intl/intl.dart';

class ReviewCell extends StatelessWidget {
  final ReviewModel reviewModel;
  final bool isMain;
  const ReviewCell({super.key, required this.reviewModel, required this.isMain});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(reviewModel.rCreatedDate!);
    // 'dd/MM/yyyy HH:mm'
    String formattedDateTime =
        DateFormat('dd/MM/yyyy HH:mm').format(parsedDate);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 246, 246, 246)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
          Row(
            children: [
              // Ảnh
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getRandomColor().withOpacity(0.5)),
                child: "${reviewModel.userName}"
                    .substring(0, 1)
                    .text
                    .white
                    .size(14)
                    .fontFamily(gilroyBold)
                    .make(),
              ),
              10.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AutoSizeText(
                        (reviewModel.userName ?? ""),
                        style: const TextStyle(
                            fontSize: 16,
                            color: primaryText,
                            fontFamily: gilroyMedium),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      5.widthBox,
                      isMain == true ? IgnorePointer(
                        ignoring: true,
                        child: RatingBar.builder(
                          initialRating: double.parse(reviewModel.rRate!),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xffF3603F),
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                  5.heightBox,
                  formattedDateTime.text
                      .size(14)
                      .color(secondaryText)
                      .fontFamily(gilroyMedium)
                      .make()
                ],
              )
            ],
          ),
          // Đánh giá chất lượng
          double.parse(reviewModel.rRate!) >= 4.5
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 227, 88, 88),
                        width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      icReview,
                      color: const Color.fromARGB(255, 227, 88, 88),
                      width: 15,
                    ),
                    5.widthBox,
                    "Đánh giá chất lượng"
                        .text
                        .size(14)
                        .fontFamily(gilroyMedium)
                        .color(const Color.fromARGB(255, 227, 88, 88))
                        .make()
                  ]),
                )
              : const SizedBox.shrink(),
          reviewModel.rMessage != ''
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    (reviewModel.rMessage ?? ""),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 14,
                        color: secondaryText,
                        fontFamily: gilroyMedium,
                        height: 1.5),
                  ),
                )
              : const SizedBox.shrink(),
          10.heightBox,
          const Divider(
            color: Colors.black26,
            height: 1,
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    icLike,
                    color: primaryText,
                    width: 20,
                  ),
                  5.widthBox,
                  "${reviewModel.rLike} Thích"
                      .text
                      .size(14)
                      .color(primaryText)
                      .fontFamily(gilroyMedium)
                      .make(),
                ],
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                  icComent,
                  color: primaryText,
                  width: 20,
                ),
                5.widthBox,
                (isMain == true ? "${reviewModel.reviewIdCount} Nhận xét" : "Trả lời")
                    .text
                    .size(14)
                    .color(primaryText)
                    .fontFamily(gilroyMedium)
                    .make(),
              ])
            ],
          ),
          10.heightBox
        ],
      ),
    );
  }
}
