//
//  GitHubService.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Combine
import Foundation

/// GitHub service.
struct GitHubService: NetworkServiceProtocol {
	let networkController: NetworkClientProtocol

	init(networkController: NetworkClientProtocol = NetworkClient()) {
		self.networkController = networkController
	}

	func fetchUsers() -> AnyPublisher<[User], Error> {
		return networkController.get(endpoint: .users)
	}

	func fetchRepositories(forUser user: User) -> AnyPublisher<[Repository], Error> {
		return networkController.get(endpoint: .repos(login: user.login))
	}

	func fetchUsers(pageNumber: Int) -> AnyPublisher<[User], Error> {
		return networkController.get(endpoint: .users(pageNumber: pageNumber))
	}

	func fetchUser(login: String) -> AnyPublisher<User, Error> {
		return networkController.get(endpoint: .user(login: login))
	}
}
