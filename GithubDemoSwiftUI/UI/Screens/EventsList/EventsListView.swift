//
//  ContentView.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 04.02.2024.
//

import SwiftUI

struct EventsListView: View {
    @ObservedObject var viewModel: EventsListViewModel = .init()
    
    @State private var isPickerVisible = false
    @State private var isDetailsShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                list
                picker
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Github Events")
            .navigationBarItems(trailing: Button(action: {
                isPickerVisible.toggle()
            }) {
                Text(viewModel.selectedEventType?.rawValue ?? "All")
            })
            .onAppear {
                viewModel.refresh()
            }
        }
        .navigationTitle("GitHub Events")
    }
    
    @ViewBuilder
    var list: some View {
        List(viewModel.filteredEvents) { event in
            NavigationLink(destination: EventDetailView(event: event)) {
                HStack {
                    AsyncImageView(url: event.actor.avatar_url ?? "")
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Type: \(event.type.rawValue)")
                        Text("Actor: \(event.actor.login)")
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .overlay(
            Group {
                if viewModel.isRefreshing {
                    ProgressView("Refreshing...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.blue)
                }
            }
        )
    }
    
    @ViewBuilder
    var picker: some View {
        if isPickerVisible {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPickerVisible = false
                    } label: {
                        Text("Done")
                    }
                    .padding(.trailing)
                }
                Picker("Event Type", selection: $viewModel.selectedEventType) {
                    Text("All").tag(nil as EventType?)
                    ForEach(EventType.allCases, id: \.self) { eventType in
                        Text(eventType.rawValue).tag(eventType as EventType?)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
                
            }
        }
    }
}

#Preview {
    EventsListView()
}
