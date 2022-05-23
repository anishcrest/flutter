import 'package:common_components/utils/enum_utils.dart';
import 'package:mobx/mobx.dart';

part 'animation_store.g.dart';

class AnimationStore = _AnimationStore with _$AnimationStore;

abstract class _AnimationStore with Store {
  @observable
  AnimationEnum? animationEnum;

  @observable
  String? error;
}
