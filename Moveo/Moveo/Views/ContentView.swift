//
//  ContentView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

extension Color{
    static let mainColor = Color("mainColor")
    static let backgroundColor = Color("backgroundColor")
    static let pointGray = Color("pointGray")
}

struct ContentView: View {
    @EnvironmentObject var loginSignStore: LoginSignupStore
    var body: some View {
        VStack {
            if loginSignStore.currentUser != nil {
                ContainTabView()
            } else {
                LodingAndLoginView()
            }
        }
//        .onAppear {
//            loginSignStore.fetchUser()
//        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginSignupStore())
    }
}
