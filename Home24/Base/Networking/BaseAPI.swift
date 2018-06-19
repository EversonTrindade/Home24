//
//  BaseAPI.swift
//  Home24
//
//  Created by Everson Trindade on 18/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol Requestable: class {
    associatedtype DataType
    func request(completion: @escaping (_ result: DataType?, _ error: CustomError?) -> Void)
}
