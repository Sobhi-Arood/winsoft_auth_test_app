import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData suffixIcon;
  final String validateMessage;
  final Function(String value) onSave;
  final TextInputType keyboardType;

  const CustomTextFieldWidget(
      {this.hintText, this.suffixIcon, this.validateMessage, this.onSave, this.keyboardType});

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _textController,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(widget.suffixIcon),
            hintText: widget.hintText,),
        validator: (value) => value.isEmpty ? widget.validateMessage : null,
        onSaved: (value) => widget.onSave(value));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}