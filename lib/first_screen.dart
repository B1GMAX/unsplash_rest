import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo/bloc.dart';
import 'package:photo/second_screen.dart';
import 'package:provider/provider.dart';

import 'photo.dart';

class FirstScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Provider<Bloc>(
      create: (context) => Bloc()..loadData(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Gallery',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          body: Center(
            child: StreamBuilder<List<Photo>>(
              initialData: [],
              stream: context.read<Bloc>().stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen(
                                    url: snapshot.data![index].urlFull,
                                    description:
                                        snapshot.data![index].altDescription,
                                  ))),
                      leading: Image.network(
                        snapshot.data![index].url,
                        width: 80.0,
                        height: 80.0,
                      ),
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].altDescription),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
