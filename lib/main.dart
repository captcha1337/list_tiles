import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/common_template.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ListTiles());
}

class ListTiles extends StatelessWidget {
  ListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return LoginPage();
                }
              }),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailField = FocusNode();
  final _passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CommonTemplate(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            style: FlutterLogoStyle.stacked,
            size: 200,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            focusNode: _emailField,
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            focusNode: _passwordFocus,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.remove_red_eye_outlined)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                signIn;
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Login'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No account?',
                style: TextStyle(color: Colors.grey.shade200),
              ),
              TextButton(onPressed: (() {}), child: const Text('Create one.'))
            ],
          )
        ],
      ),
    );
  }

  Future signIn() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
