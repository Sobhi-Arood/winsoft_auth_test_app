import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winsoft_auth_test_app/logic/image_file_notifier.dart';
import 'package:winsoft_auth_test_app/logic/multiple_text_fields.dart';
import 'package:winsoft_auth_test_app/pages/widgets/sign_up_form_widget.dart';
import 'package:winsoft_auth_test_app/routes/routes.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: MultiProvider(
          providers: [
ChangeNotifierProvider<AddPhoneNumberTextField>(
                      create: (context) => AddPhoneNumberTextField()),
                  ChangeNotifierProvider<AddAddressTextField>(
                      create: (context) => AddAddressTextField()),
                  ChangeNotifierProvider<AddImageNotifier>(create: (context) => AddImageNotifier()),
          ],
                  child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
              child: Column(
                  children: [
                    Text(
                      'Welcome to our app',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Create account with your email and password or continue with socail media accounts',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SignUpFormWidget(),
                    const SizedBox(height: 32),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Do you have an account already?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RoutesNames.login);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFFFF9442),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // SignUpFormWidget(),
            ),
          ),
        ),
      ),
    );
  }
}