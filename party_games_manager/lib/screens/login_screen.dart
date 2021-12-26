import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/auth_controller.dart';
import 'package:party_games_manager/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Party Game Manager",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // After finding a proper image uncoment this and add the image to assets.
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 60.0,
            //     bottom: 30.0,
            //   ),
            //   child: Center(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(30),
            //       child: Image.asset(
            //         /"assets/images/img_login.png",
            //         height: 200,
            //         width: 200,
            //       ),
            //     ),
            //   ),
            // ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      bottom: 30.0,
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (input) {
                          if (input!.isEmpty) {
                            return "Please enter an email";
                          }

                          if (!RegExp("^[a-zA-Z0-9++.-]+@[a-zA-Z0-9.-]+.[a-z].")
                              .hasMatch(input)) {
                            return "Please enter a valid email";
                          }
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (input) => emailController.text = input!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (input) {
                          if (input!.isEmpty) {
                            return "Please Enter Your Password";
                          }
                        },
                        onSaved: (input) => passwordController.text = input!,
                        obscureText: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueAccent,
              child: MaterialButton(
                onPressed: () {
                  AuthController.instance
                      .login(emailController.text, passwordController.text);
                },
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: 300,
                child: const Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueAccent,
              child: MaterialButton(
                onPressed: () {
                  AuthController.instance.loginAnonymous();
                },
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: 300,
                child: const Text(
                  "Sign in as Guest",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? Sign up ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "here",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => const RegisterScreen());
                      },
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
