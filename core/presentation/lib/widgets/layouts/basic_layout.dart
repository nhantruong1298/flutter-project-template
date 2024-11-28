import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';

class BasicLayout extends StatelessWidget {
  final Widget? child;
  const BasicLayout({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppScheme.colors.primary,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
