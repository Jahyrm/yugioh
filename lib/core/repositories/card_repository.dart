import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';
import 'package:yugioh/core/services/yugioh_cards_api.dart';
import 'package:yugioh/core/utils/utils.dart';

enum CardType { monster, spell, trap, skill, token }

enum Languages { english, french, german, portuguese, italian }

/// Este es el repositorio de cartas, aquí se realizan las peticiones a la API
/// y contiene información necesaria para interactuar con la API.
class CardRepository {
  /// Información obtenida de: https://db.ygoprodeck.com/api-guide/
  final List<String> monsterTypes = [
    'Effect Monster', // si
    'Flip Effect Monster', // si
    'Flip Tuner Effect Monster', // si
    'Gemini Monster', // si
    'Normal Monster', // si
    'Normal Tuner Monster', //si
    'Pendulum Effect Monster', // si
    // 'Pendulum Effect Ritual Monster',
    'Pendulum Flip Effect Monster', // si
    'Pendulum Normal Monster', // si
    'Pendulum Tuner Effect Monster', // si
    'Ritual Effect Monster', // si
    'Ritual Monster', // si
    'Spirit Monster', // si
    'Toon Monster', // si
    'Tuner Monster', // si
    'Union Effect Monster', // si
    'Fusion Monster', // si
    'Link Monster', // si
    'Pendulum Effect Fusion Monster', // si
    'Synchro Monster', // si
    'Synchro Pendulum Effect Monster', // si
    'Synchro Tuner Monster', // si
    'XYZ Monster', // si
    'XYZ Pendulum Effect Monster', // si
  ];

  /// Información obtenida de: https://db.ygoprodeck.com/api-guide/
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

  /// Información obtenida de: https://db.ygoprodeck.com/api-guide/
  static final List<String> spellRaces = [
    'Normal',
    'Field',
    'Equip',
    'Continuous',
    'Quick-Play',
    'Ritual'
  ];

  /// Información obtenida de: https://db.ygoprodeck.com/api-guide/
  static final List<String> trapRaces = ['Normal', 'Continuous', 'Counter'];

  /// Obtiene todos los "archetypes"
  Future<(List<Archetype>?, String?)> getArchetypes() async {
    List<Archetype>? archetypes;
    String? message;
    try {
      Response<List<dynamic>?> apiResponse = await dio.get(
        '/archetypes.php',
      );
      if (apiResponse.data != null) {
        archetypes = ArchetypeResponse.fromJson(apiResponse.data!).archetypes;
      } else {
        message = 'An error has occurred, check your internet connection.';
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response!.data is String?) {
          debugPrint(e.response!.data);
        } else {
          debugPrint(jsonEncode(e.response!.data));
        }
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

  /// Endpoint para obtener las cartas desde la API, se puede filtrar por varios
  /// parámetros. Ver documentación: https://ygoprodeck.com/api-guide/
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
    Languages? language,
  }) async {
    List<CardModel>? cards;
    String? message;
    try {
      Map<String, dynamic> queryParams = {};
      if (name?.isNotEmpty ?? false) queryParams['name'] = name!.join('|');
      if (fname?.isNotEmpty ?? false) queryParams['fname'] = fname;
      if (frameType != null) queryParams['frameType'] = frameType.name;
      if (id?.isNotEmpty ?? false) {
        queryParams['id'] = id!.map((e) => e.toString()).join(',');
      }
      if (type?.isNotEmpty ?? false) {
        List<String> realTypes = [];
        if (type!.contains(CardType.monster)) realTypes.addAll(monsterTypes);
        if (type.contains(CardType.spell)) realTypes.add('Spell Card');
        if (type.contains(CardType.trap)) realTypes.add('Trap Card');
        if (type.contains(CardType.skill)) realTypes.add('Skill Card');
        if (type.contains(CardType.token)) realTypes.add('Token');
        queryParams['type'] = realTypes.join(',');
      }
      if (atk?.isNotEmpty ?? false) queryParams['atk'] = atk;
      if (def?.isNotEmpty ?? false) queryParams['def'] = def;
      if (level?.isNotEmpty ?? false) queryParams['level'] = level;
      if (race?.isNotEmpty ?? false) queryParams['race'] = race!.join(',');
      if (attribute?.isNotEmpty ?? false) {
        queryParams['attribute'] = attribute!.map((e) => e.name).join(',');
      }
      if (link != null) queryParams['link'] = link;
      if (linkmarker?.isNotEmpty ?? false) {
        queryParams['linkmarker'] =
            linkmarker!.map(Utils.linkMarkerToString).join(',');
      }
      if (scale != null) queryParams['scale'] = scale;
      if (cardset?.isNotEmpty ?? false) queryParams['cardset'] = cardset;
      if (archetype != null) queryParams['archetype'] = archetype.name;
      if (banlist?.isNotEmpty ?? false) queryParams['banlist'] = banlist;
      if (sort?.isNotEmpty ?? false) queryParams['sort'] = sort;
      if (format?.isNotEmpty ?? false) queryParams['format'] = format;
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
      if (language != null && language != Languages.english) {
        if (language == Languages.french) {
          queryParams['language'] = 'fr';
        } else if (language == Languages.german) {
          queryParams['language'] = 'de';
        } else if (language == Languages.portuguese) {
          queryParams['language'] = 'pt';
        } else if (language == Languages.italian) {
          queryParams['language'] = 'it';
        }
      }
      Response<Map<String, dynamic>?> apiResponse = await dio.get(
        '/cardinfo.php',
        queryParameters: queryParams,
      );
      if (apiResponse.data != null) {
        cards = CardsResponse.fromJson(apiResponse.data!).cards;
      } else {
        message = 'An error has occurred, check your internet connection.';
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response!.data is String?) {
          debugPrint(e.response!.data);
        } else {
          debugPrint(jsonEncode(e.response!.data));
        }
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
