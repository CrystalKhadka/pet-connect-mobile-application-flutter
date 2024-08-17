import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:final_assignment/features/favorite/presentation/navigator/favorite_navigator.dart';
import 'package:final_assignment/features/favorite/presentation/viewmodel/favorite_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_test.mocks.dart';
import 'favorite_user_data/favorite_user_data.dart';

@GenerateNiceMocks(
    [MockSpec<FavoriteUsecase>(), MockSpec<FavoriteViewNavigator>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FavoriteUsecase mockFavoriteUsecase;
  late FavoriteViewNavigator mockFavoriteViewNavigator;
  late ProviderContainer container;

  late List<FavoriteEntity> favorites;

  setUp(() {
    mockFavoriteUsecase = MockFavoriteUsecase();
    mockFavoriteViewNavigator = MockFavoriteViewNavigator();

    favorites = FavoriteUserTestData.getFavoriteTestData();
    container = ProviderContainer(
      overrides: [
        favoriteViewModelProvider.overrideWith(
          (ref) => FavoriteViewModel(favoriteUsecase: mockFavoriteUsecase),
        ),
      ],
    );
  });

  test(("get favorites test"), () async {
    // arrange
    when(mockFavoriteUsecase.getFavoritePets())
        .thenAnswer((_) async => Right(favorites));

    // act
    await container
        .read(favoriteViewModelProvider.notifier)
        .fetchFavoritePets();

    final viewModel = container.read(favoriteViewModelProvider);

    // assert
    expect(viewModel.favorites, equals(favorites));
  });

  tearDown(() {
    container.dispose();
  });
}
