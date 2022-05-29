//
//  Endpoint.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Foundation

/// Endpoint.
struct Endpoint {
	var path: String
	var queryItems: [URLQueryItem] = []
	private let username = <#username#>
	private let personalToken = <#personalToken#>
}

extension Endpoint {

	var url: URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.github.com"
		components.path = path
		components.queryItems = queryItems

		guard let url = components.url else {
			preconditionFailure("Invalid URL components: \(components)")
		}

		return url
	}

	var headers: [String: String] {
		guard let credentialData = "\(username):\(personalToken)".data(using: String.Encoding.utf8) else {
			return [:]
		}
		let credential = credentialData.base64EncodedString(options: [])
		let basicData = "Basic \(credential)"
		let userAgent = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
		return [
			"Authorization": basicData,
			"User-Agent": userAgent
		]
	}
}

extension Endpoint {
	static var users: Self {
		return Endpoint(path: "/users")
	}

	static func users(pageNumber: Int) -> Self {
		return Endpoint(path: "/users", queryItems: [URLQueryItem(name: "page", value: "\(pageNumber)")])
	}

	static func user(login: String) -> Self {
		return Endpoint(path: "/users/\(login)")
	}

	static func repos(login: String) -> Self {
		return Endpoint(path: "/users/\(login)/repos")
	}
}

