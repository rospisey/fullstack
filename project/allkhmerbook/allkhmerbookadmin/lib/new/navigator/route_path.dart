class TheAppPath {
  final int? id;
  final bool isAdmin;

  TheAppPath.admin()
      : id = null,
        isAdmin = true;

  TheAppPath.home()
      : id = null,
        isAdmin = false;

  TheAppPath.details(this.id) : isAdmin = false;

  TheAppPath.unknown()
      : id = -1,
        isAdmin = false;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;

  bool get isUnknown => id == -1;
}
