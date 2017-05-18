//
//  Enums.swift
//  pushups
//
//  Created by Alexander, Jared on 12/23/15.
//  Copyright © 2015 tysonsapps. All rights reserved.
//

enum Voice: Int {
    case male = 0
    case female = 1
    case child = 2

    static var count: Int { return Voice.child.rawValue + 1 }
    
    var description: String {
        switch self {
            case .male: return "Male"
            case .female: return "Female"
            case .child   : return "Child"
        }
    }
    
    var value: Float {
        switch self {
            case .male: return 0.7
            case .female: return 1.5
            case .child   : return 2.5
        }
    }
}
