import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<RegisterViewNavigator>(),
])
void main() {}
