// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$selectedDrawerComponentEnumAtom =
      Atom(name: '_HomeStore.selectedDrawerComponentEnum');

  @override
  DrawerComponentEnum get selectedDrawerComponentEnum {
    _$selectedDrawerComponentEnumAtom.reportRead();
    return super.selectedDrawerComponentEnum;
  }

  @override
  set selectedDrawerComponentEnum(DrawerComponentEnum value) {
    _$selectedDrawerComponentEnumAtom
        .reportWrite(value, super.selectedDrawerComponentEnum, () {
      super.selectedDrawerComponentEnum = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  dynamic changeDrawerValue(DrawerComponentEnum drawerComponentEnum) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.changeDrawerValue');
    try {
      return super.changeDrawerValue(drawerComponentEnum);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDrawerComponentEnum: ${selectedDrawerComponentEnum}
    ''';
  }
}
