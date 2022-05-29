//
//  RepositoryView.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import SwiftUI

struct RepositoryView: View {
	/// User,.
	@State var user: User
	/// Repository
	@State var repositories = [Repository]()
	/// Store.
	@ObservedObject var store: GitHubStore

	@ViewBuilder
	var headerView: some View {
		HStack {
			UserImage(user: user)
			VStack(alignment: .leading) {
				Text(user.name ?? "")
					.font(.headline)
				Text("@\(user.login)")
					.font(.subheadline)
			}
			Spacer()
		}
	}

	var followStatisticsView: some View {
		HStack {
			VStack {
				Text("Followers #")
					.font(.headline)
				Text("\(user.followers ?? 0)")
			}
			VStack {
				Text("Followees #")
					.font(.headline)
				Text("\(user.following ?? 0)")
			}
		}
	}

	var repositoryListView: some View {
		List(repositories) { repository in
			Link(destination: repository.cloneUrl) {
				RepositoryRow(repository: repository)
			}
		}
	}

	var body: some View {
		VStack {
			headerView
			Spacer()
				.frame(height: 20)
			followStatisticsView
			repositoryListView
			Spacer()
		}
		.padding()
		.navigationBarTitle(Text(user.login), displayMode: .inline)
		.onAppear {
			store.fetchUser(login: user.login) { self.user = $0 }
			store.fetchRepositories(forUser: user) { repositories = $0 }
		}
	}
}

struct RepositoryView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(
			ColorScheme.allCases,
			id: \.self,
			content: RepositoryView(user: Constants.user, store: GitHubStore(networkController: NetworkClient())).preferredColorScheme
		)
	}
}
