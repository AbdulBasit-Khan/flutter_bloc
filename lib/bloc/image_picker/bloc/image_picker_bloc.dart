import 'package:bloc/bloc.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_event.dart';
import 'package:flutter_blo/bloc/image_picker/bloc/image_picker_state.dart';
import 'package:flutter_blo/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCapture>(cameraCapture);
  }
  Future<void> cameraCapture(
      CameraCapture event, Emitter<ImagePickerState> states) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }
}
