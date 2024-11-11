class OrderDetailModel {
  String? message;
  int? status;
  List<Data>? data;

  OrderDetailModel({this.message, this.status, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? cartId;
  int? productId;
  int? userId;
  int? quantity;
  int? price;
  int? afterDiscount;
  int? totalAmount;
  int? deliveryCharge;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.cartId,
      this.productId,
      this.userId,
      this.quantity,
      this.price,
      this.afterDiscount,
      this.totalAmount,
      this.deliveryCharge,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    price = json['price'];
    afterDiscount = json['after_discount'];
    totalAmount = json['total_amount'];
    deliveryCharge = json['delivery_charge'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['after_discount'] = this.afterDiscount;
    data['total_amount'] = this.totalAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
