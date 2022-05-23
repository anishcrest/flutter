// import 'package:common_components/sure_set_state.dart';
// import 'package:common_components/utils/string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class OverlayWidget extends StatefulWidget {
//   final VideoPlayerController videoController;
//
//   const OverlayWidget({
//     Key? key,
//     required this.videoController,
//   }) : super(key: key);
//
//   @override
//   State<OverlayWidget> createState() => _OverlayWidgetState();
// }
//
// class _OverlayWidgetState extends State<OverlayWidget> {
//   double? top = 0;
//   double? bottom = 0;
//   double? left = 0;
//   double? right = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AnimatedPositioned(
//           top: top,
//           bottom: bottom,
//           left: left,
//           right: right,
//           duration: Duration(milliseconds: 800),
//           child: GestureDetector(
//             onVerticalDragStart: (DragStartDetails detail) {
//               print('onVerticalDragStart ---> ${detail.globalPosition}');
//             },
//             /*onVerticalDragUpdate: (DragUpdateDetails detail) {
//                 print('onVerticalDragUpdate ---> $detail');
//                 sureSetState(this, () {
//                   top = MediaQuery.of(context).size.height / 1.2;
//                   bottom = 12;
//                   left = MediaQuery.of(context).size.width / 2;
//                   right = 12;
//                 });
//               },*/
//
//             onVerticalDragDown: (DragDownDetails detail) {
//               /* print('onVerticalDragDown ---> ${detail}');
//
//                 sureSetState(this, () {
//                   top = MediaQuery.of(context).size.height / 1.2;
//                   bottom = 12;
//                   left = MediaQuery.of(context).size.width / 2;
//                   right = 12;
//                 });*/
//             },
//             child: Scaffold(
//               appBar: AppBar(
//                 title: Text(
//                   'Video player',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     widget.videoController.value.isInitialized
//                         ? AspectRatio(
//                             aspectRatio:
//                                 widget.videoController.value.aspectRatio,
//                             child: VideoPlayer(widget.videoController),
//                           )
//                         : Container(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 20, horizontal: 16),
//                       child: Text(
//                         AppString.detail_video,
//                         style: Theme.of(context).textTheme.headline6!.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         AppString.video_desc,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
