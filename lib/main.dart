import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_bloc.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_bloc.dart';
import 'package:flutter_blo/bloc/switch_example/switch_bloc.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_bloc.dart';
import 'package:flutter_blo/repository/favourite_repository.dart';
import 'package:flutter_blo/ui/counter/counter_screen.dart';
import 'package:flutter_blo/ui/login/login_screen.dart';
import 'package:flutter_blo/utils/image_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (_) => ToDoBloc()),
        BlocProvider(create: (_) => FavouriteAppBloc(FavouriteRepository())),
        BlocProvider(create: (_) => PostsBloc()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
