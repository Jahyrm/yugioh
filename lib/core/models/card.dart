import 'package:collection/collection.dart';
import 'package:yugioh/core/utils/utils.dart';

class CardsResponse {
  String? error;
  List<CardModel>? cards;

  CardsResponse({this.error, this.cards});

  CardsResponse.fromJson(Map<String, dynamic> json,
      {bool allowBanneds = false}) {
    error = json['error'];
    if (json['data'] != null) {
      cards = <CardModel>[];
      json['data'].forEach((v) {
        CardModel card = CardModel.fromJson(v);
        if (allowBanneds || card.banlistInfo == null) {
          cards!.add(card);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (cards != null) {
      data['data'] = cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

enum FNameType {
  normal,
  effect,
  ritual,
  fusion,
  synchro,
  xyz,
  link,
  normalPendulum,
  effectPendulum,
  ritualPendulum,
  fusionPendulum,
  synchroPendulum,
  xyzPendulum,
  spell,
  trap,
  token,
  skill,
}

enum Attribute { dark, earth, fire, light, water, wind, divine }

enum LinkMarker {
  topLetf,
  top,
  topRight,
  left,
  right,
  bottomLeft,
  bottom,
  bottomRight
}

class CardModel {
  int? id;
  String? name;
  String? type;
  FNameType? frameType;
  String? desc;
  String? race;
  String? archetype;
  String? ygoprodeckUrl;
  List<CardSets>? cardSets;
  List<CardImages>? cardImages;
  List<CardPrices>? cardPrices;
  int? atk;
  int? def;
  int? level;
  Attribute? attribute;
  String? pendDesc;
  String? monsterDesc;
  int? scale;
  int? linkval;
  List<LinkMarker>? linkmarkers;
  BanlistInfo? banlistInfo;

  CardModel(
      {this.id,
      this.name,
      this.type,
      this.frameType,
      this.desc,
      this.race,
      this.archetype,
      this.ygoprodeckUrl,
      this.cardSets,
      this.cardImages,
      this.cardPrices,
      this.atk,
      this.def,
      this.level,
      this.attribute,
      this.pendDesc,
      this.monsterDesc,
      this.scale,
      this.linkval,
      this.linkmarkers,
      this.banlistInfo});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['frameType'] != null) {
      if ((json['frameType'] as String).contains('_')) {
        List<String> vector = json['frameType'].split('_');
        vector[0] = vector[0].toLowerCase();
        vector[1] = vector[1][0].toUpperCase() + vector[1].substring(1);
        frameType = FNameType.values.firstWhereOrNull(
          (e) => e.name == vector.join(''),
        );
      } else {
        frameType = FNameType.values.firstWhereOrNull(
          (e) => e.name == json['frameType'],
        );
      }
    }
    frameType = json['frameType'] != null
        ? FNameType.values.firstWhereOrNull((e) => e.name == json['frameType'])
        : null;
    desc = json['desc'];
    race = json['race'];
    archetype = json['archetype'];
    ygoprodeckUrl = json['ygoprodeck_url'];
    if (json['card_sets'] != null) {
      cardSets = <CardSets>[];
      json['card_sets'].forEach((v) {
        cardSets!.add(CardSets.fromJson(v));
      });
    }
    if (json['card_images'] != null) {
      cardImages = <CardImages>[];
      json['card_images'].forEach((v) {
        cardImages!.add(CardImages.fromJson(v));
      });
    }
    if (json['card_prices'] != null) {
      cardPrices = <CardPrices>[];
      json['card_prices'].forEach((v) {
        cardPrices!.add(CardPrices.fromJson(v));
      });
    }
    atk = json['atk'];
    def = json['def'];
    level = json['level'];
    attribute = json['attribute'] != null
        ? Attribute.values
            .firstWhereOrNull((e) => e.name == json['attribute'].toLowerCase())
        : null;
    pendDesc = json['pend_desc'];
    monsterDesc = json['monster_desc'];
    scale = json['scale'];
    linkval = json['linkval'];
    if (json['linkmarkers'] != null) {
      List<String> markersStrings = json['linkmarkers'].cast<String>();
      linkmarkers = [];
      for (String stringMarker in markersStrings) {
        String realStringValue;
        if (stringMarker.contains('-')) {
          List<String> vector = stringMarker.split('-');
          vector[0] = vector[0].toLowerCase();
          realStringValue = vector.join('');
        } else {
          realStringValue = stringMarker.toLowerCase();
        }
        LinkMarker? marker = LinkMarker.values
            .firstWhereOrNull((e) => e.name == realStringValue);
        if (marker != null) {
          linkmarkers!.add(marker);
        }
      }
    } else {
      linkmarkers = null;
    }
    banlistInfo = json['banlist_info'] != null
        ? BanlistInfo.fromJson(json['banlist_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['frameType'] = frameType?.name.replaceAll('P', '_p');
    data['desc'] = desc;
    data['race'] = race;
    data['archetype'] = archetype;
    data['ygoprodeck_url'] = ygoprodeckUrl;
    if (cardSets != null) {
      data['card_sets'] = cardSets!.map((v) => v.toJson()).toList();
    }
    if (cardImages != null) {
      data['card_images'] = cardImages!.map((v) => v.toJson()).toList();
    }
    if (cardPrices != null) {
      data['card_prices'] = cardPrices!.map((v) => v.toJson()).toList();
    }
    data['atk'] = atk;
    data['def'] = def;
    data['level'] = level;
    data['attribute'] = attribute?.name.toUpperCase();
    data['pend_desc'] = pendDesc;
    data['monster_desc'] = monsterDesc;
    data['scale'] = scale;
    data['linkval'] = linkval;
    data['linkmarkers'] = linkmarkers?.map(Utils.linkMarkerToString).toList();
    if (banlistInfo != null) {
      data['banlist_info'] = banlistInfo!.toJson();
    }
    return data;
  }
}

class CardSets {
  String? setName;
  String? setCode;
  String? setRarity;
  String? setRarityCode;
  String? setPrice;

  CardSets(
      {this.setName,
      this.setCode,
      this.setRarity,
      this.setRarityCode,
      this.setPrice});

  CardSets.fromJson(Map<String, dynamic> json) {
    setName = json['set_name'];
    setCode = json['set_code'];
    setRarity = json['set_rarity'];
    setRarityCode = json['set_rarity_code'];
    setPrice = json['set_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['set_name'] = setName;
    data['set_code'] = setCode;
    data['set_rarity'] = setRarity;
    data['set_rarity_code'] = setRarityCode;
    data['set_price'] = setPrice;
    return data;
  }
}

class CardImages {
  int? id;
  String? imageUrl;
  String? imageUrlSmall;
  String? imageUrlCropped;

  CardImages(
      {this.id, this.imageUrl, this.imageUrlSmall, this.imageUrlCropped});

  CardImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    imageUrlSmall = json['image_url_small'];
    imageUrlCropped = json['image_url_cropped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['image_url_small'] = imageUrlSmall;
    data['image_url_cropped'] = imageUrlCropped;
    return data;
  }
}

class CardPrices {
  String? cardmarketPrice;
  String? tcgplayerPrice;
  String? ebayPrice;
  String? amazonPrice;
  String? coolstuffincPrice;

  CardPrices(
      {this.cardmarketPrice,
      this.tcgplayerPrice,
      this.ebayPrice,
      this.amazonPrice,
      this.coolstuffincPrice});

  CardPrices.fromJson(Map<String, dynamic> json) {
    cardmarketPrice = json['cardmarket_price'];
    tcgplayerPrice = json['tcgplayer_price'];
    ebayPrice = json['ebay_price'];
    amazonPrice = json['amazon_price'];
    coolstuffincPrice = json['coolstuffinc_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardmarket_price'] = cardmarketPrice;
    data['tcgplayer_price'] = tcgplayerPrice;
    data['ebay_price'] = ebayPrice;
    data['amazon_price'] = amazonPrice;
    data['coolstuffinc_price'] = coolstuffincPrice;
    return data;
  }
}

class BanlistInfo {
  String? banGoat;
  String? banTcg;
  String? banOcg;

  BanlistInfo({this.banGoat, this.banTcg, this.banOcg});

  BanlistInfo.fromJson(Map<String, dynamic> json) {
    banGoat = json['ban_goat'];
    banTcg = json['ban_tcg'];
    banOcg = json['ban_ocg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ban_goat'] = banGoat;
    data['ban_tcg'] = banTcg;
    data['ban_ocg'] = banOcg;
    return data;
  }
}
