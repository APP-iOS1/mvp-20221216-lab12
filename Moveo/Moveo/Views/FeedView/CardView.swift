//
//  CardView.swift
//  Moveo
//
//  Created by 기태욱 on 2022/12/20.
//

import SwiftUI
import SDWebImageSwiftUI


struct CardView: View {
    @EnvironmentObject var postStore: PostStore
    
    
    @State private var markToggle1 = true

    
    var post: Post
    
    var body: some View {
        ZStack {
            VStack {
                VStack{
                    HStack {
                        Image("Feed_3@2x")
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
                            .scaledToFit()
                            .frame(width: 75)

                        
                        // 닉네임, 시간 레이아웃 수정
                        VStack(alignment: .leading) {
                            Text("wego_gym")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Text("40 min")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            //                    Text("4o min")
                        }
                        .offset(x:-10)
                        Spacer()
                        
                        Button {
                            markToggle1.toggle()
                        } label: {
                            if markToggle1 {
                                Image(systemName: "bookmark")
                                    .foregroundColor(Color.gray)
                            } else {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(Color.mainColor)
                            }
                        }
                        .padding(.trailing)
                    }
                }
                
                WebImage(url: URL(string: post.postImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 370, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                
                ZStack {
                    Text(post.bodyText)
                        .zIndex(1)
                    
                    Rectangle()
                        .frame(width: 330, height: 80)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CardView(post: Post(id: "5786CE4C-7120-4176-8DDF-809E67381A1D", bodyText: "빡공~~!", postImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/moveo-2f0df.appspot.com/o/5786CE4C-7120-4176-8DDF-809E67381A1D?alt=media&token=6b27711f-633a-4fd3-b956-7f0056d5a6e1", postDate: "2022-12-20 00:48:10", postCategory: "공부", writerUid: "", profileImage: "", nickName: ""))
    }
}
