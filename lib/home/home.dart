import 'package:bubble_overlay/bubble_overlay.dart';
import 'package:common_components/animation/animation_component.dart';
import 'package:common_components/component/deep_linking_component.dart';
import 'package:common_components/component/drawer_component.dart';
import 'package:common_components/login/login.dart';
import 'package:common_components/map/map.dart';
import 'package:common_components/theme/theme.dart';
import 'package:common_components/todo/todo.dart';
import 'package:common_components/utils/enum_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../image_picker/image_picker_component.dart';
import '../pull_to_refresh/pull_to_refresh_component.dart';
import '../services/login_service.dart';
import '../tab_bar/tab_bar_component.dart';
import 'home_store.dart';

class HomeView extends StatefulWidget {
  final DrawerComponentEnum? fromNotification;

  HomeView({
    Key? key,
    this.fromNotification,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeStore homeStore = HomeStore();
  final BubbleOverlay bubbleOverlay = BubbleOverlay();

  @override
  void initState() {
    if (widget.fromNotification != null) {
      homeStore.changeDrawerValue(widget.fromNotification!);
      //selectedDrawerComponentEnum = widget.fromNotification!;
    }

    super.initState();
  }

  void openBubbleVideo() async {
    String url =
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    bubbleOverlay.openVideoBubble(url,
        startTimeInMilliseconds: 15000, controlsType: ControlsType.MINIMAL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(
              homeStore.selectedDrawerComponentEnum == DrawerComponentEnum.home
                  ? AppString.home
                  : homeStore.selectedDrawerComponentEnum ==
                          DrawerComponentEnum.pull_to_refresh
                      ? AppString.pull_to_refresh
                      : homeStore.selectedDrawerComponentEnum ==
                              DrawerComponentEnum.image_picker
                          ? AppString.image_picker
                          : homeStore.selectedDrawerComponentEnum ==
                                  DrawerComponentEnum.deep_link
                              ? AppString.deep_link
                              : homeStore.selectedDrawerComponentEnum ==
                                      DrawerComponentEnum.tab_bar
                                  ? AppString.tab_bar
                                  : homeStore.selectedDrawerComponentEnum ==
                                          DrawerComponentEnum.todo
                                      ? AppString.todo
                                      : homeStore.selectedDrawerComponentEnum ==
                                              DrawerComponentEnum.animations
                                          ? AppString.animation
                                          : homeStore.selectedDrawerComponentEnum ==
                                                  DrawerComponentEnum.map
                                              ? AppString.map
                                              : '',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  //  fontWeight: FontWeight.w700,
                  ),
            );
          },
        ),
        actions: [
          Switch(
            value: appStyle.isDarkTheme,
            onChanged: (val) {
              appStyle.toggleTheme(val);
            },
          ),
        ],
      ),
      drawer: DrawerComponent(
        onTap: changeSelectedDrawerIndex,
      ),
      body: Observer(builder: (context) {
        return IndexedStack(
          index: homeStore.selectedDrawerComponentEnum.index,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    onPressed: () {
                      openBubbleVideo();
                      /*SystemAlertWindow.showSystemWindow(
                         header: header,
                          body: body,
                          margin: SystemWindowMargin(left: 12, right: 8, top: 100, bottom: 0),
                          gravity: SystemWindowGravity.TOP,
                          prefMode: SystemWindowPrefMode.BUBBLE,
                          height: 150,
                          width: 200,
                      );*/
                    },
                    child: Text(
                      'Add overlay',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    fillColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RawMaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      bubbleOverlay.closeVideoBubble();
                    },
                    child: Text(
                      'Remove overlay',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    fillColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            PullToRefreshComponent(),
            ImagePickerComponent(),
            DeepLinkingComponent(),
            TabBarComponent(),
            AnimationsComponent(
              drawerComponentEnum: DrawerComponentEnum.animations,
            ),
            TodoComponent(),
            MapComponent(),
          ],
        );
      }),
    );
  }

  void changeSelectedDrawerIndex(
      DrawerComponentEnum drawerComponentEnum) async {
    if (drawerComponentEnum == DrawerComponentEnum.logout) {
      LoginServices loginServices = LoginServices();

      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginView()));
      await Future.delayed(Duration(milliseconds: 1000));
      loginServices.firebaseLogout();

      return;
    }

    ///change current display widget when user tap on drawer item
    homeStore.changeDrawerValue(drawerComponentEnum);

    ///close drawer window
    Navigator.pop(context);
  }

/*  late SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(text: "Overlay Header Title", fontSize: 10, textColor: Colors.black45),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      decoration: SystemWindowDecoration(startColor: Colors.white),
  );

  late SystemWindowBody body = SystemWindowBody(
    rows: [
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(text: "Some body", fontSize: 12, textColor: Colors.black45),
          ),

        ],
        gravity: ContentGravity.CENTER,
      ),
    ],
    padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
  );
  */
}
