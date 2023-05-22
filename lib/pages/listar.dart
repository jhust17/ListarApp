import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pagel extends StatefulWidget {
  const Pagel({super.key});

  @override
  State<Pagel> createState() => _PagelState();
}

class _PagelState extends State<Pagel> {
  late Future<List<Usuario>> _listadosApi;

  Future<List<Usuario>> _getApi() async {
    var url = Uri.parse('https://gorest.co.in/public/v2/users?page=1');
    List<Usuario> users = [];
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var body = utf8.decode(response.bodyBytes);
      final data = jsonDecode(body);
      for (var item in data) {
        users.add(Usuario(item["id"], item["name"], item["email"],
            item["gender"], item["status"]));
      }
      return users;
    } else {
      throw Exception("Error peticion");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listadosApi = _getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Listas")),
        body: FutureBuilder(
          future: _listadosApi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Usuario> datalist = snapshot.data ?? List.empty();
              return ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print(datalist[index].id);
                      },
                      title: Text(datalist[index].name),
                      subtitle: Text(datalist[index].status),
                      leading: CircleAvatar(
                        child: Icon(datalist[index].gender == "male"
                            ? Icons.man_outlined
                            : Icons.woman_outlined),
                      ),
                      trailing: Icon(Icons.lens,
                          color: datalist[index].status == "active"
                              ? Colors.green
                              : Colors.red),
                    );
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class Usuario {
  int id = 0;
  String name = "";
  String email = "";
  String gender = "";
  String status = "";
  Usuario(id, name, email, gender, status) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.gender = gender;
    this.status = status;
  }
}
