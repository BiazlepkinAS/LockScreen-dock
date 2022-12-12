//
//  Home.swift
//  LockScreen Dock
//
//  Created by Andrei Bezlepkin on 12.12.22.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct Home: View {
    //MARK: - Add shortcuts Data
    
    @State var addedShortcuts: [AppLink] = []
    @State var availableAppLinks: [AppLink] = []
    
    var body: some View {
        List {
            Section {
                //MARK: - displaying previews
                HStack(spacing: 0) {
                    ForEach(addedShortcuts){ link in
                        Image(link.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    addedShortcuts.removeAll(where: {$0 == link})
                                }
                            }
                    }
                }
                .frame(height: 85)
                
            } header: {
                Text("Preview")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        
                        ForEach(availableAppLinks.filter({!addedShortcuts.contains($0)})) { link in
                            VStack(spacing: 8) {
                                Image(link.name)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                
                                Text(link.name)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    addedShortcuts.append(link)
                                }
                            }
                        }
                    }
                    .frame(height: 100)
                    .padding(.horizontal, 10)
                }
                .disabled(addedShortcuts.count >= 4)
                .opacity(addedShortcuts.count >= 4 ? 0.6 : 1)
                
            } header: {
                Text("Tap to add shortcut")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Button(action: addDockLockScreen) {
                HStack {
                    Text("Add Lockscreen Dock")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "dock.rectangle")
                }
            }
            .disabled(addedShortcuts.count < 2)
            .opacity(addedShortcuts.count < 2 ? 0.6 : 1)
        }
        .onAppear {
            //MARK: - checking which app's are availible in user IPhone
            
            for link in appLinks {
                if let url = URL(string: link.deepLink) {
                    if UIApplication.shared.canOpenURL(url){
                        // available on IPhone
                        var updateLink = link
                        updateLink.appURL = url
                        availableAppLinks.append(updateLink)
                    }
                }
                //else App not available
            }
        }
    }
    
    func addDockLockScreen() {
        // remove all  existing activitys
        removeExistingDock()
        //MARK: - live activity CODE
        // Step 1: creating live Activity
        let activityAttributes = DockAttributes(name: "LockScreen dick", addedLinks: addedShortcuts)
        // step 2: add content State for Live Activity
        let initialContentState = DockAttributes.ContentState()
        // step 3: add live activity
        do {
            let activity = try Activity<DockAttributes>.request(attributes: activityAttributes, contentState: initialContentState)
            print("Activity added \(activity.id)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeExistingDock() {
        Task {
            for activity in Activity<DockAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
