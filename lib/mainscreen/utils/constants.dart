import 'package:flutter/cupertino.dart';

const Color secondaryColor = Color(0xffFFF3D9);
final Color cardColor = const Color(0xff420000).withOpacity(0.5);
const Color primaryColor = Color(0xff420000);

Map<String, String> collegeToColList = Map<String, String>.unmodifiable({
  "UCD": "ucd",
  "TCD": "tcd",
  "Maynooth": "maynooth",
  "NUI Galway": "nui",
  "DCU": "dcu",
  "TU Dublin": "tu",
  "TUD": "tud",
  "UCC": "ucc",
  "RSCI Royal College of Surgeons": "rsci",
  "Barrister-Kings Inn": "barrister",
  "Dundalk IT": "dundalk",
  "IT Sligo": "sligo",
  "LYIT Letterkenny": "lyit",
  "IT Carlow": "carlow",
  "IT Tralee": "tralee",
  "Cork IT ": "cork",
  "IADT Dun Laoghaire": "iadt",
  "Hibernia College": "hibernia",
  "Portobello Institute": "portobello",
  "Marino College": "marino",
  "OpenTraining College": "open",
});

Map<String, String> colToCollegeList = Map<String, String>.unmodifiable({
  "ucd": "UCD",
  "tcd": "TCD",
  "maynooth": "Maynooth",
  "nui": "NUI Galway",
  "dcu": "DCU",
  "tu": "TU Dublin",
  "tud": "TUD",
  "ucc": "UCC",
  "rsci": "RSCI Royal College of Surgeons",
  "barrister": "Barrister-Kings Inn",
  "dundalk": "Dundalk IT",
  "sligo": "IT Sligo",
  "lyit": "LYIT Letterkenny",
  "carlow": "IT Carlow",
  "tralee": "IT Tralee",
  "cork": "Cork IT",
  "iadt": "IADT Dun Laoghaire",
  "hibernia": "Hibernia College",
  "portobello": "Portobello Institute",
  "marino": "Marino College",
  "open": "OpenTraining College",
});
