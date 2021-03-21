import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winsoft_auth_test_app/logic/multiple_text_fields.dart';
import 'package:winsoft_auth_test_app/models/user.dart';
import 'package:winsoft_auth_test_app/pages/widgets/custom_text_field_widget.dart';

class PhoneNumberListTextFields extends StatefulWidget {
  final User user;
  PhoneNumberListTextFields(this.user);
  @override
  _PhoneNumberListTextFieldsState createState() => _PhoneNumberListTextFieldsState();
}

class _PhoneNumberListTextFieldsState extends State<PhoneNumberListTextFields> {
  final int _fieldsLimit = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<AddPhoneNumberTextField>(
            builder: (context, tf, _) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tf.phoneNumberTextFields.length + 1,
                itemBuilder: (context, index) {
                  if (index == tf.phoneNumberTextFields.length) {
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
                        child: Text('+ Add another phone number', style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          if (tf.phoneNumberTextFields.length < _fieldsLimit) {
                            await tf.addTextField('');
                          }
                        },
                      ),
                    );
                  }
                  return Column(
                    children: [
                      CustomTextFieldWidget(
                        hintText: 'Phone number',
                        suffixIcon: Icons.phone_outlined,
                        validateMessage: 'Please enter your phone number',
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          widget.user.phoneNumbers.add(value);
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
