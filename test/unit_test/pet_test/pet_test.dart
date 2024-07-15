import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/navigator/pet_view_navigator.dart';
import 'package:final_assignment/features/pet/presentation/viewmodel/pet_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pet_test.mocks.dart';
import 'pet_test_data/pet_test_data.dart';

@GenerateNiceMocks([MockSpec<PetUseCase>(), MockSpec<PetViewNavigator>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PetUseCase mockPetUseCase;
  late ProviderContainer container;
  late PetViewNavigator mockPetViewNavigator;
  late List<PetEntity> pets;
  late List<String> species;

  setUp(() {
    mockPetUseCase = MockPetUseCase();
    mockPetViewNavigator = MockPetViewNavigator();
    pets = PetTestData.getPetTestData();
    species = PetTestData.getSpeciesTestData();
    container = ProviderContainer(overrides: [
      petViewModelProvider.overrideWith((ref) => PetViewModel(
          petUseCase: mockPetUseCase, petViewNavigator: mockPetViewNavigator)),
    ]);
  });

  test('get 6 pets in page 1', () async {
    // Arrange
    when(mockPetUseCase.pagination(1, 6)).thenAnswer((_) async => Right(pets));
    when(mockPetUseCase.getAllSpecies())
        .thenAnswer((_) async => Right(species));

    // Act
    await container.read(petViewModelProvider.notifier).fetchPets(6);

    final petState = container.read(petViewModelProvider);

    // Assert
    expect(petState.pets.length, 6);
    expect(petState.isLoading, false);
    expect(petState.error, null);
    expect(petState.species.length, 3);
  });

  test('get 3 species', () async {
    // Arrange
    when(mockPetUseCase.getAllSpecies())
        .thenAnswer((_) async => Right(species));

    when(mockPetUseCase.pagination(1, 6)).thenAnswer((_) async => Right(pets));

    // Act
    await container.read(petViewModelProvider.notifier).fetchSpecies();

    final petState = container.read(petViewModelProvider);

    // Assert
    expect(petState.species.length, 3);
  });

  // reset state
  test('reset state test', () async {
    // Arrange
    when(mockPetUseCase.pagination(1, 6)).thenAnswer((_) async => Right(pets));
    when(mockPetUseCase.getAllSpecies())
        .thenAnswer((_) async => Right(species));

    // Act
    await container.read(petViewModelProvider.notifier).resetState();

    final petState = container.read(petViewModelProvider);

    // Assert
    expect(petState.pets.length, 6);
    expect(petState.isLoading, false);
    expect(petState.error, null);
    expect(petState.species.length, 3);
  });

  tearDown(() {
    container.dispose();
  });
}
