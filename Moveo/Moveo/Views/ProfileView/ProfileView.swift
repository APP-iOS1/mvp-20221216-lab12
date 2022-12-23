//
//  ProfileView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
// TODO: - 형태는 유지하되 전체적으로 데이터를 받아와서 보여줄 수 있도록 할 것
struct ProfileView: View {
    @StateObject var loginSignupStore: LoginSignupStore = LoginSignupStore()
    @StateObject var postStore : PostStore = PostStore()
    @StateObject var followingStore : FollowStore = FollowStore()
    
    @State var isExpanded = false
    @State var subviewHeight : CGFloat = 0
    @State var motiDegree : CGFloat = 90
    @State var judgeMoti : Bool = false
    
    @State var isSelected = 0
    
    @State var myToggle: Bool = true
    @State var bookToggle: Bool = false
    @State var menuXAxis: Double = -90
    
    @State private var isSelectedMenu: Bool = false
    
    var columns : [GridItem] = Array(repeating: GridItem(.flexible(), spacing: nil, alignment: nil), count: 2)
    // 내 포스트와 북마크된 포스트들의 배열
    @State var bookMarkedPosts : [Post] = []
    @State var myPosts : [Post] = []
    // Motivators에 나를 제외한 유저들을 보여줌
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack(spacing: 15) {
                        Text(loginSignupStore.currentUserData?.nickName ?? "")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Button {

                            
                        } label: {
                            Text("check")
                        }

                        
                        NavigationLink(destination: {
                            Text("보관함")
                        }, label: {
                            Image(systemName: "tray.full")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                        })
                        
                        Button {
                            isSelectedMenu.toggle()
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                                .bold()
                        }
                        
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .confirmationDialog("메뉴", isPresented: $isSelectedMenu) {
                        Button("로그아웃", role: .destructive) {
                            loginSignupStore.logout()
                        }
                    }
                    
                    ScrollView {
                        VStack {
                            HStack(spacing: 50) {
                                WebImage(url: URL(string: loginSignupStore.currentUserData?.profileImageUrl ?? ""))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                FollowersView(text1: self.countMyPosts(), text2: "게시물")
                                FollowersView(text1: followingStore.followers.count, text2: "팔로워")
                                FollowersView(text1: followingStore.followings.count, text2: "팔로잉")
                            }
                            .padding(.vertical, 10)
                            
                            Text(loginSignupStore.currentUserData?.description ?? "")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            //.padding(.bottom)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(loginSignupStore.currentUserData?.category ?? [], id: \.self) { category in
                                        Text(category)
                                            .padding()
                                            .font(.caption)
                                            .frame(width: 80, height: 30)
                                            .foregroundColor(.white)
                                            .background { Color.mainColor }
                                            .cornerRadius(50)
                                            .onTapGesture {
                                                fetchMyPosts(category: category)
                                            }
                                    }
                                    Image(systemName: "plus.circle.fill")
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                        .font(.title)
                                }
                                .padding(.leading, 20)
                            }
                            //                .padding(.bottom)
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Motivators")
                                        .font(.system(size: 15, weight: .bold))
                                        .padding(.leading, 10)
                                    
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .font(.system(size: 15, weight: .bold))
                                        .rotationEffect(Angle(degrees: motiDegree))
                                }
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.25)) {
                                        isExpanded.toggle()
                                        judgeMoti.toggle()
                                        if judgeMoti {
                                            self.motiDegree = 0
                                        } else{
                                            self.motiDegree = 90
                                            
                                        }
                                    }
                                }
                                .padding(.leading)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(loginSignupStore.usersExceptMe) { user in
                                            MotivatorsView(user: user)
                                        }
                                    }
                                }
                            }
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewHeightKey.self,
                                                       value: $0.frame(in: .local).size.height)
                            })
                            .onPreferenceChange(ViewHeightKey.self) { subviewHeight = $0 }
                            .frame(height: isExpanded ? 15 : subviewHeight, alignment: .top)
                            .clipped()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .bottom))
                            
                            Divider()
                            
                        }
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header: HeaderView(myToggle: $myToggle, bookToggle: $bookToggle, menuXAxis: $menuXAxis)) {
                                if myToggle {
                                    LazyVGrid(columns: columns) {
                                        ForEach($myPosts) { post in
                                            MyPostView(post: post)
                                        }
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    
                                } else {
                                    LazyVGrid(columns: columns) {
                                        ForEach($bookMarkedPosts) { post in
                                            MyPostView(post: post)
                                        }
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                }
            }
        }
        .task {
            postStore.fetchPosts()
            loginSignupStore.fetchUser()
            loginSignupStore.fetchUsersExceptMe()
            makeBookMarkedPosts()
            fetchMyPosts(category:loginSignupStore.currentUserData?.category[0] ?? "")
            loginSignupStore.currentUserDataInput()
           
            followingStore.fetchFollowing()
            followingStore.fetchFollower()
        }
    }
    
    // 위 bookMarkedPosts 배열에 북마크된 포스트들만 담아주는 배열
    func makeBookMarkedPosts() {
        self.bookMarkedPosts = []
        guard let currentUser = loginSignupStore.currentUserData else { return }
        
        for post in postStore.posts {
            if currentUser.bookmark.contains(post.id) {
                bookMarkedPosts.append(post)
            }
        }
    }
    
    func fetchMyPosts(category : String) {
        self.myPosts = []
        guard let currentUser = loginSignupStore.currentUserData else { return }
        
        for post in postStore.posts {
            if post.writerUid == currentUser.id {
                if post.postCategory == category {
                    myPosts.append(post)
                }
            }
        }
    }
    
    func countMyPosts() -> Int {
        var count = 0
        guard let currentUser = loginSignupStore.currentUserData else { return 0 }
        for post in postStore.posts {
            if post.writerUid == currentUser.id {
                count += 1
            }
        }
        return count
    }
    

}









struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
