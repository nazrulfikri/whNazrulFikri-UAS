class ChatDetail {
  final String role;
  final String message;

  ChatDetail({required this.role, required this.message});

  factory ChatDetail.fromJson(Map<String, dynamic> json) {
    return ChatDetail(
      role: json['role'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'message': message,
    };
  }
}

class DosenModel {
  final int id;
  final String name;
  final String img;
  List<ChatDetail> details;

  DosenModel({
    required this.id,
    required this.name,
    required this.img,
    required this.details,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    var detailList = json['details'] as List;
    List<ChatDetail> chatList = detailList.map((e) => ChatDetail.fromJson(e)).toList();

    return DosenModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      details: chatList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'details': details.map((e) => e.toJson()).toList(),
      };

  DosenModel copyWith({List<ChatDetail>? details}) {
    return DosenModel(
      id: id,
      name: name,
      img: img,
      details: details ?? this.details,
    );
  }
}

