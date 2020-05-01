// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get title {
    return Intl.message(
      'Lucky Dog',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  String get purchases {
    return Intl.message(
      'Expenses',
      name: 'purchases',
      desc: '',
      args: [],
    );
  }

  String get statistics {
    return Intl.message(
      'Statistic',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  String get settings {
    return Intl.message(
      'Setting',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  String get eat {
    return Intl.message(
      'Nutrition',
      name: 'eat',
      desc: '',
      args: [],
    );
  }

  String get toys {
    return Intl.message(
      'Toys',
      name: 'toys',
      desc: '',
      args: [],
    );
  }

  String get train {
    return Intl.message(
      'Trainning',
      name: 'train',
      desc: '',
      args: [],
    );
  }

  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  String get hygiene {
    return Intl.message(
      'Hygiene',
      name: 'hygiene',
      desc: '',
      args: [],
    );
  }

  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  String get changeLang {
    return Intl.message(
      'Change language',
      name: 'changeLang',
      desc: '',
      args: [],
    );
  }

  String get ru {
    return Intl.message(
      'Русский',
      name: 'ru',
      desc: '',
      args: [],
    );
  }

  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  String get setBack {
    return Intl.message(
      'Set background image',
      name: 'setBack',
      desc: '',
      args: [],
    );
  }

  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  String get training {
    return Intl.message(
      'Training',
      name: 'training',
      desc: '',
      args: [],
    );
  }

  String get test {
    return Intl.message(
      'Feed dog at 14:30',
      name: 'test',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}