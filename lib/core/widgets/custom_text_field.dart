import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String? hint, label;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color? borderColor;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  const CustomTextField({
    super.key,
    this.hint,
    this.validator,
    this.controller,
    this.onChanged,
    this.label,
    this.borderColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool error = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      controller: widget.controller,
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
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8F8FA),
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
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
