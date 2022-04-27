class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String about;
  final String profileSrc;
  final String bearer;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.about = "",
    this.profileSrc = "",
    this.id = 0,
    this.bearer = ""
  });

  User.fromJson(Map<String, dynamic> json, {this.profileSrc = "assets/java.png", required String jwt})
      : name        = json["username" ],
        email       = json["email"    ],
        phoneNumber = json["phone"    ] ?? "",
        about       = json["about"    ] ?? "",
        id          = json["id"       ],
        bearer      = jwt;

  @override String toString() {
    return  "name=$name | "
        "email=$email | "
        "phone=$phoneNumber | "
        "about=$about | "
        "profileSrc=$profileSrc | ";
  }
}