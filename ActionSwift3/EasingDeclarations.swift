//
//  EasingDeclarations.swift
//
//  Created by CraigGrummitt on 6/08/2014.
//  Copyright (c) 2014 CraigGrummitt. All rights reserved.
//
//  Based on EasingDeclarations.h
//  AHEasing
//
//  Created by Warren Moore on 1/16/13.
//  Copyright (c) 2013 Auerhaus Development, LLC. All rights reserved.
//
//  See LICENSE file for licensing information

import Foundation

///Curve type
public enum CurveType {
  case curveTypeLinear
  case curveTypeQuadratic
  case curveTypeCubic
  case curveTypeQuartic
  case curveTypeQuintic
  case curveTypeSine
  case curveTypeCircular
  case curveTypeExpo
  case curveTypeElastic
  case curveTypeBack
  case curveTypeBounce
}

///Ease type
public enum EaseType {
  case easeTypeIn
  case easeTypeOut
  case easeTypeInOut
}
