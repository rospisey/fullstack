import 'package:allkhmerbookadmin/new/navigator/route_page_manager.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details $id'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$id',
              style: Theme.of(context).textTheme.headline3,
            ),
            // Gap(20),
            OutlineButton(
              child: Text('Open Details'),
              onPressed: () {
                RoutePageManager.of(context).openDetails();
              },
            ),
            // Gap(20),
            OutlineButton(
              child: Text('Reset to home'),
              onPressed: () {
                RoutePageManager.of(context).resetToHome();
              },
            ),
            OutlineButton(
              child: Text('Go to Admin'),
              onPressed: () {
                RoutePageManager.of(context).goToAdmin();
              },
            ),
            // Gap(20),
            OutlineButton(
              child: Text('Add new Details below'),
              onPressed: () {
                RoutePageManager.of(context).addDetailsBelow();
              },
            ),
          ],
        ),
      ),
    );
  }
}
