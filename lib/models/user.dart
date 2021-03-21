import 'package:flutter/foundation.dart';

class User {
  static const List<String> genders = ['Male', 'Female'];

  @required
  int id;
  @required
  String firstName;
  @required
  String lastName;
  @required
  String email;
  @required
  String password;
  @required
  List<String> phoneNumbers = [];
  @required
  List<String> address = [];
  @required
  String gender;
  @required
  DateTime dateOfBirth;
  @required
  String pictureUrl;

  User();

  Map<String, Object> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'date_of_birth': dateOfBirth.toString(),
      'picture_url': pictureUrl,
    };
  }

  User.fromMap(Map<String, Object> map, phones, address) {
    id = map['id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    email = map['email'];
    password = map['password'];
    phoneNumbers = phones;
    address = address;
    gender = map['gender'];
    dateOfBirth = DateTime.parse(map['date_of_birth']);
    pictureUrl = map['picture_url'];
  }

  @override
  String toString() {
    return 'User{id: $id, first_name: $firstName, last_name: $lastName, email: $email, password: $password, gender: $gender, date_of_birth: $dateOfBirth, picture_url: $pictureUrl}';
  }
}