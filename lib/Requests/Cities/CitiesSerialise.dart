class CitiesSerialise {
  List<String> items;

  CitiesSerialise({this.items});

  CitiesSerialise.fromJson(Map<String, dynamic> json) {
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = this.items;
    return data;
  }
}
