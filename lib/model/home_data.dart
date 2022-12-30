import 'dart:convert';

class HomeData {
  String title;
  String body;
  HomeData({
    required this.title,
    required this.body,
  });

  HomeData copyWith({
    String? title,
    String? body,
  }) {
    return HomeData(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      title: json['title'],
      body: json['body'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory HomeData.fromJson(String source) => HomeData.fromMap(json.decode(source));

  @override
  String toString() => 'HomeData(title: $title, body: $body)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HomeData &&
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}
