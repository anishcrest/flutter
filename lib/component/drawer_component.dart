import 'package:common_components/utils/enum_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';

import '../chat/chat_component.dart';

class DrawerComponent extends StatelessWidget {
  final ValueSetter<DrawerComponentEnum> onTap;

  const DrawerComponent({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 5,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              onTap: () => onTap(DrawerComponentEnum.home),
              title: Text(AppString.home),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.pull_to_refresh),
              onTap: () => onTap(DrawerComponentEnum.pull_to_refresh),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.image_picker),
              onTap: () => onTap(DrawerComponentEnum.image_picker),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.deep_link),
              onTap: () => onTap(DrawerComponentEnum.deep_link),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.tab_bar),
              onTap: () => onTap(DrawerComponentEnum.tab_bar),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.user_one),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatComponent(
                      usersEnum: UsersEnum.user_one,
                    ),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.user_two),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatComponent(
                      usersEnum: UsersEnum.user_two,
                    ),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.animation),
              onTap: () => onTap(DrawerComponentEnum.animations),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.todo),
              onTap: () => onTap(DrawerComponentEnum.todo),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.map),
              onTap: () => onTap(DrawerComponentEnum.map),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            ListTile(
              dense: false,
              visualDensity: VisualDensity.compact,
              title: Text(AppString.logout),
              onTap: () => onTap(DrawerComponentEnum.logout),
            ),
            Divider(
              color: Colors.black,
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
