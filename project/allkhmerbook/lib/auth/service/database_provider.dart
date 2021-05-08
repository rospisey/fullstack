import 'package:allkhmerbook/auth/model/user.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<List<UserModel>> streamUser();
  // Stream<List<NewsData>> streamNewsData();
  //  Future<void> setNewsData(NewsData news);
  //  Future<void> deleteNewsData(NewsData news);
  //  Future<void> setCommentsData(CommentsData comment,String newsID);
  //  Stream<List<CommentsData>> streamCommentsData(String newsID);
  //  Future<void> setBookmarkData(BookmarkData news,String uid);
  //  Stream<List<BookmarkData>> streamBookmarkData(String docUserID);
  //  Future<void> deleteBookmarkData(String docBmID,String uid) ;
  //  Stream<List<LoveData>> streamLovesData(String newsID);
  //  Future<void> setLovesData(LoveData love,String newsID);
  //  Future<void> deleteLovesData(String docloveID,String newsID);
  //  Future<void> updateNewsData(NewsData news);
  //  Stream<List<NotificationData>> streamNotificationsData(String uid);
  //  Future<void> setNotificationsData(NotificationData no,String uid);
  //  Future<void> deleteNotificationsData(String docNoID,String newsID);
}

String docIDFromCurrentTime() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  final instance = FirestoreService.instance;

  @override
  Stream<List<UserModel>> streamUser() {
    return instance.setStream(
        path: APIpath.getUsersPath(),
        builder: (data, docID) => UserModel.fromMapEN(data, docID));
  }

  // @override
  // Stream<List<NewsData>> streamNewsData() {
  //   return instance.setStream(
  //       path: APIpath.getNewsPath(),
  //       builder: (data, docID) => NewsData.fromMap(data, docID));
  // }

  // @override
  // Future<void> setNewsData(NewsData news) async {
  //   await instance.setData(APIpath.setNewsPath(docNewsID: news.docID), news.toMap());
  // }

  // @override
  // Future<void> deleteNewsData(NewsData news) async {
  //   await instance.deleteData(path: APIpath.setNewsPath(docNewsID: news.docID));
  // }

  // @override
  // Future<void> updateNewsData(NewsData news) async {
  //   await instance.updateData(APIpath.setNewsPath(docNewsID: news.docID), news.toMap());
  // }

  // @override
  // Stream<List<CommentsData>> streamCommentsData(String newsID) {
  //   return instance.setStream(
  //       path: APIpath.getCommentPath(newsID: newsID),
  //       builder: (data, docID) => CommentsData.fromMap(data, docID));
  // }

  // @override
  // Future<void> setCommentsData(CommentsData comment,String newsID) async {
  //   await instance.setData(APIpath.setCommentPath(docCmtID: comment.uid,newsID: newsID), comment.toMap());
  // }

  // @override
  // Stream<List<BookmarkData>> streamBookmarkData(String docUserID) {
  //   return instance.setStream(
  //       path: APIpath.getBookmarkPath(docUserID: docUserID),
  //       builder: (data, docID) => BookmarkData.fromMap(data, docID));
  // }

  // @override
  // Future<void> setBookmarkData(BookmarkData news,String uid) async {
  //   await instance.setData(APIpath.setBookmarkPath(docUserID: uid,docBmID: news.docID), news.toMap());
  // }

  // @override
  // Future<void> deleteBookmarkData(String docBmID,String uid) async {
  //   await instance.deleteData(path: APIpath.setBookmarkPath(docUserID: uid,docBmID: docBmID));
  // }

  // @override
  // Stream<List<LoveData>> streamLovesData(String newsID) {
  //   return instance.setStream(
  //       path: APIpath.getLovePath(newsID: newsID),
  //       builder: (data, docID) => LoveData.fromMap(data, docID));
  // }

  // @override
  // Future<void> setLovesData(LoveData love,String newsID) async {
  //   await instance.setData(APIpath.setLovePath(docLoveID: love.docID,newsID: newsID), love.toMap());
  // }

  // @override
  // Future<void> deleteLovesData(String docloveID,String newsID) async {
  //   await instance.deleteData(path: APIpath.setLovePath(docLoveID: docloveID,newsID: newsID));
  // }

  // @override
  // Stream<List<NotificationData>> streamNotificationsData(String uid) {
  //   return instance.setStream(
  //       path: APIpath.getNotificationsPath(docUserID: uid),
  //       builder: (data, docID) => NotificationData.fromMap(data, docID));
  // }

  // @override
  // Future<void> setNotificationsData(NotificationData no,String uid) async {
  //   await instance.setData(APIpath.setNotificationsPath(docBmID: no.docID,docUserID: uid), no.toMap());
  // }

  // @override
  // Future<void> deleteNotificationsData(String docNoID,String uid) async {
  //   await instance.deleteData(path: APIpath.setNotificationsPath(docBmID: docNoID,docUserID: uid));
  // }

}
