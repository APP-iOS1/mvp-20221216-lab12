//
//  CommentView.swift
//  Moveo
//
//  Created by 기태욱 on 2022/12/20.
//

import SwiftUI

struct CommentView: View {
    
    @EnvironmentObject var commentStore : CommentStore
    
    //@State private var myComment
    
    var comment : Comment
    
    var body: some View {
        VStack{
            Text("댓글")
                .font(.title3)
            
            Divider()
            
            
            HStack{
                Image(comment.profileImage)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
                    .scaledToFit()
                    .frame(width: 50)
                
                
                VStack(alignment: .leading) {
                    
                    //TO DO: nickname firestroe로부터 불러와야하는 부분
                    Text(comment.nickName)
                        .font(.callout)
                        .fontWeight(.medium)
                    
                }
                
                Spacer()
            }
            .padding(.leading, 10)
            
            
            HStack{
                Text(comment.commentText)
                Spacer()
            }
            .padding(.leading, 20)
            
            HStack{
                Text(comment.commentDate)
                Spacer()
            }
            .padding(.leading, 20)
            
            
            Spacer()
            
            
            Spacer()
            
            
            HStack{
                Image(comment.profileImage)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
                    .scaledToFit()
                    .frame(width: 40)
                
                //TextField("댓글 달기", )
            }
            
        }
        
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(id: "fdasfdsafdsafdas", nickName: "위고 요리스", profileImage: "https://firebasestorage.googleapis.com:443/v0/b/moveo-2f0df.appspot.com/o/5786CE4C-7120-4176-8DDF-809E67381A1D?alt=media&token=6b27711f-633a-4fd3-b956-7f0056d5a6e1", commentText: "운동합시다", commentDate: "2022-12-25 11:11:11"))

    }
}
