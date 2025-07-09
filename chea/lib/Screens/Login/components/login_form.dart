// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:chea/utils/auth_service.dart';
import 'package:flutter/material.dart';
// import 'package:your_project/services/auth_service.dart'; // Make sure to implement this service for sending email

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  void _sendPasswordResetEmail(String email) {
    // Implement the function to send password reset email
    // AuthService.sendPasswordResetEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    Future<void> _login() async {
      final authService = AuthService();
      final response = await authService.login(email, password);
      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed!: ${response.body}')));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => email = newValue ?? '',
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onSaved: (newValue) => password = newValue ?? '',
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                _login();
              }
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/home');
          }, child: Text('Go Home')),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                if (email.isNotEmpty) {
                  _sendPasswordResetEmail(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password reset email sent"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter your email"),
                    ),
                  );
                }
              }
            },
            child: const Text(
              "Forgot Password?",
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
