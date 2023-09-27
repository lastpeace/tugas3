import 'package:flutter/material.dart';
import 'package:tugas3/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  //ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //ignore prefer_typing_uninitialized_variables
  var namauser;

  void _saveUsername() async {
    //Inisialisasi Share Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Simpan Username ke local storage
    prefs.setString('username', _usernameController.text);
  }

  _showInput(namacontroller, placeholder, isPassword, String icon) {
    IconData iconUsed = icon == 'person' ? Icons.person : Icons.password;
    return TextField(
      controller: namacontroller,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintText: placeholder,
          prefixIcon: Icon(iconUsed),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(6),
          ))),
    );
  }

  _showDialog(pesan, alamat) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(pesan),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => alamat,
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showInput(_usernameController, 'Username', false, "person"),
            _showInput(_passwordController, 'Password', true, "password"),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_usernameController.text == 'ammar' &&
                    _passwordController.text == 'ammar') {
                  //save Username
                  _saveUsername();
                  //Show alert
                  _showDialog('Anda Berhasil Login', const HomePage());
                } else {
                  //Show Alert
                  _showDialog('Username dan Password Salah', const LoginPage());
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.fromLTRB(6, 20, 6, 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
