//
//  ContentView.swift
//  LockScreen Dock
//
//  Created by Andrei Bezlepkin on 12.12.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Lockscreen Dock")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
