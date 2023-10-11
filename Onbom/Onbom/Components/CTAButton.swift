//
//  CTAButton.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/10.
//

import SwiftUI

enum CTAButtonStyle {
    case primary(isDisabled: Bool)
    case secondary(isDisabled: Bool)
    case expanded(isDisabled: Bool)
    case main
}

struct CTAButton {
    struct CustomButtonView<CustomLabelType: View>: View {
        let style: CTAButtonStyle
        let action: () -> Void
        let label: CustomLabelType?
        
        var body: some View {
            switch style {
            case .primary(let isDisabled):
                Button(action: action) {
                    if let label {
                        label
                    }
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .secondary:
                Button(action: action) {
                    if let label {
                        label
                    }
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            case .expanded(let isDisabled):
                Button(action: action) {
                    if let label {
                        label

                    }
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .main:
                Button(action: action) {
                    if let label {
                        label

                    }
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            }
        }
        init(
            style: CTAButtonStyle,
            action: @escaping () -> Void,
            @ViewBuilder label: () -> CustomLabelType
        ) {
            self.style = style
            self.action = action
            self.label = label()
        }
    }
}

public struct CTAButtonStyleModifiers: ButtonStyle {
    let style: CTAButtonStyle
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        switch style {
        case let .primary(isDisabled):
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(isDisabled ? Color.PB2 : configuration.isPressed ? Color.PB5 : Color.PB4))
            // TODO: - Text로 적용이 안 되서 직접 박음. 추후 수정 필요
                .font(.system(size:16, weight: .bold))
                .kerning(-0.3)
            
        case .secondary:
            configuration.label
                .foregroundColor(Color.PB4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 16).fill( configuration.isPressed ? Color.PB3 : Color.PB2))
                .font(.system(size:16, weight: .bold))
                .kerning(-0.3)
            
        case let .expanded(isDisabled):
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(isDisabled ? Color.PB2 : configuration.isPressed ? Color.PB5 : Color.PB4)
                .font(.system(size:16, weight: .bold))
                .kerning(-0.3)
        case .main:
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 16).fill(configuration.isPressed ? Color.PB5 : Color.PB4))
                .font(.system(size:16, weight: .bold))
                .kerning(-0.3)
        }
    }
}

struct CTAButtonExampleView: View {
    @State private var isDisabled = false
    
    var body: some View {
        VStack {
            // 비활성화 체크를 위한 버튼
            Button("check") {
                isDisabled.toggle()
            }
            
            // PrimaryButton
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: isDisabled))
            {
                print()
            } label: {
                   Text("다음")
            }
            .padding(.horizontal, 20)
            
            // SecondaryButton
            CTAButton.CustomButtonView(
                style: .secondary(isDisabled: isDisabled))
            {
                print()
            } label: {
                   Text("다음")
            }
            .padding(.horizontal, 20)

            
            // ExpandedButton
            CTAButton.CustomButtonView(
                style: .expanded(isDisabled: isDisabled))
            {
                print()
            } label: {
                   Text("다음")
            }
            .padding(.horizontal, 20)
            
            // MainCTAButton
            CTAButton.CustomButtonView(
                style: .main)
            {
                print()
            } label: {
                   Text("다음")
            }
            .padding(.horizontal, 20)
            
            // VerticalCTAButton
            VStack {
                CTAButton.CustomButtonView(
                    style: .main)
                {
                    print()
                } label: {
                    Text("다음")
                }
                CTAButton.CustomButtonView(
                    style: .secondary(isDisabled: isDisabled))
                {
                    print()
                } label: {
                    Text("다음")
                }
            }
            .padding(.horizontal, 20)
            
            // HorizontalCTAButton
            HStack {
                CTAButton.CustomButtonView(
                    style: .secondary(isDisabled: isDisabled))
                {
                    print()
                } label: {
                    Text("아니요")
                }
                CTAButton.CustomButtonView(
                    style: .main)
                {
                    print()
                } label: {
                    Text("네")
                }
            }
            .padding(.horizontal, 20)
            
            // IDCardHorizontalCTAButton
            // TODO: - 버튼 크기 조정하는 방법 다시 생각하기
            HStack {
                CTAButton.CustomButtonView(style: .secondary(isDisabled: isDisabled))
                {
                    print()
                } label: {
                    Text("재촬영")
                }
                .frame(width: 103)
                
                CTAButton.CustomButtonView(style: .main)
                {
                    print()
                } label: {
                    Text("다음")
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CTAButtonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CTAButtonExampleView()
    }
}
