// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimationStore on _AnimationStore, Store {
  final _$animationEnumAtom = Atom(name: '_AnimationStore.animationEnum');

  @override
  AnimationEnum? get animationEnum {
    _$animationEnumAtom.reportRead();
    return super.animationEnum;
  }

  @override
  set animationEnum(AnimationEnum? value) {
    _$animationEnumAtom.reportWrite(value, super.animationEnum, () {
      super.animationEnum = value;
    });
  }

  final _$errorAtom = Atom(name: '_AnimationStore.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  @override
  String toString() {
    return '''
animationEnum: ${animationEnum},
error: ${error}
    ''';
  }
}
