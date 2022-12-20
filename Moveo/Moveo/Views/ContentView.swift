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
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    var body: some View {
        VStack {
            if loginSignupStore.currentUser != nil {
                ContainTabView()
            } else {
                LodingAndLoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginSignupStore())
    }
}
