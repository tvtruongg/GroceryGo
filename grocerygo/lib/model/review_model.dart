class ReviewModel {
  int? reviewId;
  String? userName;
  String? inImage;
  String? rRate;
  String? rMessage;
  int? rLike;
  int? reviewIdCount;
  String? rCreatedDate;

  ReviewModel(
      {this.reviewId,
      this.userName,
      this.inImage,
      this.rRate,
      this.rMessage,
      this.rLike,
      this.reviewIdCount,
      this.rCreatedDate});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userName = json['user_name'];
    inImage = json['in_image'];
    rRate = json['r_rate'];
    rMessage = json['r_message'];
    rLike = json['r_like'];
    reviewIdCount = json['review_id_count'];
    rCreatedDate = json['r_created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['review_id'] = reviewId;
    data['user_name'] = userName;
    data['in_image'] = inImage;
    data['r_rate'] = rRate;
    data['r_message'] = rMessage;
    data['r_like'] = rLike;
    data['review_id_count'] = reviewIdCount;
    data['r_created_date'] = rCreatedDate;
    return data;
  }
}
