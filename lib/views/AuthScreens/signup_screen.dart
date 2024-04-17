import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/services/auth_services.dart';
import 'package:flutter_blog/services/validator.dart';
import 'package:flutter_blog/widgets/app_text.dart';
import 'package:flutter_blog/widgets/image_container.dart';
import 'package:flutter_blog/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isSigningUp = false;

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
                    text: "Sign Up To Your\nAccount",
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  const CustomAppText(
                    text: "Enter your details below to continue",
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
                          text: "Welcome to  ",
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
                          validator: (value) => Validator.validateName(value),
                          labelText: "Full Name",
                          hintText: "Enter your name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          controller: nameController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          validator: (value) => Validator.validateEmail(value),
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: Icons.mail,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          validator: (value) =>
                              Validator.validatePassword(value),
                          labelText: "Password",
                          hintText: "Enter your password",
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          suffixIcon: Icons.visibility_off,
                          controller: passwordController,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blueGrey,
                              ),
                            ),
                            onPressed: _isSigningUp ? null : _signUp,
                            child: _isSigningUp
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const CustomAppText(
                                    text: "Sign Up",
                                    fontSize: 16,
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
                                Get.toNamed(Routes.login);
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
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
                        text: "Sign Up To Your Account",
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      const CustomAppText(
                        text: "Enter your details below to continue",
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
                              text: "Welcome to  ",
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
                              validator: (value) =>
                                  Validator.validateName(value),
                              labelText: "Full Name",
                              hintText: "Enter your name",
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              controller: nameController,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              validator: (value) =>
                                  Validator.validateEmail(value),
                              labelText: "Email",
                              hintText: "Enter your email",
                              prefixIcon: Icons.mail,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              controller: emailController,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              validator: (value) =>
                                  Validator.validatePassword(value),
                              labelText: "Password",
                              hintText: "Enter your password",
                              prefixIcon: Icons.lock,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              suffixIcon: Icons.visibility_off,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 50),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blueGrey,
                                  ),
                                ),
                                onPressed: _isSigningUp ? null : _signUp,
                                child: _isSigningUp
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const CustomAppText(
                                        text: "Sign Up",
                                        fontSize: 16,
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
                                    Get.toNamed(Routes.login);
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
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

  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    User? user = await FirebaseAuthHelper.registerUsingEmailPassword(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isSigningUp = false;
    });

    if (user != null) {
      print("User registered successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User registered successfully"),
        ),
      );
      Get.toNamed(Routes.homePage, arguments: user);
    }
  }
}
