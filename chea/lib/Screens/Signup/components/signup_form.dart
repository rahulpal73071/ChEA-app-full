import 'package:chea/utils/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _rePasswordController.dispose();
    _emailController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async{
    final response = await http.post(
      Uri.parse('http://172.28.102.117:8000/signup/'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'email': _emailController.text,
        'roll_no': _rollNumberController.text,
        'password': _passwordController.text,
      }),
    );
    if(response.statusCode == 201){
      String token = jsonDecode(response.body)['token'];
      await AuthService().setToken(token);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up Failed!: ${response.body}'))
      );
    }
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _rollNumberController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              onSaved: (signUp) {},
              decoration: const InputDecoration(
                hintText: "Roll Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your roll number';
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            obscureText: !_passwordVisible,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Your password",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
            controller: _rePasswordController,
            textInputAction: TextInputAction.done,
            obscureText: !_rePasswordVisible,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Re-enter your password",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _rePasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _rePasswordVisible = !_rePasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please re-enter your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _signUp();
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}