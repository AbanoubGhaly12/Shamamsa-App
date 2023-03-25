import 'package:flutter/material.dart';

import '../resources/size_manager.dart';

class CustomListTile extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final Function() onTap;
  final EdgeInsets? padding;

  const CustomListTile({
    Key? key,
    this.child,
    required this.onTap,
    this.children,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: children != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: children ??
            [
              Expanded(
                child: Padding(
                  padding:
                      padding ?? const EdgeInsets.only(right: SizeManager.s14),
                  child: child,
                ),
              ),
            ],
      ),
    );
  }
}
