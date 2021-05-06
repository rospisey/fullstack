part of pisey_ui_kits;

class MyListView extends StatelessWidget {
  final List<Widget>? list;

  const MyListView({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list!.map((e) => e).toList(),
    );
  }
}

class MyListViewBuilder extends StatelessWidget {
  final List<Widget>? list;

  const MyListViewBuilder({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return list![index];
      },
    );
  }
}

class MyListViewSeparate extends StatelessWidget {
  final List<Widget>? list;

  const MyListViewSeparate({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 0,
        );
      },
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return list![index];
      },
    );
  }
}
