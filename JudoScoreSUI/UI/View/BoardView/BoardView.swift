//
//  BoardView.swift
//  JudoScoreSUI
//
//  Created by Moulinet Chloë on 30/09/2024.
//

import SwiftUI

struct BoardView: View {
    
    @State var fight = Fight(fighter1: Fighter(color: .red),
                             fighter2: Fighter(color: .white))
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TopBarView()
                    .frame(maxHeight: .infinity)

                FighterView(fighter: fight.fighter1)
                    .frame(maxHeight: .infinity)

                FighterView(fighter: fight.fighter2)
                    .frame(maxHeight: .infinity)

                BottomBarView()
                    .frame(maxHeight: .infinity)
           }
        }
        .environment(fight)
    }
}

#Preview {
    BoardView()
}
