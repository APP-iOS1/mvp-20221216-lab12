//
//  FollowersView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/22.
//

import SwiftUI

struct FollowersView : View {
    var text1 : Int
    var text2 : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("\(text1)")
                .font(.system(size: 16, weight: .semibold))
            Text(text2)
                .font(.system(size: 15))
        }
    }
}


