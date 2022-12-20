//
//  addScheduleView.swift
//  NotoficationTutorial2
//
//  Created by Jae hyuk Yim on 2022/12/19.
//

import SwiftUI

struct AddScheduleView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var inManager: NotificationManager
    
    @State private var scheduleDate = Date()
    
    @State private var title: String = ""
    
//    @State private var title: String = ""
//    @State private var body: String = ""
    
    var body: some View {
        
        VStack {
            VStack {
                // 알람인증을 하게 될 경우
                if inManager.isGranted {
//                    GroupBox("알람등록-Interval") {
//                        Button {
//                            // ----- Manager에서 request를 추가하는 함수를 마무리 했으므로, Interval 기능을 추가
//                            Task {
//                                var localNotification = LocalNotification(identifier: UUID().uuidString,
//                                                                          title: "월드컵 결승전",
//                                                                          timeInterval: 60,
//                                                                          // repeat 기능을 추가할 예정이므로, true로 변경함
//                                                                          repeats: true)
//                                localNotification.subtitle = "12시 시작"
//                                await inManager.schedule(localNotification: localNotification)
//
//                                // Warning! 여기까지만 해서 Build하고, Interval Notification을 클릭하면 아무일도 일어나지 않음!?
//                                // 왜? 알림은 background에서 작동하도록 되어있기 때문 -> 관리자 위임을 위해 Manager swift 파일에서 몇가지 클래스를 상속받아야 함
//                            }
//
//                        } label: {
//                            Text("Interval Notification")
//
//                        }
//                        .buttonStyle(.bordered)
//                    }
                    GroupBox("알람등록-일정") {
                        // 날짜 피커 넣고,
                        DatePicker("", selection: $scheduleDate)
                        TextField("할일을 입력해주세요", text: $title)
                        
                        // 해당 피커값을 알림에 저장하는 버튼을 생성
                        Button {
                            inManager.createLocalNotification(scheduleDate: scheduleDate, title: title)
//                            Task {
//                                let dateComponets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
//                                let localNotification = LocalNotification(identifier: UUID().uuidString,
//                                                                          title: title,
//                                                                          dateComponets: dateComponets,
//                                                                          repeats: false)
//
//                                await inManager.schedule(localNotification: localNotification)
//                            }
                            presentation.wrappedValue.dismiss()
                       } label: {
                            Text("Calender Notification")
                        }
                        .buttonStyle(.bordered)
                    }
                

                    
                    // MainView로 나가는 dismiss() 버튼
                    VStack {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Text("설정완료")
                        }
                    }
                    
                    // 알람인증 하지 않을 경우 -> 인증하라는 버튼
                } else {
                    Button {
                        inManager.openSetting()
                    } label: {
                        Text("Enable Notifications")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
            }
            
        }
    }
}

struct AddScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AddScheduleView()
            .environmentObject(NotificationManager())
    }
}
