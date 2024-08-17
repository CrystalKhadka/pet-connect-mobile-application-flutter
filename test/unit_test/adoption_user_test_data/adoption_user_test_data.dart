import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class AdoptionUserTestData {
  AdoptionUserTestData._();

  static List<AdoptionEntity> getAdoptionTestData() => [
        const AdoptionEntity(
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
          formSender: AuthEntity(
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
          formReceiver: AuthEntity(
            firstName: 'Crystal',
            id: '6683b1f7f523f9afbd2d8fer',
            lastName: 'Khadka',
            email: 'khadkacrystal@gmail.com',
            password: '',
            phone: '9843041037',
            address: 'KTM',
            gender: 'Male',
            birthDate: '2004-05-11',
          ),
          form: FormEntity(
              fullName: "Crystal Khadka",
              email: "khadkacrystal@gmai.com",
              phone: "9843041037",
              age: 18,
              gender: "male",
              houseType: "house",
              reason: "for fun",
              yard: "yes",
              petExperience: "some"),
          id: "66c011722ff44bbc31c9a4dd",
        ),
      ];
}
