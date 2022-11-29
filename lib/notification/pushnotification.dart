// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.

class PushNotification {
  /*FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        debugPrint('remote message  initial - ${remoteMessage.data.toString()}');
        //display ride request information - user information who request a ride
        var notificationEncodedBody = jsonDecode(remoteMessage.data['body'].toString());

        debugPrint(
            'remote message  onMessage Event- ${remoteMessage.toString()} ${notificationEncodedBody['notification_short_code']}');
        if (notificationEncodedBody['notification_short_code'] == 'accept_req') {
          BlocProvider.of<NotificationBloc>(context).add(ReceiveAcceptRequestNotification(remoteMessage));
        } else if (notificationEncodedBody['notification_short_code'] == 'req_cancelled') {
          BlocProvider.of<NotificationBloc>(context).add(ReceiveCanceledRequestNotification(remoteMessage));
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      //display ride request information - user information who request a ride
      var notificationEncodedBody = jsonDecode(remoteMessage!.data['body'].toString());
      debugPrint(
          'remote message  onMessage Event- ${remoteMessage.toString()} ${notificationEncodedBody['notification_short_code']}');
      if (notificationEncodedBody['notification_short_code'] == 'accept_req') {
        BlocProvider.of<NotificationBloc>(context).add(ReceiveAcceptRequestNotification(remoteMessage));
      } else if (notificationEncodedBody['notification_short_code'] == 'req_cancelled') {
        BlocProvider.of<NotificationBloc>(context).add(ReceiveCanceledRequestNotification(remoteMessage));
      }
      // BlocProvider.of<NotificationBloc>(context).add(ReceiveAcceptRequestNotification(remoteMessage));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      //display ride request information - user information who request a ride

      debugPrint('remote message On Opened app  - ${remoteMessage.toString()} ');
      var notificationEncodedBody = jsonDecode(remoteMessage!.data['body'].toString());
      debugPrint(
          'remote message  onMessage Event- ${remoteMessage.toString()} ${notificationEncodedBody['notification_short_code']}');
      if (notificationEncodedBody['notification_short_code'] == 'accept_req') {
        BlocProvider.of<NotificationBloc>(context).add(ReceiveAcceptRequestNotification(remoteMessage));
      } else if (notificationEncodedBody['notification_short_code'] == 'req_cancelled') {
        BlocProvider.of<NotificationBloc>(context).add(ReceiveCanceledRequestNotification(remoteMessage));
      }
    });
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();
    debugPrint("FCM Registration Token: $registrationToken");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kFirebaseToken, registrationToken!);
  }*/

}
