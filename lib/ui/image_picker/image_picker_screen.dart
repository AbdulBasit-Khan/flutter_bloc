import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_event.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker Bloc"),
      ),
      body: Center(
        child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state) {
          return state.file == null
              ? GestureDetector(
                  onTap: () {
                    context.read<ImagePickerBloc>().add(CameraCapture());
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.camera),
                  ))
              : Image.file(File(state.file!.path));
        }),
      ),
    );
  }
}
