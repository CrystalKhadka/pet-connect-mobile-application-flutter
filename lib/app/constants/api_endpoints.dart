class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 50);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";
  // static const String baseUrl = "http://192.168.18.7:5000/api/";

  // ====================== Auth Routes ======================
  static const String loginUser = "user/login";
  static const String registerUser = "user/register";

  // Pet Routes
  static const String getAllPets = "pet/all";
  static const String getPetById = "pet/get/";
  static const String pagination = "pet/pagination";
  static const String getAllPetsByOwner = "pet/all/";
  static const String getAllSpecies = "pet/species";
  static const String petImage = "http://10.0.2.2:5000/pets/";
}
