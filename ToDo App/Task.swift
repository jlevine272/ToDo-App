//
//  Task.swift
//  ToDo App
//
//  Created by Josh Levine on 7/21/19.
//  Copyright © 2019 Josh Levine. All rights reserved.
//

import Foundation

class Task {
    
    var title : String
    var complete : Bool
    
    init(title: String, complete: Bool = false) {
        self.title = title
        self.complete = complete
    }
}
