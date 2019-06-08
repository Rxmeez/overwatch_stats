import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Stats competitiveStats;
  int endorsement;
  String endorsementIcon;
  int gamesWon;
  String icon;
  int level;
  String levelIcon;
  String name;
  int prestige;
  String prestigeIcon;
  bool private;
  Stats quickPlayStats;
  int rating;
  String ratingIcon;

  Welcome({
    this.competitiveStats,
    this.endorsement,
    this.endorsementIcon,
    this.gamesWon,
    this.icon,
    this.level,
    this.levelIcon,
    this.name,
    this.prestige,
    this.prestigeIcon,
    this.private,
    this.quickPlayStats,
    this.rating,
    this.ratingIcon,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => new Welcome(
        competitiveStats: Stats.fromJson(json["competitiveStats"]),
        endorsement: json["endorsement"],
        endorsementIcon: json["endorsementIcon"],
        gamesWon: json["gamesWon"],
        icon: json["icon"],
        level: json["level"],
        levelIcon: json["levelIcon"],
        name: json["name"],
        prestige: json["prestige"],
        prestigeIcon: json["prestigeIcon"],
        private: json["private"],
        quickPlayStats: Stats.fromJson(json["quickPlayStats"]),
        rating: json["rating"],
        ratingIcon: json["ratingIcon"],
      );

  Map<String, dynamic> toJson() => {
        "competitiveStats": competitiveStats.toJson(),
        "endorsement": endorsement,
        "endorsementIcon": endorsementIcon,
        "gamesWon": gamesWon,
        "icon": icon,
        "level": level,
        "levelIcon": levelIcon,
        "name": name,
        "prestige": prestige,
        "prestigeIcon": prestigeIcon,
        "private": private,
        "quickPlayStats": quickPlayStats.toJson(),
        "rating": rating,
        "ratingIcon": ratingIcon,
      };
}

class Stats {
  Awards awards;
  Games games;

  Stats({
    this.awards,
    this.games,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => new Stats(
        awards: Awards.fromJson(json["awards"]),
        games: Games.fromJson(json["games"]),
      );

  Map<String, dynamic> toJson() => {
        "awards": awards.toJson(),
        "games": games.toJson(),
      };
}

class Awards {
  int cards;
  int medals;
  int medalsBronze;
  int medalsSilver;
  int medalsGold;

  Awards({
    this.cards,
    this.medals,
    this.medalsBronze,
    this.medalsSilver,
    this.medalsGold,
  });

  factory Awards.fromJson(Map<String, dynamic> json) => new Awards(
        cards: json["cards"],
        medals: json["medals"],
        medalsBronze: json["medalsBronze"],
        medalsSilver: json["medalsSilver"],
        medalsGold: json["medalsGold"],
      );

  Map<String, dynamic> toJson() => {
        "cards": cards,
        "medals": medals,
        "medalsBronze": medalsBronze,
        "medalsSilver": medalsSilver,
        "medalsGold": medalsGold,
      };
}

class Games {
  int played;
  int won;

  Games({
    this.played,
    this.won,
  });

  factory Games.fromJson(Map<String, dynamic> json) => new Games(
        played: json["played"],
        won: json["won"],
      );

  Map<String, dynamic> toJson() => {
        "played": played,
        "won": won,
      };
}

Future<String> getData() async {
  http.Response response = await http.get(
      Uri.encodeFull("https://ow-api.com/v1/stats/pc/eu/Rameez-2620/profile"),
      headers: {"Accept": "application/json"});

  print(response.body);
}
