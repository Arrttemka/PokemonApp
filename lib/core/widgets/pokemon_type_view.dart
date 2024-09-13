import 'package:flutter/material.dart';

Widget pokemonTypeView(String type) {
  Color color;

  switch (type) {
    case 'normal':
      color = Color(0xFFbdbeb0);
      break;
    case 'poison':
      color = Color(0xFF995E98);
      break;
    case 'psychic':
      color = Color(0xFFE96EB0);
      break;
    case 'grass':
      color = Color(0xFF9CD363);
      break;
    case 'ground':
      color = Color(0xFFE3C969);
      break;
    case 'ice':
      color = Color(0xFFAFF4FD);
      break;
    case 'fire':
      color = Color(0xFFE7614D);
      break;
    case 'rock':
      color = Color(0xFFCBBD7C);
      break;
    case 'dragon':
      color = Color(0xFF8475F7);
      break;
    case 'water':
      color = Color(0xFF6DACF8);
      break;
    case 'bug':
      color = Color(0xFFC5D24A);
      break;
    case 'dark':
      color = Color(0xFF886958);
      break;
    case 'fighting':
      color = Color(0xFF9E5A4A);
      break;
    case 'ghost':
      color = Color(0xFF7774CF);
      break;
    case 'steel':
      color = Color(0xFFC3C3D9);
      break;
    case 'flying':
      color = Color(0xFF81A2F8);
      break;
    case 'fairy':
      color = Color(0xFFEEB0FA);
      break;
    default:
      color = Colors.black;
      break;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}