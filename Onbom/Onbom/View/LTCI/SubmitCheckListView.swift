//
//  SubmitCheckListView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct SubmitCheckListView: View {
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var pdfManager: PDFManager
    @State private var isSubmitLoadingViewPresented = false
    
    var body: some View {
        HStack {
            Text("신청 정보를 확인해 주세요")
                .H1()
                .foregroundColor(.B)
            Spacer()
        }
        .padding()
        
        ScrollView {
            Group {
                HStack {
                    Text("신청 종류")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //관계 설정 페이지
                    } label: {
                        Text("신규")
                            .B4()
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                .padding(.bottom)
                .padding(.bottom)
            }
            .padding()
            
            HStack {
                Text("신청인")
                    .Cap6()
                    .foregroundColor(.Green4)
                    .padding(4)
                    .padding(.horizontal, 3)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.Green2))
                Text("\(patient.name)님 정보")
                    .T2()
                    .foregroundColor(.G6)
                    .padding(.leading, -4)
                Spacer()
            }
            .padding(.leading)
            
            Divider()
                .padding(.horizontal)
            
            Group {
                HStack {
                    Text("신청인 전화번호")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(patient.phoneNumber)
                            .B4()
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                HStack {
                    Text("신청인 주민등록번호")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(patient.id)
                            .B4()
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("신청인 주민등록지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 4)
                    Text(patient.address.cityAddress)
                        .B3()
                        .foregroundColor(.G5)
                    Text(patient.address.detailAddress)
                        .B3()
                        .foregroundColor(.G5)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("신청인이 현재 살고 계신 주소지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 4)
                    Text(patient.actualAddress.cityAddress)
                        .B3()
                        .foregroundColor(.G5)
                    Text(patient.actualAddress.detailAddress)
                        .B3()
                        .foregroundColor(.G5)
                }
                .padding(.bottom)
                .padding(.bottom)
                
            }
            .padding()
            
            
            HStack {
                Text("대리인")
                    .Cap6()
                    .foregroundColor(.Green4)
                    .padding(4)
                    .padding(.horizontal, 3)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.Green2))
                Text("\(agent.name)님 정보")
                    .T2()
                    .foregroundColor(.G6)
                    .padding(.leading, -4)
                Spacer()
            }
            .padding(.leading)
            Divider()
                .padding(.horizontal)
            
            Group {
                HStack {
                    Text("신청인과의 관계")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //관계 설정 페이지
                    } label: {
                        Text(agent.relation)
                            .B4()
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                HStack {
                    Text("대리인 주민등록번호")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(agent.id)
                            .B4()
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("대리인 주소지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 4)
                    Text(agent.address.cityAddress)
                        .B3()
                        .foregroundColor(.G5)
                    Text(agent.address.detailAddress)
                        .B3()
                        .foregroundColor(.G5)
                }
            }
            .padding()
            Spacer()
            
            
            HStack() {
                Button {
                    //
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.Green4)
                }
                Text("입력한 정보를 다음에도 사용할게요")
                    .Cap3()
                    .foregroundColor(Color.B)
                Spacer()
            }
            .padding()
        }
        
        //CTA Button
        CTAButton.CustomButtonView(
            style: .primary(isDisabled:false))
        {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                isSubmitLoadingViewPresented = true
            }
        } label: {
            Text("신청하기")
        }
        .padding(.bottom,0)
        .padding([.top, .leading, .trailing], 20)
        .navigationBarBackButton()
        .fullScreenCover(isPresented: $isSubmitLoadingViewPresented) {
            SubmitView()
            
        }
    }
}

struct SubmitCheckListView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitCheckListView()
            .environmentObject(Patient())
            .environmentObject(Agent())
    }
}
