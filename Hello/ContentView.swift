//
//  ContentView.swift
//  Hello
//
//  Created by Jasmine Brown on 07/06/2021.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable {
    case Select, English, Spanish, German, Dutch, French, Italian
    var id: String { self.rawValue }
    var display: Bool {
        if (self == .Select) {
            return false
        } else {
            return true
        }
    }
    var translation: String {
        switch self {
        case .Select: return "Hello"
        case .English: return "Hello"
        case .Spanish: return "¡Hola"
        case .French: return "Bonjour"
        case .German: return "Hallo"
        case .Dutch: return "Hallo"
        case .Italian: return "Ciao"
        }
    }
    var image: String {
        switch self {
        case .Select: return ""
        case .English: return "england"
        case .Spanish: return "spain"
        case .French: return "france"
        case .German: return "germany"
        case .Dutch: return "netherlands"
        case .Italian: return "italy"
        }
    }
}

struct InputView: View {
    
    @State var name: String = ""
    @State var language: Language = .Select
            
    var body: some View {
        NavigationView{
            ZStack {
                Spacer()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("SkyBlue2"), Color("SkyBlue1")]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                GeometryReader { geo in
                    let width = geo.frame(in: .global).width
                    let height = geo.frame(in: .global).height
                    
                    if height > width {
                        /* Portrait layout */
                        VStack {
                            Spacer()
                            Spacer()
                            TextField("NAME", text: $name)
                                .padding(.horizontal, 50)
                                .font(Font.custom("Cera Pro Medium", size: 34))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .accentColor(.white)
                            Divider()
                                .background(Color.white)
                                .padding(.horizontal, 50)
                                .padding(.top, -10)
                                .foregroundColor(.white)
                                .frame(height: 20.0)
                            Spacer()
                            DropDown(language: $language)
                            Spacer()
                            NavigationLink(destination: OutputView(name: name, language: language)) {
                                ZStack {
                                    Image("Cloud")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(5)
                                        .padding([.bottom], 10)
                                    HStack {
                                        Text("Say hi")
                                            .font(Font.custom("Cera Pro Light", size: 28))
                                            .foregroundColor(Color.black)
                                            .padding([.bottom], 30)
                                            .padding([.leading], 35)
                                        Image(systemName: "chevron.right.2")
                                            .foregroundColor(Color.black)
                                            .padding([.bottom], 30)
                                            .padding([.trailing], 35)
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }
                            Spacer()
                            Spacer()
                        }
                        
                    } else {
                        /* Landscape layout */
                        HStack {
                            VStack {
                                DropDown(language: $language)
                                Spacer()
                            }.padding([.top], 50.0)
                            VStack {
                                Spacer()
                                Spacer()
                                TextField("NAME", text: $name)
                                    .padding(.horizontal, 50)
                                    .font(Font.custom("Cera Pro Medium", size: 34))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .accentColor(.white)
                                Divider()
                                    .background(Color.white)
                                    .padding(.horizontal, 50)
                                    .padding(.top, -10)
                                    .foregroundColor(.white)
                                    .frame(height: 20.0)
                                Spacer()
                                NavigationLink(destination: OutputView(name: name, language: language)) {
                                    ZStack {
                                        Image("Cloud")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(5)
                                            .padding([.bottom], 10)
                                        HStack {
                                            Text("Say hi")
                                                .font(Font.custom("Cera Pro Light", size: 28))
                                                .foregroundColor(Color.black)
                                                .padding([.bottom], 30)
                                                .padding([.leading], 35)
                                            Image(systemName: "chevron.right.2")
                                                .foregroundColor(Color.black)
                                                .padding([.bottom], 30)
                                                .padding([.trailing], 35)
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                }
                                Spacer()
                            }
                        }.padding([.leading], 20.0)
                        .padding([.trailing], 10.0)
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}

struct OutputView: View {
    
    var name: String = ""
    var language: Language = .Select
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(name: String, language: Language) {
        /* Generate message ("Hello + name!" or just "Hello!" if name is empty */
        if (name != "") {
            self.name = " "
        }
        self.name += name
        self.language = language
    }
    
    var body: some View {
        ZStack {
            Image(language.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .layoutPriority(-1)
            VStack {
                HStack {
                    Spacer()
                    Text(language.translation + name + "!")
                        .font(Font.custom("Cera Pro Medium", size: 34))
                        .padding()
                    Spacer()
                }.background(Color.white
                                .opacity(0.6))
                Spacer()
                HStack {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) { // go back to InputView
                        HStack {
                            Image(systemName: "chevron.left.2")
                                .foregroundColor(Color.black)
                                .padding([.vertical], 20)
                                .padding([.leading], 25)
                            Text("Back")
                                .font(Font.custom("Cera Pro Light", size: 22))
                                .foregroundColor(Color.black)
                                .padding([.vertical], 20)
                                .padding([.trailing], 30)
                        }.background(Color.white .opacity(0.6))
                        .cornerRadius(40)
                    }.padding([.leading], 20)
                    Spacer()
                }
            }.padding([.vertical], 40)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct DropDown: View {
    @State var expand = false
    @Binding var language: Language
    @State var height = 75.0
    
    var body: some View {
        VStack {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: expand) {
                VStack(spacing: 30) {
                    HStack() {
                        Text(expand || language == .Select ? "Select language" : language.rawValue)
                            .font(Font.custom("Cera Pro Bold", size: 24))
                            .fontWeight(language == .Select ? .semibold : .light)
                            .padding([.top], 25.0)
                            .padding([.leading], 35.0)
                        Spacer()
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 14, height: 8)
                            .foregroundColor(.black)
                            .padding([.top], 25.0)
                            .padding([.trailing], 35.0)
                    }.frame(width: 300.0).onTapGesture {
                        withAnimation() {
                            expand.toggle()
                            height = expand ? 220.0 : 75.0
                            language = .Select
                        }
                    }
                    
                    /* When expanded, display buttons corresponding to each language option */
                    if expand {
                        ForEach(Language.allCases, id: \.id) { lang in
                            if (lang.display) {
                                Button(action: {
                                    self.language = lang
                                    expand.toggle()
                                    height = 75.0
                                }) {
                                    Text(lang.id)
                                        .font(Font.custom("Cera Pro Light", size: 22))
                                        .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
                                        .padding([.vertical], -2)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }.frame(height: CGFloat(height))
            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.6))
            .cornerRadius(40)
            Spacer()
        }
        .frame(height: 220.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputView()
        }
    }
}
