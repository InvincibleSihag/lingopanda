import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/placeholder_descriptions.dart';
import 'package:lingopanda/features/auth/presentation/pages/signup_page.dart';
import 'package:lingopanda/features/auth/presentation/providers/login_provider.dart';
import 'package:lingopanda/features/auth/presentation/widgets/app_name.dart';
import 'package:lingopanda/features/news/presentation/pages/news_page.dart';
import 'package:lingopanda/init_dependencies.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(DisplayConstants.largePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: DisplayConstants.largePadding),
              child: AppName(),
            ),
            Align(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: PlaceholderDescriptions.emailField),
                        validator: validateEmail,
                        style: const TextStyle(color: Colors.black),
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
                )),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final result =
                            await serviceLocator<LoginProvider>().signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        result.fold((failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(failure.message)),
                          );
                          authProvider.setLoading(false);
                        }, (_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            NewsPage.route(),
                            (route) => false,
                          );
                        });
                      }
                    },
                    child: authProvider.isLoading
                        ? const CupertinoActivityIndicator(color: ColorPalette.appWhite)
                        : const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: DisplayConstants.smallFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  const SizedBox(height: DisplayConstants.smallPadding),
                  RichText(
                    text: TextSpan(
                      text: 'New here? ',
                      style: const TextStyle(
                          color: ColorPalette.secondary,
                          fontWeight: FontWeight.bold),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
