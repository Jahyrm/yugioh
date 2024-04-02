class ArchetypeResponse {
  List<Archetype>? archetypes;

  ArchetypeResponse({this.archetypes});

  ArchetypeResponse.fromJson(List<dynamic>? json) {
    if (json != null) {
      archetypes = <Archetype>[];
      for (var v in json) {
        archetypes!.add(Archetype.fromJson(v));
      }
    }
  }

  List<dynamic> toJson() {
    final List<dynamic> data = <dynamic>[];
    if (archetypes != null) {
      data.addAll(archetypes!.map((v) => v.toJson()).toList());
    }
    return data;
  }
}

class Archetype {
  String? name;

  Archetype({this.name});

  Archetype.fromJson(Map<String, dynamic> json) {
    name = json['archetype_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['archetype_name'] = name;
    return data;
  }
}
