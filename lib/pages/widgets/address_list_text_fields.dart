import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winsoft_auth_test_app/logic/multiple_text_fields.dart';
import 'package:winsoft_auth_test_app/models/user.dart';

import 'custom_text_field_widget.dart';

class AddressListTextFields extends StatefulWidget {
  final User user;
  AddressListTextFields(this.user);
  @override
  _AddressListTextFieldsState createState() => _AddressListTextFieldsState();
}

class _AddressListTextFieldsState extends State<AddressListTextFields> {
  final int _fieldsLimit = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<AddAddressTextField>(
            builder: (context, tf, _) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tf.addressTextFields.length + 1,
                itemBuilder: (context, index) {
                  if (index == tf.addressTextFields.length) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
borderRadius: BorderRadius.circular(32)
                          ),)
                        ),
                        child: Text('+ Add another address', style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          if (tf.addressTextFields.length < _fieldsLimit) {
                            await tf.addTextField('');
                          }
                        },
                      ),
                    );
                  }
                  return Column(
                    children: [
                      CustomTextFieldWidget(
                        hintText: 'address',
                        suffixIcon: Icons.location_on_outlined,
                        validateMessage: 'Please enter your address',
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          widget.user.address.add(value);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}