//
//  JSON.swift
//  Demo
//
//  Created by Yassine ElBadaoui on 2022/05/28.
//  Copyright © 2022 Yassine Elbadaoui All rights reserved.
//

import Foundation

/// JSON struct.
enum JSON {
	/// Encoder.
	static let encoder: JSONEncoder = {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601
		encoder.outputFormatting = .prettyPrinted
		return encoder
	}()

	/// Decoder.
	static let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()
}

extension DateFormatter {
	static var iso8601DateTime: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		return formatter
	}()
}
