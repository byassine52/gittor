//
//  NetworkServiceProtocol.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Combine
import Foundation

protocol NetworkServiceProtocol {
	/// Network conteoller.
	var networkController: NetworkClientProtocol { get }

	/// Fetch users.
	/// - Returns: Users
	func fetchUsers() -> AnyPublisher<[User], Error>
	/// Fetch non-forked repositories.
	/// - Returns: Users
	func fetchRepositories(forUser user: User) -> AnyPublisher<[Repository], Error>
	/// Fetch Users by page number.
	/// - Parameter pageNumber: Page number.
	/// - Returns: Users by page number.
	func fetchUsers(pageNumber: Int) -> AnyPublisher<[User], Error>
	/// Fetch user information.
	/// - Parameter id: Identifier.
	/// - Returns: User information.
	func fetchUser(login: String) -> AnyPublisher<User, Error>
}
