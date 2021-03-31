package com.example.prototype2021

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

           if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
              if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                  requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, 0);
              }
           }
    }
}
