class APIpath {
  static String setUsersPath({String? docUserID}) => 'users/$docUserID';
  static String getUsersPath() => 'users/';

  static String setNewsPath({String? docNewsID}) => 'allNews/$docNewsID';
  static String getNewsPath() => 'allNews/';

  static String setCommentPath({String? newsID, String? docCmtID}) =>
      'allNews/$newsID/comments/$docCmtID';
  static String getCommentPath({String? newsID}) => 'allNews/$newsID/comments/';

  static String setBookmarkPath({String? docUserID, String? docBmID}) =>
      'users/$docUserID/bookmark/$docBmID';
  static String getBookmarkPath({String? docUserID}) =>
      'users/$docUserID/bookmark/';

  static String setLovePath({String? newsID, String? docLoveID}) =>
      'allNews/$newsID/loves/$docLoveID';
  static String getLovePath({String? newsID}) => 'allNews/$newsID/loves/';

  static String setNotificationsPath({String? docUserID, String? docBmID}) =>
      'users/$docUserID/notification/$docBmID';
  static String getNotificationsPath({String? docUserID}) =>
      'users/$docUserID/notification/';
}
