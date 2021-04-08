// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Start counting`
  String get game_start_button {
    return Intl.message(
      'Start counting',
      name: 'game_start_button',
      desc: '',
      args: [],
    );
  }

  /// `Current best score : {bestPlayerName} {bestScore}`
  String point_record(Object bestPlayerName, Object bestScore) {
    return Intl.message(
      'Current best score : $bestPlayerName $bestScore',
      name: 'point_record',
      desc: '',
      args: [bestPlayerName, bestScore],
    );
  }

  /// `Click count : {clickCount}`
  String click_count(Object clickCount) {
    return Intl.message(
      'Click count : $clickCount',
      name: 'click_count',
      desc: '',
      args: [clickCount],
    );
  }

  /// `{score, plural, zero{no point} one{1 point} other{{score} points}}`
  String result_score_points(num score) {
    return Intl.plural(
      score,
      zero: 'no point',
      one: '1 point',
      other: '$score points',
      name: 'result_score_points',
      desc: '',
      args: [score],
    );
  }

  /// `Clicker`
  String get app_name {
    return Intl.message(
      'Clicker',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name en start a game`
  String get before_game_text {
    return Intl.message(
      'Enter your name en start a game',
      name: 'before_game_text',
      desc: '',
      args: [],
    );
  }

  /// `Hall of fame`
  String get hall_of_fame {
    return Intl.message(
      'Hall of fame',
      name: 'hall_of_fame',
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
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}