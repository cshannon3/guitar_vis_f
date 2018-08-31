// Any list of music related stuff that might be accessed by multiple widgets

List<String> notenames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" ];
List<int> sharps = [1, 3 ,6,8, 10];
List<int> majorscale = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24];

List<int> rootnotes = [4, 9, 14, 19, 23, 28];

List<List<int>> tunings = [[4, 9, 14, 19, 23, 28],[2, 9, 14, 19, 23, 28], // Drop D
[2, 9, 14, 19, 23, 26], // Double drop d
[2, 7, 14, 19, 23, 26] // open G
];


List<List<int>> scales = [[0,2,4,5,7,9,11,12], // major Scale
[0,2,3,5,7,8,10,12], // minor Scale
[0,2,3,5,7,8,11,12], // harmonic
[0,2,3,5,7,9,11,12], // melodic
[0,2,3,5,6,7,11,12]  // Blues scale
];
List<List<int>> chords = [[0, 4, 7],// major chord
[0, 3, 7], // minor chord
[0, 4, 7, 10], // 7
[0, 4, 7, 11], // maj7
[0, 2, 7], // sus2
[0, 5, 7], // sus4
[0, 3, 6, 9] // dim
];
