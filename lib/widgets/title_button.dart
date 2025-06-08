import 'package:flutter/material.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({
    super.key,
    this.onTap,
    required this.leading,
    required this.title,
    this.trailing,
  });

  final void Function()? onTap;
  final Widget leading;
  final Widget title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(leading: leading, title: title, trailing: trailing),
    );
  }
}
