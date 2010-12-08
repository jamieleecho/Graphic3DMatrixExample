/*
 *  MatrixSpecializations.cpp
 *  SimpleMatrix
 *
 *  Created by Jamie Cho on 11/13/07.
 *  Copyright 2007 Jamie Cho. All rights reserved.
 *
 */

#include "Matrix.h"


// Indicates that the matrix should be transposed before the operation
const char *jcho::MatrixTranspose = "T";

// Indicates that the matrix should NOT be transposed before the operation
const char *jcho::MatrixNoTranspose = "N";

namespace jcho {
  template<>
  jcho::Matrix<double> jcho::Matrix<double>::operator *(const Matrix<double> &a) const {
    return multiply<cblas_dgemm>(a);
  }


  template<>
  jcho::Matrix<double> jcho::Matrix<double>::operator /(const Matrix<double> &a) const {
    return divide<dgesv_>(a);
  }


  template<>
  jcho::Matrix<double> jcho::Matrix<double>::linear_least_squares(const Matrix<double> &a) const {
    if (a.m() != m())
      throw Exception("linear_least_squares(const Matrix<T> &): This operation can only be applied when a.m() == this->m().");
    return least_squares<dgels_>(a);
  }
  
  template<>
  double jcho::Matrix<double>::dot(const Matrix<double> &v) const {
    AssertSameDimensions(v);
    AssertIsVector();
    return cblas_ddot(m() == 1 ? n() : m(), _storage, 1, v._storage, 1);
  }  
  template<>

  double jcho::Matrix<double>::length() const {
    AssertIsVector();
    return cblas_dnrm2(m() == 1 ? n() : m(), _storage, 1);
  }  
}