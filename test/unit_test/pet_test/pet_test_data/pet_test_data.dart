import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PetTestData {
  PetTestData._();

  static List<PetEntity> getPetTestData() {
    List<PetEntity> lstPets = [
      const PetEntity(
          id: "667fa5a23dcd1df4d96dd18e",
          petName: "Doggy",
          petSpecies: "dog",
          petBreed: "german shepherd",
          petAge: 3,
          petWeight: 22,
          petColor: 'brown',
          petDescription: 'This is test',
          petImage: '1719641506302-german.jpg',
          petStatus: 'available',
          createdAt: '2024-06-29T05:42:55.826Z',
          createdBy: '6683b1f7f523f9afbd2d8fe0'),
      const PetEntity(
        id: "667fa6453dcd1df4d96dd19a",
        petName: "kitty",
        petSpecies: "cat",
        petBreed: "Himalyan",
        petAge: 3,
        petWeight: 2,
        petColor: "brown",
        petDescription:
            "This is a himalyan cat with weight 2kg and age of 3 months",
        petImage: "1719641669631-himalyan.jpg",
        petStatus: "available",
        createdAt: "2024-06-29T05:42:55.826Z",
        createdBy: "6683b1f7f523f9afbd2d8fe0",
      ),
      const PetEntity(
        id: "667fa64d3dcd1df4d96dd19c",
        petName: "Doggy2",
        petSpecies: "dog",
        petBreed: "german shepherd",
        petAge: 3,
        petWeight: 22,
        petColor: "brown",
        petDescription: "This is test",
        petImage: "1719641677473-german.jpg",
        petStatus: "available",
        createdAt: "2024-06-29T05:42:55.826Z",
        createdBy: "6683b1f7f523f9afbd2d8fe0",
      ),
      const PetEntity(
        id: "6683b1f7f523f9afbd2d8fe0",
        petName: "Jasper",
        petSpecies: "dog",
        petBreed: "golden retreiver",
        petAge: 2,
        petWeight: 22,
        petColor: "brown",
        petDescription: "This is test",
        petImage: "1719641732792-golden.jpg",
        petStatus: "available",
        createdAt: "2024-06-29T05:42:55.826Z",
        createdBy: "6683b1f7f523f9afbd2d8fe0",
      ),
      const PetEntity(
        id: "667fa6a33dcd1df4d96dd1a3",
        petName: "pitty",
        petSpecies: "dog",
        petBreed: "pitbull",
        petAge: 2,
        petWeight: 20,
        petColor: "brown",
        petDescription: "This is pitbull",
        petImage: "1719641763841-pitbull.jpg",
        petStatus: "available",
        createdAt: "2024-06-29T05:42:55.826Z",
        createdBy: "6683b1f7f523f9afbd2d8fe0",
      ),
      const PetEntity(
        id: "667fa82f3dcd1df4d96dd1b1",
        petName: "kitty cat",
        petSpecies: "cat",
        petBreed: "Himalyan",
        petAge: 3,
        petWeight: 2,
        petColor: "brown",
        petDescription:
            "This is a himalyan cat with weight 2kg and age of 3 months",
        petImage: "1719642159945-himalyan.jpg",
        petStatus: "available",
        createdAt: "2024-06-29T05:42:55.826Z",
        createdBy: "6683b1f7f523f9afbd2d8fe0",
      )
    ];
    print(lstPets.length);

    return lstPets;
  }

  static List<String> getSpeciesTestData() {
    List<String> lstSpecies = ["dog", "cat", "bird"];
    return lstSpecies;
  }
}
