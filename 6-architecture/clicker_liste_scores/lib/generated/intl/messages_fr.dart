// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static m0(clickCount) => "Nombre de clics : ${clickCount}";

  static m1(bestPlayerName, bestScore) => "Record de points : ${bestPlayerName} ${bestScore}";

  static m2(score) => "${Intl.plural(score, zero: 'Aucun point', one: '1 point', other: '${score} points')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "app_name" : MessageLookupByLibrary.simpleMessage("Clicker"),
    "click_count" : m0,
    "game_start_button" : MessageLookupByLibrary.simpleMessage("Commencer à compter"),
    "point_record" : m1,
    "result_score_points" : m2
  };
}
