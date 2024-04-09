import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:wecon/resources/auth_methods.dart';
import 'package:wecon/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      // var options = JitsiMeetingOptions(room: roomName)
      _firestoreMethods.addToMeetingHistory(roomName);
      var options = JitsiMeetingOptions(
          roomNameOrUrl: roomName,
          userDisplayName: name,
          userEmail: _authMethods.user.email,
          userAvatarUrl: _authMethods.user.photoURL,
          isAudioMuted: isAudioMuted,
          isVideoMuted: isVideoMuted,
          featureFlags: {
            'welcomepageenabled': false,
            'resolution': 'MD_RESOLUTION'
          });

      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      print("error: $error");
    }
  }
}
