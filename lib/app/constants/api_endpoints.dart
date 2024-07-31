class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 500);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // static const String baseUrl = "http://10.0.2.2:5000/api/";
  //
  static const String baseUrl = "http://192.168.137.1:5000/api/";

  // ====================== Auth Routes ======================
  static const String loginUser = "user/login";
  static const String registerUser = "user/register";
  static const String verifyUser = "user/verify";
  static const String getMe = "user/getMe";
  static const String getToken = "user/getToken";
  static const String getAllUsers = "user/all";
  static const String getUserById = "user/get/";
  static const String googleLogin = "user/google";
  static const String getUserByGoogleEmail = "user/getGoogleUser";

  // Pet Routes
  static const String getAllPets = "pet/all";
  static const String getPetById = "pet/get/";
  static const String pagination = "pet/pagination";
  static const String getAllPetsByOwner = "pet/all/";
  static const String getAllSpecies = "pet/species";

  static const String petImage = "http://192.168.137.1:5000/pets/";

  // static const String petImage = "http://10.0.2.2:5000/pets/";

  // Adoption Routes
  static const String addAdoption = 'adoption/create';

  // favorite Routes
  static const String addFavorite = 'favorite/add';
  static const String getFavorite = 'favorite/get';
  static const String deleteFavorite = 'favorite/delete/';

  // Chat Routes
  static const String sendMessage = 'messages/send';
  static const String getMessages = 'messages/get/';
  static const String getMessageById = 'messages/get_by_id/';
  static const String sendFile = 'messages/send/file';
  static const String messageFileUrl =
      'http:// 192.168.137.1:5000/messages/files/';
  static const String messageImageUrl =
      'http:// 192.168.137.1:5000/messages/images/';
}
