class UserModel {
  String id;
  String googleToken;
  String emailToken;
  String userName;
  String userEmail;
  String role;
  String imageUrl;
  DateTime createDate;

  UserModel({
    this.id,
    this.googleToken,
    this.emailToken,
    this.userName,
    this.userEmail,
    this.role,
    this.imageUrl,
    this.createDate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleToken = json['googleToken'];
    emailToken = json['emailToken'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    role = json['role'];
    imageUrl = json['imageUrl'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['googleToken'] = this.googleToken;
    data['emailToken'] = this.emailToken;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['role'] = this.role;
    data['createDate'] = this.createDate;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
