part of pisey_services;

class APIpath {
  //Firestore
  static String setUsersPath({String? docUserID}) => 'users/$docUserID';
  static String setContentPath({String? docUserID}) => 'content/$docUserID';
  static String getUsersPath() => 'users/';

  //Storage
  static String setBookFile({String? docUserID, String? name}) =>
      '/books/$docUserID/$name';
}
