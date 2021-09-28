import 'package:allkhmerbookadmin/page/bloc/firebase/stream_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamUserList>.reactive(
        disposeViewModel: false,
        builder: (context, user, userchild) {
          if (user.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (user.data!.docs.length == 0) {
              return Center(
                child: Text('No data'),
              );
            } else {
              return ListView(children: [
                Text(
                  'Total Users: ${user.data!.docs.length}',
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                ...user.data!.docs
                    .map((e) => ListTile(
                        title: Text('${e['username']}•${e['lastSeenInEpoch']}'),
                        subtitle: Text('${e.id}'),
                        trailing: CircleAvatar(
                          radius: 5,
                          backgroundColor:
                              (e['presence']) ? Colors.green : Colors.grey,
                        )))
                    .toList(),
              ]);
            }
          }
        },
        viewModelBuilder: () => StreamUserList());
  }
}
