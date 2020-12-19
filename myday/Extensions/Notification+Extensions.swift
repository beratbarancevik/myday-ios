//
//  Notification+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Foundation

extension Notification.Name {
    static let loadingShouldStart = Notification.Name("loadingShouldStart")
    static let loadingShouldFinish = Notification.Name("loadingShouldFinish")
    static let requestDidFail = Notification.Name("requestDidFail")
    static let requestDidSucceed = Notification.Name("requestDidSucceed")
}
