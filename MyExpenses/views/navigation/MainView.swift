//
//  ContentView.swift
//  MyExpenses
//
//  Created by Lucas Lima on 24/12/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var expenses = Expenses()
    
    var body: some View {
        TabView {
            ExpensesView(expenses: expenses)
                .tabItem {
                    Label("Expenses", systemImage: "list.dash")
                }
            
            LogsView(expenses: expenses)
                .tabItem {
                    Label("Logs", systemImage: "tray.full")
                }
            
            TypesView(expenses: expenses)
                .tabItem {
                    Label("Types", systemImage: "list.bullet.indent")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
