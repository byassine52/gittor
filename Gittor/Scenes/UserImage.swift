//
//  UserImage.swift
//  Gittor
//
//  Created by Yassine ElBadaoui on 2022/05/30.
//  Copyright © 2022 Yassine ElBadaoui. All rights reserved.
//

import SwiftUI

struct UserImage: View {
	/// Item.
	var user: User

	var body: some View {
		AsyncImage(url: user.avatarUrl){ phase in
			if let image = phase.image {
				image.resizable().scaledToFit() // Displays the loaded image.
			} else if phase.error != nil {
				Color.red // Indicates an error.
			} else {
				Color.gray // Normal placeholder.
			}
		}
		.frame(width: 50, height: 50)
		.cornerRadius(8)
	}
}
