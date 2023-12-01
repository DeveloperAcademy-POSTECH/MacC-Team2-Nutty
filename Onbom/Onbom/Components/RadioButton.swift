//  RadioButton.swift
//  Onbom
//  Created by 금가경 on 2023/10/10.
//

import SwiftUI

enum RadioButtonStyle {
    case oneUnselected
    case oneSelected
    case twoUnselected
    case twoSelected
}

struct OneSelectedButton: View {
    let action: () -> Void
    let type: ApplyTypeViewButton
    let disabled: Bool
    @Binding var selected: ApplyTypeViewButton?
    
    init(type: ApplyTypeViewButton, selected: Binding<ApplyTypeViewButton?>, disabled: Bool = false, action: @escaping () -> Void) {
        self.type = type
        self._selected = selected
        self.action = action
        self.disabled = disabled
    }
    
    var titleColor: Color {
        get {
            if(disabled) { return .G3 }
            if(type == selected) { return .Green4 }
            else { return .B }
        }
    }
    
    var descColor: Color {
        get {
            if(disabled) { return .G3 }
            if(type == selected) { return .Green4 }
            else { return .G5 }
        }
    }
    
    var body: some View {
        Button { 
            action()
        } label: {
            VStack(alignment: .leading, spacing: 13) {
                Text(type.rawValue)
                    .T2()
                    .foregroundColor(titleColor)
                Text(type.desc)
                    .Cap3()
                    .foregroundColor(descColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 16)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(type == selected ? Color.Green2 : Color.G2))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(type == selected ? Color.Green4 : Color.G2, lineWidth: 1.2).opacity(0.7))
        .buttonStyle(OneSelectedButtonStyle())
    }
}


struct OneSelectedButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        print("haf")
        
        return configuration.label
            .foregroundColor(configuration.isPressed ? Color.Green4 : Color.white.opacity(0.0000001))
            .background(RoundedRectangle(cornerRadius: 10).fill(configuration.isPressed ? Color.Green3 : Color.white.opacity(0.0000001)))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(configuration.isPressed ? Color.TGreen : Color.white.opacity(0.000000001), lineWidth: 1.2))
    }
}


struct TestGoodView: View {
    
    @State var selected: ApplyTypeViewButton? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            OneSelectedButton(type: .new, selected: $selected) {
                selected = ApplyTypeViewButton.new
            }
            OneSelectedButton(type: .renew, selected: $selected) {
                selected = .renew
            }
            OneSelectedButton(type: .change, selected: $selected, disabled: true) {
                selected = .change
            }
            .disabled(true)
            Spacer()

            Rectangle().fill(Color.blue)
                .frame(width: 100, height: 100)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TestGoodView()
}

struct RadioButton {
    struct CustomButtonView<CustomLabelType: View>: View {
        let style: RadioButtonStyle
        let action: () -> Void
        let label: CustomLabelType?
        var body: some View {
            Button(action: action) {
                if let label {
                    VStack {
                        label
                    }
                }
            }
            .buttonStyle(RadioButtonStyleModifiers(style: style))

        }
        
        init(
            style: RadioButtonStyle,
            action: @escaping () -> Void,
            @ViewBuilder label: () -> CustomLabelType
        ) {
            self.style = style
            self.action = action
            self.label = label()
        }
    }
}

public struct RadioButtonStyleModifiers: ButtonStyle {
    
    let style: RadioButtonStyle
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        switch style {
        case .oneUnselected:
            configuration.label
                .foregroundColor(configuration.isPressed ? Color.Green4 : .B)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 20.0)
                .background(RoundedRectangle(cornerRadius: 10).fill(configuration.isPressed ? Color.Green3 : Color.G2))
                .foregroundColor(configuration.isPressed ? .Green4 : .B)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(configuration.isPressed ? Color.TGreen : Color.G2, lineWidth: 1.2))
            
        case .oneSelected:
            configuration.label
                .foregroundColor(Color.Green4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 20.0)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.Green2))
                .foregroundColor(configuration.isPressed ? .Green4 : .B)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.Green4, lineWidth: 1.2).opacity(0.7))
            
        case .twoUnselected:
            configuration.label
                .foregroundColor(configuration.isPressed ? Color.Green4 : .B)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 10).fill(configuration.isPressed ? Color.Green3 : Color.G2))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(configuration.isPressed ? Color.TGreen : Color.G2, lineWidth: 1.2))
            
            // TODO: 더 좋은 코드를 고민해보겠음, 미야
        case .twoSelected:
            configuration.label
                .foregroundColor(Color.Green4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.Green2))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.Green4, lineWidth: 1.2).opacity(0.7))
            
        }
    }
}

struct RadioButtonExampleView: View {
    let title: [String] = ["신청", "갱신", "등급 변경"]
    let description: [String] = ["노인성 질병이 있는 경우에만 신청할 수 있어요", "2년에 한 번씩 갱신해 주세요", "환자의 상태가 변했을 때 신청할 수 있어요"]
    @State var oneSelectedIndex : Int = -1
    
    let yesNo: [String] = ["네", "아니요"]
    @State var twoSelectedIndex : Int = -1
    
    var body: some View {
        ScrollView {
            VStack {
                // RadioOne
                VStack(spacing: 10) {
                    ForEach(0..<title.count, id: \.self) { index in
                        let oneStyle: RadioButtonStyle = oneSelectedIndex == index ? .oneSelected : .oneUnselected
                        
                        RadioButton.CustomButtonView(style: oneStyle) {
                            oneSelectedIndex = index
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 13) {
                                    Text("\(title[index])")
                                        .T3()
                                    Text("\(description[index])")
                                        .Cap3()
                                        .foregroundColor(.G5)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                //RadioTwo
                HStack(spacing: 10) {
                    ForEach(0..<yesNo.count, id: \.self) { index in
                        let twoStyle: RadioButtonStyle = twoSelectedIndex == index ? .twoSelected : .twoUnselected
                        RadioButton.CustomButtonView(style: twoStyle) {
                            twoSelectedIndex = index
                        } label: {
                            Text("\(yesNo[index])")
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

//struct RadioButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioButtonExampleView()
//    }
//}
