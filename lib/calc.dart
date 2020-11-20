// lists, maps and info
var orbital_capacities = {"S": 2, "P": 6, "D": 10, "F": 14};
var orbitals = <String>[
  "1S",
  "2S",
  "2P",
  "3S",
  "3P",
  "4S",
  "3D",
  "4P",
  "5S",
  "4D",
  "5P",
  "6S",
  "4F",
  "5D",
  "6P",
  "7S",
  "5F",
  "6D",
  "7P"
];
var gases = {
  "He": 2,
  "Ne": 10,
  "Ar": 18,
  "Kr": 36,
  "Xe": 54,
  "Rn": 86,
};
var gases_cons = {
  "He": "2S",
  "Ne": "3S",
  "Ar": "4S",
  "Kr": "5S",
  "Xe": "6S",
  "Rn": "7S",
};

// get orbital capacity by name
int getOrbitalCap(String orb) {
  for (String k in orbital_capacities.keys) {
    int v = orbital_capacities[k];
    if (orb.contains(k)) {
      return v;
    }
  }
  return 0;
}

// get nearest stable gas by electrons count
dynamic getNearestGas(int numm) {
  dynamic nearest = false;
  for (String g in gases.keys) {
    int v = gases[g];
    if (numm > v) {
      nearest = g;
    }
  }
  return nearest;
}

// calculate, distribute and return results
String calculateElectrons(int count, bool byNearestGas) {
  String result = "";
  dynamic gas = false;
  bool gasCon = false; // let it continue after gas
  if (byNearestGas) {
    gas = getNearestGas(count);
    if (gas != false) {
      count -= gases[gas];
      // subtract the value of nearest stable gas from the total count of electrons
    }
  }
  for (final o in orbitals) {
    if (count <= 0) {
      break;
    }
    if (gas != false && gasCon == false && gases_cons[gas] == o) {
      gasCon = true;
    }
    if ((gas == false) || (gas != false && gasCon == true)) {
      var o_cap = getOrbitalCap(o);
      if (count <= o_cap && count > 0) {
        result = result + o + " (" + count.toString() + ")";
        count = 0;
      } else {
        result = result + o + " (" + o_cap.toString() + "), ";
        count -= o_cap;
      }
    }
  }
  if (gas != false) {
    var comma = ", ";
    if (result == "") {
      comma = "";
    }
    result = "[" + gases[gas].toString() + gas + "]" + comma + result;
  }
  return result;
}
