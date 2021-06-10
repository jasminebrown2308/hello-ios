//
//  ContentView.swift
//  Hello
//
//  Created by Jasmine Brown on 07/06/2021.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable {
    case English, Spanish, French, German, Dutch, Italian
    var id: String { self.rawValue }
}

extension Translation {
    var language: Language {
        switch self {
        case .English: return .Hello
        case .Spanish: return .¡Hola
        case .French: return .Bonjour
        case .German: return .Hallo
        case .Dutch: return .Hallo
        case .Italian: return .Ciao
        }
    }
}

struct InputView: View {
    
    @State var name: String = ""
    @State var language: Language = .English
    
    var body: some View {
        
        NavigationView{
                
            VStack {
                Spacer()
                TextField("NAME", text: $name)
                    .padding(.horizontal, 40.0)
                    .font(.largeTitle)
                Divider()
                Spacer()
                DropDown()
                Spacer()
                NavigationLink(destination: OutputView(name: name, language: language)) {
                    
                    HStack {
                        Text("Say hi")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .bottom]/*@END_MENU_TOKEN@*/)
                        Image(systemName: "chevron.right.2")
                            .foregroundColor(Color.white)
                            .padding(/*@START_MENU_TOKEN@*/[.top, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                    }
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Accent1")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
        }
    }
}

struct OutputView: View {
    
    var name: String = ""
    var language: Language = .English
    
    var body: some View {
        
        Text(translate(lang: language) + ", " + name + "!")
            .font(.largeTitle)
            .padding()
            .background(Color.red
                            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/))
        
    }
    
    func translate(lang: Language) -> String {
//        let translations: [String: String] = ["en": "Hello", "es": "¡Hola", "fr": "Bonjour", "de": "Hallo", "nl": "Hallo", "it": "Ciao"]
        
        return translations[lang]!
        
    }
}

struct DropDown: View {
    @State var expand = false
    @State var language = "Select language"
    
    var body: some View {
        VStack() {
            VStack(spacing: 30) {
                HStack() {
                    Text(expand ? "Select language" : language)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .foregroundColor(.black)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    ForEach(Language.allCases, id: \.id) { lang in
                        Button(action: {
                            language = lang.id
                            self.expand.toggle()
                        }) {
                            Text(lang.id)
                                .padding(5)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputView()
            OutputView()
        }
    }
}
