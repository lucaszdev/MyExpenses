//
//  Settings.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct Settings: View {
    @AppStorage("ThemeDarkMode") var theme = false
    @AppStorage("Language") var identifier = "en"
    @State private var languages = Languages()
    
    private func changeAppIcon(to iconName: String) {
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("Error setting alternate icon \(error.localizedDescription)")
            }

        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Dark Mode", isOn: $theme)
                
                Picker("Language", selection: $identifier) {
                    ForEach(Array(languages.avaiablesLanguages.enumerated()), id: \.element) { index, lang in
                        Text(languages.avaiablesLanguagesDescription[index])
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .navigationTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
