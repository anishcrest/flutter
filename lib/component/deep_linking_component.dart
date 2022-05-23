import 'dart:io';

import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DeepLinkingComponent extends StatelessWidget {
  final String? link;

  DeepLinkingComponent({this.link});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'https://new-flutter-universal-link.herokuapp.com/',
            style: Theme.of(context).textTheme.subtitle1!,
          ),
          SizedBox(
            height: 16,
          ),
          RawMaterialButton(
            onPressed: () {
              String url = '';

              if (Platform.isAndroid) {
                url = 'https://new-flutter-universal-link.herokuapp.com/';
              } else if (Platform.isIOS) {
                url = 'unilinks://com.example.uniLinksExample';
              }
              Share.share(url);
            },
            fillColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              AppString.share,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
