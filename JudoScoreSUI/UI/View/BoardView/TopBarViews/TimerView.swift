//
//  TimerView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 30/09/2024.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(Fight.self) private var fight

    @State private var showSetTimerAlert = false
    private var timerColor: Color {
        fight.isMainTimerRunning ? .green : .yellow
    }
    
    let minutes = Array(0...4)
    let seconds = Array(0...59)
    @State var selectedMinute: Int = 0
    @State var selectedSecond: Int = 0

    var body: some View {
        
        VStack {
            
            Button(action: {
                //
            }, label: {
                Text("\(formatTimer())")
                    .font(.custom("LemonMilk", size: 68))
                    .foregroundStyle(timerColor)
            })
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                fight.isMainTimerRunning = false
                selectedMinute = fight.mainTimerRemainingTime / 60
                selectedSecond = fight.mainTimerRemainingTime % 60
                showSetTimerAlert = true
            })
            .simultaneousGesture(TapGesture().onEnded {
                fight.isMainTimerRunning.toggle()
            })
            .onChange(of: fight.fighter1.isIppon)       { fight.isMainTimerRunning = !fight.fighter1.isIppon && fight.mainTimerRemainingTime != fight.baseTimer }
            .onChange(of: fight.fighter1.isForfeit)     { fight.isMainTimerRunning = !fight.fighter1.isForfeit && fight.mainTimerRemainingTime != fight.baseTimer }
            .onChange(of: fight.fighter1.isHansokumake) { fight.isMainTimerRunning = !fight.fighter1.isHansokumake && fight.mainTimerRemainingTime != fight.baseTimer }
            .onChange(of: fight.fighter2.isIppon)       { fight.isMainTimerRunning = !fight.fighter2.isIppon && fight.mainTimerRemainingTime != fight.baseTimer }
            .onChange(of: fight.fighter2.isForfeit)     { fight.isMainTimerRunning = !fight.fighter2.isForfeit && fight.mainTimerRemainingTime != fight.baseTimer }
            .onChange(of: fight.fighter2.isHansokumake) { fight.isMainTimerRunning = !fight.fighter2.isHansokumake && fight.mainTimerRemainingTime != fight.baseTimer }
            .onReceive(fight.generalTimer.timer) { _ in
                if fight.mainTimerRemainingTime > 0 && fight.isMainTimerRunning {
                    fight.mainTimerRemainingTime -= 1
                }
                if fight.mainTimerRemainingTime == 0 {
                    fight.isTimerFinished = true
                }
            }
            .sheet(isPresented: $showSetTimerAlert,
                   content: {
                HStack {
                    Spacer()
                    Button(action: {
                        saveNewTime()
                        showSetTimerAlert = false
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .padding()
                    .tint(.primary)
                }
                Spacer()
                VStack {
                    Text("Set main timer")
                        .font(.custom("LemonMilk", size: 20))
                        .foregroundStyle(.primary)
                   HStack {
                        Picker("minutes", selection: $selectedMinute) {
                            ForEach(minutes, id: \.self) {
                                Text("\($0)")
                                    .font(.custom("LemonMilk", size: 20))
                                    .foregroundStyle(.primary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100, height: 100)
                        Text(":")
                            .font(.custom("LemonMilk", size: 20))
                            .foregroundStyle(.primary)
                        Picker("seconds", selection: $selectedSecond) {
                            ForEach(seconds, id: \.self) {
                                Text("\($0)")
                                    .font(.custom("LemonMilk", size: 20))
                                    .foregroundStyle(.primary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100, height: 100)
                    }
                }
                Spacer()
            })
        }
    }
    
    func formatTimer() -> String {
        return "\(fight.mainTimerRemainingTime / 60):\(String(format: "%02d", fight.mainTimerRemainingTime % 60))"
    }
    
    func saveNewTime() {
        fight.mainTimerRemainingTime = (selectedMinute * 60) + selectedSecond
    }
    
    func pauseTimer() {
        fight.isMainTimerRunning = false
    }
    
    func resumeTimer() {
        fight.isMainTimerRunning = true
    }
}

#Preview {
    TimerView()
}
