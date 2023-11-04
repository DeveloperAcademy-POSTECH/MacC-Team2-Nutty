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
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.leading, 20.0)
                .background(RoundedRectangle(cornerRadius: 10).fill(configuration.isPressed ? Color.Green3 : Color.G2))
                .foregroundColor(configuration.isPressed ? .Green4 : .B)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(configuration.isPressed ? Color.TGreen : Color.G2, lineWidth: 1.2))
            
        case .oneSelected:
            configuration.label
                .foregroundColor(Color.Green4)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.leading, 20.0)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.Green2))
                .foregroundColor(configuration.isPressed ? .Green4 : .B)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.Green4, lineWidth: 1.2))
            
        case .twoUnselected:
            configuration.label
                .foregroundColor(configuration.isPressed ? Color.Green4 : .B)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 10).fill(configuration.isPressed ? Color.Green3 : Color.G2))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(configuration.isPressed ? Color.TGreen : Color.G2, lineWidth: 1.2))
            
        case .twoSelected:
            configuration.label
                .foregroundColor(Color.Green4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.Green2))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.Green4, lineWidth: 1.2))
            
        }
    }
}

struct RadioButtonExampleView: View {
    let title: [String] = ["신청", "갱신", "등급 변경"]
    let description: [String] = ["노인성 질병이 있는 경우에만 신청할 수 있어요", "2년에 한 번씩 갱신해 주세요", "환자의 상태가 변했을 때 신청할 수 있어요"]
    @State var oneSelectedIndex : Int = -1
    
    let yesNo: [String] = ["네", "아니오"]
    @State var twoSelectedIndex : Int = -1
    
    var body: some View {
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

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonExampleView()
    }
}
