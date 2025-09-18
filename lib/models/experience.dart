import 'package:google_maps_flutter/google_maps_flutter.dart';

class Experience {
  final String id;
  final LatLng location;
  final String notes;
  final DateTime dateCreated;
  final DateTime? dateModified;

  Experience({
    required this.id,
    required this.location,
    required this.notes,
    required this.dateCreated,
    this.dateModified,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      location: LatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ),
      notes: json['notes'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateModified: json['dateModified'] != null
          ? DateTime.parse(json['dateModified'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'notes': notes,
      'dateCreated': dateCreated.toIso8601String(),
      'dateModified': dateModified?.toIso8601String(),
    };
  }

  Experience copyWith({
    String? id,
    LatLng? location,
    String? notes,
    DateTime? dateCreated,
    DateTime? dateModified,
  }) {
    return Experience(
      id: id ?? this.id,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
    );
  }

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(dateCreated);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateCreated.day}/${dateCreated.month}/${dateCreated.year}';
    }
  }

  @override
  String toString() {
    return 'Experience(id: $id, location: $location, notes: $notes, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Experience && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
