//
//  UserRow.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import SwiftUI

struct UserRow: View {
	/// Item.
	var user: User

	var body: some View {
		HStack {
			UserImage(user: user)
			Text(user.login)
		}
	}
}

struct UserRow_Previews: PreviewProvider {
	static var previews: some View {
		UserRow(user: Constants.user)
			.previewLayout(PreviewLayout.sizeThatFits)
			.previewDisplayName("User Cell")
	}
}
