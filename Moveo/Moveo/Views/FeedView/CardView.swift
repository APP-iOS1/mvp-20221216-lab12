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
    
    @State private var likeToggle = true
    @State private var markToggle = true
    
    // Modal
    @State private var showModal : Bool = false
    
    var post: Post
    
    var body: some View {
        ZStack {
            VStack {
                VStack{
                    HStack {
                        if post.profileImage != "" {
                            WebImage(url: URL(string: post.profileImage))
                                .resizable()
                                .cornerRadius(25)
                                .frame(width: 50, height: 50)
                        } else {
                            Image(systemName: "person.circle")
                                .font(.system(size: 50))
                                .foregroundColor(Color(.label))
                        }

                        VStack(alignment: .leading) {
                            Text(post.nickName)
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Text(post.postDate)
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            markToggle.toggle()
                             //TO DO : 북마크 클릭시 액션
                        } label: {
                            if markToggle {
                                Image(systemName: "bookmark")
                                    .foregroundColor(Color.gray)
                            } else {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(Color.mainColor)
                            }
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.bottom, 5)
                }
                
                WebImage(url: URL(string: post.postImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 370, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                
                VStack(alignment: .leading){
                    Text(post.bodyText)
                        .frame(width: 350, alignment: .leading)

                    //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                    
                }
                .frame(width: 360, alignment: .leading)
                .padding(.top, 5)
                .padding(.leading, 10)
                .padding(.bottom, 10)

                
                HStack{
                    HStack {
                        Button {
                            likeToggle.toggle()
                        } label: {
                            if likeToggle {
                                Image(systemName: "heart")
                                    .foregroundColor(Color.black)
                            } else {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                        Text("1.1k")
                            .font(.caption2)
                            .fontWeight(.light)
                        
                        NavigationLink(destination: {
                            CommentView(post: post)
                        }, label: {
                            Image(systemName: "message")
                                .font(.title3)
                        })
                        
                        //TO DO : comment의 사용자 id를 카운트 해서 반영

                    }
                    Spacer()
                }
                .padding(.leading, 20)
                
                Divider()
                    .padding()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CardView(post: Post(id: "5786CE4C-7120-4176-8DDF-809E67381A1D", bodyText: "빡공~~!", postImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/moveo-2f0df.appspot.com/o/5786CE4C-7120-4176-8DDF-809E67381A1D?alt=media&token=6b27711f-633a-4fd3-b956-7f0056d5a6e1", postDate: "2022-12-20 00:48:10", postCategory: "공부", writerUid: "", profileImage: "", nickName: ""))
    }
}
