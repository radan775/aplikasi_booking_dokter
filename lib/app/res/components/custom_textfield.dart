import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  final TextInputType inputType;
  final bool obscureText;
  final IconData? icon;

  const CustomTextfield({
    super.key,
    required this.hint,
    this.textController,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.icon,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.inputType,
      cursorColor: AppColors.blueColor,
      obscureText: _isObscured,
      style: TextStyle(
        color: widget.textColor,
      ),
      inputFormatters: widget.inputType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        labelText: widget.hint, // Ubah dari hintText menjadi labelText
        labelStyle: TextStyle(
          color: widget.textColor.withOpacity(0.5),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Aktifkan animasi
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.borderColor,
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: widget.borderColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
