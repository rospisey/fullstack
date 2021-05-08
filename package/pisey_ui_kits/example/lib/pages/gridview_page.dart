// import 'package:flutter/material.dart';
// import 'package:myuikits/ui/widgets/grid_view.dart';
// import 'package:myuikits/ui/widgets/list_tile.dart';
// import 'package:myuikits/ui/widgets/tab_model.dart';

// class GridViewPage extends StatelessWidget {
//   final List<MyModel> list = [
//     MyModel(
//       text: 'GridView',
//     ),
//     MyModel(text: 'GridView.builder'),
//     MyModel(text: 'GridView.Separate'),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MyGridView(
//         count: 1,
//         children: list
//             .map((e) => MyListTileWithTextUsedWithGridView(
//                   text: e.text,
//                   onTap: () {
//                     print('hello');
//                   },
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
