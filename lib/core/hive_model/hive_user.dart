/* class HiveUser {
  final String? cognitoID;
  final String? id;
  final String? token;
  final String? phone;
  final String? fullName;
  HiveUser({this.cognitoID, this.id, this.token, this.phone, this.fullName});

  factory HiveUser.fromJson(Map<String, dynamic> json) => HiveUser(
    cognitoID: json["cognitoID"] as String?,
    id: json["id"] as String?,
    token: json["token"] as String?,
    phone: json["phone"] as String?,
    fullName: json["fullName"] as String?,
  );
  Map<String, dynamic> toJson() => {
    "cognitoID": cognitoID,
    "id": id,
    "token": token,
    "phone": phone,
    "fullName": fullName,
  };
} */
