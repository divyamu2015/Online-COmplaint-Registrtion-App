import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
// Ensure correct filename
import 'screens/register_grievance/bloc/register_grievance_bloc.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterGrievanceBloc()),
      ],
      child: ScreenUtilInit(
        // Initialize ScreenUtil
        designSize: const Size(
            375, 812), // Set your design size (based on Figma, Adobe XD, etc.)
        minTextAdapt: true, // Prevents `_minTextAdapt` error
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
