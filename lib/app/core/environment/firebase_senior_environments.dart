import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

abstract class FirebaseSeniorEnvironments {
  static FirebaseOptions get production {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidProductionOptions;
      case TargetPlatform.iOS:
        return _iosProductionOptions;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static FirebaseOptions get development {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidDevelopmentOptions;
      case TargetPlatform.iOS:
        return _iosDevelopmentOptions;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const _androidProductionOptions = FirebaseOptions(
    apiKey: 'AIzaSyAPUvRJGoFzrrUCFeI2KsISLVeceBfOHN8',
    appId: '1:425427803219:android:bef65316473d7dfeb77aa6',
    messagingSenderId: '425427803219',
    projectId: 'app-employee-c1514',
    storageBucket: 'app-employee-c1514.appspot.com',
    androidClientId: '425427803219-0oni77tu35354tv8esvn9jkdnelvhh6b.apps.googleusercontent.com',
  );

  static const _iosProductionOptions = FirebaseOptions(
    apiKey: 'AIzaSyBLBkD5nSyZ0DFrQ6l5p_6ZzPDIxK_r_EE',
    appId: '1:425427803219:ios:f3a4be9df50d31dab77aa6',
    messagingSenderId: '425427803219',
    projectId: 'app-employee-c1514',
    storageBucket: 'app-employee-c1514.appspot.com',
    iosClientId: '425427803219-oclihqll06vigf3t8tacmbhms15r2um2.apps.googleusercontent.com',
    iosBundleId: 'br.com.senior.employee',
  );

  static const _androidDevelopmentOptions = FirebaseOptions(
    apiKey: 'AIzaSyCt64xaKrRgbf7UOibpSjVMUQYS1J8R3FU',
    appId: '1:1060530172225:android:fcef42c19de613bdc7f1c0',
    messagingSenderId: '1060530172225',
    projectId: 'app-employee-dev',
    storageBucket: 'app-employee-dev.appspot.com',
    androidClientId: '1060530172225-hj0l78h6i5ohg90hsr0m20dp0pcni4q4.apps.googleusercontent.com',
  );

  static const _iosDevelopmentOptions = FirebaseOptions(
    apiKey: 'AIzaSyCFClzXiMEKBNC0EOa6zpRCYfhz0U39cYc',
    appId: '1:1060530172225:ios:a1bb73e12a2e6c3cc7f1c0',
    messagingSenderId: '1060530172225',
    projectId: 'app-employee-dev',
    storageBucket: 'app-employee-dev.appspot.com',
    iosClientId: '1060530172225-hj0l78h6i5ohg90hsr0m20dp0pcni4q4.apps.googleusercontent.com',
    iosBundleId: 'br.com.senior.employee',
  );
}
