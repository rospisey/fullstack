part of pisey_ui_kits;

class DatabaseModel {
  final String? category;
  final String? duration;
  final int? views;
  final String? imageURL;
  // final String thumbnailURL;
  final String? timestamp;
  final String? title;
  final String? youtubeID;
  final String? hash;
  final List? keyword;
  final List? keywordList;
  final String? id;

  DatabaseModel({
    this.hash,
    this.category,
    this.duration,
    this.views,
    this.imageURL,
    // this.thumbnailURL,
    this.timestamp,
    this.title,
    this.youtubeID,
    this.keyword,
    this.keywordList,
    this.id,
  });
  factory DatabaseModel.fromMap(Map<String, dynamic>? data, String docID) {
    final String category = data!['category'];
    final String duration = data['duration'];
    final int views = data['views'];
    final String imageURL = data['imageURL'];
    // final String thumbnailURL = data['thumbnailURL'];
    final String timestamp = data['timestamp'];
    final String title = data['title'];
    final String youtubeID = data['youtubeID'];
    final String hash = data['hash'];
    final List keyword = data['keyword'];
    final List keywordList = data['keywordList'];
    return DatabaseModel(
      id: docID,
      hash: hash,
      category: category,
      duration: duration,
      views: views,
      imageURL: imageURL,
      // thumbnailURL: thumbnailURL,
      timestamp: timestamp,
      title: title,
      youtubeID: youtubeID,
      keyword: keyword,
      keywordList: keywordList,
    );
  }
}

// final databaseReference = Firestore.instance;

void addTestFirebase() async {
  try {
    // // await databaseReference.collection("test").add({
    // //   'imageURL': 'hash',
    // //   'category': 'category',
    // //   'grade': 'grade',
    // //   'youtubeURL': 'youtubeURL',
    // //   'youtubeID': 'youtubeID',
    // //   'title': 'title',
    // //   'duration': 'duration',
    // //   'timestamp': 'timestamp',
    // //   'keyword': 'keyword',
    // //   'hash': 'hash',
    // //   'thumbnailURL': 'thumbnailURL',
    // // });
    // databaseTestList.map((e) async {
    //   await databaseReference.collection("test").document(e['grade']).setData({
    //     'imageURL': e['imageURL'],
    //     'category': e['category'],
    //     'grade': e['grade'],
    //     'youtubeURL': e['youtubeURL'],
    //     'youtubeID': e['youtubeID'],
    //     'title': e['title'],
    //     'duration': e['duration'],
    //     'timestamp': e['timestamp'],
    //     'keyword': e['keyword'],
    //     'hash': e['hash'],
    //     'thumbnailURL': e['thumbnailURL'],
    //   });
    // }).toList();
  } catch (e) {
    print('error $e');
  }
}

List<Map<String, dynamic>> databaseTestList = [
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category1',
    'duration': '01:00',
    'grade': '1',
    'imageURL': 'https://picsum.photos/id/1/200/300',
    'thumbnailURL': 'https://picsum.photos/id/1/50/50',
    'timestamp': '20201609061210',
    'title': 'title1',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category2',
    'duration': '02:00',
    'grade': '2',
    'imageURL': 'https://picsum.photos/id/2/200/300',
    'thumbnailURL': 'https://picsum.photos/id/2/50/50',
    'timestamp': '20201609061210',
    'title': 'title2',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category3',
    'duration': '03:00',
    'grade': '3',
    'imageURL': 'https://picsum.photos/id/3/200/300',
    'thumbnailURL': 'https://picsum.photos/id/3/50/50',
    'timestamp': '20201609061210',
    'title': 'title3',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category4',
    'duration': '04:00',
    'grade': '4',
    'imageURL': 'https://picsum.photos/id/4/200/300',
    'thumbnailURL': 'https://picsum.photos/id/4/50/50',
    'timestamp': '20201609061210',
    'title': 'title4',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category5',
    'duration': '05:00',
    'grade': '5',
    'imageURL': 'https://picsum.photos/id/5/200/300',
    'thumbnailURL': 'https://picsum.photos/id/5/50/50',
    'timestamp': '20201609061210',
    'title': 'title5',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category6',
    'duration': '06:00',
    'grade': '6',
    'imageURL': 'https://picsum.photos/id/6/200/300',
    'thumbnailURL': 'https://picsum.photos/id/6/50/50',
    'timestamp': '20201609061210',
    'title': 'title6',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category7',
    'duration': '07:00',
    'grade': '7',
    'imageURL': 'https://picsum.photos/id/7/200/300',
    'thumbnailURL': 'https://picsum.photos/id/7/50/50',
    'timestamp': '20201609061210',
    'title': 'title7',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category8',
    'duration': '08:00',
    'grade': '8',
    'imageURL': 'https://picsum.photos/id/8/200/300',
    'thumbnailURL': 'https://picsum.photos/id/8/50/50',
    'timestamp': '20201609061210',
    'title': 'title8',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category9',
    'duration': '09:00',
    'grade': '9',
    'imageURL': 'https://picsum.photos/id/9/200/300',
    'thumbnailURL': 'https://picsum.photos/id/9/50/50',
    'timestamp': '20201609061210',
    'title': 'title9',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category10',
    'duration': '10:00',
    'grade': '10',
    'imageURL': 'https://picsum.photos/id/10/200/300',
    'thumbnailURL': 'https://picsum.photos/id/10/50/50',
    'timestamp': '20201609061210',
    'title': 'title10',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category11',
    'duration': '11:00',
    'grade': '11',
    'imageURL': 'https://picsum.photos/id/11/200/300',
    'thumbnailURL': 'https://picsum.photos/id/11/50/50',
    'timestamp': '20201609061210',
    'title': 'title11',
    'youtubeID': 'youtube.com',
    'keyword': [],
  },
  {
    'hash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'category': 'category12',
    'duration': '12:00',
    'grade': '12',
    'imageURL': 'https://picsum.photos/id/12/200/300',
    'thumbnailURL': 'https://picsum.photos/id/12/50/50',
    'timestamp': '20201609061210',
    'title': 'title12',
    'youtubeID': 'youtube.com',
    'keyword': [],
  }
];
