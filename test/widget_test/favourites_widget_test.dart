import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:final_assignment/features/favorite/presentation/view/favorite_view.dart';
import 'package:final_assignment/features/favorite/presentation/viewmodel/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/favorite_user_data/favorite_user_data.dart';
import '../unit_test/pet_test.mocks.dart';

class MockFavoriteViewModel extends Mock implements FavoriteViewModel {}

@GenerateNiceMocks([MockSpec<FavoriteUsecase>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FavoriteUsecase mockFavoriteUsecase;

  late List<FavoriteEntity> favorites;

  setUp(() {
    // Mock the favorite usecase
    favorites = FavoriteUserTestData.getFavoriteTestData();
    mockFavoriteUsecase = MockFavoriteUsecase();
  });

  testWidgets('shows empty state when there are no favorites',
      (WidgetTester tester) async {
    // arrange
    when(mockFavoriteUsecase.getFavoritePets())
        .thenAnswer((_) async => const Right([]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoriteViewModelProvider.overrideWith(
            (ref) => FavoriteViewModel(favoriteUsecase: mockFavoriteUsecase),
          ),
        ],
        child: const MaterialApp(
          home: FavoriteView(),
        ),
      ),
    );

    // run init
    await tester.pumpAndSettle();

    expect(find.text('You haven\'t added any pets to your favorites yet.'),
        findsOneWidget);
    expect(find.text('Start exploring and heart the pets you love!'),
        findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('shows list of favorite pets when they are available',
      (WidgetTester tester) async {
    // arrange
    when(mockFavoriteUsecase.getFavoritePets())
        .thenAnswer((_) async => Right(favorites));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoriteViewModelProvider.overrideWith(
            (ref) => FavoriteViewModel(favoriteUsecase: mockFavoriteUsecase),
          ),
        ],
        child: const MaterialApp(
          home: FavoriteView(),
        ),
      ),
    );

    // run init
    await tester.pumpAndSettle();

    expect(find.text('Doggy'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
