// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/pet_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i7;
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart'
    as _i11;
import 'package:final_assignment/features/favorite/domain/repository/i_favorite_repository.dart'
    as _i4;
import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart'
    as _i10;
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart'
    as _i8;
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart'
    as _i2;
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart'
    as _i5;
import 'package:final_assignment/features/pet/presentation/navigator/pet_view_navigator.dart'
    as _i9;
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

class _FakeIFavoriteRepository_2 extends _i1.SmartFake
    implements _i4.IFavoriteRepository {
  _FakeIFavoriteRepository_2(
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
class MockPetUseCase extends _i1.Mock implements _i5.PetUseCase {
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
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.PetEntity>>> pagination(
    int? page,
    int? limit,
    String? search,
    String? breed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #pagination,
          [
            page,
            limit,
            search,
            breed,
          ],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.PetEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.PetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
              search,
              breed,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.PetEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.PetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
              search,
              breed,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.PetEntity>>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<String>>> getAllSpecies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllSpecies,
          [],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<String>>>.value(
            _FakeEither_1<_i7.Failure, List<String>>(
          this,
          Invocation.method(
            #getAllSpecies,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, List<String>>>.value(
                _FakeEither_1<_i7.Failure, List<String>>(
          this,
          Invocation.method(
            #getAllSpecies,
            [],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<String>>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.PetEntity>> getPetById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPetById,
          [id],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.PetEntity>>.value(
            _FakeEither_1<_i7.Failure, _i8.PetEntity>(
          this,
          Invocation.method(
            #getPetById,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, _i8.PetEntity>>.value(
                _FakeEither_1<_i7.Failure, _i8.PetEntity>(
          this,
          Invocation.method(
            #getPetById,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.PetEntity>>);
}

/// A class which mocks [PetViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockPetViewNavigator extends _i1.Mock implements _i9.PetViewNavigator {
  @override
  dynamic openSinglePetView(String? id) => super.noSuchMethod(
        Invocation.method(
          #openSinglePetView,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  dynamic openAdoptionFormView(String? id) => super.noSuchMethod(
        Invocation.method(
          #openAdoptionFormView,
          [id],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [FavoriteUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteUsecase extends _i1.Mock implements _i10.FavoriteUsecase {
  @override
  _i4.IFavoriteRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIFavoriteRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIFavoriteRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.IFavoriteRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> addFavorite(String? petId) =>
      (super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [petId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #addFavorite,
            [petId],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
                _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #addFavorite,
            [petId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> removeFavorite(String? petId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [petId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #removeFavorite,
            [petId],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
                _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #removeFavorite,
            [petId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i11.FavoriteEntity>>>
      getFavoritePets() => (super.noSuchMethod(
            Invocation.method(
              #getFavoritePets,
              [],
            ),
            returnValue: _i6.Future<
                    _i3.Either<_i7.Failure, List<_i11.FavoriteEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i11.FavoriteEntity>>(
              this,
              Invocation.method(
                #getFavoritePets,
                [],
              ),
            )),
            returnValueForMissingStub: _i6.Future<
                    _i3.Either<_i7.Failure, List<_i11.FavoriteEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i11.FavoriteEntity>>(
              this,
              Invocation.method(
                #getFavoritePets,
                [],
              ),
            )),
          ) as _i6.Future<_i3.Either<_i7.Failure, List<_i11.FavoriteEntity>>>);
}