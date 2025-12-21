import 'package:flutter/material.dart';

final InputDecoration dropdownDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.grey[300]!),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.grey[300]!),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: Color(0xFF0052FF), width: 2.0),
  ),
);
