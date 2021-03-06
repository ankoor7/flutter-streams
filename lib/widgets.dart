import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    @required this.color,
    @required this.text,
    @required this.size,
    @required this.onPressed,
  });

  final Color color;
  final String text;
  final double size;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        child: Text(text),
        textColor: Colors.white,
        color: color,
        onPressed: onPressed,
        minWidth: size,
      ),
    );
  }
}

class ProductivityButton extends StatelessWidget {
  const ProductivityButton({
    @required this.color,
    @required this.onPressed,
    @required this.size,
    @required this.text,
  });

  final Color color;
  final VoidCallback onPressed;
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: Container(
            padding: const EdgeInsets.all(5),
            child: MaterialButton(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: onPressed,
              color: color,
              minWidth: size,
            )));
  }
}
