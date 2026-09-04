import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(1200, 800),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) => const UltronApp(),
      ),
    ),
  );
}
