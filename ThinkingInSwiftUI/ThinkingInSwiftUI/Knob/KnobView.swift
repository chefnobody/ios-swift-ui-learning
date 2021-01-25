//
//  KnobView.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import SwiftUI

fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
    }
}

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

struct Knob: View {
//    var value: Double
//    var valueChanged: (Double) -> Void
    @Binding var value: Double // should be between 0 and 1
    
    var pointerSize: CGFloat? = nil
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        KnobShape(pointerSize: pointerSize ?? envPointerSize)
            .fill(colorScheme == .dark ? Color.white : Color.black)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                self.value = self.value < 0.5 ? 1 : 0
            }
    }
}

struct KnobView: View {
    @State var volume: Double = 0.5
    @State var balance: Double = 0.5

    var body: some View {
        HStack{
            VStack {
                Text("Volume")
                Knob(value: $volume)
                    .frame(width: 100, height: 100)
    //                .knobPointerSize(0.2)
                
                Slider(value: $volume, in: (0...1))
            }
            VStack {
                Text("Balance")
                Knob(value: $balance)
                    .frame(width: 100, height: 100)
    //                .knobPointerSize(0.3)
                
                Slider(value: $balance, in: (0...1))
            }
        }
        .knobPointerSize(0.3)
    }
}

struct KnobView_Previews: PreviewProvider {
    static var previews: some View {
        KnobView()
    }
}
