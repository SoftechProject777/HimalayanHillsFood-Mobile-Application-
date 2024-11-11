class ReviewModel {
  // String? message;
  // int? status;
  List<ReviewData>? data;

  ReviewModel({
    // this.message, 
    // this.status, 
    this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <ReviewData>[];
      json['data'].forEach((v) {
        data!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['message'] = this.message;
    // data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewData {
  int? id;
  int? userId;
  int? productId;
  int? rate;
  String? review;
  String? status;
  String? createdAt;
  String? updatedAt;

  ReviewData(
      {this.id,
      this.userId,
      this.productId,
      this.rate,
      this.review,
      this.status,
      this.createdAt,
      this.updatedAt});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    rate = json['rate'];
    review = json['review'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['rate'] = rate;
    data['review'] = review;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


