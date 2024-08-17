import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/usecases/adoption_usecase.dart';
import 'package:final_assignment/features/my_pets/presentation/navigator/my_pets_navigator.dart';
import 'package:final_assignment/features/my_pets/presentation/view/my_pets_view.dart';
import 'package:final_assignment/features/my_pets/presentation/viewmodel/my_pets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/adoption_user_test_data/adoption_user_test_data.dart';
import 'my_pets_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdoptionUsecase>()])
void main() {
  late AdoptionUsecase mockAdoptionUsecase;
  late MyPetsViewNavigator navigator;
  late List<AdoptionEntity> adoptions;
  setUp(() {
    // Mock the navigator
    mockAdoptionUsecase = MockAdoptionUsecase();
    navigator = MyPetsViewNavigator();
    adoptions = AdoptionUserTestData.getAdoptionTestData();
  });

  testWidgets('shows empty state when there are no adoptions',
      (WidgetTester tester) async {
    when(mockAdoptionUsecase.getAdoptionsByUser())
        .thenAnswer((_) async => const Right([]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myPetsViewModelProvider.overrideWith((ref) => MyPetsViewModel(
              adoptionUsecase: mockAdoptionUsecase, navigator: navigator)),
        ],
        child: const MaterialApp(
          home: MyPetsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('You haven\'t adopted any pets yet.'), findsOneWidget);
  });

  testWidgets('shows list of adopted pets when they are available',
      (WidgetTester tester) async {
    when(mockAdoptionUsecase.getAdoptionsByUser())
        .thenAnswer((_) async => Right(adoptions));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myPetsViewModelProvider.overrideWith((ref) => MyPetsViewModel(
              adoptionUsecase: mockAdoptionUsecase, navigator: navigator)),
        ],
        child: const MaterialApp(
          home: MyPetsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MyPetCard), findsNWidgets(1));
  });

  
}
