class BrandModel {
  // String? message;
  // int? status;
  List<BrandData>? data;

  BrandModel({this.data});

  BrandModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(BrandData.fromJson(v));
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

class BrandData {
  int? id;
  String? title;
  String? image;
  int? status;
  int? addedBy;
  String? createdAt;
  String? updatedAt;

  BrandData(
      {this.id,
      this.title,
      this.image,
      this.status,
      this.addedBy,
      this.createdAt,
      this.updatedAt});

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['status'] = status;
    data['added_by'] = addedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
