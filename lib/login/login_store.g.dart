// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$isDataSubmittingAtom = Atom(name: '_LoginStore.isDataSubmitting');

  @override
  bool get isDataSubmitting {
    _$isDataSubmittingAtom.reportRead();
    return super.isDataSubmitting;
  }

  @override
  set isDataSubmitting(bool value) {
    _$isDataSubmittingAtom.reportWrite(value, super.isDataSubmitting, () {
      super.isDataSubmitting = value;
    });
  }

  final _$errorAtom = Atom(name: '_LoginStore.error');

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

  final _$resultAtom = Atom(name: '_LoginStore.result');

  @override
  bool? get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(bool? value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$submitDataAsyncAction = AsyncAction('_LoginStore.submitData');

  @override
  Future submitData(BuildContext context) {
    return _$submitDataAsyncAction.run(() => super.submitData(context));
  }

  final _$signWithGoogleAsyncAction = AsyncAction('_LoginStore.signWithGoogle');

  @override
  Future signWithGoogle() {
    return _$signWithGoogleAsyncAction.run(() => super.signWithGoogle());
  }

  final _$signWithFacebookAsyncAction =
      AsyncAction('_LoginStore.signWithFacebook');

  @override
  Future signWithFacebook() {
    return _$signWithFacebookAsyncAction.run(() => super.signWithFacebook());
  }

  @override
  String toString() {
    return '''
isDataSubmitting: ${isDataSubmitting},
error: ${error},
result: ${result}
    ''';
  }
}
