import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordField extends StatefulWidget {
  final String? hint;
  final Function(String?)? validator;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  const CustomPasswordField({
    super.key,
    this.hint,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.controller,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool error = false;
  String? errorText;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: (value) {
            if (widget.validator != null) {
              errorText = widget.validator?.call(value);
              if (errorText != null && errorText!.isNotEmpty) {
                setState(() {
                  error = true;
                });
                return widget.validator?.call(value);
              } else {
                setState(() {
                  error = false;
                  errorText = null;
                });
              }
            }
            return null;
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10.5,
            ),
            isDense: true,
            errorMaxLines: 1,
            errorText: errorText,
            errorStyle: const TextStyle(
              color: Colors.transparent,
              fontSize: 0,
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.plusJakartaSans().copyWith(
              color: const Color(0xff494A57),
              fontSize: 12,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            suffixIcon: IconButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: 11, vertical: 10.5),
              constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
