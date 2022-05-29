//
//  RepositoryRow.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import SwiftUI

/// Repository row.
struct RepositoryRow: View {
	/// Repository.
	let repository: Repository

	var body: some View {
		VStack {
			HStack {
				Label(repository.name, systemImage: "internaldrive")
				Spacer()
				VStack(alignment: .trailing) {
					Label("\(repository.stargazersCount)", systemImage: "star")
						.foregroundColor(.orange)
					HStack {
						Spacer()
						Text(repository.language ?? "")
							.foregroundColor(.white)
							.background(Color.green)
					}
				}
			}
			HStack {
				Text(repository.description ?? "")
					.lineLimit(0)
					.foregroundColor(.black)
					.font(.subheadline)
				Spacer()
			}
		}
	}
}

struct RepositoryRow_Previews: PreviewProvider {
	static var previews: some View {
		RepositoryRow(repository: Constants.repository)
			.previewLayout(PreviewLayout.sizeThatFits)
			.previewDisplayName("Repository Row")
	}
}
