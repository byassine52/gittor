//
//  Repository.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import Foundation

/// Repository.
struct Repository: Codable, Identifiable {
	struct License: Codable {
		let name: String?
		let spdxId: String?
		let nodeId: String?
		let key: String?
		let url: String?
	}

	let license: License?

	struct Owner: Codable {
		let organizationsUrl: String?
		let reposUrl: String?
		let htmlUrl: String?
		let siteAdmin: Bool?
		let gravatarId: String?
		let starredUrl: String?
		let avatarUrl: String?
		let type: String?
		let gistsUrl: String?
		let login: String?
		let followersUrl: String?
		let id: Int
		let subscriptionsUrl: String?
		let followingUrl: String?
		let receivedEventsUrl: String?
		let nodeId: String?
		let url: String?
		let eventsUrl: String?
	}

	let owner: User?

	struct Permission: Codable {
		let maintain: Bool?
		let triage: Bool?
		let push: Bool?
		let admin: Bool?
		let pull: Bool?
	}

	let permissions: Permission?

	let pullsUrl: String?
	let hasProjects: Bool?
	let cloneUrl: URL
	let size: Double?
	let gitUrl: String?
	let gitTagsUrl: String?
	let id: Int
	let defaultBranch: String?
	let issueEventsUrl: String?

	let archived: Bool?
	let downloadsUrl: String?
	let homepage: String?
	let teamsUrl: String?
	let url: URL
	let hasPages: Bool?
	let hooksUrl: String?
	let htmlUrl: String?
	let issuesUrl: String?
	let fullName: String?
	let fork: Bool
	let description: String?
	let openIssues: Int?
	let notificationsUrl: String?
	let sshUrl: String?
	let stargazersCount: Int
	let issueCommentUrl: String?
	let compareUrl: String?
	let languagesUrl: String?
	let watchers: Int?
	let milestonesUrl: String?
	let branchesUrl: String?
	let collaboratorsUrl: String?
	let hasIssues: Bool?
	let archiveUrl: String?
	let forks: Int?
	let createdAt: Date?
	let assigneesUrl: String?
	let openIssuesCount: Int?
	let labelsUrl: String?
	let forksCount: Int?
	let eventsUrl: String?
	let blobsUrl: String?
	let hasDownloads: Bool?
	let svnUrl: String?
	let forksUrl: String?
	let `private`: Bool?
	let releasesUrl: String?
	let disabled: Bool?
	let language: String?
	let allowForking: Bool?
	let pushedAt: Date?
	let visibility: String?
	let contentsUrl: String?
	let statusesUrl: String?
	let tagsUrl: String?
	let gitRefsUrl: String?
	let stargazersUrl: String?
	let name: String
	let updatedAt: Date?
	let subscriptionUrl: String?
	let contributorsUrl: String?
	let treesUrl: String?
	let keysUrl: String?
	let hasWiki: Bool?
	let gitCommitsUrl: String?
	let commitsUrl: String?
	let watchersCount: Int?
	let deploymentsUrl: String?
	let subscribersUrl: String?
	let mergesUrl: String?
	let isTemplate: Bool?
	let nodeId: String?
	let commentsUrl: String?
}
