//
// // ignore_for_file: avoid_print
//
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationService {
//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   void NotificationPermission()async{
//
//     NotificationSettings settings= await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       sound: true,
//       provisional: true,
//       carPlay: true,
//       badge: true,
//       criticalAlert: true,
//     );
//     if(settings.authorizationStatus == AuthorizationStatus.authorized){
//       print('Permission allow');
//     }
//     else if(settings.authorizationStatus == AuthorizationStatus.provisional){
//       print('Provisional permission');
//     }
//     else {
//       print('permission graind');
//     }
//   }
//
// }