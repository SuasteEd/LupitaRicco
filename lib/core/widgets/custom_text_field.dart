import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool validator;
  final bool? readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Widget? actionIcon;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.label,
    required this.validator,
    this.readOnly,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.actionIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (actionIcon != null) ...[
              const SizedBox(
                width: 15,
              ),
              actionIcon!
            ],
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          cursorColor: Colors.amber,
          readOnly: readOnly ?? false,
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
              prefixIcon: prefixIcon),
          keyboardType: keyboardType ?? TextInputType.visiblePassword,
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator:
              !validator ? null : (v) => v!.isEmpty ? 'Campo requerido' : null,
          onTap: onTap,
        )
      ],
    );
  }
}
