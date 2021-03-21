import 'package:flutter/material.dart';
import 'package:winsoft_auth_test_app/models/user.dart';
import 'package:winsoft_auth_test_app/pages/widgets/address_list_text_fields.dart';
import 'package:winsoft_auth_test_app/pages/widgets/image_picker_btn.dart';
import 'package:winsoft_auth_test_app/pages/widgets/phone_number_list_fields.dart';
import 'package:winsoft_auth_test_app/pages/widgets/show_message.dart';
import 'package:winsoft_auth_test_app/routes/routes.dart';
import 'package:winsoft_auth_test_app/services/DB/db_service.dart';

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final User _user = User();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool _rememberMe = false;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person_outlined),
              hintText: 'Enter your first name',
              labelText: 'first name',
            ),
            autocorrect: false,
            validator: (v) => v.isEmpty ? 'Please enter your first name' : null,
            onSaved: (v) {
              _user.firstName = v;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person_outlined),
              hintText: 'Enter your last name',
              labelText: 'last name',
            ),
            autocorrect: false,
            validator: (v) => v.isEmpty ? 'Please enter your last name' : null,
            onSaved: (v) {
              _user.lastName = v;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email_outlined),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            autocorrect: false,
            validator: (v) => v.isEmpty ? 'Please enter your email' : null,
            onSaved: (v) {
              _user.email = v;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock_outline),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            autocorrect: false,
            obscureText: true,
            validator: (v) => v.isEmpty ? 'Please enter your password' : null,
            onSaved: (v) {
              _user.password = v;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          PhoneNumberListTextFields(this._user),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          AddressListTextFields(this._user),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 10,top: 20,
            bottom: 20,
            left: 30,),
            labelText: 'Gender',
            ),
        dropdownColor: Colors.white,
        elevation: 2,
        value: _user.gender,
        validator: (v) => v.isEmpty ? 'Please enter choose your gender' : null,
        onChanged: (v) {
          setState(() {
            _user.gender = v;
          });
        },
        items: User.genders
            .map((v) => DropdownMenuItem(
                  child: Text(v),
                  value: v,
                ),)
            .toList(),
      ),
      SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
      ),
      GestureDetector(
        onTap: () => selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _dateController,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
              hintText: 'Date of birth',
              labelText: 'DOB',
            ),
            validator: (value) =>
                value.isEmpty ? 'Please choose your birth of date' : null,
            onSaved: (value) => {_user.dateOfBirth = selectedDate},
          ),
        ),
      ),
      SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
      ),
      ImagePickerButton(this._user),
      SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey),
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (v) {
                        setState(() {
                          _rememberMe = v;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () async {
              validateAndSubmit();
            },
            child: Text(
              'Continue',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Color(0xFFFF9442)),
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 64)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        if (await DBService.db.checkUserExists(_user.email)) {
          print('User already exists');
          Navigator.of(context).pop();
          ShowMessages.instance.showMessage(context, 'User already exists');
        } else {
          await DBService.db.addUser(_user);
          Navigator.of(context).popAndPushNamed(RoutesNames.home, arguments: _user);
        }
      } catch (e) {
        print(e.toString());
        Navigator.of(context).pop();
        ShowMessages.instance.showMessage(context, 'Error');
        // showMessage(e.toString());
      }
    } 
  }
}