// class DriverProfile {
//   final int id;
//   final String name;
//   final String email;
//   final String route;
//   final String avatarUrl; // bisa kosong atau default

//   DriverProfile({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.route,
//     this.avatarUrl = '',
//   });

//   factory DriverProfile.fromJson(Map<String, dynamic> json) {
//     return DriverProfile(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       route: json['noAngkot'] as String,
//       avatarUrl: json['avatarUrl'] as String? ?? '',
//     );
//   }
// }
