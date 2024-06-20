import 'dart:convert';
import 'package:http/http.dart' as http;

class Name {
  final String first;
  final String last;

  const Name({
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(first: json['first'], last: json['last']);
  }
}

class User {
  final String email;
  final String
      location; // Mengubah tipe data dari String menjadi Map<String, dynamic>
  final Name name;

  const User({
    required this.email,
    required this.location,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      location: json['location']['street']
          ['name'], // Mengakses properti street dan name
      name: Name.fromJson(json['name']),
    );
  }
}

class UserService {
  Future<List<User>> getUsers() async {
    final url = Uri.parse("https://randomuser.me/api?results=20");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['results'] is List) {
          final List<User> userList = (data['results'] as List)
              .map((entry) => User.fromJson(entry))
              .toList();
          return userList;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }
}
