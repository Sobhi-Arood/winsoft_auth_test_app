import 'package:flutter/material.dart';
import 'package:winsoft_auth_test_app/pages/widgets/show_message.dart';
import 'package:winsoft_auth_test_app/routes/routes.dart';
import 'package:winsoft_auth_test_app/services/DB/db_service.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email_outlined),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            autocorrect: false,
            validator: (value) => value.isEmpty ? 'Please enter your email' : null,
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
            validator: (value) => value.isEmpty ? 'Please enter your password' : null,

          ),
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
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value;
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
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.grey,
                  ),
                ),
              )
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          builder: (context) => Center(child: CircularProgressIndicator()));
          try {

          var u = await DBService.db.getLogin(_emailController.value.text, _passwordController.value.text);
          if (u != null) {
            Navigator.of(context).popAndPushNamed(RoutesNames.home, arguments: u);
          } else {
            Navigator.of(context).pop();
            ShowMessages.instance.showMessage(context, 'Email or password is incorrect');
          }
          
      } catch (e) {
        print(e.toString());
        Navigator.of(context).pop();
        ShowMessages.instance.showMessage(context, 'Something went wrong');
      }
    } 
  }
}