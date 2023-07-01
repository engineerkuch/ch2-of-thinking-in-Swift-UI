//
//  ContentView.swift
//  ch2
//
//  Created by Kelvin KUCH on 07.06.2023.
//

import SwiftUI



/*  Understanding dynamic view trees

 struct LabelView: View {
     @Binding var number: Int
     
     @ViewBuilder var helper: some View {
         if number > 0 {
             Text("Number is now \(number).")
         } else {
             Image(systemName: "lightbulb")
         }
     }
     
     var body: some View {
         if number > 0 {
             Text("Number is now \(number).")
         } else {
             Image(systemName: "lightbulb")
         }
     }
 }
 */


/*  Understanding Property Wrappers

 Binding vs State
 
struct LabelView: View {
    @Binding var number: Int
    
    var body: some View {
        print("LabelView")
        return Group {
            if number > 0 {
                Text("Number is now \(number).")
            }
        }
    }
}

// State example using @State property wrapper
struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        print("ContentView")
        return VStack {
            Button("Tap Me") {
                self.counter += 1
            }
            
            LabelView(number: $counter)
        }
    }
}

// State example using State(initialValue:)
struct ContentView: View {
    private var counter = State(initialValue: 0)
    
    var body: some View {
        print("ContentView")
        return VStack {
            Button("Tap Me") {
                self.counter.wrappedValue += 1
            }
            
            LabelView(number: counter.projectedValue)
        }
    }
}


struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.10
    var pointerWidth: CGFloat = 0.10

    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * self.pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        
        return Path { p in
            print("KnobShape")
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - (pointerWidth / 2.00), y: 0.00, width: pointerWidth, height: pointerHeight * 2.00))
        }
    }
}

struct Knob: View {
    @Binding var value: Double
//    var valueChanged: (Double) -> ()
    
    var body: some View {
        print("Knob")
        return KnobShape()
            .fill(Color.primary)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                self.value = self.value < 0.5 ? 1 : 0
            }
        
    }
}

struct ContentView: View {
    @State var volume: Double = 0.50
    
    var body: some View {
        print("ContentView")
        return VStack {
            Knob(value: $volume
//                 , valueChanged: { newValue in self.volume = newValue}
            )
                .frame(width: 100.00, height: 100.00)
            
            Slider(value: $volume, in: (0...1))
        }
    }
}
 */


struct ContentView: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
