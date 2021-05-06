part of pisey_ui_kits;

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            'Featured',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: PageView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            controller: PageController(initialPage: 0),
            onPageChanged: (index) {
              setState(() {
                dotIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'featured$index',
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 10),
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(MyTextString.url)),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 10,
                                  offset: Offset(3, 3))
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 30,
                      right: 15,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 6, bottom: 6),
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Colors.deepPurpleAccent.withOpacity(0.7)),
                            child: Text(
                              'Politics',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Spacer(),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 6, bottom: 6),
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black45),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // BaseStream<List<LoveData>>(
                                  //     create: (context) =>
                                  //         database.streamLovesData(
                                  //             nb[index].docID),
                                  //     builder:
                                  //         (context, list, child) {
                                  //       if (list == null ||
                                  //           list.length == null) {
                                  //         return Container();
                                  //       } else {
                                  //         return Text(
                                  //           '${list.length}',
                                  //           style: TextStyle(
                                  //               color:
                                  //                   Colors.white),
                                  //         );
                                  //       }
                                  //     })
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))),
                          child: Column(
                            children: <Widget>[
                              Text(
                                MyTextString.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.timer,
                                      size: 16, color: Colors.white),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('04 June 2020',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                onTap: () {},
              );
            },
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: DotsIndicator(
              dotsCount: 5,
              position: dotIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.black26,
                activeColor: Colors.black,
                spacing: EdgeInsets.only(left: 6),
                size: const Size.square(7.0),
                activeSize: const Size(25.0, 5.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            )),
      ],
    );
  }
}
