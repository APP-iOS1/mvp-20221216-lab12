//
//  AddSchedule.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/18.
//

import SwiftUI

struct AddSchedule: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var sampleTasks: SampleTask
    @EnvironmentObject var inManager: NotificationManager
    //    @EnvironmentObject var schedule: Schedule
    
    @State private var todoTitle: String = ""
    @State private var scheduledDay: Date = Date()
    @State private var scheduledTime: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("할 일", text: $todoTitle)
                    DatePicker("날짜", selection: $scheduledDay, displayedComponents: .date)
                    DatePicker("시간", selection: $scheduledTime, displayedComponents: .hourAndMinute)
                } header: {
                    Text("추가할 목록")
                }
                
            }
            .background(.ultraThinMaterial)
            .navigationTitle("일정 추가")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        Task {
                            let dateComponets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduledDay)
                            var localNotification = LocalNotification(identifier: UUID().uuidString,
                                                                      title: todoTitle,
                                                                      dateComponets: dateComponets,
                                                                      repeats: false)
                            
                            await inManager.schedule(localNotification: localNotification)
                        }
                        
                        // 근섭님 코드
                        addScheduleToTasks(time: scheduledTime)
                        dismiss()
                    } label: {
                        Text("추가")
                    }
                })
            }
        }
    }
    
    func addScheduleToTasks(time: Date) {
        sampleTasks.sortedTasks.append(contentsOf: [TaskMetaData(task: [Task(title: todoTitle)], taskDate: scheduledDay, taskTime: time)]
        )
    }
}

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
            .environmentObject(SampleTask())
            .environmentObject(NotificationManager())
        //            .environmentObject(Schedule())
    }
}
