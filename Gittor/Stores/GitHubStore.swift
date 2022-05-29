//
//  GitHubStore.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/28.
//

import Combine
import Foundation

/// User list view model.
class GitHubStore: ObservableObject {
	/// Network controller.
	let networkController: NetworkClientProtocol
	/// Current page number.
	private let resultsPerPage = 100

	/// Users.
	@Published var users = [User]()
	/// Selected user.
	@Published var selectedUser: User?
	/// Subscription.
	private var subscriptions = Set<AnyCancellable>()
	/// Data load flag to prevent loading data while another API is working.
	private var isLoading = false
	/// Current page number.
	private var sinceUserID = 1

	init(networkController: NetworkClientProtocol) {
		self.networkController = networkController
	}

	func fetchUsers() {
		guard !isLoading else {
			return
		}
		GitHubService().fetchUsers()
			.sink(receiveCompletion: { completion in
				switch completion {
				case let .failure(error):
					print("Couldn't get users: \(error)")
				case .finished:
					self.isLoading = false
					self.sinceUserID += self.resultsPerPage
					print("Finished.")
				}
			}, receiveValue: { value in
				self.users += value
				print(value)
			})
			.store(in: &subscriptions)
	}

	func fetchRepositories(forUser user: User, completion: @escaping (([Repository]) -> Void)) {
		guard !isLoading else {
			return
		}
		GitHubService().fetchRepositories(forUser: user)
			.sink(receiveCompletion: { completion in
				switch completion {
				case let .failure(error):
					print("Couldn't get repositories: \(error)")
				case .finished:
					self.isLoading = false
					print("Finished.")
				}
			}, receiveValue: { value in
				print(value)
				completion(value)
			})
			.store(in: &subscriptions)
	}

	func fetchUsers(pageNumber: Int) {
		guard !isLoading else {
			return
		}
		GitHubService().fetchUsers()
			.sink(receiveCompletion: { completion in
				switch completion {
				case let .failure(error):
					print("Couldn't get users: \(error)")
				case .finished: break
				}
			}, receiveValue: { [weak self] value in
				self?.users = value
				print(value)
			})
			.store(in: &subscriptions)
	}

	func fetchUser(login: String, completion: @escaping ((User) -> Void)) {
		guard !isLoading else {
			return
		}
		GitHubService().fetchUser(login: login)
			.sink(receiveCompletion: { completion in
				switch completion {
				case let .failure(error):
					print("Couldn't get users: \(error)")
				case .finished: break
				}
			}, receiveValue: { [weak self] value in
				self?.selectedUser = value
				completion(value)
				print(value)
			})
			.store(in: &subscriptions)
	}
}
