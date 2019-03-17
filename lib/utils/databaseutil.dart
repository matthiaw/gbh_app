import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:gbh_app/models/user.dart';
import 'package:gbh_app/models/news.dart';

// Source from https://www.developerlibs.com/2018/11/flutter-firebase-realtime-database-crud.html
class FirebaseDatabaseUtil {
  DatabaseReference _userRef;
  DatabaseReference _newsRef;

  FirebaseDatabase database = new FirebaseDatabase();

  Query _newsQuery;

  // Singleton database util
  static final FirebaseDatabaseUtil _instance = new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _userRef = database.reference().child('users');
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _newsQuery = database
        .reference()
        .child('news')
        .orderByChild('published')
        .limitToFirst(10);

  }

  Future<List<News>> loadNews() async {
    Completer c = new Completer<List<News>>();
    List<News> list = new List<News>();
    Stream<Event> sse = _newsQuery.onChildAdded;

    sse.listen((Event event) {
      onNewsAdded(event, list).then((List<News> newsList) {
        return new Future.delayed(new Duration(seconds: 0), ()=> newsList);
      }).then((_) {
         if (!c.isCompleted) {
           c.complete(list);
         }
      });
    });

    return c.future;
  }

  Future<List<News>> onNewsAdded(Event event, List<News> newsList) async {
    News n = News.fromSnapshot(event.snapshot);
    //print("ADD: "+n.title);
    newsList.add(n);
    return newsList;
  }

  Future<User> loadUser(String userId) async {
    print("Try loading user with id $userId");
    return await getUserReference().child(userId).once().then((DataSnapshot snapshot) {
      User user = User.fromSnapshot(snapshot);
      //print(user.toJson());
      return user;
    });
  }

  DatabaseReference getUserReference() {
    return _userRef;
  }

  addUser(User user) async {
      _userRef.push().set(<String, String>{
        "firstname": "" + user.firstname,
        "familyname": "" + user.familyname,
        "group": "" + user.group,
      }).then((_) {
        print('Transaction  committed.');
      });
  }

  void deleteUser(User user) async {
    await _userRef.child(user.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateUser(User user) async {
    await _userRef.child(user.id).update({
      "firstname": "" + user.firstname,
      "familyname": "" + user.familyname,
      "group": "" + user.group,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}