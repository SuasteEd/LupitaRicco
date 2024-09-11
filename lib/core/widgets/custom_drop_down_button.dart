import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final List<DropdownMenuItem<String>>? items;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final String? value;
  const CustomDropdownField({
    super.key,
    required this.label,
    this.validator,
    this.controller,
    this.items,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
            suffixIcon: suffixIcon,
          ),
          value: value,
          onChanged: (newValue) {
            if (controller != null) {
              controller?.text = newValue!;
            }
            if (onChanged != null) {
              onChanged!(newValue!);
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: items,
          validator: validator,

          onTap: onTap,
        ),
      ],
    );
  }
}
