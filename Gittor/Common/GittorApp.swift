//
//  GittorApp.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/28.
//  Copyright © 2022 Yassine Elbadaoui All rights reserved.
//

import SwiftUI

@main
struct GittorApp: App {
	@StateObject private var store = GitHubStore(networkController: NetworkClient())

	var body: some Scene {
		WindowGroup {
			ContentView(store: store)
		}
	}
}
