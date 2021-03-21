import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:winsoft_auth_test_app/logic/image_file_notifier.dart';
import 'package:winsoft_auth_test_app/models/user.dart';

class ImagePickerButton extends StatefulWidget {
  final User user;
  ImagePickerButton(this.user);
  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await Provider.of<AddImageNotifier>(context, listen: false).addImage(File(pickedFile.path));
      setState(() {
        _image = File(pickedFile.path);
        widget.user.pictureUrl = _image.uri.path;
    });
    } else {
        print('No image selected.');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _image == null
          ? ElevatedButton(style: ButtonStyle(
            elevation: MaterialStateProperty.all(0)
          ), child: Text('Select an image'), onPressed: () => getImage(),)
          : Image.file(_image),
    );
  }
}