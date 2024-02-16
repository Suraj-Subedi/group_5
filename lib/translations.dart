import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
          'bookings': 'Bookings',
          'profile': 'Profile',
          'editProfile': 'Edit Profile',
          'changePassword': 'Change Password',
        },
        'np': {
          'home': 'गृहपृष्ठ',
          'bookings': 'बुकिङ्स',
          'profile': 'प्रोफाइल',
          'editProfile': 'प्रोफाइल सम्पादन गर्नुहोस्',
          'changePassword': 'पासवर्ड परिवर्तन गर्नुहोस्',
        }
      };
}
