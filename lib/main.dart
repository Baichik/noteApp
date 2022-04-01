import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/blocs/home_bloc.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final DBHelper dbHelper = DBHelper()..initDatabase();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(dbHelper)..add(FetchHomeEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
