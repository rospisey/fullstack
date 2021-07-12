part of pisey_services;

class UploadModel {
  storage.TaskState? state;
  String? name;
  PlatformFile? files;
  int? totalBytes;
  int? byteTransfer;
  String? formname;
  int? timestamp;
  int? id;

  UploadModel(
      {this.state,
      this.id,
      this.name,
      this.files,
      this.totalBytes,
      this.byteTransfer,
      this.formname})
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'name': name,
      'file': files,
      'totalBytes': totalBytes,
      'byteTransfer': byteTransfer,
      'timestamp': timestamp,
      'formname': formname,
      'id': id
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadModel &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          name == other.name &&
          files == other.files &&
          totalBytes == other.totalBytes &&
          byteTransfer == other.byteTransfer;

  @override
  int get hashCode => hashValues(state, name, files, totalBytes, byteTransfer);
}

class FormUploadModel {
  final String? name;
  List<UploadModel>? files;

  FormUploadModel({this.name, this.files});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'file': files,
    };
  }
}
