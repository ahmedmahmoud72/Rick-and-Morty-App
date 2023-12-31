import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/presentation/app_router.dart';
import 'package:rick_and_morty_app/presentation/constants/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.lightBlue,
        )
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
