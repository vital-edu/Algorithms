// Instruction: Write a code fragment to print the transposition
// (rows and columns changed) of a two-dimensional array with
// M rows and N columns.

main(List<String> args) {
  var arr = [
    [1, 2, 3, 10, 11],
    [4, 5, 6, 12, 13],
    [7, 8, 9, 14, 15],
    [16, 17, 18, 19, 20],
    [21, 22, 23, 24, 25],
  ];
  print('Before:');
  printMatrix(arr);

  print('\nAfter:');
  printMatrix(transposeMatrix(arr));
}

void printMatrix<T>(List<List<T>> matrix) {
  int size = matrix.length;
  for (int i = 0; i < size; i++) {
    print(matrix[i].join(' '));
  }
}

List<List<T>> transposeMatrix<T>(List<List<T>> matrix) {
  int size = matrix.length;

  for (int i = 0; i < size; i++) {
    for (int j = i; j < size; j++) {
      T temp = matrix[i][j];
      matrix[i][j] = matrix[j][i];
      matrix[j][i] = temp;
    }
  }
  return matrix;
}
