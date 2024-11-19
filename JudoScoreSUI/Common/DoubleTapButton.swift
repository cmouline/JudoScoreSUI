//
//  DoubleTapButton.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 10/10/2024.
//

import SwiftUI

struct DoubleTapButton: View {
    
    var tapAction: (() -> Void)
    var doubleTapAction: (() -> Void)
    var title: String
    
    var body: some View {
        Button(action: {
            //
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .gesture(TapGesture(count: 2).onEnded {
            doubleTapAction()
        }.exclusively(before: TapGesture(count: 1).onEnded {
            tapAction()
        }))
    }
}
