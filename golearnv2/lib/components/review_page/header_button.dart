import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
  }) : super(key: key);

  //THIS IS THE CODE FOR THE HEADER IN THE REVIEW PAGE

  final String title;
  final VoidCallback onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
