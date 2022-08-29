import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../libraries.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          labelText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value != null && !EmailValidator.validate(value)) {
          Fluttertoast.showToast(msg: "Enter a valid email");
        }
        Fluttertoast.showToast(msg: "Enter a valid email");
      },
      onSaved: (value) => emailController.text = value!,
      textInputAction: TextInputAction.done,
    );

    final resetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Reset",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        onPressed: () {
          resetPassword(emailController.text);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SigninScreen()));
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/images/sikshyatechnology.jpg",
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Enter your email address to reset your account password",
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        // textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(height: 20.0),
                      emailField,
                      const SizedBox(height: 20.0),
                      resetButton,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword(String? email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success Message"),
              content: const Text("Password Reset Email Sent"),
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40.0,
                    ))
              ],
            );
          });
      // Fluttertoast.showToast(msg: "Password Reset Email Sent");
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error Message"),
              content: Text(e.message.toString()),
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40.0,
                    ))
              ],
            );
          });
      // Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}
