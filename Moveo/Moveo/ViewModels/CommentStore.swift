

import Foundation
import FirebaseFirestore

class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    
    let database = Firestore.firestore()
    
    init() {
        comments = []
    }

  
    func fetchComments(postid: String) {
        database.collection("post")
            .document(postid).collection("comment").order(by: "commentDate", descending: true)
            .getDocuments { (snapshot, error) in
                self.comments.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        let commentText: String = docData["commentText"] as? String ?? ""
                        let commentDate: String = docData["commentDate"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        
                        let comment: Comment = Comment(id: id, nickName: nickName, profileImage: "", commentText: commentText, commentDate: commentDate)
                        
                        self.comments.append(comment)
                        
                    }
                }
            }
    }
    
    func addComment(_ postid: String, comment: Comment) {
        database.collection("post")
            .document(postid)
            .collection("Comment")
            .document(comment.id)
            .setData(["commentText": comment.commentText,
                      "commentDate": comment.commentDate,
                      "nickName": comment.nickName,
                      "profileImage": comment.profileImage
                     ])
        
        fetchComments(postid: postid)
    }
    
    
    func removeComment(_ comment: Comment, postid: String) {
        database.collection("posts")
            .document(postid)
            .collection("Comment")
            .document(comment.id).delete()
        fetchComments(postid: postid)
    }
}
