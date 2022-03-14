import 'package:clean_arch_experts/core/error/failure.dart';
import 'package:clean_arch_experts/features/auth/domain/entities/user.dart';
import 'package:clean_arch_experts/features/auth/domain/repositories/do_login.dart';
import 'package:clean_arch_experts/features/auth/domain/usecases/do_login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DoLoginRepositoryMock extends Mock implements DoLoginRepository {}

void main() {
  DoLoginRepository _doLoginRepository = DoLoginRepositoryMock();
  DoLogin _doLogin = DoLogin(repository: _doLoginRepository);

  test('Should login with success', () async {
    when(() => _doLoginRepository.doLogin(
        email: 'email@email.com',
        password: 'fake-password')).thenAnswer((_) async => Right(tUser));

    var result = await _doLogin(
        DoLoginParams(email: 'email@email.com', password: 'fake-password'));

    expect(result, isA<Right>());
    expect(result, Right(tUser));
  });

  test('Should throw email/password error when try to login', () async {
    when(() => _doLoginRepository.doLogin(
            email: 'email@email.com', password: 'fake-password'))
        .thenAnswer((_) async => Left(UsernameOrPasswordFailure()));

    var result = await _doLogin(
        DoLoginParams(email: 'email@email.com', password: 'fake-password'));

    expect(result, isA<Left>());
    expect(result, Left(UsernameOrPasswordFailure()));
  });
}

var tUser = const User(email: 'email@email.com', name: 'Username');
