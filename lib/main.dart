import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/theme.dart';
import 'package:lingopanda/features/auth/domain/repository/auth_repository.dart';
import 'package:lingopanda/features/auth/presentation/pages/login_page.dart';
import 'package:lingopanda/features/auth/presentation/providers/signup_provider.dart';
import 'package:lingopanda/features/news/presentation/pages/news_page.dart';
import 'package:lingopanda/firebase_options.dart';
import 'package:lingopanda/init_dependencies.dart';
import 'package:provider/provider.dart';
import 'package:lingopanda/features/auth/presentation/providers/login_provider.dart';
import 'package:lingopanda/features/news/presentation/providers/news_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<NewsProvider>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<SignupProvider>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lingo Panda',
        theme: baseTheme,
        home: serviceLocator<AuthRepository>().getCurrentUser() != null ? const NewsPage() : LoginScreen(),
      ),
    );
  }
}
