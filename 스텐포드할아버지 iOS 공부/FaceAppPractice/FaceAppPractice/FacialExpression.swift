//
//  FacialExpression.swift
//  FaceAppPractice
//
//  Created by CHANGGUEN YU on 10/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import Foundation

struct FacialExpression {
  enum Eyes: Int {
    case Open
    case Closed
    case Squinting
  }
  enum EyeBrows: Int {
    case Relaxed
    case Normal
    case Furrowed
    
    func moreRelaxedBrow() -> EyeBrows {
      return EyeBrows(rawValue: rawValue - 1) ?? EyeBrows.Relaxed
    }
    
    func moreFurrowedBrow() -> EyeBrows {
      return EyeBrows(rawValue: rawValue + 1) ?? EyeBrows.Furrowed
    }
  }
  enum Mouth: Int {
    case Frown
    case Smirk
    case Neutral
    case Grin
    case Smile
    
    func sadderMouth() -> Mouth {
      return Mouth(rawValue: rawValue - 1) ?? Mouth.Frown
    }
    
    func happierMouth() -> Mouth {
      return Mouth(rawValue: rawValue + 1) ?? Mouth.Smile
    }
  }
  
  var eyes: Eyes
  var eyeBrows: EyeBrows
  var mouth: Mouth
}
