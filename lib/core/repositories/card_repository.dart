import 'package:yugioh/core/models/archetype.dart';
import 'package:yugioh/core/models/card.dart';

class CardRepository {
  /// Get all archetypes
  Future<List<Archetype>?> getArchetypes() async {
    List<Archetype>? archetypes;
    try {} catch (_) {}
    return archetypes;
  }

  /// Endpoint to get cards from the API, it can be filtered by several
  /// parameters. See doc: https://ygoprodeck.com/api-guide/
  Future<List<Card>?> getCards({
    List<String>? name,
    String? fname,
    int? id,
    List<String>? type,
    String? atk,
    String? def,
    String? level,
    List<String>? race,
    List<String>? attribute,
    int? link,
    List<String>? linkmarker,
    int? scale,
    List<String>? cardset,
    List<String>? archetype,
    List<String>? banlist,
    List<String>? sort,
    bool? misc,
    bool? staple,
    bool? hasEffect,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateregion,
  }) async {
    List<Card>? cards;
    try {} catch (_) {}
    return cards;
  }
}
