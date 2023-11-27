// // ignore_for_file: avoid_print, constant_identifier_names

import 'package:callkit_test/local_notif_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  LocalNotificationServices notificationService = LocalNotificationServices();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  notificationService.initializeNotificationServices();

  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Call test",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Notification Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              LocalNotificationServices().showNotification();
            },
            child: const Text('Schedule Notification'),
          ),
        ),
      ),
    );
  }
}

// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// // import 'package:flutter_callkit_incoming/entities/entities.dart';
// // import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'package:notification_incoming_call/notification_incoming_call.dart';
// import 'package:system_alert_window/system_alert_window.dart';
// import 'package:uuid/uuid.dart';

// class IsolateManager {
//   static const FOREGROUND_PORT_NAME = "foreground_port";

//   static SendPort? lookupPortByName() {
//     return IsolateNameServer.lookupPortByName(FOREGROUND_PORT_NAME);
//   }

//   static bool registerPortWithName(SendPort port) {
//     removePortNameMapping(FOREGROUND_PORT_NAME);
//     return IsolateNameServer.registerPortWithName(port, FOREGROUND_PORT_NAME);
//   }

//   static bool removePortNameMapping(String name) {
//     return IsolateNameServer.removePortNameMapping(name);
//   }
// }

// bool callBackFunction(String tag) {
//   print("Got tag $tag");
//   SendPort? port = IsolateManager.lookupPortByName();
//   port?.send([tag]);
//   return true;
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await SystemAlertWindow.requestPermissions(
//   //   prefMode: SystemWindowPrefMode.OVERLAY,
//   // );
//   ReceivePort port = ReceivePort();
//   IsolateManager.registerPortWithName(port.sendPort);
//   port.listen((dynamic callBackData) {
//     String tag = callBackData[0];
//     switch (tag) {
//       case "personal_btn":
//         print(
//             "Personal button click : Do what ever you want here. This is inside your application scope");
//         break;
//       case "simple_button":
//         print(
//             "Simple button click : Do what ever you want here. This is inside your application scope");
//         break;
//       case "focus_button":
//         print(
//             "Focus button click : Do what ever you want here. This is inside your application scope");
//         break;
//     }
//   });
//   SystemAlertWindow.registerOnClickListener(callBackFunction);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Incoming Call Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var _uuid = Uuid();
//   var _currentUuid;

//   @override
//   void initState() {
//     super.initState();
//     listenerEvent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Click FAB to test fake incoming call',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           makeFakeCallInComing();
//           // this._currentUuid = _uuid.v4();
//           // CallKitParams callKitParams = const CallKitParams(
//           //   id: "12",
//           //   nameCaller: 'Hien Nguyen',
//           //   appName: 'Callkit',
//           //   avatar: 'https://i.pravatar.cc/100',
//           //   handle: '0123456789',
//           //   type: 0,
//           //   textAccept: 'Accept',
//           //   textDecline: 'Decline',
//           //   // textMissedCall: 'Missed call',
//           //   // textCallback: 'Call back',
//           //   duration: 30000,
//           //   extra: <String, dynamic>{'userId': '1a2b3c4d'},
//           //   headers: <String, dynamic>{
//           //     'apiKey': 'Abc@123!',
//           //     'platform': 'flutter'
//           //   },

//           //   android: AndroidParams(
//           //     isCustomNotification: true,
//           //     isShowLogo: false,
//           //     // isShowCallback: false,
//           //     // isShowMissedCallNotification: true,
//           //     ringtonePath: 'system_ringtone_default',
//           //     backgroundColor: '#0955fa',
//           //     backgroundUrl: 'https://i.pravatar.cc/500',
//           //     actionColor: '#4CAF50',
//           //     incomingCallNotificationChannelName: "Incoming Call",
//           //     missedCallNotificationChannelName: "Missed Call",
//           //   ),
//           //   ios: IOSParams(
//           //     iconName: 'CallKitLogo',
//           //     handleType: 'generic',
//           //     supportsVideo: true,
//           //     maximumCallGroups: 2,
//           //     maximumCallsPerCallGroup: 1,
//           //     audioSessionMode: 'default',
//           //     audioSessionActive: true,
//           //     audioSessionPreferredSampleRate: 44100.0,
//           //     audioSessionPreferredIOBufferDuration: 0.005,
//           //     supportsDTMF: true,
//           //     supportsHolding: true,
//           //     supportsGrouping: false,
//           //     supportsUngrouping: false,
//           //     ringtonePath: 'system_ringtone_default',
//           //   ),
//           // );
//           // await NotificationIncomingCall.showCallkitIncoming(callKitParams);
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> makeFakeCallInComing() async {
//     await Future.delayed(const Duration(seconds: 7), () async {
//       this._currentUuid = _uuid.v4();
//       var params = <String, dynamic>{
//         'id': _currentUuid,
//         'nameCaller': 'Hien Nguyen',
//         'appName': 'Callkit',
//         'avatar': 'https://i.pravatar.cc/100',
//         'handle': '0123456789',
//         'type': 0,
//         'duration': 30000,
//         'extra': <String, dynamic>{'userId': '1a2b3c4d'},
//         'headers': <String, dynamic>{
//           'apiKey': 'Abc@123!',
//           'platform': 'flutter'
//         },
//         'android': <String, dynamic>{
//           'isCustomNotification': true,
//           'isShowLogo': false,
//           // 'ringtonePath': 'ringtone_default',
//           'backgroundColor': '#0955fa',
//           'background': 'https://i.pravatar.cc/500',
//           'actionColor': '#4CAF50'
//         },
//         'ios': <String, dynamic>{
//           'iconName': 'AppIcon40x40',
//           'handleType': '',
//           'supportsVideo': true,
//           'maximumCallGroups': 2,
//           'maximumCallsPerCallGroup': 1,
//           'audioSessionMode': 'default',
//           'audioSessionActive': true,
//           'audioSessionPreferredSampleRate': 44100.0,
//           'audioSessionPreferredIOBufferDuration': 0.005,
//           'supportsDTMF': true,
//           'supportsHolding': true,
//           'supportsGrouping': false,
//           'supportsUngrouping': false,
//           'ringtonePath': 'Ringtone.caf'
//         }
//       };
//       await NotificationIncomingCall.showCallkitIncoming(params);
//     });
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> listenerEvent() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       NotificationIncomingCall.onEvent.listen((event) {
//         print(event);
//         if (!mounted) return;
//         switch (event!.name) {
//           case CallEvent.ACTION_CALL_INCOMING:
//             // TODO: received an incoming call
//             break;
//           case CallEvent.ACTION_CALL_START:
//             // TODO: started an outgoing call
//             // TODO: show screen calling in Flutter
//             break;
//           case CallEvent.ACTION_CALL_ACCEPT:
//             // TODO: accepted an incoming call
//             // TODO: show screen calling in Flutter
//             break;
//           case CallEvent.ACTION_CALL_DECLINE:
//             // TODO: declined an incoming call
//             break;
//           case CallEvent.ACTION_CALL_ENDED:
//             // TODO: ended an incoming/outgoing call
//             break;
//           case CallEvent.ACTION_CALL_TIMEOUT:
//             // TODO: missed an incoming call
//             break;
//           case CallEvent.ACTION_CALL_CALLBACK:
//             // TODO: only Android - click action `Call back` from missed call notification
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_HOLD:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_MUTE:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_DMTF:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_GROUP:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
//             // TODO: only iOS
//             break;
//         }
//         // setState(() {
//         //   textEvents += "${event.toString()}\n";
//         // });
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
