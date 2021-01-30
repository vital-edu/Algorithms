// Instruction: Matrix library. Write a library Matrix that implements the
// following API:
// public class Matrix
// ----------------------------------API----------------------------------------
// static double dot(double[] x, double[] y)           | vector dot product
// static double[][] mult(double[][] a, double[][] b)  | matrix-matrix product
// static double[][] transpose(double[][] a)           | transpose
// static double[] mult(double[][] a, double[] x)      | matrix-vector product
// static double[] mult(double[] y, double[][] a)      | vector-matrix product
// -----------------------------------------------------------------------------
// Develop a test client that reads values from standard input and tests all
// the methods.

import '../../../../utils/assert.dart';

main(List<String> args) {
  List<double> a11 = [1, 3, -5];
  List<double> b11 = [4, -2, -1];

  List<List<double>> a23 = [
    [1, 2, 3],
    [4, 5, 6],
  ];
  List<List<double>> b32 = [
    [7, 8],
    [9, 10],
    [11, 12],
  ];

  Assert.equal(Matrix.dot(a11, b11), 3);
  Assert.deepEqual(Matrix.mult(a23, b32), [
    [58.0, 64.0],
    [139.0, 154.0],
  ]);
  Assert.deepEqual(Matrix.transpose(b32), [
    [7, 9, 11],
    [8, 10, 12],
  ]);
  Assert.deepEqual(Matrix.multMatrixVector(a23, a11), [-8, -11]);
  Assert.deepEqual(Matrix.multVectorMatrix(a11, a23), [-8, -11]);
}

class Matrix {
  static double dot(List<double> x, List<double> y) {
    Assert.equal(x.length, y.length);
    double result = 0;
    for (int i = 0; i < x.length; i++) {
      result += x[i] * y[i];
    }

    return result;
  }

  static List<List<double>> mult(List<List<double>> x, List<List<double>> y) {
    // X: matrix M x N
    // Y: matrix N x P
    // Result: matrix M x P
    final m = x.length;
    final n = y.length;
    final p = y.length > 0 ? y.first.length : 0;

    List<List<double>> result = List(m);

    for (int i = 0; i < m; i++) {
      result[i] = List<double>(p);
      for (int j = 0; j < p; j++) {
        result[i][j] = 0;
        for (int k = 0; k < n; k++) {
          result[i][j] += x[i][k] * y[k][j];
        }
      }
    }

    return result;
  }

  static List<List<double>> transpose(List<List<double>> a) {
    int m = a.length;
    int n = a.length > 0 ? a.first.length : 0;
    return List.generate(n, (i) => List.generate(m, (j) => a[j][i]));
  }

  static List<double> multMatrixVector(List<List<double>> a, List<double> x) {
    final m = a.length;
    final n = a.length > 0 ? a.first.length : 0;
    assert(
      x.length == n,
      'vector must have the same size of the columns of the matrix: ${x.length} != $n',
    );
    List<double> result = List.filled(m, 0);

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        result[i] += a[i][j] * x[j];
      }
    }

    return result;
  }

  static List<double> multVectorMatrix(List<double> x, List<List<double>> a) {
    return multMatrixVector(a, x);
  }
}
