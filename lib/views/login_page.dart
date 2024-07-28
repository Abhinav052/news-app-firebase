import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newzbuzz/services/auth_service.dart';
import 'package:newzbuzz/utils/routes/routes.dart';
import 'package:newzbuzz/utils/theme/app_pallete.dart';
import 'package:newzbuzz/views/components/AuthButton.dart';
import 'package:newzbuzz/views/components/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSubmitting = false;

  setSubmitting(bool value) {
    setState(() {
      isSubmitting = value;
    });
  }

  submitForm() async {
    setSubmitting(true);
    final res = await AuthService.login(
        identifier: emailController.text.trim(), password: passwordController.text.trim());
    res.fold((l) {
      snackBarCustom(context, l.message);
    }, (r) async {
      if (AuthService.checkLoginStatus())
        Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
    });
    setSubmitting(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AbsorbPointer(
          absorbing: isSubmitting,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "MyNews",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppPallete.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        AuthButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                submitForm();
                              }
                            },
                            isSubmitting: isSubmitting,
                            buttonText: "Login"),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New here? ",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, Routes.registerScreen, (route) => false);
                                },
                                child: Text(
                                  "Signup",
                                  style: GoogleFonts.poppins(
                                      color: AppPallete.primaryColor, fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
