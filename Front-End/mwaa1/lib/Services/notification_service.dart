import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/main.dart';

///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static ReceivedAction? initialAction;
  static late DatabaseReference _sensorRef;
  static Timer? _timer; // Tambahkan variabel untuk mengontrol timer

  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotificationsFcm().initialize(
      onFcmTokenHandle: myFcmTokenHandle,
      onFcmSilentDataHandle: mySilentDataHandle,
      licenseKey: null,
    );

    await AwesomeNotifications().initialize(
        'resource://drawable/res_name',
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);

    // Inisialisasi Firebase
    await Firebase.initializeApp();

    // Mengatur referensi Firebase Realtime Database
    _sensorRef = FirebaseDatabase.instance.ref();

    // Memantau perubahan data di Firebase Realtime Database
    _sensorRef.onValue.listen((event) async {
      var data = event.snapshot.value;

      // Tunggu status login diperbarui
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Notifikasi: Pengguna belum login, data tidak diproses.');
        return;
      }

      if (data != null && data is Map<dynamic, dynamic>) {
        print('Data Firebase diterima: $data');
        checkSensorData(data);
      } else {
        print('Data Firebase tidak valid: $data');
      }
    });

    // Pantau status login secara real-time
    monitorAuthState();
  }

  static void monitorAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('Pengguna login: ${user.email}');
        startScheduledTask(); // Mulai ulang tugas terjadwal setelah login
      } else {
        print('Pengguna logout');
        stopScheduledTask(); // Hentikan semua tugas jika pengguna logout
      }
    });
  }

  static void startScheduledTask() {
    print("Starting scheduled task at ${DateTime.now()}");
    _timer?.cancel(); // Batalkan timer sebelumnya jika ada
    _timer = Timer.periodic(Duration(minutes: 5), (timer) async {
      print("Timer triggered at ${DateTime.now()}");

      // Periksa status login
      if (!isUserLoggedIn()) {
        print('Timer: Pengguna belum login.');
        return;
      }

      try {
        // Ambil data dari Firebase
        var event = await _sensorRef.once();
        var data = event.snapshot.value;

        if (data != null && data is Map<dynamic, dynamic>) {
          print('Timer: Data Firebase diproses: $data');
          await checkSensorData(data);
        } else {
          print('Timer: Data Firebase tidak valid.');
        }
      } catch (e) {
        print('Timer: Error saat mengambil data: $e');
      }
    });
  }

  static Future<void> checkSensorData(Map<dynamic, dynamic> data) async {
    // Ambang batas sensor
    const double maxSuhu = 32.0;
    const double minSuhu = 27.0;
    const double maxPH = 8.5;
    const double minPH = 7.5;
    const double minDO = 3.5; // Hanya periksa batas bawah DO
    const double maxTDS = 500.0;

    // Delay untuk memastikan notifikasi muncul satu per satu
    int delayInMillis = 10000; // 1 detik per notifikasi

    // Periksa nilai DO
    if (data['DO'] != null) {
      if (data['DO'] < minDO) {
        await sendNotification(
            'Peringatan DO Rendah', 'DO: ${data['DO']} terlalu rendah!');
        await Future.delayed(Duration(milliseconds: delayInMillis));
      }
    }

    // Periksa nilai TDS
    if (data['TDS'] != null) {
      if (data['TDS'] > maxTDS) {
        await sendNotification('Peringatan TDS Tinggi',
            'TDS: ${data['TDS']} melebihi batas aman!');
        await Future.delayed(Duration(milliseconds: delayInMillis));
      }
    }

    // Periksa nilai Temperature
    if (data['Temperature'] != null) {
      if (data['Temperature'] < minSuhu || data['Temperature'] > maxSuhu) {
        await sendNotification('Peringatan Suhu Tidak Normal',
            'Temperature: ${data['Temperature']}°C berada di luar batas aman!');
        await Future.delayed(Duration(milliseconds: delayInMillis));
      }
    }

    // Periksa nilai pH
    if (data['pH'] != null) {
      if (data['pH'] < minPH || data['pH'] > maxPH) {
        await sendNotification('Peringatan pH Tidak Normal',
            'pH: ${data['pH']} berada di luar batas aman!');
        await Future.delayed(Duration(milliseconds: delayInMillis));
      }
    }
  }

  static Future<void> sendNotification(String title, String message) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000),
        channelKey: 'alerts',
        title: title,
        body: message,
        notificationLayout: NotificationLayout.Default,
        fullScreenIntent: true,
        wakeUpScreen: true,
        locked: false,
        autoDismissible: true,
        actionType: ActionType.Default,
      ),
    );
  }

  static void stopScheduledTask() {
    print('Stopping scheduled task at ${DateTime.now()}');
    _timer?.cancel();
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 20),
                Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    print('FCM Token:"$token"');
  }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    int id = Random().nextInt(1000);

    inspect(silentData);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: silentData.data!['title'],
        body: silentData.data!['message'],
        bigPicture: silentData.data!['image'],
        notificationLayout: silentData.data!['image'] == null
            ? NotificationLayout.BigText
            : NotificationLayout.BigPicture,
        fullScreenIntent: true,
        wakeUpScreen: true,
        locked: false,
        autoDismissible: true,
        actionType: ActionType.Default,
      ),
    );
    inspect(silentData);
    if (silentData.createdLifeCycle == NotificationLifeCycle.Foreground) {
      // String? token = PreferenceService.getToken();
      // if (token != null) {
      //   Get.find<NotificatioController>().onGetNotif();
      // }
    }
  }
}
