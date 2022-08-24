import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_dot/model/asset/status.dart';
import 'package:today_dot/view/screen/change_name_screen.dart';
import 'package:today_dot/view/screen/edit_diary_screen.dart';
import 'package:today_dot/view/screen/home_screen.dart';
import 'package:today_dot/view/screen/setting_screen.dart';
import 'package:today_dot/view/screen/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:today_dot/view/screen/sign_up_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    Status authStatus;
    if (user == null) {
      authStatus = Status.signOut;
      print('User is currently signed out!');
    } else {
      authStatus = Status.signIn;
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/', page: () => const SignInScreen()),
        GetPage(name: '/signUp', page: () => const SignUpScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/setting', page: () => const SettingScreen()),
        GetPage(name: '/changeName', page: () => const ChangeNameScreen()),
        GetPage(name: '/editDiary', page: () => const EditDiaryScreen()),
      ],
      theme: ThemeData(
          primaryColor: Color(0xff92B4EC),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff92B4EC),
                  onSurface: Color(0xff92B4EC),
                  textStyle: TextStyle(color: Colors.black)))),
    );
  }
}
