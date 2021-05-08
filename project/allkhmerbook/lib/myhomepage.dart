import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:allkhmerbook/auth/service/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'file_process/get_directory.dart';
import 'main.dart';
import 'package:encrypt/encrypt.dart' as enc;

class MyHomePage extends StatefulWidget with WidgetsBindingObserver {
  final TargetPlatform? platform;

  MyHomePage({Key? key, this.title, this.platform}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _documents = [
    {
      'name': 'Learning Android Studio',
      'ext': '.pdf',
      'link':
          'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
    },
    {
      'name': 'Android Programming Cookbook',
      'ext': '.pdf',
      'link':
          'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
    },
    {
      'name': 'iOS Programming Guide',
      'ext': '.pdf',
      'link':
          'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
    },
    {
      'name': 'Objective-C Programming (Pre-Course Workbook',
      'ext': '.pdf',
      'link':
          'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
    },
  ];

  final _images = [
    {
      'name': 'Arches National Park',
      'ext': '.jpg',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
    },
    {
      'name': 'Canyonlands National Park',
      'ext': '.jpg',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
    },
    {
      'name': 'Death Valley National Park',
      'ext': '.jpg',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
    },
    {
      'name': 'Gates of the Arctic National Park and Preserve',
      'ext': '.jpg',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
    }
  ];

  final _videos = [
    {
      'name': 'Big Buck Bunny',
      'ext': '.mp4',
      'link':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
    },
    {
      'name': 'Elephant Dream',
      'ext': '.mp4',
      'link':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    }
  ];

  List<DownloadInfo>? _tasks;
  late List<DownloadHolder> _items;
  late bool _isLoading;
  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }

    _port.listen(
      (dynamic data) async {
        if (debug) {
          print('UI Isolate Callback: $data');
        }
        String? id = data[0];
        DownloadTaskStatus? status = data[1];
        int? progress = data[2];

        if (_tasks != null && _tasks!.isNotEmpty) {
          final task = _tasks!.firstWhere((task) => task.taskId == id);
          if (task != null) {
            setState(() {
              task.status = status;
              task.progress = progress;
            });
          }
          if (task.status == DownloadTaskStatus.complete) {
            bool file = File(
                    '/storage/emulated/0/Android/data/com.rospisey.allkhmerbook/files/Download/${task.name}${task.ext}')
                .existsSync();
            if (file) {
              await _encryption('${task.name!}${task.ext}');
            }
          }
        }
      },
    );
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }

    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  signOut() async {
    final provider = Provider.of<BaseAuth>(context, listen: false);
    await provider.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title!),
        actions: [
          IconButton(icon: Icon(Icons.rotate_left_rounded), onPressed: signOut)
        ],
      ),
      body: Builder(
          builder: (context) => _isLoading
              ? new Center(
                  child: new CircularProgressIndicator(),
                )
              : _permissionReady
                  ? _buildDownloadList()
                  : _buildNoPermissionWarning()),
    );
  }

  Widget _buildDownloadList() => Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: _items
              .map(
                (item) => item.task == null
                    ? _buildListSection(item.name!)
                    : DownloadItem(
                        data: item,
                        isLoading: _isLoadingProgress,
                        onItemClick: (task) {
                          _openDownloadedFile(task);
                        },
                        onAtionClick: (task) async {
                          if (task.status == DownloadTaskStatus.undefined) {
                            _requestDownload(task);
                          } else if (task.status ==
                              DownloadTaskStatus.running) {
                            _pauseDownload(task);
                          } else if (task.status == DownloadTaskStatus.paused) {
                            _resumeDownload(task);
                          } else if (task.status ==
                              DownloadTaskStatus.complete) {
                            _delete(task);
                          } else if (task.status == DownloadTaskStatus.failed) {
                            _retryDownload(task);
                          }
                        },
                      ),
              )
              .toList(),
        ),
      );

  Widget _buildListSection(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18.0),
        ),
      );

  Widget _buildNoPermissionWarning() => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Please grant accessing storage permission to continue -_-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              FlatButton(
                  onPressed: () {
                    _checkPermission().then((hasGranted) {
                      setState(() {
                        _permissionReady = hasGranted;
                      });
                    });
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ))
            ],
          ),
        ),
      );
  List<DownloadTask>? taskInfo = [];

  void _requestDownload(DownloadInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link!,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        fileName: '${task.name}${task.ext}',
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(DownloadInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId!);
  }

  void _pauseDownload(DownloadInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  void _resumeDownload(DownloadInfo task) async {
    // await FlutterDownloader.resume(taskId: task.taskId!);
    String? newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  void _retryDownload(DownloadInfo task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  bool _isLoadingProgress = false;

  void _toggleLoading() {
    setState(() {
      _isLoadingProgress = !_isLoadingProgress;
    });
  }

  //return file path
  _decryption(String filename) async {
    try {
      String? tempfile;
      String path =
          await findLocalPath() + Platform.pathSeparator + 'Download/$filename';
      bool existfile = File('$path.aes').existsSync();

      final temp = await getTemporaryDirectory();
      if (existfile) {
        await _readData('$path.aes').then((filePath) async {
          List<int> decData = _decryptData(filePath);
          String file = await _writeData(decData, '${temp.path}/$filename');
          setState(() {
            tempfile = file;
          });
        });
        return tempfile;
        // await File('$path').delete();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future _openDownloadedFile(DownloadInfo? task) async {
    if (task != null) {
      String path = await findLocalPath() +
          Platform.pathSeparator +
          'Download/${task.name}${task.ext}.aes';
      bool existfile = File('$path').existsSync();

      final temp = await getTemporaryDirectory();
      final tempPath = '${temp.path}/${task.name}${task.ext}';
      File fileTemp = File(tempPath);
      if (existfile) {
        if (fileTemp.existsSync()) {
          // await _decryption('${task.name}${task.ext}')
          //   .then((file) => OpenFile.open(File(file!).path));
          OpenFile.open(fileTemp.path);
        } else {
          await _decryption('${task.name}${task.ext}')
              .then((file) => OpenFile.open(fileTemp.path));
        }
      }
      // return FlutterDownloader.open(taskId: task.taskId!);
    }
  }

  void _delete(DownloadInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId!, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    int count = 0;
    _tasks = [];
    _items = [];

    _tasks!.addAll(_documents.map((document) => DownloadInfo(
        name: document['name'], link: document['link'], ext: document['ext'])));

    _items.add(DownloadHolder(name: 'Documents'));
    for (int i = count; i < _tasks!.length; i++) {
      _items.add(DownloadHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(_images.map((image) => DownloadInfo(
        name: image['name'], link: image['link'], ext: image['ext'])));

    _items.add(DownloadHolder(name: 'Images'));
    for (int i = count; i < _tasks!.length; i++) {
      _items.add(DownloadHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(_videos.map((video) => DownloadInfo(
        name: video['name'], link: video['link'], ext: video['ext'])));

    _items.add(DownloadHolder(name: 'Videos'));
    for (int i = count; i < _tasks!.length; i++) {
      _items.add(DownloadHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    final tasks = await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE status=3');

    tasks!.forEach((task) {
      for (DownloadInfo info in _tasks!) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
          info.filename = task.filename;
        }
      }
    });

    final tasks2 = await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE status=2');

    tasks2!.forEach((task) {
      for (DownloadInfo info in _tasks!) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
          info.filename = task.filename;
        }
      }
    });

    final tasks4 = await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE status=6');

    tasks4!.forEach((task) {
      for (DownloadInfo info in _tasks!) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
          info.filename = task.filename;
        }
      }
    });

    // for (int i = 0; i < _items.length; i++) {
    //   print(_items[i].task!.taskId);
    // }
    _permissionReady = await _checkPermission();

    _localPath =
        (await _findLocalPath(context)) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }
}

Future<String> _findLocalPath(BuildContext context) async {
  final directory = Theme.of(context).platform == TargetPlatform.android
      ? await (getExternalStorageDirectory())
      : await getApplicationDocumentsDirectory();
  return directory!.path;
}

class DownloadItem extends StatefulWidget {
  final DownloadHolder? data;
  final Function(DownloadInfo?)? onItemClick;
  final Function(DownloadInfo)? onAtionClick;
  final bool? isLoading;

  DownloadItem(
      {this.data, this.onItemClick, this.onAtionClick, this.isLoading});

  @override
  _DownloadItemState createState() => _DownloadItemState();
}

class _DownloadItemState extends State<DownloadItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: widget.data!.task!.status == DownloadTaskStatus.complete
            ? () {
                widget.onItemClick!(widget.data!.task);
              }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.data!.name!,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionForTask(widget.data!.task!),
                  ),
                ],
              ),
            ),
            widget.data!.task!.status == DownloadTaskStatus.running ||
                    widget.data!.task!.status == DownloadTaskStatus.paused
                ? Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: LinearProgressIndicator(
                      value: widget.data!.task!.progress! / 100,
                    ),
                  )
                : Container()
          ].where((child) => child != null).toList(),
        ),
      ),
    );
  }

  Widget? _buildActionForTask(DownloadInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          widget.onAtionClick!(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          widget.onAtionClick!(task);
        },
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          widget.onAtionClick!(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Ready',
            style: TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              widget.onAtionClick!(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Text('Canceled', style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Failed', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              widget.onAtionClick!(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return Text('Pending', style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }
}

class DownloadInfo {
  final String? name;
  final String? link;
  final String? ext;

  String? taskId;
  String? filename;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  DownloadInfo({this.name, this.link, this.ext});
}

class DownloadHolder {
  final String? name;
  final DownloadInfo? task;

  DownloadHolder({this.name, this.task});
}

Future _encryption(String filename) async {
  try {
    String path =
        await findLocalPath() + Platform.pathSeparator + 'Download/$filename';

    bool existfile = File('$path').existsSync();
    if (existfile) {
      final filePath = await _readData(path);
      final encData = _encryptData(filePath);
      print(path);
      await _writeData(encData, '$path.aes');
      await File('$path').delete();
    }
  } catch (e) {
    print('Error: $e');
  }
}

//return Uint8list
Future _decryptionUint8list(String filename) async {
  try {
    String path =
        await findLocalPath() + Platform.pathSeparator + 'Download/$filename';
    bool existfile = File('$path.aes').existsSync();

    if (existfile) {
      final filePath = await _readData('$path.aes');
      final decData = _decryptData(filePath);

      // await File('$path').delete();
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<File?> movefile(File sourceFile, String newPath) async {
  try {
    return await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    //if rename fail, copy the source file and delete it
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    print(e);
    return newFile;
  }
}

Uint8List? _encryptData(plaintext) {
  try {
    final encrypted =
        MyEncrypt.myencrypt.encryptBytes(plaintext, iv: MyEncrypt.myiv);
    return encrypted.bytes;
  } catch (e) {
    print('Error: $e');
  }
}

List<int> _decryptData(encData) {
  enc.Encrypted en = new enc.Encrypted(encData);
  return MyEncrypt.myencrypt.decryptBytes(en, iv: MyEncrypt.myiv);
}

Future<Uint8List?> _readData(fileNameWithPath) async {
  try {
    File f = File(fileNameWithPath);
    return await f.readAsBytes();
  } catch (e) {
    print('Error: $e');
  }
}

Future<String> _writeData(dataToWrite, fileNameWithPath) async {
  File f = File(fileNameWithPath);
  await f.writeAsBytes(dataToWrite);
  return f.absolute.toString();
}

class MyEncrypt {
  static final mykey = enc.Key.fromUtf8('CBoaDQIQAgceGg8dFAkMDBEOECEZCxgM');
  static final myiv = enc.IV.fromUtf8('rospisey12345');
  static final myencrypt = enc.Encrypter(enc.AES(mykey));
}
