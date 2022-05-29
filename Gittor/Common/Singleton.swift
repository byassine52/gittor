//
//  Singleton.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Foundation

/// Singleton protocol.
protocol Singleton: AnyObject {
	/// Shared instance.
	static var shared: Self { get }
}
