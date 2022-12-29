//
//  selectIconViewswift.swift
//  MyExpenses
//
//  Created by Lucas Lima on 28/12/22.
//

import SwiftUI

struct selectCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("SelectedCategory") var categorySelected = "tshirt"
    
    @State private var selectedIcon = "tshirt"
    @State private var category = Categories()
    
    var body: some View {
        NavigationStack {
            List {
                Picker("", selection: $categorySelected) {
                    ForEach(Array(category.avaiablesIcons.enumerated()), id: \.element) { index, icon in
                        Label(category.avaiablesIconsDescription[index], systemImage: icon)
                    }
                }
                .pickerStyle(.inline)
                .onChange(of: categorySelected) { cat in
                    dismiss()
                }
            }
            .navigationTitle("Select category")
        }
    }
}

struct selectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        selectCategoryView()
    }
}
