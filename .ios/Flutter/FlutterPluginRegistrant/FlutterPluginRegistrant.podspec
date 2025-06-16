#
# Generated file, do not edit.
#

Pod::Spec.new do |s|
  s.name             = 'FlutterPluginRegistrant'
  s.version          = '0.0.1'
  s.summary          = 'Registers plugins with your Flutter app'
  s.description      = <<-DESC
Depends on all your plugins, and provides a function to register them.
                       DESC
  s.homepage         = 'https://flutter.dev'
  s.license          = { :type => 'BSD' }
  s.author           = { 'Flutter Dev Team' => 'flutter-dev@googlegroups.com' }
  s.ios.deployment_target = '12.0'
  s.source_files =  "Classes", "Classes/**/*.{h,m}"
  s.source           = { :path => '.' }
  s.public_header_files = './Classes/**/*.h'
  s.static_framework    = true
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.dependency 'Flutter'
  s.dependency 'camera_avfoundation'
  s.dependency 'connectivity_plus'
  s.dependency 'device_info_plus'
  s.dependency 'file_picker'
  s.dependency 'firebase_analytics'
  s.dependency 'firebase_core'
  s.dependency 'firebase_crashlytics'
  s.dependency 'firebase_messaging'
  s.dependency 'flutter_gryfo_lib'
  s.dependency 'flutter_image_compress_common'
  s.dependency 'flutter_inappwebview_ios'
  s.dependency 'flutter_native_splash'
  s.dependency 'flutter_pdfview'
  s.dependency 'flutter_secure_storage'
  s.dependency 'geolocator_apple'
  s.dependency 'google_mlkit_barcode_scanning'
  s.dependency 'google_mlkit_commons'
  s.dependency 'image_cropper'
  s.dependency 'image_picker_ios'
  s.dependency 'in_app_review'
  s.dependency 'local_auth_darwin'
  s.dependency 'location'
  s.dependency 'mobile_device_identifier'
  s.dependency 'nfc_manager'
  s.dependency 'open_file_ios'
  s.dependency 'package_info_plus'
  s.dependency 'path_provider_foundation'
  s.dependency 'permission_handler_apple'
  s.dependency 'printing'
  s.dependency 'rive_common'
  s.dependency 'share_plus'
  s.dependency 'shared_preferences_foundation'
  s.dependency 'sqflite_darwin'
  s.dependency 'sqlite3_flutter_libs'
  s.dependency 'url_launcher_ios'
  s.dependency 'video_player_avfoundation'
  s.dependency 'wakelock_plus'
  s.dependency 'webview_flutter_wkwebview'
end
