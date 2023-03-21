import 'package:flutter/material.dart';

import 'database.dart';
import 'film_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite database of Films',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Films'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DataBase database;

  Future<int> addFilms() async {
    Film film1 = Film(
        id: 1,
        title: 'Apocalypse Now',
        director: 'Francis Ford Coppola',
        releaseYear: 1979);
    Film film2 =
        Film(id: 2, title: 'Heat', director: 'Michael Mann', releaseYear: 1995);
    Film film3 = Film(
        id: 3,
        title: 'The Martian',
        director: 'Ridley Scott',
        releaseYear: 2015);
    Film film4 = Film(
        id: 4, title: 'Man on Fire', director: 'Tony Scott', releaseYear: 2004);
    Film film5 = Film(
        id: 4, title: 'Man on Fire', director: 'Tony Scott', releaseYear: 2004);

    List<Film> films = [film1, film2, film3, film4];
    return await database.addFilms(films);
  }

  @override
  void initState() {
    super.initState();
    database = DataBase();
    database.initializeDB().whenComplete(() async {
      await addFilms();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: database.getAllFilms(),
          builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                            title: Text(snapshot.data![index].title),
                            subtitle: Text(snapshot.data![index].director),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(right: 32),
                            child: Text(snapshot.data![index].releaseYear.toString())),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
