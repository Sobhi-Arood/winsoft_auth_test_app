import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winsoft_auth_test_app/pages/widgets/login_form_widget.dart';
import 'package:winsoft_auth_test_app/routes/routes.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Sign in with your email and password or continue with socail media accounts',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              LoginFormWidget(),
              Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          size: 22,
                          color: Color(0xFFFF6B30),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          minimumSize: MaterialStateProperty.all(Size(55, 55)),
                          shape: MaterialStateProperty.all(CircleBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFF5F7F9)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.facebookF,
                          size: 22,
                          color: Color(0xFF3A67A8),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          minimumSize: MaterialStateProperty.all(Size(55, 55)),
                          shape: MaterialStateProperty.all(CircleBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFF5F7F9)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.twitter,
                          size: 22,
                          color: Color(0xFF15A2ED),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          minimumSize: MaterialStateProperty.all(Size(55, 55)),
                          shape: MaterialStateProperty.all(CircleBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFF5F7F9)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RoutesNames.sign_up);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xFFFF9442),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}