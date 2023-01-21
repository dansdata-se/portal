import "package:flutter/material.dart";
import "package:portal/app/routing/destination.dart";

abstract class NavigationEntry {
  NavigationEntry({
    required this.icon,
    this.selectedIcon,
    required this.destination,
  });
  final IconData icon;
  final IconData? selectedIcon;
  final DestinationWithoutParams destination;
}
