import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:flutter_blo/bloc/switch_example/switch_bloc.dart';
import 'package:flutter_blo/ui/image_picker/image_picker_screen.dart';
import 'package:flutter_blo/ui/switch_example/switch_example.dart';
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
      // create: (context)=>SwitchBloc(),
      providers: [
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ImagePickerScreen(),
      ),
    );
  }
}
