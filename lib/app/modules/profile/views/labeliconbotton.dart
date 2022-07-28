import 'package:flutter/material.dart';

class LabelIconButton extends StatelessWidget {
  const LabelIconButton({
    Key? key,
    this.iconColor = Colors.blue,
    required this.icon,
    required this.label,
    required this.onPress,
  }) : super(key: key);
  final IconData icon;
  final Color iconColor;
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 80,
        height: 100,
        child: TextButton(
          onPressed: () {
            onPress();
          },
          style: TextButton.styleFrom(
            primary: iconColor.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
