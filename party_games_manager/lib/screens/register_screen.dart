import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Register",
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.account_circle),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (input) {
                              if (input!.isEmpty) {
                                return "Please enter Name";
                              }
                            },
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => nameController.text = input!,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail),
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
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9++.-]+@[a-zA-Z0-9.-]+.[a-z].")
                                  .hasMatch(input)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => emailController.text = input!,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
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
                                return "Please Enter Password";
                              }
                              if (!RegExp(
                                      "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
                                  .hasMatch(input)) {
                                return "Must be atleast 8 characters!\nMust contain atleast 1 Capital Case!\nMust contain atleast 1 Small Case!\nMust contain atleast 1 number!\nMust contain atleast 1 Special Character!";
                              }
                            },
                            onSaved: (input) =>
                                passwordController.text = input!,
                            obscureText: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.vpn_key),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (input) {
                              if (input!.isEmpty) {
                                return "Please Confirm Your Password";
                              }
                              if (passwordController.text != input) {
                                return "Password dont't match";
                              }
                            },
                            onSaved: (input) =>
                                passwordController.text = input!,
                            obscureText: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent,
                    child: MaterialButton(
                      onPressed: () {
                        AuthController.instance.register(emailController.text,
                            passwordController.text, nameController.text);
                      },
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: 300,
                      child: const Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                        text: "Already registered? Login ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "here",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(() => const RegisterScreen());
                          },
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
}
