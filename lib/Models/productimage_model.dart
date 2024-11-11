class ProductImageModel {
  String? message;
  int? status;
  List<ProductImageData>? data;

  ProductImageModel({this.message, this.status, this.data});

  ProductImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductImageData>[];
      json['data'].forEach((v) {
        data!.add(ProductImageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImageData {
  int? id;
  String? productId;
  String? file;
  String? createdAt;
  String? updatedAt;

  ProductImageData(
      {this.id, this.productId, this.file, this.createdAt, this.updatedAt});

  ProductImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
