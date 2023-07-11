import 'package:flutter/material.dart';

class KanbanColumn {
  String id;
  String header;
  List<Widget> items;

  KanbanColumn({
    required this.id,
    required this.header,
    required this.items,
  });
}

Draggable<String> _kanbanItem({
  required String columnId,
  Widget? itemFeedback,
  required Widget child,
}) {
  return Draggable<String>(
    data: columnId,
    feedback: itemFeedback ?? child,
    child: child,
  );
}

class Kanban extends StatefulWidget {
  const Kanban({super.key});

  @override
  State<Kanban> createState() => _KanbanState();
}

class _KanbanState extends State<Kanban> {
  final List<KanbanColumn> data = [
    KanbanColumn(
      id: "requested",
      header: "Solicitado",
      items: [
        _kanbanItem(columnId: "requested", child: const Text("hehe")),
        _kanbanItem(columnId: "requested", child: const Text("hihi")),
      ],
    ),
    KanbanColumn(
      id: "approved",
      header: "Aprovado",
      items: [
        _kanbanItem(columnId: "approved", child: const Text("haha")),
        _kanbanItem(columnId: "approved", child: const Text("hoho")),
      ],
    ),
    KanbanColumn(
      id: "rejected",
      header: "Rejeitado",
      items: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          ...data.map((kanbanColumn) {
            return SizedBox(
              width: 200,
              child: Column(
                children: [
                  _kanbanHeader(title: kanbanColumn.header),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      color: Colors.black12.withOpacity(.05),
                      child: _kanbanItems(
                        items: kanbanColumn.items,
                      ),
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _kanbanHeader({
    required String title,
    Color? color = Colors.white,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    ShapeBorder? shape,
    double height = 50,
    Widget? content,
  }) =>
      Card(
        color: color,
        surfaceTintColor: surfaceTintColor ?? Colors.white,
        shadowColor: shadowColor ?? Colors.black54,
        shape: shape,
        elevation: elevation ?? 2,
        child: Container(
          height: height,
          padding: const EdgeInsets.all(10),
          child: content ?? Center(child: Text(title)),
        ),
      );

  Widget _kanbanItems({
    List<Widget>? items,
  }) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        if (accepted.isEmpty) return Column(children: [...items!]);
        return Column(children: [...accepted.map((e) => Text(e))]);
      },
      onWillAccept: (data) {
        return data != null;
      },
      onAccept: (data) {},
    );
  }
}

// class Item {
//   final String id;
//   String? listId;
//   final String title;
//   String status;

//   Item(
//       {required this.id,
//       this.listId,
//       required this.title,
//       required this.status});
// }

// class Kanban extends StatefulWidget {
//   final double tileHeight = 100;
//   final double headerHeight = 80;
//   final double tileWidth = 300;

//   const Kanban({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _KanbanState createState() => _KanbanState();
// }

// class _KanbanState extends State<Kanban> {
//   late Map<String, List<Item>> board;

//   @override
//   void initState() {
//     board = {};
//     board.addAll({
//       '1': [
//         Item(id: '1', listId: '1', title: 'Pera', status: 'SOLICITADO'),
//         Item(id: '2', listId: '1', title: 'Papa', status: 'SOLICITADO'),
//       ],
//       '2': [
//         Item(id: '3', listId: '2', title: 'Auto', status: 'APROVADO'),
//         Item(id: '4', listId: '2', title: 'Bicicleta', status: 'APROVADO'),
//         Item(id: '5', listId: '2', title: 'Bla bla', status: 'APROVADO'),
//       ],
//       '3': [
//         Item(id: '6', listId: '3', title: 'Chile', status: 'REJEITADO'),
//         Item(id: '7', listId: '3', title: 'Madagascar', status: 'REJEITADO'),
//         Item(id: '8', listId: '3', title: 'Japón', status: 'REJEITADO'),
//       ]
//     });

//     super.initState();
//   }

//   DragTarget<Item> buildItemDragTarget(
//       String listId, int targetPosition, double height) {
//     return DragTarget<Item>(
//       onWillAccept: (data) {
//         return board[listId]!.isEmpty ||
//             data!.id != board[listId]![targetPosition].id;
//       },
//       onAccept: (Item data) {
//         setState(() {
//           board[data.listId]?.remove(data);
//           data.listId = listId;
//           data.status = listId == '1'
//               ? 'SOLICITADO'
//               : listId == '2'
//                   ? 'APROVADO'
//                   : listId == '3'
//                       ? 'REJEITADO'
//                       : '';
//           if (board[listId]!.length > targetPosition) {
//             board[listId]?.insert(targetPosition, data);
//           } else {
//             board[listId]?.add(data);
//           }
//         });
//       },
//       builder: (context, data, rejectedData) {
//         if (data.isEmpty) {
//           return Container(
//             height: height,
//             // color: Colors.red,
//           );
//         } else {
//           return Column(
//             children: [
//               Container(
//                 height: height,
//               ),
//               ...data.map(
//                 (e) {
//                   return Opacity(
//                     opacity: 0.5,
//                     child: ItemWidget(item: e!),
//                   );
//                 },
//               ).toList()
//             ],
//           );
//         }
//       },
//     );
//   }

//   Stack buildHeader(String listId) {
//     final Widget header = SizedBox(
//       height: widget.headerHeight,
//       child: HeaderWidget(
//         title: listId == '1'
//             ? 'SOLICITADO'
//             : listId == '2'
//                 ? 'APROVADO'
//                 : listId == '3'
//                     ? 'REJEITADO'
//                     : '',
//       ),
//     );

//     return Stack(
//       // The header
//       children: [
//         Draggable<String>(
//           data: listId,
//           childWhenDragging: Opacity(
//             opacity: 0.2,
//             child: header,
//           ),
//           feedback: SizedBox(
//             width: widget.tileWidth,
//             child: header,
//           ),
//           child: header,
//         ),
//         buildItemDragTarget(listId, 0, widget.headerHeight),
//         DragTarget<String>(
//           onWillAccept: (data) {
//             return listId != data;
//           },
//           onAccept: (String incomingListId) {
//             setState(
//               () {
//                 final Map<String, List<Item>> reorderedBoard = {};
//                 for (String key in board.keys) {
//                   if (key == incomingListId) {
//                     reorderedBoard[listId] = board[listId]!;
//                   } else if (key == listId) {
//                     reorderedBoard[incomingListId] = board[incomingListId]!;
//                   } else {
//                     reorderedBoard[key] = board[key]!;
//                   }
//                 }
//                 board = reorderedBoard;
//               },
//             );
//           },
//           builder: (context, data, rejectedData) {
//             if (data.isEmpty) {
//               return SizedBox(
//                 height: widget.headerHeight,
//                 width: widget.tileWidth,
//               );
//             } else {
//               return Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 3,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 height: widget.headerHeight,
//                 width: widget.tileWidth,
//               );
//             }
//           },
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SingleChildScrollView buildKanbanList(String listId, List<Item> items) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             buildHeader(listId),
//             ListView.builder(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               itemCount: items.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Stack(
//                   children: [
//                     Draggable<Item>(
//                       data: items[index],
//                       childWhenDragging: Opacity(
//                         opacity: 0.2,
//                         child: ItemWidget(item: items[index]),
//                       ),
//                       feedback: SizedBox(
//                         height: widget.tileHeight,
//                         width: widget.tileWidth,
//                         child: ItemWidget(
//                           item: items[index],
//                         ),
//                       ),
//                       child: ItemWidget(
//                         item: items[index],
//                       ),
//                     ),
//                     buildItemDragTarget(listId, index, widget.tileHeight),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SizedBox(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: board.keys.map((String key) {
//                 return Expanded(
//                   child: buildKanbanList(key, board[key]!),
//                 );
//               }).toList(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class HeaderWidget extends StatelessWidget {
//   final String title;

//   const HeaderWidget({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         dense: true,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 10.0,
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         onTap: () {},
//       ),
//     );
//   }
// }

// class ItemWidget extends StatelessWidget {
//   final Item item;

//   const ItemWidget({Key? key, required this.item}) : super(key: key);
//   ListTile makeListTile(Item item) => ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 10.0,
//         ),
//         title: Text(
//           item.title,
//           style: const TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         subtitle: Text('STATUS: ${item.status}'),
//         onTap: () {},
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8.0,
//       margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//       child: Container(
//         decoration: const BoxDecoration(),
//         child: makeListTile(item),
//       ),
//     );
//   }
// }
