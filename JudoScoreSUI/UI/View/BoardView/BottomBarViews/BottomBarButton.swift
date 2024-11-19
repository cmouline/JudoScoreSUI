//
//  BottomBarButton.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 10/10/2024.
//

import SwiftUI

struct BottomBarButton: View {
    
    var tapAction: (() -> Void)
    var doubleTapAction: (() -> Void)?
    var isSelected: Bool = false
    var buttonType: BottomButtonType
    
    var body: some View {
        
        DoubleTapButton(tapAction: {
            tapAction()
        }, doubleTapAction: {
            doubleTapAction?()
        }, title: buttonType.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isSelected ? buttonType.backgroundColor : .black)
        .foregroundStyle(isSelected ? buttonType.textColor : .gray)
        .font(.custom("LemonMilkLight", size: 18))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(isSelected ? buttonType.borderColor : .jSdarkGray, lineWidth: isSelected ? 5 : 0.5)
        )
   }
}
