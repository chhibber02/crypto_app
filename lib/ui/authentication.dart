// ignore_for_file: use_build_context_synchronously

import 'package:crypto_app/net/flutterfire.dart';
import 'package:crypto_app/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //email field
              TextFormField(
                controller: _emailField,
                decoration: const InputDecoration(
                  hintText: "example@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              // password field
              TextFormField(
                controller: _passwordField,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              // register button
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await register(_emailField.text, _passwordField.text);

                    if (shouldNavigate) {
                      //Navigate
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: const Text("Register"),
                ),
              ),

              // login button
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);

                    if (shouldNavigate) {
                      //Navigate
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
