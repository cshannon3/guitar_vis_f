// Any list of music related stuff that might be accessed by multiple widgets

import 'package:flutter/material.dart';

List<String> notenames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" ];
List<int> sharps = [1, 3 ,6,8, 10];
List<int> majorscale = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24];

List<int> rootnotes = [4, 9, 14, 19, 23, 28];

List<List<int>> tunings = [[4, 9, 14, 19, 23, 28],[2, 9, 14, 19, 23, 28], // Drop D
[2, 9, 14, 19, 23, 26], // Double drop d
[2, 7, 14, 19, 23, 26] // open G
];

List<String> scalenames = <String>[
  '', 'Major', 'Minor', 'Harmonic', 'Melodic', "Blues"];

List<List<int>> scales =
[[0,2,4,5,7,9,11,12,14,16,17,19,21,23,24], // major Scale
[0,2,3,5,7,8,10,12,14,15,17,19,20,22,24], // minor Scale
[0,2,3,5,7,8,11,12,14,15,17,19,20,23,24],  // harmonic
[0,2,3,5,7,9,11,12,14,15,17,19,21,23,24],  // melodic
[0,2,3,5,6,7,11,12,14,15,17,18,19,23,24],   // Blues scale
];

List<String> modenames = <String>[
  '', 'Ionian', 'Dorian', 'Phrygian', 'Lydian',
    'Mixolydian', 'Aeolian', 'Locrian'];

List<List<int>> modes =
[[0,2,4,5,7,9,11,12,14,16,17,19,21,23,24], // Ionian
[0,2,3,5,7,8,10,12,14,15,17,19,20,22,24], // Dorian
[0,1,3,5,7,8,10,12,13,15,17,19,20,22,24],  // Phrygian
[0,2,4,6,7,9,11,12,14,16,18,19,21,23,24],  // Lydian
[0,2,4,5,7,9,10,12,14,16,17,19,21,22,24],   // Mizolydian
[0,2,3,5,7,8,10,12,14,15,17,19,20,22,24],   // Aeolian
[0,1,3,5,6,8,10,12,13,15,17,18,20,22,24],   // Locrian
];

List<String> chordnames = <String>[
  '', 'Major', 'Minor', 'dom7', 'maj7',
  'sus2', 'sus4', 'dim', 'aug',
  'min6', 'min7', 'min/maj7', 'dim7', 'halfdim'
];
List<List<int>> chords = [[0, 4, 7],// major chord
[0, 3, 7], // minor chord
[0, 4, 7, 10], // dom7
[0, 4, 7, 11], // maj7
[0, 4, 7, 9], // maj6
[0, 2, 7], // sus2
[0, 5, 7], // sus4
[0, 3, 6, 9], // dim
  [0,4,8], //aug
  [0,4,8,10], // aug7
  [0,3,7,9], // min6
  [0,3,7,10], // min7
  [0,3,7,11], // min/maj7
  [0,3,6,9], //dim7
  [0,3,6,10], // halfdim
];

Color getColor(double tnote) {
  return Color.lerp(Colors.red, Colors.blue, tnote / 12);
}