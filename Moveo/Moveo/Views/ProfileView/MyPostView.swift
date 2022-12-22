//
//  MyPostView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPostView : View {
    @Binding var post : Post
    var body: some View {
        WebImage(url: URL(string: post.postImageUrl))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 175)
            .clipped()
            .cornerRadius(10)
    }
}

