//
//  User.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Foundation

/// User.
struct User: Codable, Identifiable, CustomStringConvertible {
	let avatarUrl: URL
	let blog: String?
	let company: String?
	let createdAt: Date?
	let email: String?
	let eventsUrl: String?
	let followers: Int?
	let followersUrl: String?
	let following: Int?
	let followingUrl: String?
	let gistsUrl: String?
	let gravatarId: String?
	let htmlUrl: String?
	let id: Int
	let location: String?
	let login: String
	let name: String?
	let nodeId: String?
	let organizationsUrl: String?
	let publicGists: Int?
	let publicRepos: Int?
	let receivedEventsUrl: String?
	let reposUrl: String?
	let siteAdmin: Bool?
	let starredUrl: String?
	let subscriptionsUrl: String?
	let twitterUsername: String?
	let type: UserType
	let updatedAt: Date?
	let url: String?

	init(avatarUrl: URL, blog: String? = nil, company: String? = nil, createdAt: Date? = nil, email: String? = nil, eventsUrl: String, followers: Int? = nil, followersUrl: String, following: Int? = nil, followingUrl: String, gistsUrl: String, gravatarId: String, htmlUrl: String, id: Int, location: String? = nil, login: String, name: String? = nil, nodeId: String, organizationsUrl: String, publicGists: Int? = nil, publicRepos: Int? = nil, receivedEventsUrl: String, reposUrl: String, siteAdmin: Bool = false, starredUrl: String, subscriptionsUrl: String, twitterUsername: String? = nil, type: UserType = .user, updatedAt: Date? = Date(), url: String) {
		self.avatarUrl = avatarUrl
		self.blog = blog
		self.company = company
		self.createdAt = createdAt
		self.email = email
		self.eventsUrl = eventsUrl
		self.followers = followers
		self.followersUrl = followersUrl
		self.following = following
		self.followingUrl = followingUrl
		self.gistsUrl = gistsUrl
		self.gravatarId = gravatarId
		self.htmlUrl = htmlUrl
		self.id = id
		self.location = location
		self.login = login
		self.name = name
		self.nodeId = nodeId
		self.organizationsUrl = organizationsUrl
		self.publicGists = publicGists
		self.publicRepos = publicRepos
		self.receivedEventsUrl = receivedEventsUrl
		self.reposUrl = reposUrl
		self.siteAdmin = siteAdmin
		self.starredUrl = starredUrl
		self.subscriptionsUrl = subscriptionsUrl
		self.twitterUsername = twitterUsername
		self.type = type
		self.updatedAt = updatedAt
		self.url = url
	}
}

/// User type.
enum UserType: String, Codable {
	case user = "User"
	case organization = "Organization"
}
