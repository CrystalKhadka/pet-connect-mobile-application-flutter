import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInServiceProvider =
    Provider<GoogleSignInService>((ref) => GoogleSignInService());

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Access token and ID token
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      return {
        'accessToken': accessToken,
        'idToken': idToken,
        'user': googleUser,
      };
    } catch (error) {
      print('Google Sign-In error: $error');
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
  }
}
