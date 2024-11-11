class CategoryModel {
  // String? message;
  // int? status;
  List<CategoryData> data=[];

  CategoryModel({required this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['message'] = this.message;
    // data['status'] = this.status;
    data['data'] = this.data.map((v) => v.toJson()).toList();
      return data;
  }
}

class CategoryData {
  int? id;
  String? title;
  String? slug;
  String? summary;
  String? image;
  int? status;
  int? addedBy;
  String? createdAt;
  String? updatedAt;

  CategoryData(
      {this.id,
      this.title,
      this.slug,
      this.summary,
      this.image,
      this.status,
      this.addedBy,
      this.createdAt,
      this.updatedAt});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    summary = json['summary'];
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
    data['slug'] = slug;
    data['summary'] = summary;
    data['image'] = image;
    data['status'] = status;
    data['added_by'] = addedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
