import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/services/auth_services.dart';
import 'package:flutter_blog/services/validator.dart';
import 'package:flutter_blog/widgets/app_text.dart';
import 'package:flutter_blog/widgets/image_container.dart';
import 'package:flutter_blog/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  void _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const CustomAppText(
                    text: "Sign In To Your\nAccount",
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  const CustomAppText(
                    text: "Enter your credentials below to continue",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const CustomAppText(
                          text: "Welcome back to ",
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        const CustomAppText(
                          text: "Blog",
                          fontSize: 30,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: Icons.mail,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          controller: emailController,
                          validator: (value) => Validator.validateEmail(value),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: "Password",
                          hintText: "Enter your password",
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          suffixIcon: Icons.visibility_off,
                          controller: passwordController,
                          validator: (value) =>
                              Validator.validatePassword(value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const CustomAppText(
                                text: "Forgot Password",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey),
                            ),
                            onPressed: _isSigningIn ? null : _signIn,
                            child: _isSigningIn
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const CustomAppText(
                                    text: "Login",
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomAppText(
                              text: "Or continue with",
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageContainer(
                              image: "assets/google.png",
                            ),
                            ImageContainer(
                              image: "assets/facebook.png",
                            ),
                            ImageContainer(
                              image: "assets/apple.png",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.signup);
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CustomAppText(
                        text: "Sign In To Your Account",
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      const CustomAppText(
                        text: "Enter your credentials below to continue",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const CustomAppText(
                              text: "Welcome back to ",
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const CustomAppText(
                              text: "Blog",
                              fontSize: 30,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              labelText: "Email",
                              hintText: "Enter your email",
                              prefixIcon: Icons.mail,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              controller: emailController,
                              validator: (value) =>
                                  Validator.validateEmail(value),
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              labelText: "Password",
                              hintText: "Enter your password",
                              prefixIcon: Icons.lock,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              suffixIcon: Icons.visibility_off,
                              controller: passwordController,
                              validator: (value) =>
                                  Validator.validatePassword(value),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const CustomAppText(
                                    text: "Forgot Password",
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 50)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey),
                                ),
                                onPressed: _isSigningIn ? null : _signIn,
                                child: _isSigningIn
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const CustomAppText(
                                        text: "Login",
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAppText(
                                  text: "Or continue with",
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageContainer(
                                  image: "assets/google.png",
                                ),
                                ImageContainer(
                                  image: "assets/facebook.png",
                                ),
                                ImageContainer(
                                  image: "assets/apple.png",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account ?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.signup);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigningIn = true;
    });

    User? user = await FirebaseAuthHelper.signInUsingEmailPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isSigningIn = false;
    });

    if (user != null) {
      Get.offNamed(Routes.homePage);
    } else {
      print("User not found");
    }
  }
}
