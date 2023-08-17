class DailyAdsModel {
  int? id;
  String? name;
  String? description;
  String? video;

  DailyAdsModel({this.id, this.name, this.description, this.video});

  DailyAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['video'] = this.video;
    return data;
  }
}
