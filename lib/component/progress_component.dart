import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressComponent extends StatelessWidget {
  final bool isVisible;

  const ProgressComponent({Key? key, this.isVisible = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Visibility(
        visible: isVisible,
        child: Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
