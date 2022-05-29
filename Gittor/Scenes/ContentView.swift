//
//  ContentView.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/28.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var store: GitHubStore

	var body: some View {
		NavigationView {
			List(store.users) { user in
				NavigationLink(destination: RepositoryView(user: user, store: store)) {
					UserRow(user: user)
				}
			}
			.navigationTitle("User List")
		}
		.onAppear(perform: store.fetchUsers)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(
			ColorScheme.allCases,
			id: \.self,
			content: ContentView(store: GitHubStore(networkController: NetworkClient())).preferredColorScheme
		)
	}
}
