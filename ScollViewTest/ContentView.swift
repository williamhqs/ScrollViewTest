//
//  ContentView.swift
//  ScollViewTest
//
//  Created by Hu Qiushi on 2024/4/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var testText: String = ""
    @State var isPopup: Bool = false
    
    var body: some View {
        ScrollView {
            
            Text("a").id("4").frame(height: 100).frame(maxWidth: .infinity).background(Color.red).id("4")
            Text("b").id("5").frame(height: 100).frame(maxWidth: .infinity).background(Color.red).id("5")
            Text("c").frame(maxWidth: .infinity).id("6").frame(height: 100).background(Color.red).id("6")
            Text("e").frame(maxWidth: .infinity).id("6").frame(height: 100).background(Color.red).id("6")
            VStack {
                KeyTitleView(title: "Math")
                NumberView(isPopup: $isPopup, onKeyPressed: {
                    
                })
            }
            VStack {
                TextField("abc", text: $testText).id("7")
                    .frame(height: 100).background(Color.cyan)
                Text("e").id("6").frame(height: 100).frame(maxWidth: .infinity).background(Color.red).id("6")
            }
            
            Text("f").id("7").frame(maxWidth: .infinity).frame(height: 100).background(Color.red).id("8")
            Text("g").id("8").frame(maxWidth: .infinity).frame(height: 100).background(Color.red).id("9")
            Text("h").id("9").frame(maxWidth: .infinity).frame(height: 100).background(Color.red).id("10")
        }
    }
    
}

#Preview {
    ContentView()
}


struct KeyTitleView:View {
    @State var title: String
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.caption)
                .foregroundColor(Color.gray)
            Spacer()
        }.padding([.top, .leading])
        
    }
}

struct NumberView: View {
    
    @Binding var isPopup: Bool
    
    var onKeyPressed: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("x")
                    .font(.title)
                Spacer()
            }.padding()
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.green))
                .onTapGesture {
                    isPopup = true
                    onKeyPressed?()
                    
                }
        }
        .popover(isPresented: $isPopup, attachmentAnchor: PopoverAttachmentAnchor.point(.topTrailing),
                 content: {
            if #available(iOS 16.4, *) {
                NumberEditView()
                    .presentationCompactAdaptation(.popover)
            } else {
                
            }
        })
    }
}

#Preview {
    NumberView(isPopup: .constant(true))
}


struct NumberEditView: View {
    enum FocusedField {
        case f1, f2
    }
    @State var value1: String = ""

    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        TextField("x", text: $value1)
            .font(.title)
            .cornerRadius(5.0)
            .background(Color.gray)
            .padding(.leading)
            .focused($focusedField, equals: .f1)
        .onAppear(perform: {
            focusedField = .f1
        })
        
    }
}

#Preview("NumberEditView") {
    NumberEditView(value1: "x")
}
