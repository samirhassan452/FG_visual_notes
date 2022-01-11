import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:visual_notes/app/core/core_exports.dart'
    show DatabaseServices, NavigationService, Routers, RoutesNames;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show GetDeleteVisualNoteCubit;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get instance from db services
    final dbServices = DatabaseServices();
    // add BlocProvider<GetDeleteVisualNoteCubit> here to provide it to all descendants
    return BlocProvider<GetDeleteVisualNoteCubit>(
      create: (context) => GetDeleteVisualNoteCubit(dbServices: dbServices),
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Visual Notes",
        initialRoute: RoutesNames.splashRoute,
        onGenerateRoute: Routers.allRoutes,
      ),
    );
  }
}
