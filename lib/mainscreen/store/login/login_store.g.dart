// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$accessTokenAtom = Atom(name: '_LoginStore.accessToken');

  @override
  String get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  final _$emailAtom = Atom(name: '_LoginStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$stateAtom = Atom(name: '_LoginStore.state');

  @override
  ButtonState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ButtonState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$storeStateAtom = Atom(name: '_LoginStore.storeState');

  @override
  StoreState get storeState {
    _$storeStateAtom.reportRead();
    return super.storeState;
  }

  @override
  set storeState(StoreState value) {
    _$storeStateAtom.reportWrite(value, super.storeState, () {
      super.storeState = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_LoginStore.init');

  @override
  Future<int> init({required BuildContext context}) {
    return _$initAsyncAction.run(() => super.init(context: context));
  }

  final _$signOutAsyncAction = AsyncAction('_LoginStore.signOut');

  @override
  Future<void> signOut({required BuildContext context}) {
    return _$signOutAsyncAction.run(() => super.signOut(context: context));
  }

  final _$signupAsyncAction = AsyncAction('_LoginStore.signup');

  @override
  Future<void> signup(
      {required BuildContext context, required LoginStore store}) {
    return _$signupAsyncAction
        .run(() => super.signup(context: context, store: store));
  }

  @override
  String toString() {
    return '''
accessToken: ${accessToken},
email: ${email},
state: ${state},
storeState: ${storeState}
    ''';
  }
}
