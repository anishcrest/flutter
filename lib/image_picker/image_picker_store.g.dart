// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picker_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImagePickerStore on _ImagePickerStore, Store {
  final _$selectedImageFileAtom =
      Atom(name: '_ImagePickerStore.selectedImageFile');

  @override
  ObservableList<File> get selectedImageFile {
    _$selectedImageFileAtom.reportRead();
    return super.selectedImageFile;
  }

  @override
  set selectedImageFile(ObservableList<File> value) {
    _$selectedImageFileAtom.reportWrite(value, super.selectedImageFile, () {
      super.selectedImageFile = value;
    });
  }

  @override
  String toString() {
    return '''
selectedImageFile: ${selectedImageFile}
    ''';
  }
}
