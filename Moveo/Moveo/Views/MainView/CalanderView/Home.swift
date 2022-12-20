//
//  Home.swift
//  KavasoftCalender
//
//  Created by 전근섭 on 2022/12/17.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var sampleTasks: SampleTask
    @EnvironmentObject var inManager: NotificationManager
    @State private var showModal: Bool = false
    @State private var currentDate: Date = Date()
    @State private var bottomSheetActivated: Bool = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            HStack {
                Image("moveoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                Spacer()
                
                NavigationLink {
                    // TODO: - 설정페이지 연결(알림에 대한 설정을 추가하게 된다면 사용 아니면 삭제)
                } label: {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.mainColor)
                    
                }
                
                NavigationLink {
                    AddPostView()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.mainColor)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    CustomDatePicker(currentDate: $currentDate)
                }
                .padding(.vertical)
            }
//            .safeAreaInset(edge: .bottom) {
//                Button {
//                    bottomSheetActivated.toggle()
//                } label: {
//                    Text("일정 추가")
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.orange, in: Capsule())
//                }
//                .padding(.horizontal)
//                .padding(.top)
//                .foregroundColor(.white)
//                .background(.ultraThinMaterial)
//                .sheet(isPresented: $bottomSheetActivated) {
//                    AddSchedule()
//                        .presentationDetents([.medium, .large])
//                }
//            }
            VStack {
                VStack {
                    Button {
                        self.showModal = true
                    } label: {
                        Text("일정등록")
                    }
                    .sheet(isPresented: self.$showModal) {
                        AddScheduleView()
                            .presentationDetents([.fraction(0.6)])
                    }
                }
                .task {
                    try? await inManager.requestAuthorization()
                }
//                .onChange(of: scenePhase) { newValue in
//                    if newValue == .active {
//                        Task {
//                            await inManager.getCurrentSetting()
//                            await inManager.getPendingRequests()
//                        }
//                    }
//                }
                
                VStack {
                    List {
                        ForEach(inManager.pendingRequests, id: \.identifier) { request in
                            VStack(alignment: .leading) {
                                    Text(request.content.title)
                                    Spacer()
                                    HStack {
                                        Text(request.identifier)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                            }
                            // Swipe를 통해 리스트 삭제
                            .swipeActions {
                                Button(role: .destructive) {
                                    inManager.removeRequest(withIdentifier: request.identifier)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                    
                }
            }
            // 오늘의 일정 view
            // 같은 날에 일정을 여러 개 추가할 수 있는데 해당 날짜에 일정이 없을 때 "추가된 일정이 없습니다" 문구가 안 나옴
//            VStack(spacing: 15) {
//                Text("오늘의 일정")
//                    .font(.title2.bold())
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.vertical, 20)
//
//                if let task = sampleTasks.sortedTasks.filter({ task in
//                    isSameDay(date1: task.taskDate, date2: currentDate)
//                }) {
//
//                    // schedule toggle 카드
//                    ForEach(task, id: \.id) { t in
//                        ForEach(t.task) { j in
//                            HStack {
//                                ScheduleToggle(time: t.taskTime, title: j.title )
//
//                            }
//                        }
//                    }
//
//
//                } else {
//                    Text("추가된 일정이 없습니다")
//                }
//            }
//            .animation(.spring(), value: currentDate)
//            .padding()
//            .padding(.top, 25)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(SampleTask())
    }
}
