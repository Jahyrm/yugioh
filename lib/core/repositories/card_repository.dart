import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/services/yugioh_cards_api.dart';
import 'package:yugioh/core/utils/utils.dart';

enum CardType { monster, spell, trap, skill, token }

class CardRepository {
  final List<String> monsterTypes = [
    'Effect Monster',
    'Flip Effect Monster',
    'Flip Tuner Effect Monster',
    'Gemini Monster',
    'Normal Monster',
    'Normal Tuner Monster',
    'Pendulum Effect Monster',
    'Pendulum Effect Ritual Monster',
    'Pendulum Flip Effect Monster',
    'Pendulum Normal Monster',
    'Pendulum Tuner Effect Monster',
    'Ritual Effect Monster',
    'Ritual Monster',
    'Spirit Monster',
    'Toon Monster',
    'Tuner Monster',
    'Union Effect Monster',
    'Fusion Monster',
    'Link Monster',
    'Pendulum Effect Fusion Monster',
    'Synchro Monster',
    'Synchro Pendulum Effect Monster',
    'Synchro Tuner Monster',
    'XYZ Monster',
    'XYZ Pendulum Effect Monster',
  ];

  static final List<String> monsterRaces = [
    'Aqua',
    'Beast',
    'Beast-Warrior',
    'Creator-God',
    'Cyberse',
    'Dinosaur',
    'Divine-Beast',
    'Dragon',
    'Fairy',
    'Fiend',
    'Fish',
    'Insect',
    'Machine',
    'Plant',
    'Psychic',
    'Pyro',
    'Reptile',
    'Rock',
    'Sea Serpent',
    'Spellcaster',
    'Thunder',
    'Warrior',
    'Winged Beast',
    'Wyrm',
    'Zombie',
  ];

  static final List<String> spellRaces = [
    'Normal',
    'Field',
    'Equip',
    'Continuous',
    'Quick-Play',
    'Ritual'
  ];

  static final List<String> trapRaces = ['Normal', 'Continuous', 'Counter'];

  /// Get all archetypes
  Future<(List<Archetype>?, String?)> getArchetypes() async {
    List<Archetype>? archetypes;
    String? message;
    try {
      await Future.delayed(const Duration(seconds: 1));
      return (
        ArchetypeResponse.fromJson(
          jsonDecode(
            await rootBundle.loadString('assets/json/min_archetypes.json'),
          ),
        ).archetypes,
        null
      );
      /*
      Response<List<dynamic>?> apiResponse = await dio.get(
        '/archetypes.php',
      );
      if (apiResponse.data != null) {
        archetypes = ArchetypeResponse.fromJson(apiResponse.data!).archetypes;
      } else {
        message = 'An error has occurred, check your internet connection.';
      }
      */
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        try {
          CardsResponse response = CardsResponse.fromJson(e.response!.data!);
          message = response.error;
          message ??= 'An error has occurred.';
        } catch (_) {
          message = 'An error has occurred.';
        }
        debugPrint(message);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message.toString());
        message = e.message;
        message ??= 'An error has occurred. Please try again.';
        debugPrint(message);
      }
    }
    return (archetypes, message);
  }

  /// Endpoint to get cards from the API, it can be filtered by several
  /// parameters. See doc: https://ygoprodeck.com/api-guide/
  Future<(List<CardModel>?, String?)> getCards({
    List<String>? name,
    String? fname,
    FNameType? frameType,
    List<int>? id,
    List<CardType>? type,
    String? atk,
    String? def,
    String? level,
    List<String>? race,
    List<Attribute>? attribute,
    int? link,
    List<LinkMarker>? linkmarker,
    int? scale,
    String? cardset,
    Archetype? archetype,
    String? banlist,
    String? sort,
    String? format,
    bool? misc,
    bool? staple,
    bool? hasEffect,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateregion,
  }) async {
    List<CardModel>? cards;
    String? message;
    try {
      Map<String, dynamic> queryParams = {};
      if (name != null) queryParams['name'] = name.join('|');
      if (fname != null) queryParams['fname'] = fname;
      if (frameType != null) queryParams['frameType'] = frameType.name;
      if (id != null) queryParams['id'] = id.map((e) => e.toString()).join(',');
      if (type?.isNotEmpty ?? false) {
        List<String> realTypes = [];
        if (type!.contains(CardType.monster)) realTypes.addAll(monsterTypes);
        if (type.contains(CardType.spell)) realTypes.add('Spell Card');
        if (type.contains(CardType.trap)) realTypes.add('Trap Card');
        if (type.contains(CardType.skill)) realTypes.add('Skill Card');
        if (type.contains(CardType.token)) realTypes.add('Token');
        queryParams['type'] = realTypes.join(',');
      }
      if (atk != null) queryParams['atk'] = atk;
      if (def != null) queryParams['def'] = def;
      if (level != null) queryParams['level'] = level;
      if (race != null) queryParams['race'] = race.join(',');
      if (attribute?.isNotEmpty ?? false) {
        queryParams['attribute'] = attribute!.map((e) => e.name).join(',');
      }
      if (link != null) queryParams['link'] = link;
      if (linkmarker?.isNotEmpty ?? false) {
        queryParams['linkmarker'] =
            linkmarker!.map(Utils.linkMarkerToString).join(',');
      }
      if (scale != null) queryParams['scale'] = scale;
      if (cardset != null) queryParams['cardset'] = cardset;
      if (archetype != null) queryParams['archetype'] = archetype.name;
      if (banlist != null) queryParams['banlist'] = banlist;
      if (sort != null) queryParams['sort'] = sort;
      if (format != null) queryParams['format'] = format;
      if (misc != null) queryParams['misc'] = misc;
      if (staple ?? false) queryParams['staple'] = 'yes';
      if (hasEffect ?? false) queryParams['hasEffect'] = hasEffect;
      if (startDate != null) {
        queryParams['startDate'] = DateFormat('YYYY-mm-dd').format(startDate);
      }
      if (endDate != null) {
        queryParams['endDate'] = DateFormat('YYYY-mm-dd').format(endDate);
      }
      if (dateregion != null) {
        queryParams['dateregion'] = DateFormat('YYYY-mm-dd').format(dateregion);
      }
      await Future.delayed(const Duration(seconds: 2));
      return (
        CardsResponse.fromJson(
          jsonDecode(await rootBundle.loadString('assets/json/min_cards.json')),
        ).cards,
        null
      );
      /*
      Response<Map<String, dynamic>?> apiResponse = await dio.get(
        '/cardinfo.php',
        queryParameters: queryParams,
      );
      if (apiResponse.data != null) {
        cards = CardsResponse.fromJson(apiResponse.data!).cards;
      } else {
        message = 'An error has occurred, check your internet connection.';
      }
      */
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        try {
          CardsResponse response = CardsResponse.fromJson(e.response!.data!);
          message = response.error;
          message ??= 'An error has occurred.';
        } catch (_) {
          message = 'An error has occurred.';
        }
        debugPrint(message);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message.toString());
        message = e.message;
        message ??= 'An error has occurred. Please try again.';
        debugPrint(message);
      }
    }
    return (cards, message);
  }
}
