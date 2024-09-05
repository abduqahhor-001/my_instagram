import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    /// Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    var initAndroidSetting =
    const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initSetting = InitializationSettings(android: initAndroidSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSetting);
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Bildirishnoma jo'natish funksiyasi
  static Future<void> showFollowNotification(String username) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // channel ID
      'High Importance Notifications', // channel Name
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'New Follower',
      '$username has followed you!',
      notificationDetails,
      payload: 'UserFollowed',
    );
  }
}
