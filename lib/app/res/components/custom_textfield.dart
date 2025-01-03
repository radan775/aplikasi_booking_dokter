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
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters; // Tambahkan parameter baru

  const CustomTextfield({
    super.key,
    required this.hint,
    this.textController,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.enabled = true,
    this.inputFormatters, // Optional parameter
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
    // Gabungkan input formatters default dengan custom input formatters
    List<TextInputFormatter> combinedFormatters = [];

    // Tambahkan formatter digits only untuk input number
    if (widget.inputType == TextInputType.number) {
      combinedFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    // Tambahkan custom input formatters jika ada
    if (widget.inputFormatters != null) {
      combinedFormatters.addAll(widget.inputFormatters!);
    }

    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.inputType,
      cursorColor: AppColors.blueColor,
      obscureText: _isObscured,
      enabled: widget.enabled,
      style: TextStyle(
        color: widget.enabled ? widget.textColor : Colors.grey.withOpacity(0.7),
      ),
      inputFormatters: combinedFormatters, // Gunakan combined formatters
      decoration: InputDecoration(
        isDense: true,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor.withOpacity(0.5),
          ),
        ),
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
        labelText: widget.hint,
        labelStyle: TextStyle(
          color: widget.enabled
              ? widget.textColor.withOpacity(0.5)
              : Colors.grey.withOpacity(0.5),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.enabled ? widget.borderColor : Colors.grey,
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
            : widget.enabled
                ? null
                : Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
      ),
    );
  }
}
