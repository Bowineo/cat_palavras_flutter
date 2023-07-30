import 'dart:math';
import 'package:cat_palavras_game/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'letters.dart';

List<String> kJsonWord = ['assets/dictionaries/pt_br.json'];
String kLogo = 'assets/images/logo.png';
String kTitle = 'Cat Palavras Game';
String kRules =
    'Baseado no jogo de sucesso Torto da revista Coquetel, esta é uma versão gatificada! Forme palavras seguindo em todos as direções, sempre ligando as letras em sequência direta, sem pular e sem repetir letras (para que uma palavra tenha letra repetida, é necessário que a mesma letra também esteja duplicada no diagrama). Só valem palavras de 4 letras ou mais. Boa sorte e divirta-se!';

List<List<String>> generateRandomMatrix(int rows, int cols) {
  List<List<String>> matrix =
      List.generate(rows, (_) => List<String>.filled(cols, ''));
  final Random random = Random();
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      if (random.nextBool()) {
        matrix[row][col] = vowels[random.nextInt(vowels.length)];
      } else {
        matrix[row][col] = consonants[random.nextInt(consonants.length)];
      }
    }
  }
  return matrix;
}

List<List<String>> invalidRandomMatrix(int rows, int cols) {
  List<List<String>> matrix =
      List.generate(rows, (_) => List<String>.filled(cols, ''));
  final Random random = Random();
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      if (random.nextBool()) {
        matrix[row][col] = vowelsInvalid[random.nextInt(vowelsInvalid.length)];
      } else {
        matrix[row][col] = consonants[random.nextInt(consonants.length)];
      }
    }
  }
  return matrix;
}

bool isVowel(String letter) {
  return letter == 'A' ||
      letter == 'E' ||
      letter == 'I' ||
      letter == 'O' ||
      letter == 'U';
}

bool matrixValidate(List<List<String>> matrix) {
  final int rows = matrix.length;
  final int cols = matrix[0].length;

  int vowelCount = 0;
  Set<String> uniqueVowels = <String>{};
  Set<String> uniqueConsonants = <String>{};

  for (int row = 0; row < rows; row++) {
    int vowelRow = 0;

    for (int col = 0; col < cols; col++) {
      String cell = matrix[row][col];

      if (isVowel(cell)) {
        vowelCount++;
        uniqueVowels.add(cell);
        vowelRow++;
      } else {
        uniqueConsonants.add(cell);
        if (!hasAdjacentVowel(matrix, row, col)) {
          return false;
        }
      }
      if (countConsonant(matrix, cell) > 2) {
        return false;
      }
    }

    if (vowelRow == 0) {
      return false;
    }
  }
  if (vowelCount < 7 || vowelCount > 8) {
    return false;
  }

  if (uniqueVowels.length < 3 || uniqueConsonants.isEmpty) {
    return false;
  }

  for (int i = 0; i < rows - 1; i++) {
    if (matrix[i].toSet().intersection(matrix[i + 1].toSet()).isNotEmpty) {
      return false;
    }
  }

  for (int j = 0; j < cols - 1; j++) {
    Set<String> currentColumn = <String>{};
    Set<String> nextColumn = <String>{};
    for (int i = 0; i < rows; i++) {
      currentColumn.add(matrix[i][j]);
      nextColumn.add(matrix[i][j + 1]);
    }
    if (currentColumn.intersection(nextColumn).isNotEmpty) {
      return false;
    }
  }
  return true;
}

bool hasAdjacentVowel(List<List<String>> matrix, int row, int col) {
  final int rows = matrix.length;
  final int cols = matrix[0].length;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int newRow = row + i;
      int newCol = col + j;
      if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
        if (isVowel(matrix[newRow][newCol])) {
          return true;
        }
      }
    }
  }
  return false;
}

int countConsonant(List<List<String>> matrix, String consonant) {
  int count = 0;
  for (List<String> row in matrix) {
    for (String cell in row) {
      if (!isVowel(cell) && cell == consonant) {
        count++;
      }
    }
  }
  return count;
}

void printMatrix(List<List<String>> matrix) {
  for (List<String> row in matrix) {
    print(row.join(' '));
  }
}

bool isWordValid(String word, List<List<String>> matrix) {
  final int rows = matrix.length;
  final int cols = matrix[0].length;

  word = word.toUpperCase();

  List<List<bool>> usedPositions =
      List.generate(rows, (_) => List<bool>.filled(cols, false));

  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      if (isWordPossible(word, matrix, usedPositions, row, col)) {
        return true;
      }
    }
  }

  return false;
}

bool isWordPossible(String word, List<List<String>> matrix,
    List<List<bool>> usedPositions, int row, int col) {
  if (word.isEmpty) {
    return true;
  }

  final int rows = matrix.length;
  final int cols = matrix[0].length;

  if (row >= 0 && row < rows && col >= 0 && col < cols) {
    if (usedPositions[row][col]) {
      return false;
    }

    if (matrix[row][col] == word[0]) {
      usedPositions[row][col] = true;

      bool isPossible = isWordPossible(
              word.substring(1), matrix, usedPositions, row - 1, col - 1) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row - 1, col) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row - 1, col + 1) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row, col - 1) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row, col + 1) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row + 1, col - 1) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row + 1, col) ||
          isWordPossible(
              word.substring(1), matrix, usedPositions, row + 1, col + 1);

      if (!isPossible) {
        usedPositions[row][col] = false;
      }

      return isPossible;
    }
  }

  return false;
}

String getCharacterByIndex(int index, List<List<String>> list) {
  int contador = 0;
  for (int i = 0; i < list.length; i++) {
    for (int j = 0; j < list[i].length; j++) {
      if (contador == index) {
        return list[i][j];
      }
      contador++;
    }
  }
  return '';
}

List<String> listMatrix(List<List<String>> list) {
  List<String> listMatrix = [];
  for (int i = 0; i < list.length; i++) {
    for (int j = 0; j < list[i].length; j++) {
      listMatrix.add(list[i][j]);
    }
  }
  return listMatrix;
}

void showValidationPopup(BuildContext context, String validWord) {
  showDialog(
    barrierColor: Colors.black54,
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
      });

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Parabéns palavra válida:',
                style: textDefault,
              ),
            ),
            Text(
              '' "$validWord" '',
              style: textWord,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
            ),
          ],
        ),
      );
    },
  );
}
