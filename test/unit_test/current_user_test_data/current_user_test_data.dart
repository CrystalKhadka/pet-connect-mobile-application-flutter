import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class CurrentUserTestData {
  CurrentUserTestData._();

  static AuthEntity getAuthEntity() => const AuthEntity(
        firstName: 'Crystal',
        id: '6683b1f7f523f9afbd2d8fe0',
        lastName: 'Khadka',
        email: 'khadkacrystal@gmail.com',
        password: '',
        phone: '9843041037',
        address: 'KTM',
        gender: 'Male',
        birthDate: '2004-05-11',
      );
}
