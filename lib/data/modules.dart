class LoginInfo {
  String userName;
  String password;
  LoginInfo({required this.userName, required this.password});
}

class RegisterInfo {
  String fullName;
  String username;
  String email;
  String password;
  RegisterInfo(
      {required this.fullName,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

class UserInfo {
  String profilePic;
  String fullName;
  String phoneNumber;
  String email;
  String password;
  String about;
  UserInfo(
      {required this.profilePic,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.password,
      required this.about});
}

class NewInfo {
  String title;
  String description;
  String imageAddress;
  NewInfo(
      {required this.title,
      required this.description,
      required this.imageAddress});
  static NewInfo formJson(Map<dynamic, dynamic> json) {
    return NewInfo(
        title: json['title'],
        description: json['description'],
        imageAddress: json['image']);
  }
}

class NewWordInfo {
  String id;
  String word;
  String meaning;
  String? describe;
  bool favourite;
  String type;

  NewWordInfo(
      {required this.id,
      required this.word,
      required this.meaning,
      required this.favourite,
      required this.type,
      this.describe});

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'describe': describe,
      'favourite': favourite,
      'type': type
    };
  }

  Map<String, dynamic> toJsonWithUsername(String username) {
    return {
      'username': username,
      'word': word,
      'meaning': meaning,
      'describe': describe,
      'favourite': favourite,
      'type': type
    };
  }

  static NewWordInfo fromJson(Map<String, dynamic> json) {
    return NewWordInfo(
        id: json['_id'],
        word: json['word'],
        meaning: json['meaning'],
        favourite: json['favourite'],
        type: json['type'],
        describe: json['describe']);
  }
}

class WordModel {
  int id;
  String word;
  String definition;
  String type;
  String example;
  WordModel(
      {required this.id,
      required this.word,
      required this.definition,
      required this.type,
      required this.example});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'type': type,
      'definition': definition,
    };
  }

  WordModel formJson(Map<dynamic, dynamic> json) {
    return WordModel(
        id: json['id'],
        word: json['word'],
        definition: json['definition'],
        type: json['type'],
        example: json['example']);
  }
}
