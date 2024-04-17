import 'package:flutter_blog/views/AuthScreens/login_screen.dart';
import 'package:flutter_blog/views/AuthScreens/signup_screen.dart';
import 'package:flutter_blog/views/add_blog_screen.dart';
import 'package:flutter_blog/views/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String login = '/loginPage';
  static String signup = '/signupPage';
  static String homePage = '/homePage';
  static String addblogPage = '/addblogPage';
}

final getPages = [
  GetPage(name: Routes.login, page: () => const LoginScreen()),
  GetPage(name: Routes.signup, page: () => const SignUpScreen()),
  GetPage(name: Routes.homePage, page: () => const HomeScreen()),
  GetPage(name: Routes.addblogPage, page: () => const AddBlogScreen()),
];
