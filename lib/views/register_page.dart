import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newzbuzz/utils/routes/routes.dart';
import 'package:newzbuzz/utils/theme/app_pallete.dart';
import 'package:newzbuzz/views/components/AuthButton.dart';
import 'package:newzbuzz/views/components/custom_snackbar.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();

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
    final res = await AuthService.register(
        userName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    res.fold((l) => {snackBarCustom(context, l.message)}, (r) async {
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
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "Name"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Password"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            buttonText: "Signup"),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, Routes.loginScreen, (route) => false);
                                },
                                child: Text(
                                  "Login",
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
