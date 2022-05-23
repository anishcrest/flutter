// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_to_refresh_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PullToRefreshStore on _PullToRefreshStore, Store {
  final _$isRefreshAtom = Atom(name: '_PullToRefreshStore.isRefresh');

  @override
  bool get isRefresh {
    _$isRefreshAtom.reportRead();
    return super.isRefresh;
  }

  @override
  set isRefresh(bool value) {
    _$isRefreshAtom.reportWrite(value, super.isRefresh, () {
      super.isRefresh = value;
    });
  }

  final _$_fetchPageAsyncAction = AsyncAction('_PullToRefreshStore._fetchPage');

  @override
  Future<void> _fetchPage(int pageKey) {
    return _$_fetchPageAsyncAction.run(() => super._fetchPage(pageKey));
  }

  final _$onRefreshAsyncAction = AsyncAction('_PullToRefreshStore.onRefresh');

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  @override
  String toString() {
    return '''
isRefresh: ${isRefresh}
    ''';
  }
}
