import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/features/auth/presentation/pages/signup_page.dart';
import 'package:lingopanda/features/auth/presentation/providers/login_provider.dart';
import 'package:lingopanda/features/news/presentation/pages/news_page.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utilities/utils.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  static route() => MaterialPageRoute(builder: (context) => LoginScreen());

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.appGrey,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'MyNews',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorPalette.primary,
                fontSize: DisplayConstants.largeFontSize),
          ),
        ),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: ColorPalette.appWhite),
                validator: validateEmail,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: ColorPalette.appWhite),
                validator: validatePassword,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await authProvider.signIn(
                      emailController.text,
                      passwordController.text,
                    );
                    result.fold(
                      (failure) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(failure.message)),
                      ),
                      (_) => Navigator.pushAndRemoveUntil(
                        context,
                        NewsPage.route(),
                        (route) => false,
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'New here? ',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: 'Signup',
                      style: const TextStyle(
                          color: ColorPalette.primary,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            SignupScreen.route(),
                            (route) => false,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
