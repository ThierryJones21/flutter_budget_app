import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> myTransactions = [
  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Food',
    'TotalAmount': '-\$ 10',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.gasPump, color: Colors.white),
    'color': Colors.purple[300],
    'name': 'Gas',
    'TotalAmount': '-\$ 50',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white),
    'color': Colors.green[700],
    'name': 'Health',
    'TotalAmount': '-\$ 149',
    'date': 'Yesterday',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.planeArrival, color: Colors.white),
    'color': Colors.red[700],
    'name': 'Travel',
    'TotalAmount': '-\$ 349',
    'date': 'Yesterday',
  }
];