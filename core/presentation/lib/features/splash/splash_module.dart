import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/features/splash/cubit/splash_cubit.dart';
import 'package:presentation/features/splash/views/splash_screen.dart';

@RoutePage()
class SplashModule extends StatelessWidget {
  const SplashModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashScreen(),
    );
  }
}