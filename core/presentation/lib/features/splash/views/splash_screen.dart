import 'package:flutter/material.dart';
import 'package:presentation/base/base_screen.dart';
import 'package:presentation/widgets/layouts/basic_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreenState<SplashScreen> {

  @override
  Widget builder(BuildContext context) {
    return BasicLayout();
  }
}
