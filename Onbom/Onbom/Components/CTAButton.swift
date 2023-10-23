//
//  CTAButton.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/10.
//

import SwiftUI

enum CTAButtonStyle {
    case primary(isDisabled: Bool)
    case secondary
    case expanded(isDisabled: Bool)
    case main
}

struct CTAButton {
    struct CustomButtonView: View {
        let style: CTAButtonStyle
        let action: () -> Void
        let label: Text
        
        var body: some View {
            switch style {
            case .primary(let isDisabled):
                Button(action: action) {
                    label
                        .B1()
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .secondary:
                Button(action: action) {
                    label
                        .B1()
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            case .expanded(let isDisabled):
                Button(action: action) {
                    label
                        .B1()
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .main:
                Button(action: action) {
                    label
                        .B1()
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            }
        }
        init(
            style: CTAButtonStyle,
            action: @escaping () -> Void,
            @ViewBuilder label: () -> Text
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
                .background(RoundedRectangle(cornerRadius: 16).fill(isDisabled ? Color.PB3 : configuration.isPressed ? Color.PB5 : Color.PB4))
            
        case .secondary:
            configuration.label
                .foregroundColor(Color.PB4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 16).fill( configuration.isPressed ? Color.PB3 : Color.PB2))
            
        case let .expanded(isDisabled):
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(isDisabled ? Color.PB3 : configuration.isPressed ? Color.PB5 : Color.PB4)
            
        case .main:
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 14).fill(configuration.isPressed ? Color.PB5 : Color.PB4))
        }
    }
}

struct CTAButtonExampleView: View {
    @State private var isDisabled = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
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
                        style: .secondary)
                    {
                        print()
                    } label: {
                        Text("다음")
                    }
                    .padding(.horizontal, 20)
                    
                    // ExpandedButton
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.48)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 104)
                        CTAButton.CustomButtonView(
                            style: .expanded(isDisabled: isDisabled))
                        {
                            print()
                        } label: {
                            Text("다음")
                        }
                    }
                    
                    // MainCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        CTAButton.CustomButtonView(
                            style: .main)
                        {
                            print()
                        } label: {
                            Text("다음")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // VerticalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.16)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 186)
                        VStack(spacing: 10) {
                            CTAButton.CustomButtonView(
                                style: .main)
                            {
                                print()
                            } label: {
                                Text("버튼 텍스트")
                            }
                            CTAButton.CustomButtonView(
                                style: .secondary)
                            {
                                print()
                            } label: {
                                Text("버튼 텍스트")
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // HorizontalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        HStack {
                            CTAButton.CustomButtonView(
                                style: .secondary)
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
                    }
                    
                    // IDCardHorizontalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        HStack {
                            CTAButton.CustomButtonView(style: .secondary)
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
        }
    }
}

struct CTAButtonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CTAButtonExampleView()
    }
}
