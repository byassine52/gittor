//
//  CustomStringConvertible.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Foundation

extension CustomStringConvertible where Self: Codable {
	var description: String {
		var description = "\n \(type(of: self)) \n"
		let selfMirror = Mirror(reflecting: self)
		for child in selfMirror.children {
			if let propertyName = child.label {
				description += "\(propertyName): \(child.value)\n"
			}
		}
		return description
	}
}
