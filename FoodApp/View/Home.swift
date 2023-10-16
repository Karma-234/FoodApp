//
//  Home.swift
//  FoodApp
//
//  Created by MAC  on 10/15/23.
//

import SwiftUI

struct Home: View {
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var shouldNavigate: Bool = false
    let persistence = PersistenceController.shared
    var body: some View {
        NavigationStack {
            TabView{
                MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                    .environment(\.managedObjectContext,persistence.container.viewContext)
                Profile()
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
            }
            
//            .searchable(text: $searchText, isPresented: $showSearch)
//            .onSubmit {
//                showSearch = false
//            }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo").frame(alignment: .center)
                    }
                }
//                .navigationDestination(isPresented: $shouldNavigate){
//                    Profile()
//                }
        }
    }
}
extension String: Identifiable {

    public var id: String {

        self

    }

}
#Preview {
    Home()
}
