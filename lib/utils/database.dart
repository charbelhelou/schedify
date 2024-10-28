import 'package:realm/realm.dart';
import 'package:schedify/models/shift.dart';

class Database {
  static Realm? _realm;

  static Realm get instance {
    if (_realm == null) {
      _init();
    }
    return _realm!;
  }

  Database._();

  static _init() {
    var config = Configuration.local(
      [Shift.schema, Break.schema],
      schemaVersion: 0,
      migrationCallback: (migration, oldSchemaVersion) {
        // if (oldSchemaVersion < 6) {
        //   migration.newRealm.all<DownloadedVideo>().forEach((video) {
        //     video.id = ObjectId();
        //   });
        // }
      },
    );
    _realm = Realm(config);
  }

  static close() {
    _realm?.close();
    _realm = null;
  }

  // static addDownloadedVideo(DownloadedVideo video) {
  //   realm.write(() {
  //     realm.add(video);
  //   });
  // }

  // static bool videoExists(String url) {
  //   final videos = realm.all<DownloadedVideo>().query("url CONTAINS[c] '$url'");
  //   if (videos.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  // static addPathToVideo(DownloadedVideo video, String path) {
  //   realm.write(() {
  //     video.path = path;
  //   });
  // }

  // static RealmResults<DownloadedVideo> getAllVideos() {
  //   final videos = realm.all<DownloadedVideo>();
  //   return videos;
  // }

  // static void deleteVideo(DownloadedVideo video) {
  //   if (video.path != null) {
  //     try {
  //       final file = File(video.path!);
  //       final directory = file.parent;
  //       debugPrint('Deleting directory: ${directory.path}');
  //       directory.deleteSync(recursive: true);
  //     } catch (e) {
  //       debugPrint('Error deleting folder: $e');
  //     }
  //   }
  //   realm.write(() {
  //     realm.delete(video);
  //   });
  // }

  // static void deleteAllVideos() {
  //   final allVideos = getAllVideos().toList();
  //   realm.write(() {
  //     for (DownloadedVideo video in allVideos) {
  //       if (video.path != null) {
  //         try {
  //           final file = File(video.path!);
  //           final directory = file.parent;
  //           debugPrint('Deleting directory: ${directory.path}');
  //           directory.deleteSync(recursive: true);
  //         } catch (e) {
  //           debugPrint('Error deleting folder: $e');
  //         }
  //       }
  //       realm.delete(video);
  //     }
  //   });
  // }
}
