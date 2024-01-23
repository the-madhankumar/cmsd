import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en",LocaleData.EN),
  MapLocale("hi",LocaleData.HI),
  MapLocale("ta",LocaleData.TA),
];

mixin LocaleData {
  static const String title = "title";
  static const String body = "body";
  static const String profile = "profile";
  static const String history = "history";
  static const String adddevice = "adddevice";
  static const String info1 = "info1";
  static const String info2 = "info2";
  static const String info3 = "info3";
  static const String info4 = "info4";
  static const String info5 = "info5";
  static const String info6 = "info6";
  static const String info7 = "info7";
  static const String info8 = "info8";
  static const String info9 = "info9";
  static const String setbtn1 = "setbtn1";
  static const String setbtn2 = "setbtn2";
  static const String setbtn3 = "setbtn3";
  static const String setbtn4 = "setbtn4";

  static const Map<String, dynamic> EN = {
    title: "Soil tester",
    profile: "Profile",
    history: "History",
    adddevice: "Add device",
    info1: 'Internet not available!',
    info2: 'Please turn on Wifi/Mobile data to continue or you can still acccess your history.',
    info3: 'Elements Page',
    info4: 'Section 1',
    info5: 'Section 2',
    info6: 'Section 3',
    info7: 'Settings',
    info8: 'Menu',
    info9: 'Home',
    setbtn1: 'Account',
    setbtn2: 'Notifications',
    setbtn3: 'Languages',
    setbtn4: 'Sign Out',
  };

  static const Map<String, dynamic> HI = {
    title: "मृदा परीक्षक",
    profile: "रूपरेखा",
    history: "इतिहास",
    adddevice: "डिवाइस जोड़ें",
    info1: 'Internet not available!',
    info2: 'Please turn on Wifi/Mobile data to continue or you can still acccess your history.',
    info3: 'तत्व पृष्ठ',
    info4: 'अनुभाग 1',
    info5: 'अनुभाग 2',
    info6: 'अनुभाग 3',
    info7: 'सेटिंग्स',
    info8: 'मेनू',
    info9: 'घर',
    setbtn1: 'खाता',
    setbtn2: 'सूचनाएँ',
    setbtn3: 'Languages',
    setbtn4: 'साइन आउट करें',
  };

  static const Map<String, dynamic> TA = {
    title: "மண் பரிசோதனை கருவி",
    profile: "பக்கத்தோற்ற வடிவம்",
    history: "வரலாறு",
    adddevice: "சாதனத்தைச் சேர்",
    info1: 'Internet not available!',
    info2: 'Please turn on Wifi/Mobile data to continue or you can still acccess your history.',
    info3: 'கூறுகள் பக்கம்',
    info4: 'கூறு 1',
    info5: 'கூறு 2',
    info6: 'கூறு 3',
    info7: 'அமைப்புகள்',
    info8: 'பட்டியல்',
    info9: 'வீடு',
    setbtn1: 'எண்ணுதல்',
    setbtn2: 'அறிவிக்கைகள்',
    setbtn3: 'Languages',
    setbtn4: 'வெளியேறு',
  };
}