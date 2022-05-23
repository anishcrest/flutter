import 'package:common_components/utils/enum_utils.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  DrawerComponentEnum selectedDrawerComponentEnum = DrawerComponentEnum.home;

  @action
  changeDrawerValue(DrawerComponentEnum drawerComponentEnum) {
    selectedDrawerComponentEnum = drawerComponentEnum;
  }
}
