import 'package:kanban/app/modules/home/home_page.dart';
import 'package:kanban/app/modules/home/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => HomeStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => const HomePage()),];

}