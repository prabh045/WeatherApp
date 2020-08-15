//
//  Box.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
