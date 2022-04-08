import 'dart:convert';

import 'dart:math';

class EncryptionUtil {
  final _letter_map = {
    'A': '-',
    'a': 'l',
    'B': '9',
    'b': 'M',
    'C': '&',
    'c': '3',
    'D': 'j',
    'd': 'A',
    'E': '*',
    'e': 'W',
    'F': 't',
    'f': '8',
    'G': 'C',
    'g': 'v',
    'H': '1',
    'h': 'G',
    'I': '@',
    'i': 'E',
    'J': 'Z',
    'j': 'N',
    'K': 'f',
    'k': '2',
    'L': 'n',
    'l': 'F',
    'M': 'R',
    'm': 'L',
    'N': 'u',
    'n': '6',
    'O': '#',
    'o': 'g',
    'P': 'D',
    'p': '5',
    'Q': 'J',
    'q': '0',
    'R': 'K',
    'r': 'b',
    'S': 'I',
    's': 'X',
    'T': 'm',
    't': '7',
    'U': 'H',
    'u': '=',
    'V': 's',
    'v': 'q',
    'W': '4',
    'w': 'P',
    'X': 'h',
    'x': 'i',
    'Y': 'k',
    'y': 'o',
    'Z': 'd',
    'z': 'U',
    '0': '!',
    '1': 'O',
    '2': 'w',
    '3': 'V',
    '4': 'c',
    '5': 'B',
    '6': 'Y',
    'y': 'p',
    '8': 'e',
    '9': 'T',
    ' ': 'Q',
    '(': 'S',
    ')': 'a',
    '?': 'x'
  };
  //rz

  /// Encrypts [plainTxt] based on some strong encryption method :)
  ///
  /// It finally returns encrypted string
  String encryptContent(String plainTxt) {
    print('Plain text: ' + plainTxt);
    String mappedTxt = _mapTxt(plainTxt);
    print('Mapped text: ' + mappedTxt);
    String perm = _permutation(mappedTxt);
    print('Swap two half of the text: ' + perm);
    String cipher = _addExtraChars(perm);
    print('Cipher text: ' + cipher);
    String encoded = base64.encode(utf8.encode(cipher));
    String decoded = utf8.decode(base64.decode(encoded));
    print('Base64 Coded text: ' + encoded);
    print('Decoed: ' + decoded);
    return encoded;
  }

  /// Performs character mapping on the [input] based on [_letter_map]
  String _mapTxt(String input) {
    String mapped = '';
    for (int i = 0; i < input.length; i++) {
      if (_letter_map.containsKey(input[i]))
        mapped += ''; //_letter_map[input[i]];
      else
        mapped += input[i];
    }
    return mapped;
  }

  /// Performs a simple text permutation
  String _permutation(String input) {
    int half = (input.length / 2).floor();
    String perm = input.substring(half) + input.substring(0, half);
    return perm;
  }

  /// Adds a random character after each character in the [input]
  String _addExtraChars(String input) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*()_+';
    Random _rnd = Random();
    String result = '';
    for (int i = 0; i < input.length; i++) {
      result += input[i] + _chars[_rnd.nextInt(_chars.length)];
    }
    return result;
  }
}
