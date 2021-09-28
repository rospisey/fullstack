import 'package:allkhmerbookadmin/page/bloc/firebase/content_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamBookList>.reactive(
        disposeViewModel: false,
        builder: (context, books, bookschild) {
          if (books.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (books.data!.docs.length == 0) {
              return Center(
                child: Text('No data'),
              );
            } else {
              return ListView(
                children: books.data!.docs
                    .map((e) => ListTile(
                        // leading: e['image_Url_0'] == null
                        //     ? Container()
                        //     : Image.network(
                        //         '${e['image_Url_0']}',
                        //         fit: BoxFit.contain,
                        //       ),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.delete_rounded)),
                        title: Text('សៀវភៅ${e['bookSubject']}${e['grade']}'),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Chip(
                              label: e['bookType'] == null
                                  ? Text('bookType')
                                  : Text('${e['bookType']}')),
                        )))
                    .toList(),
              );
            }
          }
        },
        viewModelBuilder: () => StreamBookList());
  }
}
