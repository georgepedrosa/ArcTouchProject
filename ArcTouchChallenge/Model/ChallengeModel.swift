//
//  ChallengeModel.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation

struct Challenge {
  let question: String
  let answers: [String]
}

class ChallengeMapper {
  func map(_ dictionary: [String: Any]) -> Challenge? {
    guard let question = dictionary["question"] as? String else { return nil }
    guard let answers = dictionary["answer"] as? [String] else { return nil }
    
    return Challenge(question: question, answers: answers)
  }
}
