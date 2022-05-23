import 'dart:io';

import 'package:common_components/utils/bottom_sheet_util.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'image_picker_store.dart';

class ImagePickerComponent extends StatefulWidget {
  const ImagePickerComponent({Key? key}) : super(key: key);

  @override
  _ImagePickerComponentState createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  late ImagePickerStore imagePickerStore;

  @override
  void initState() {
    super.initState();
    imagePickerStore = ImagePickerStore();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              onPressed: () => _showBottomSheet(),
              fillColor: Theme.of(context).primaryColor,
              child: Text(
                AppString.pick_image,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            if (imagePickerStore.selectedImageFile.isNotEmpty)
              Text(
                AppString.selected_image,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            Visibility(
              visible: imagePickerStore.selectedImageFile.isNotEmpty,
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: imagePickerStore.selectedImageFile.length,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0)
                    .copyWith(right: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        imagePickerStore.selectedImageFile[index],
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: -2,
                        right: -5,
                        child: InkWell(
                          onTap: () {
                            imagePickerStore.selectedImageFile.removeAt(index);
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.clear,
                              size: 16,
                            ),
                            radius: 10,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  _showBottomSheet() async {
    var file = await BottomSheetUtil.showImagePickerBottomSheet(
        context, imagePickerStore.picker);

    if (file != null) {
      ///add picked image into list
      imagePickerStore.selectedImageFile.add(File(file.path));
    }
  }
}
