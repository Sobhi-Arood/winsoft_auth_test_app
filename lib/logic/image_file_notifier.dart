import 'dart:io';
import 'package:flutter/foundation.dart';

class AddImageNotifier extends ChangeNotifier {
  List<File> images = [];
  addImage(File img) async {
    images.add(img);
    notifyListeners();
  }
}