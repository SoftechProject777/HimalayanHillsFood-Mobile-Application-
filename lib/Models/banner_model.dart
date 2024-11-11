class BannerModel {
  // String? message;
  // int? status;
  List<Data>? data;

  BannerModel({this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
      // print(json['data']);
      // print(data);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['message'] = this.message;
    // data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? link;
  String? image;
  int? status;
  int? addedBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.link,
      this.image,
      this.status,
      this.addedBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    image = json['image'];
    status = json['status'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['image'] = this.image;
    data['status'] = this.status;
    data['added_by'] = this.addedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class Banner {
//   final int? id;
//   final String? title;
//   final String? link;
//   final String? image;
//   final int? status;
//   final int? addedBy;
//   final String? createdAt;
//   final String? updatedAt;

//   Banner({required this.id, required this.title, required this.link, required this.image, required this.status, required this.addedBy, required this.createdAt, required this.updatedAt,});
//   return
// }
