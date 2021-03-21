import 'package:flutter/foundation.dart';

class AddPhoneNumberTextField extends ChangeNotifier {
  List<String> phoneNumberTextFields = [''];
  List<String> phoneNumbers = [];
  addTextField(String phoneNumber) async {
    phoneNumberTextFields.add(phoneNumber);
    notifyListeners();
  }
}

class AddAddressTextField extends ChangeNotifier {
  List<String> addressTextFields = [''];
  List<String> addresses = [];
  addTextField(String address) async {
    addressTextFields.add(address);
    notifyListeners();
  }
}