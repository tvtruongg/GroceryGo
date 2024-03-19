class ProductDetailsModel {
  int? productId;
  String? pName;
  String? pDetail;
  String? pUnitName;
  String? pUnitValue;
  int? pPrice;
  String? pManufacturingDate;
  String? pExpiryDate;
  String? pModifyDate;
  int? sSold;
  int? isRemaining;
  int? nType;
  String? nGlucid;
  String? nFiber;
  String? nLipid;
  String? nProtid;
  String? nCalo;
  String? nSum;
  String? bName;
  String? caName;
  int? isOfferActive;
  int? ofPrice;
  String? rRate;
  int? rCount;
  int? isFavorite;
  List<ImageList>? imageList;

  ProductDetailsModel(
      {this.productId,
      this.pName,
      this.pDetail,
      this.pUnitName,
      this.pUnitValue,
      this.pPrice,
      this.pManufacturingDate,
      this.pExpiryDate,
      this.pModifyDate,
      this.sSold,
      this.isRemaining,
      this.nType,
      this.nGlucid,
      this.nFiber,
      this.nLipid,
      this.nProtid,
      this.nCalo,
      this.nSum,
      this.bName,
      this.caName,
      this.isOfferActive,
      this.ofPrice,
      this.rRate,
      this.rCount,
      this.isFavorite,
      this.imageList});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    pName = json['p_name'];
    pDetail = json['p_detail'];
    pUnitName = json['p_unit_name'];
    pUnitValue = json['p_unit_value'];
    pPrice = json['p_price'];
    pManufacturingDate = json['p_manufacturing_date'];
    pExpiryDate = json['p_expiry_date'];
    pModifyDate = json['p_modify_date'];
    sSold = json['s_sold'];
    isRemaining = json['is_remaining'];
    nType = json['n_type'];
    nGlucid = json['n_glucid'];
    nFiber = json['n_fiber'];
    nLipid = json['n_lipid'];
    nProtid = json['n_protid'];
    nCalo = json['n_calo'];
    nSum = json['n_sum'];
    bName = json['b_name'];
    caName = json['ca_name'];
    isOfferActive = json['is_offer_active'];
    ofPrice = json['of_price'];
    rRate = json['r_rate'];
    rCount = json['r_count'];
    isFavorite = json['is_favorite'];
    if (json['image_list'] != null) {
      imageList = <ImageList>[];
      json['image_list'].forEach((v) {
        imageList!.add(ImageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = productId;
    data['p_name'] = pName;
    data['p_detail'] = pDetail;
    data['p_unit_name'] = pUnitName;
    data['p_unit_value'] = pUnitValue;
    data['p_price'] = pPrice;
    data['p_manufacturing_date'] = pManufacturingDate;
    data['p_expiry_date'] = pExpiryDate;
    data['p_modify_date'] = pModifyDate;
    data['s_sold'] = sSold;
    data['is_remaining'] = isRemaining;
    data['n_type'] = nType;
    data['n_glucid'] = nGlucid;
    data['n_fiber'] = nFiber;
    data['n_lipid'] = nLipid;
    data['n_protid'] = nProtid;
    data['n_calo'] = nCalo;
    data['n_sum'] = nSum;
    data['b_name'] = bName;
    data['ca_name'] = caName;
    data['is_offer_active'] = isOfferActive;
    data['of_price'] = ofPrice;
    data['r_rate'] = rRate;
    data['r_count'] = rCount;
    data['is_favorite'] = isFavorite;
    if (imageList != null) {
      data['image_list'] = imageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageList {
  String? iImage;

  ImageList({this.iImage});

  ImageList.fromJson(Map<String, dynamic> json) {
    iImage = json['i_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['i_image'] = iImage;
    return data;
  }
}