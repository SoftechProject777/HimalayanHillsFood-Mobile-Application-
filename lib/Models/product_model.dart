class ProductModel {
  // String? message;
  // int? status;
  List<ProductData>? data;

  ProductModel({this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
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

class ProductData {
  int? id;
  String? uniqueId;
  late String title;
  String? slug;
  String? summary;
  String? description;
  late String price;
  late String? discount;
  late String qty;
  int? isFeatured;
  int? isStock;
  int? status;
  String? image;
  int? categoryId;
  int? subcategoryId;
  int? sellerId;
  int? brandId;
  int? unitId;
  int? addedBy;
  int? visitNo;

  ProductData({
    this.id,
    this.uniqueId,
    required this.title,
    this.slug,
    this.summary,
    this.description,
    required this.price,
    required this.discount,
    required this.qty,
    this.isFeatured,
    this.isStock,
    this.status,
    this.image,
    this.categoryId,
    this.subcategoryId,
    this.sellerId,
    this.brandId,
    this.unitId,
    this.addedBy,
    this.visitNo,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    title = json['title'];
    slug = json['slug'];
    summary = json['summary'];
    description = json['description'];
    price = json['price'].toString();
    discount = json['discount'].toString();
    qty = json['qty'].toString();
    isFeatured = json['is_featured'];
    isStock = json['is_stock'];
    status = json['status'];
    image = json['image'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    sellerId = json['seller_id'];
    brandId = json['brand_id'];
    unitId = json['unit_id'];
    addedBy = json['added_by'];
    visitNo = json['visit_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['title'] = title;
    data['slug'] = slug;
    data['summary'] = summary;
    data['description'] = description;
    data['price'] = price;
    data['discount'] = discount;
    data['qty'] = qty;
    data['is_featured'] = isFeatured;
    data['is_stock'] = isStock;
    data['status'] = status;
    data['image'] = image;

    data['category_id'] = categoryId;
    data['subcategory_id'] = subcategoryId;
    data['seller_id'] = sellerId;
    data['brand_id'] = brandId;
    data['unit_id'] = unitId;
    data['added_by'] = addedBy;
    data['visit_no'] = visitNo;
    return data;
  }
}
