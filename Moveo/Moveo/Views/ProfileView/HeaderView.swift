//
//  HeaderView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/22.
//

import SwiftUI

// Sticky Header 치면 나옴
struct HeaderView: View {
    @Binding var myToggle: Bool
    @Binding var bookToggle: Bool
    @Binding var menuXAxis: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.backgroundColor)
                .frame(height: 40)
            VStack {
                HStack {
                    Button {
                        myToggle = true
                        bookToggle = false
                        menuXAxis = -90
                    } label: {
                        Text("My")
                            .foregroundColor(myToggle ? .mainColor : .black)
                    }
                    
                    Spacer()
                    
                    Button {
                        bookToggle = true
                        myToggle = false
                        menuXAxis = 90
                    } label: {
                        Text("Bookmark")
                            .foregroundColor(bookToggle ? .mainColor : .black)
                    }
                }
                .padding(.leading, 95)
                .padding(.trailing, 65)
                
                Rectangle()
                    .fill(Color.mainColor)
                    .animation(.linear(duration: 0.2), value: menuXAxis)
                    .offset(x: menuXAxis)
                    .frame(width: 160, height: 5)
            }
        }
    }
}


