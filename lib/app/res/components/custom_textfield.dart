import 'package:flutter/services.dart';
import 'package:aplikasi_booking_dokter/app/data/consts/consts.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  final TextInputType inputType; // Menambahkan properti inputType
  const CustomTextfield({
    super.key,
    required this.hint,
    this.textController,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.inputType = TextInputType.text, // Default TextInputType adalah text
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.inputType, // Menambahkan keyboardType
      cursorColor: AppColors.blueColor,
      style: TextStyle(
        color: widget.textColor, // Mengatur warna teks input
      ),
      inputFormatters: widget.inputType == TextInputType.number
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ] // Input hanya angka jika inputType adalah number
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
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.textColor.withOpacity(0.5), // Warna hint lebih redup
        ),
      ),
    );
  }
}
