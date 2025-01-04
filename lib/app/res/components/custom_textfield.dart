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
  final List<TextInputFormatter>? inputFormatters;

  // Tambahkan parameter onChanged
  final void Function(String)? onChanged;

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
    this.inputFormatters,
    this.onChanged, // Optional parameter untuk onChanged
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
    List<TextInputFormatter> combinedFormatters = [];

    if (widget.inputType == TextInputType.number) {
      combinedFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    if (widget.inputFormatters != null) {
      combinedFormatters.addAll(widget.inputFormatters!);
    }

    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.inputType,
      cursorColor: AppColors.blueColor,
      obscureText: _isObscured,
      enabled: widget.enabled,

      // Tambahkan onChanged
      onChanged: widget.onChanged,

      style: TextStyle(
        fontSize: AppSizes.fontSize16,
        color: widget.enabled ? widget.textColor : Colors.grey.withOpacity(0.7),
      ),
      inputFormatters: combinedFormatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(
          AppSizes.paddingHorizontal10,
          AppSizes.paddingVertical12,
          AppSizes.paddingHorizontal10,
          AppSizes.paddingVertical12,
        ),
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
          fontSize: AppSizes.fontSize14,
          color: widget.enabled
              ? widget.textColor.withOpacity(0.5)
              : Colors.grey.withOpacity(0.5),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: widget.icon != null
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingHorizontal10),
                child: Icon(
                  widget.icon,
                  color: widget.enabled ? widget.borderColor : Colors.grey,
                  size: AppSizes.iconSize20,
                ),
              )
            : null,
        suffixIcon: widget.obscureText
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingHorizontal10),
                child: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: widget.borderColor,
                    size: AppSizes.iconSize20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              )
            : widget.enabled
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingHorizontal10),
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                      size: AppSizes.iconSize20,
                    ),
                  ),
      ),
    );
  }
}
