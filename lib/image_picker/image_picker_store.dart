import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_picker_store.g.dart';

class ImagePickerStore = _ImagePickerStore with _$ImagePickerStore;

abstract class _ImagePickerStore with Store {
  final ImagePicker picker = ImagePicker();

  @observable
  ObservableList<File> selectedImageFile = ObservableList();
}
