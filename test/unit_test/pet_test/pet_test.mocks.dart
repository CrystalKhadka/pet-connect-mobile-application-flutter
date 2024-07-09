// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/pet_test/pet_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i6;
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart'
    as _i7;
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart'
    as _i2;
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIPetRepository_0 extends _i1.SmartFake
    implements _i2.IPetRepository {
  _FakeIPetRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PetUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPetUseCase extends _i1.Mock implements _i4.PetUseCase {
  @override
  _i2.IPetRepository get petRepository => (super.noSuchMethod(
        Invocation.getter(#petRepository),
        returnValue: _FakeIPetRepository_0(
          this,
          Invocation.getter(#petRepository),
        ),
        returnValueForMissingStub: _FakeIPetRepository_0(
          this,
          Invocation.getter(#petRepository),
        ),
      ) as _i2.IPetRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.PetEntity>>> pagination(
    int? page,
    int? limit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #pagination,
          [
            page,
            limit,
          ],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.PetEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.PetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.PetEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.PetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.PetEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<String>>> getAllSpecies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllSpecies,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<String>>>.value(
            _FakeEither_1<_i6.Failure, List<String>>(
          this,
          Invocation.method(
            #getAllSpecies,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<String>>>.value(
                _FakeEither_1<_i6.Failure, List<String>>(
          this,
          Invocation.method(
            #getAllSpecies,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<String>>>);
}
