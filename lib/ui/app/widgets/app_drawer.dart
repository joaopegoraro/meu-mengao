// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    this.controller,
    required this.child,
  }) : super(key: key);

  final ZoomDrawerController? controller;
  final Widget child;

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ZoomDrawer(
      controller: widget.controller,
      menuBackgroundColor: theme.primaryColor,
      isRtl: true,
      style: DrawerStyle.defaultStyle,
      androidCloseOnBackTap: true,
      menuScreen: Container(
        color: theme.primaryColor,
      ),
      mainScreen: widget.child,
    );
  }
}
