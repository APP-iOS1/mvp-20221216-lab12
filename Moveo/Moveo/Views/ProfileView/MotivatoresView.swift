//
//  MotivatoresView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MotivatorsView : View {
    @EnvironmentObject var followingStore : FollowStore
    @EnvironmentObject var loginSignupStore : LoginSignupStore
    @State var buttonToggle = true
     var user : User
    var body: some View {
        VStack(spacing: 5) {
            WebImage(url: URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text(user.nickName)
                .font(.system(size: 13, weight: .semibold))
                .padding(.bottom, 1)
            Button {
                buttonToggle.toggle()
                if buttonToggle {
                    followingStore.deleteFollowing(user: user)
                } else {
                    followingStore.addFollowing(user: user)
                }
            } label: {
                if buttonToggle {
                    Text("팔로우")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 50)
                        .background(Color("mainColor"))
                        .cornerRadius(50)
                } else {
                    Text("팔로잉")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 50)
                        .background(Color.pointGray)
                        .cornerRadius(50)
                }
                
            }
        }
        .onAppear {
            loginSignupStore.currentUserDataInput()
            followingStore.fetchFollowing()
            self.buttonToggle = followingStore.checkFollwing(user: user)
        }
        .frame(width: 80, height: 110)
        
    }
}


