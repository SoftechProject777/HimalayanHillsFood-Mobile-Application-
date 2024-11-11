class OrderModel {
  String? message;
  int? status;
  List<Data>? data;

  OrderModel({this.message, this.status, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? subAmount;
  int? vatAmount;
  int? deliveryCharge;
  int? totalAmount;
  Null? paymentMethod;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.cartId,
      this.userId,
      this.subAmount,
      this.vatAmount,
      this.deliveryCharge,
      this.totalAmount,
      this.paymentMethod,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    subAmount = json['sub_amount'];
    vatAmount = json['vat_amount'];
    deliveryCharge = json['delivery_charge'];
    totalAmount = json['total_amount'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['sub_amount'] = this.subAmount;
    data['vat_amount'] = this.vatAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['total_amount'] = this.totalAmount;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
