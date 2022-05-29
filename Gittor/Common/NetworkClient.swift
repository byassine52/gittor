//
//  NetworkClient.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Combine
import Foundation

protocol NetworkClientProtocol: AnyObject {
	typealias Headers = [String: Any]

	/// Send `GET` HTTP request.
	/// - Parameter endpoint: Endpoint.
	/// - Returns: Publisher with specified decoding type.
	func get<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

final class NetworkClient: NetworkClientProtocol {
	func get<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
		let urlRequest: URLRequest = {
			var request = URLRequest(url: endpoint.url)
			endpoint.headers.forEach { (key, value) in
				request.setValue(value, forHTTPHeaderField: key)
			}
			return request
		}()
		print("Fetching `GET` \(urlRequest.url?.absoluteString ?? "")")
		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.map(\.data)
			.decode(type: T.self, decoder: JSON.decoder)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}

}
