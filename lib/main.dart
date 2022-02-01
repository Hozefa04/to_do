import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit/auth/auth_cubit.dart';
import 'package:to_do/cubit/color_picker/color_cubit.dart';
import 'package:to_do/router/app_router.dart';
import 'package:to_do/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ColorCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
