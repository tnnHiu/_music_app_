import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.onPressed,
    this.obscureText = false,
    this.controller,
    this.isTypeNumber = false,
    this.validator,
    this.onSaved,
  });

  final String hintText;
  final IconData? icon;
  final void Function()? onPressed;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isTypeNumber;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade800.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400,
                    ),
              ),
              keyboardType: isTypeNumber ? TextInputType.number : null,
              cursorColor: Colors.white,
              obscureText: obscureText,
              controller: controller,
              validator: validator,
              onSaved: onSaved,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// TextFormField(
// decoration: InputDecoration(
// isDense: true,
// filled: true,
// fillColor: Colors.white,
// hintText: 'Search',
// hintStyle: Theme.of(context)
//     .textTheme
//     .bodyMedium!
//     .copyWith(color: Colors.grey.shade400),
// prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15.0),
// borderSide: BorderSide.none,
// ),
// ),
// ),
