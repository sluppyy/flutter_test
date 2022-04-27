const server = "http://10.0.2.2:1337";
Map<String, String> authHeader({required String bearer}) => {
  "Authorization": "Bearer $bearer"
};