//
//  Extensions.swift
//  InterestingNumbers
//
//  Created by Данік on 30/06/2023.
//

import Foundation
import UIKit

protocol HasApply { }

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }

