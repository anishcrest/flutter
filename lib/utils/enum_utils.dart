enum DrawerComponentEnum {
  home,
  pull_to_refresh,
  image_picker,
  deep_link,
  tab_bar,
  animations,
  todo,
  map,
  logout,
}

enum UsersEnum {
  user_one,
  user_two,
}

enum TabBarViewEnum {
  home,
  business,
  school,
  setting,
}

enum MessageType {
  text,
  image,
}

class EnumUtil {
  static T fromStringEnum<T>(Iterable<T> values, String stringType) {
    return values.firstWhere(
      (f) => "${f.toString().split('.').last}".toString() == stringType,
    );
  }

  static String toStringEnum<T>(T enumType) {
    return enumType.toString().split('.').last;
  }
}

enum AnimationEnum {
  fade_in,
  fade_out,
  size_in,
  size_out,
  slide_up,
  slide_down,
  slide_left,
  slide_right,
}