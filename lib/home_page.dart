import 'package:flutter/material.dart';
import 'package:jajal_app/user_page.dart';
import 'package:jajal_app/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengguna')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 154, 240, 5), // Warna awal (top)
              Color.fromARGB(255, 40, 188, 230), // Warna akhir (bottom)
            ],
          ),
        ),
        child: Center(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: ((context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    User user = snapshot.data![index];
                    return ListTile(
                      title: Text('${user.name.first} ${user.name.last}'),
                      subtitle: Text(user.email),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: (() => openPage(context, user)),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }

  void openPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserPage(user: user)),
    );
  }
}
