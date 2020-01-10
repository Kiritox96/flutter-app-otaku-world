import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/widgets.dart';

class AdsService {

  static Widget showBanner(){
    return new AdmobBanner(
      adUnitId:'ca-app-pub-1584490079922301/5175394113' ,
      adSize: AdmobBannerSize.SMART_BANNER
    );
  }
}