class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? imageString;
  UserModel(
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.imageString,
  );
  factory UserModel.fromJSON(Map<String, dynamic> map) => UserModel(
        map['uid'],
        map['email'],
        map['firstName'],
        map['lastName'],
        map['imageString'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'imageString': imageString
      };
}
