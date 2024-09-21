import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/features/auth/presentation/pages/login_page.dart';
import 'package:lingopanda/features/auth/presentation/providers/signup_provider.dart';
import 'package:lingopanda/features/news/presentation/pages/news_page.dart';
import 'package:provider/provider.dart';
import '../../../../core/utilities/utils.dart';

class SignupScreen extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => SignupScreen());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'MyNews',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primary,
                  fontSize: DisplayConstants.largeFontSize),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: validateEmail,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: validatePassword,
                  obscureText: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final result = await authProvider.signUp(
                  emailController.text,
                  nameController.text,
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
            child: const Text('Signup'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                        color: ColorPalette.primary,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          LoginScreen.route(),
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
    );
  }
}
