import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class FavoriteUserTestData {
  FavoriteUserTestData._();

  static List<FavoriteEntity> getFavoriteTestData() => [
        const FavoriteEntity(
          pet: PetEntity(
              id: "667fa5a23dcd1df4d96dd18e",
              petName: "Doggy",
              petSpecies: "dog",
              petBreed: "german shepherd",
              petAge: 3,
              petWeight: 22,
              petColor: 'brown',
              petDescription: 'This is test',
              petStatus: 'available',
              createdAt: '2024-06-29T05:42:55.826Z',
              createdBy: null),
          user: AuthEntity(
            firstName: 'Crystal',
            id: '6683b1f7f523f9afbd2d8fe0',
            lastName: 'Khadka',
            email: 'khadkacrystal@gmail.com',
            password: '',
            phone: '9843041037',
            address: 'KTM',
            gender: 'Male',
            birthDate: '2004-05-11',
          ),
          id: "66c011722ff44bbc31c9a43c",
        ),
      ];
}
