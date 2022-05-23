import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetUtil {
  static Future<XFile?> showImagePickerBottomSheet(
      BuildContext context, ImagePicker imagePicker) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (_) {
        return Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.camera),
                child: Text(AppString.camera),
              ),
              Divider(
                color: Colors.black,
                height: 0,
                endIndent: 20,
                indent: 20,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: Text(AppString.gallery),
              ),
            ],
          ),
        );
      },
    ).then((value) async {
      ///pick image based on user selection
      var imageFile = await imagePicker.pickImage(source: value!);

      if (imageFile != null) {
        return imageFile;
      } else {
        return null;
      }
    });
  }
}
