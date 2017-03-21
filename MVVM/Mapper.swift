//
//  Mapper.swift
//  MVVM
//
//  Created by DaoNV on 3/17/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

// MARK: Scalar mapping

infix operator =!: AssignmentPrecedence
func =! (lhs: inout String, rhs: String?) {
    guard let rhs = rhs else {
        lhs = ""
        return
    }
    lhs = rhs
}

func =! <T: Integer>(lhs: inout T, rhs: T?) {
    guard let rhs = rhs else {
        lhs = 0
        return
    }
    lhs = rhs
}

func =! (lhs: inout Double, rhs: Double?) {
    guard let rhs = rhs else {
        lhs = 0
        return
    }
    lhs = rhs
}

func =! (lhs: inout Float, rhs: Float?) {
    guard let rhs = rhs else {
        lhs = 0
        return
    }
    lhs = rhs
}
