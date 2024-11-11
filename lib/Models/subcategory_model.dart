import 'package:flutter/src/material/tabs.dart';

class SubcategoryModel {
  // String? message;
  // int? status;
  List<Data>? data;

  SubcategoryModel({this.data});

  SubcategoryModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

  map(Tab Function(dynamic subcategory) param0) {}
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? summary;
  String? image;
  int? status;
  int? addedBy;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.summary,
      this.image,
      this.status,
      this.addedBy,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    summary = json['summary'];
    image = json['image'];
    status = json['status'];
    addedBy = json['added_by'];
    categoryId = json['category_id'];
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
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
