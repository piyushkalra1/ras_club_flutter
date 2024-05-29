import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String? deviceId = null;
  static String? deviceData = null;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static void getDeviceIdAndData() async {
    if (deviceId == null && deviceData == null) {
      initPlatformState();
    }
  }

  static Future<void> initPlatformState() async {
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      Map<String, dynamic> deviceDataMap;
      if (Platform.isAndroid) {
        deviceDataMap =
            readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else {
        deviceDataMap = Utils.readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
      String data = "";
      deviceDataMap.forEach((key, value) {
        data = "$data$value#";
      });
      data = data.substring(0, data.length - 1);
      final bytes = utf8.encode(data);
      deviceData = base64.encode(bytes);
    } on PlatformException {
      print("Failed to get device id");
      deviceId = 'Failed to get deviceId.';
      deviceData = "";
    }
  }

  static Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
    };
  }

  static Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  static void showToast(String msg , {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showSuccessToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer
        .asUint8List();
  }

  static Future<void> launchMapUrl(double latitude, double longitude) async {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    String appleMapUrl = "http://maps.apple.com/?q=$latitude,$longitude";
    Uri googleMapUri = Uri.parse(googleMapUrl);
    Uri appleMapUri = Uri.parse(appleMapUrl);
    if (Platform.isAndroid) {
      try {
        if (await canLaunchUrl(googleMapUri)) {
          await launchUrl(googleMapUri);
        }
      } catch (error) {
        throw("Cannot launch Google map");
      }
    }
    if (Platform.isIOS) {
      try {
        if (await canLaunchUrl(appleMapUri)) {
          await launchUrl(appleMapUri);
        }
      } catch (error) {
        throw("Cannot launch Apple map $error");
      }
    }
  }
}
