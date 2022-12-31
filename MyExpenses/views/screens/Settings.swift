//
//  Settings.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct Settings: View {
    @AppStorage("ThemeDarkMode") var theme = false
    @State private var languages = Languages()
    let locale = String(Locale.current.identifier).prefix(2)
    
    @State private var showingChangeLanguage = false

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
                
                
                HStack {
                    Button {
                        showingChangeLanguage = true
                    } label: {
                        Text("Language")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text(languages.avaiablesLanguagesDescription[languages.avaiablesLanguages.firstIndex(of: String(locale)) ?? 0])
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Settings")
            .alert("How to set your My Expenses app language", isPresented: $showingChangeLanguage) {
                Button("Continue") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                
                Button("Cancel", role: .cancel) {}
                
            } message: {
                Text("Due to updates to your phone, there are diffrent steps to change your My Expenses language.\n\n 1. Continue to the next screen.\n2. Tap language to select the language you want.\n\n If no language setting is avaiable, go to your general iPhone language settings to first set a preferred language.")
            }
            .preferredColorScheme(theme ? .dark : .light)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
