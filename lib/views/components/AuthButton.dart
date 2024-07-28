// lib/components/auth_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newzbuzz/utils/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;
  final String buttonText;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.isSubmitting,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppPallete.primaryColor,
        minimumSize: Size(MediaQuery.of(context).size.width * .5, 0),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: isSubmitting
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              buttonText,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
