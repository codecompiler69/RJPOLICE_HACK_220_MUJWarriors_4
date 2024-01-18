import 'package:fir_analysis/fir_new.dart';
import 'package:fir_analysis/widgets/app_text.dart';
import 'package:fir_analysis/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool passwordVisible = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

  void signIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FIRForm(
                  ipcSections: '',
                  description: '',
                )));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/rj_police_logo.jpg',
                height: 200,
                width: 100,
              ),
              const AppText(
                text: 'Officer Login',
                size: 30,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: _emailcontroller,
                obscureText: false,
                label: 'SSO',
              ),
              const SizedBox(
                height: 15,
              ),
              AppTextField(
                controller: _passwordcontroller,
                obscureText: passwordVisible,
                label: 'Password',
                icon: IconButton(
                  icon: passwordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 34, 7, 79),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: signIn,
                  child: const AppText(
                    text: 'Sign In',
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
