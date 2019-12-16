//
//  ArcTouchService.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation

class ChallengeService {
    
    func getChallenge(_ completion: @escaping (Challenge?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://codechallenge.arctouch.com/quiz/1")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let challenge = ChallengeMapper().map(json)
                completion(challenge, nil)
            } catch {
                completion(nil, error)
            }
        })
        task.resume()
    }
}
