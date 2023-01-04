import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../common/common_template.dart';
import '../main.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Error. $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: (() {
          setState(() {
            isLogin = !isLogin;
          });
        }),
        child: Text(isLogin ? 'Register instead' : 'Login instead'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _entryField('email', _controllerEmail),
              _entryField('password', _controllerPassword),
              _errorMessage(),
              _submitButton(),
              _loginOrRegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

// Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const FlutterLogo(
//             style: FlutterLogoStyle.stacked,
//             size: 200,
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Row(
//             children: [
//               Text(
//                 'Email',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextField(
//             focusNode: _emailField,
//             controller: _emailController,
//             decoration: const InputDecoration(
//               hintText: 'Enter your email',
//               prefixIcon: Icon(Icons.email),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Text(
//                 'Password',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextField(
//             focusNode: _passwordFocus,
//             controller: _passwordController,
//             decoration: InputDecoration(
//               hintText: 'Enter your password',
//               prefixIcon: const Icon(Icons.lock),
//               suffixIcon: GestureDetector(
//                   onTap: () {},
//                   child: const Icon(Icons.remove_red_eye_outlined)),
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             width: double.maxFinite,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await signIn;
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               child: const Text('Login'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'No account?',
//                 style: TextStyle(color: Colors.grey.shade200),
//               ),
//               TextButton(onPressed: (() {}), child: const Text('Create one.'))
//             ],
//           )
//         ],
//       ),
