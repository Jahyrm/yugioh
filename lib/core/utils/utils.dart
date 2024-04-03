import 'package:flutter/material.dart';
import 'package:yugioh/core/models/card.dart';

class Utils {
  /// Hide keyboard if it is shown
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Get the real name of LinkMarker enum
  static String linkMarkerToString(LinkMarker linkMarker) {
    int? index;
    for (int i = 0; i < linkMarker.name.length; i++) {
      if (linkMarker.name[i] == linkMarker.name[i].toUpperCase()) {
        index = i;
        break;
      }
    }
    if (index != null) {
      String finalString =
          linkMarker.name[0].toUpperCase() + linkMarker.name.substring(1);
      finalString =
          '${finalString.substring(0, index)}-${linkMarker.name[index]}${finalString.substring(index + 1)}';
      return finalString;
    } else {
      return linkMarker.name[0].toUpperCase() + linkMarker.name.substring(1);
    }
  }

  static (Color, Color) getBackgroundCardColors(CardModel card) {
    if (card.name == 'Slifer the Sky Dragon') {
      return (const Color(0xFFFB0007), const Color(0xFFFB0007));
    } else if (card.name == 'The Winged Dragon of Ra') {
      return (const Color(0xFFFED00A), const Color(0xFFFED00A));
    } else if (card.name == 'The Fang of Critias' ||
        card.name == 'The Claw of Hermos' ||
        card.name == 'The Eye of Timaeus') {
      return (const Color(0xFF8DA6C1), const Color(0xFF8DA6C1));
    } else if (card.name == 'Obelisk the Tormentor') {
      return (const Color(0xFF251f87), const Color(0xFF251f87));
    } else {
      switch (card.frameType) {
        case FNameType.normal:
          return (const Color(0xFFfce278), const Color(0xFFfce278));
        case FNameType.effect:
          return (const Color(0xFFfc7642), const Color(0xFFfc7642));
        case FNameType.ritual:
          return (const Color(0xFF8DA6C1), const Color(0xFF8DA6C1));
        case FNameType.fusion:
          return (const Color(0xFF8e70a8), const Color(0xFF8e70a8));
        case FNameType.synchro:
          return (const Color(0xFFc0c0c0), const Color(0xFFc0c0c0));
        case FNameType.xyz:
          return (Colors.black, Colors.black);
        case FNameType.link:
          return (const Color(0xFF000078), const Color(0xFF000078));
        case FNameType.normalPendulum:
          return (const Color(0xFFfce278), const Color(0xFF1e8f61));
        case FNameType.effectPendulum:
          return (const Color(0xFFfc7642), const Color(0xFF1e8f61));
        case FNameType.ritualPendulum:
          return (const Color(0xFF8DA6C1), const Color(0xFF1e8f61));
        case FNameType.fusionPendulum:
          return (const Color(0xFF8e70a8), const Color(0xFF1e8f61));
        case FNameType.synchroPendulum:
          return (const Color(0xFFc0c0c0), const Color(0xFF1e8f61));
        case FNameType.xyzPendulum:
          return (Colors.black, const Color(0xFF1e8f61));
        case FNameType.spell:
          return (const Color(0xFF1e8f61), const Color(0xFF1e8f61));
        case FNameType.trap:
          return (const Color(0xFFac4271), const Color(0xFFac4271));
        case FNameType.token:
          return (const Color(0xFFb3b3b3), const Color(0xFFb3b3b3));
        case FNameType.skill:
          return (Colors.blue, Colors.blue);
        case null:
          if (card.type == 'Pendulum Effect Fusion Monster') {
            return (const Color(0xFF8e70a8), const Color(0xFF1e8f61));
          } else if (card.type == 'Pendulum Effect Monster') {
            return (const Color(0xFFfc7642), const Color(0xFF1e8f61));
          } else if (card.type == 'Pendulum Effect Ritual Monster') {
            return (const Color(0xFF8DA6C1), const Color(0xFF1e8f61));
          } else if (card.type == 'Pendulum Flip Effect Monster') {
            return (const Color(0xFFfc7642), const Color(0xFF1e8f61));
          } else if (card.type == 'Pendulum Normal Monster') {
            return (const Color(0xFFfce278), const Color(0xFF1e8f61));
          } else if (card.type == 'Pendulum Tuner Effect Monster') {
            return (const Color(0xFFfc7642), const Color(0xFF1e8f61));
          } else if (card.type == 'Synchro Pendulum Effect Monster') {
            return (const Color(0xFFc0c0c0), const Color(0xFF1e8f61));
          } else if (card.type == 'XYZ Pendulum Effect Monster') {
            return (Colors.black, const Color(0xFF1e8f61));
          }
          return (const Color(0xFFfce278), const Color(0xFFfce278));
      }
    }
  }

  static Color getForegroundColor(CardModel card) {
    if (card.name == 'Slifer the Sky Dragon') {
      return Colors.black;
    } else if (card.name == 'The Winged Dragon of Ra') {
      return Colors.black;
    } else if (card.name == 'The Fang of Critias' ||
        card.name == 'The Claw of Hermos' ||
        card.name == 'The Eye of Timaeus') {
      return Colors.black;
    } else if (card.name == 'Obelisk the Tormentor') {
      return Colors.white;
    } else {
      switch (card.frameType) {
        case FNameType.normal:
          return Colors.black;
        case FNameType.effect:
          return Colors.white;
        case FNameType.ritual:
          return Colors.black;
        case FNameType.fusion:
          return Colors.white;
        case FNameType.synchro:
          return Colors.black;
        case FNameType.xyz:
          return Colors.white;
        case FNameType.link:
          return Colors.white;
        case FNameType.normalPendulum:
          return Colors.black;
        case FNameType.effectPendulum:
          return Colors.black;
        case FNameType.ritualPendulum:
          return Colors.black;
        case FNameType.fusionPendulum:
          return Colors.white;
        case FNameType.synchroPendulum:
          return Colors.black;
        case FNameType.xyzPendulum:
          return Colors.white;
        case FNameType.spell:
          return Colors.white;
        case FNameType.trap:
          return Colors.white;
        case FNameType.token:
          return Colors.black;
        case FNameType.skill:
          return Colors.white;
        case null:
          return Colors.black;
      }
    }
  }
}
