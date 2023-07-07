import 'package:flutter_modular/flutter_modular.dart';
import 'package:kanban/app/modules/home/home_store.dart';
import 'package:kanban/app/modules/home/kanban_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Kanbanb'}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Kanban(),
    );
  }
}
