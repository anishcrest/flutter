// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStore, Store {
  final _$isDataSubmittingAtom = Atom(name: '_SignUpStore.isDataSubmitting');

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

  final _$errorAtom = Atom(name: '_SignUpStore.error');

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

  final _$resultAtom = Atom(name: '_SignUpStore.result');

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

  final _$submitDataAsyncAction = AsyncAction('_SignUpStore.submitData');

  @override
  Future submitData(BuildContext context) {
    return _$submitDataAsyncAction.run(() => super.submitData(context));
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
