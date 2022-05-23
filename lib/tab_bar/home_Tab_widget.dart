// import 'package:common_components/sure_set_state.dart';
// import 'package:common_components/utils/string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class HomeTab extends StatefulWidget {
//   const HomeTab({Key? key}) : super(key: key);
//
//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab> {
//   late VideoPlayerController videoController;
//   Offset? offset;
//
//   @override
//   void initState() {
//     super.initState();
//     videoController = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
//
//   @override
//   void didChangeDependencies() {
//     print('didChangeDependencies');
//     if (offset == null) {
//       offset = Offset(0, MediaQuery.of(context).size.height / 1.2);
//     }
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     videoController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: 10,
//           itemBuilder: (_, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               child: ListTile(
//                 tileColor: Theme.of(context).cardColor,
//                 visualDensity: VisualDensity.compact,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                 minVerticalPadding: 0,
//                 dense: true,
//                 leading: Container(
//                   width: 40.0,
//                   height: 40.0,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     border: Border.all(
//                       color: Colors.black54,
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.play_arrow,
//                     size: 35,
//                   ),
//                 ),
//                 title: Text(
//                   'Item $index',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 subtitle: Text(
//                   'Item sub Title $index',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 onTap: () {
//                   print('asdsadsad');
//                   videoController.play();
//                   sureSetState(this, () {
//                     offset = Offset(0, 0);
//                   });
//
//                   print(offset);
//                 },
//               ),
//             );
//           },
//         ),
//         Transform.translate(
//           offset: offset!,
//           child: GestureDetector(
//             onVerticalDragUpdate: (DragUpdateDetails detail) {
//               print('onVerticalDragUpdate');
//             },
//             onVerticalDragDown: (DragDownDetails detail) {
//               print('onVerticalDragUpdate');
//             },
//             child: SingleChildScrollView(
//               child: Container(
//                 color: Theme.of(context).cardColor,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     videoController.value.isInitialized
//                         ? AspectRatio(
//                             aspectRatio: videoController.value.aspectRatio,
//                             child: VideoPlayer(videoController),
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
//
// ///animated open container logic
// /*
// OpenContainer(
//                 closedElevation: 10,
//                 openElevation: 15,
//                 closedShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 transitionType: ContainerTransitionType.fade,
//                 transitionDuration: Duration(milliseconds: 600),
//                 closedColor: Theme.of(context).cardColor,
//                 closedBuilder: (context, action) {
//                   return ListTile(
//                     tileColor: Theme.of(context).cardColor,
//                     visualDensity: VisualDensity.compact,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                     minVerticalPadding: 0,
//                     dense: true,
//                     leading: Container(
//                       width: 40.0,
//                       height: 40.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         border: Border.all(
//                           color: Colors.black54,
//                         ),
//                       ),
//                       child: const Icon(
//                         Icons.play_arrow,
//                         size: 35,
//                       ),
//                     ),
//                     title: Text(
//                       'Item $index',
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                     subtitle: Text(
//                       'Item sub Title $index',
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                   );
//                 },
//                 openBuilder: (context, action) {
//                   videoController.play();
//                   return OverlayWidget(
//                     videoController: videoController,
//                   );
//                 },
//               ),
//  */
