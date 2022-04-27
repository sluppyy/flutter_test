import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:startup_namer/legacy/User.dart';

import 'ProfileScreen.dart';

class AuthPage extends StatefulWidget {
  final void Function(User) onNewUser;
  final void Function({required String username, required String password}) onLogIn;
  final void Function({required String username, required String email, required String password}) onSignUp;

  const AuthPage({Key? key,
    required this.onNewUser,
    required this.onLogIn,
    required this.onSignUp
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const Map<String, String> headers = {
  'Content-Type':'application/json',
  'Accept': 'application/json'
};

class _AuthPageState extends State<AuthPage> {
  bool isLogIn = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final nameController = TextEditingController();

  void onSubmitLogIn() async {
    /*final response = await post(
      Uri.parse("$server/api/auth/local"),
      headers: headers,
      body: jsonEncode({
        "identifier": nameController.text,
        "password": passwordController.text
      })
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json["user"], jwt: json["jwt"]);
      widget.onNewUser(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong email or password!")));
    }*/
    widget.onLogIn(username: nameController.text, password: passwordController.text);
  }

  void onSubmitRegister() async {
    if (passwordController.text != passwordConfirmationController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    /*final response = await post(
        Uri.parse("$server/api/auth/local/register"),
        headers: headers,
        body: jsonEncode({
          "email": emailController.text,
          "username": nameController.text,
          "password": passwordConfirmationController.text
        })
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json["user"], jwt: json["jwt"]);
      widget.onNewUser(user);
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("username must be unique!")));
    }*/

    widget.onSignUp(
        username: nameController.text,
        email: emailController.text,
        password: passwordConfirmationController.text
    );
  }

  void onLogIn(bool isLogIn) {
    setState(() {
      this.isLogIn = isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00ffffff),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Profile"),
      ),
      body: ListView(
          children: [
            LogSign(onLogIn: onLogIn),

            const Center(child: SocIcons()),

            const Center(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Or", style: TextStyle(color: Colors.white, fontSize: 20))
                )
            ),

            if (isLogIn)
              Center(child: PersonInput(controller: nameController,)),
            if (isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: PasswordInputWithLabel(label: "Password", controller: passwordController,))),
            if (isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: SubmitButton(text: "Submit", onSubmit: onSubmitLogIn))),

            if (!isLogIn)
              Center(child: PersonInput(controller: nameController,)),
            if (!isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: MailInputWithLabel(controller: emailController,))),
            if (!isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: PasswordInputWithLabel(label: "Password", controller: passwordController,))),
            if (!isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: PasswordInputWithLabel(label: "Confirmation", controller: passwordConfirmationController,))),
            if (!isLogIn)
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0), child: SubmitButton(text: "Register", onSubmit: onSubmitRegister))),
          ]
      ),
    );
  }
}

class LogSign extends StatefulWidget {
  final void Function(bool) onLogIn;

  const LogSign({Key? key, required this.onLogIn}) : super(key: key);

  @override
  State<LogSign> createState() => _LogSignState();
}

class _LogSignState extends State<LogSign> {
  bool isLogIn = true;

  void _setLogState(bool isLogIn) {
    setState(() {
      widget.onLogIn(isLogIn);
      this.isLogIn = isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
              children: [
                Expanded(
                    child: isLogIn
                        ? OutlinedButton(
                      onPressed: (){_setLogState(true);},
                      child: const Padding(padding: EdgeInsets.all(12), child: Text("LOG IN", style: TextStyle(fontSize: 20, color: Colors.white))),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0, color: Colors.white),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25))),
                      ),
                    )
                        : ElevatedButton(
                      onPressed: (){_setLogState(true);},
                      child: const Padding(padding: EdgeInsets.all(12), child: Text("LOG IN", style: TextStyle(fontSize: 20, color: Colors.black))),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25))),
                          primary: Colors.white
                      ),
                    )
                ),

                Expanded(
                    child: isLogIn
                        ? ElevatedButton(
                      onPressed: (){_setLogState(false);},
                      child: const Padding(padding: EdgeInsets.all(12), child: Text("SIGN UP", style: TextStyle(fontSize: 20, color: Colors.black))),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.elliptical(25, 25))),
                          primary: Colors.white
                      ),
                    )
                        : OutlinedButton(
                      onPressed: (){_setLogState(false);},
                      child: const Padding(padding: EdgeInsets.all(12), child: Text("SIGN UP", style: TextStyle(fontSize: 20, color: Colors.white))),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0, color: Colors.white),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.elliptical(25, 25)))
                      ),
                    )
                )
              ]
          )
      )
    );
  }
}

class SocIcons extends StatelessWidget {
  const SocIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(width: 50, height: 50,
                  child: Stack(children: [
                    Container(color: Colors.blueAccent),
                    const Center(child: Icon(Icons.android, color: Colors.black, size: 40))
                  ])))),

      Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(width: 50, height: 50,
                  child: Stack(children: [
                    Container(color: Colors.redAccent),
                    const Center(child: Icon(Icons.android, color: Colors.black, size: 40))
                  ])))),

      Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(width: 50, height: 50,
                  child: Stack(children: [
                    Container(color: Colors.lightBlueAccent),
                    const Center(child: Icon(Icons.android, color: Colors.black, size: 40))
                  ])))),
    ]);
  }
}

class MailInputWithLabel extends StatelessWidget {
  final TextEditingController controller;

  const MailInputWithLabel({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, width: 350,
        child: TextField(
          controller: controller,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightGreenAccent), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                icon: Icon(Icons.mail_outline_sharp, color: Colors.white, size: 40),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.white)
            )
        )
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String text;
  final void Function() onSubmit;

  const SubmitButton({Key? key, required this.text, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 150, height: 50, child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25)))
      ),
        onPressed: onSubmit,
        child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 20)))
    );
  }
}

class PersonInput extends StatelessWidget {
  const PersonInput({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, width: 350,
        child: TextField(
          controller: controller,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                icon: Icon(Icons.person, color: Colors.white, size: 40),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
              labelText: "Login",
              labelStyle: TextStyle(color: Colors.white)
            )
        )
    );
  }
}

class PasswordInputWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const PasswordInputWithLabel({Key? key, required this.label, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, width: 350,
        child: TextField(
          controller: controller,
            obscureText: true,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrangeAccent), borderRadius: BorderRadius.horizontal(left: Radius.elliptical(25, 25), right: Radius.elliptical(25, 25))),
                icon: const Icon(Icons.lock, color: Colors.white, size: 40),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
              labelStyle: const TextStyle(color: Colors.white),
              labelText: label
            )
        )
    );
  }

}