import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/experience.dart';

class ExperienceProvider with ChangeNotifier {
  List<Experience> _experiences = [];
  bool _isLoading = false;
  String? _error;

  List<Experience> get experiences => List.unmodifiable(_experiences);
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get experienceCount => _experiences.length;

  Future<void> initialize() async {
    _setLoading(true);
    try {
      _clearError();
    } catch (e) {
      _setError('Failed to initialize: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addExperience({
    required LatLng location,
    required String notes,
  }) async {
    try {
      final experience = Experience(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        location: location,
        notes: notes,
        dateCreated: DateTime.now(),
      );

      _experiences.add(experience);
      notifyListeners();
    } catch (e) {
      _setError('Failed to add experience: $e');
      rethrow;
    }
  }

  Future<void> updateExperience({
    required String id,
    String? notes,
  }) async {
    try {
      final index = _experiences.indexWhere((exp) => exp.id == id);
      if (index == -1) {
        throw Exception('Experience not found');
      }

      final existingExperience = _experiences[index];
      final updatedExperience = existingExperience.copyWith(
        notes: notes ?? existingExperience.notes,
        dateModified: DateTime.now(),
      );

      _experiences[index] = updatedExperience;
      notifyListeners();
    } catch (e) {
      _setError('Failed to update experience: $e');
      rethrow;
    }
  }

  Future<void> deleteExperience(String id) async {
    try {
      _experiences.removeWhere((exp) => exp.id == id);
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete experience: $e');
      rethrow;
    }
  }

  Experience? getExperienceById(String id) {
    try {
      return _experiences.firstWhere((exp) => exp.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Experience> getExperiencesNearLocation(LatLng location, double radiusKm) {
    return _experiences.where((exp) {
      final distance = _calculateDistance(
        location.latitude,
        location.longitude,
        exp.location.latitude,
        exp.location.longitude,
      );
      return distance <= radiusKm;
    }).toList();
  }

  Future<void> clearAllExperiences() async {
    try {
      _experiences.clear();
      notifyListeners();
    } catch (e) {
      _setError('Failed to clear experiences: $e');
      rethrow;
    }
  }


  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;
    
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * asin(sqrt(a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
