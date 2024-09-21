import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/constants/error_messages.dart';
import 'package:lingopanda/core/constants/placeholder_descriptions.dart';
import 'package:lingopanda/features/auth/presentation/pages/login_page.dart';
import 'package:lingopanda/features/auth/presentation/providers/signup_provider.dart';
import 'package:lingopanda/features/auth/presentation/widgets/app_name.dart';
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
    final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DisplayConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: DisplayConstants.largePadding),
              child: AppName(),
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
                    decoration: const InputDecoration(
                        hintText: PlaceholderDescriptions.emailField),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: DisplayConstants.generalPadding),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: PlaceholderDescriptions.nameField),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ErrorMessages.nameFieldEmpty;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DisplayConstants.generalPadding),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: PlaceholderDescriptions.passwordField),
                    validator: validatePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await signupProvider.signUp(
                          emailController.text.trim(),
                          nameController.text.trim(),
                          passwordController.text.trim(),
                        );
                        result.fold(
                          (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(failure.message)),
                            );
                            signupProvider.setLoading(false);
                          },
                          (_) => Navigator.pushAndRemoveUntil(
                            context,
                            NewsPage.route(),
                            (route) => false,
                          ),
                        );
                      }
                    },
                    child: signupProvider.isLoading
                        ? const CupertinoActivityIndicator(color: ColorPalette.appWhite)
                        : const Text(
                            'Signup',
                            style: TextStyle(
                                fontSize: DisplayConstants.smallFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(DisplayConstants.smallPadding),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
            ),
          ],
        ),
      ),
    );
  }
}
