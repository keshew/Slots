import SwiftUI

extension Text {
    func Bold(size: CGFloat,
               color: Color = .white)  -> some View {
        self.font(.custom("SFProDisplay-Bold", size: size))
            .foregroundColor(color)
    }
    
    func Mendium(size: CGFloat,
                 color: Color = .white)  -> some View {
        self.font(.custom("SFProDisplay-Medium", size: size))
            .foregroundColor(color)
    }
    
    func Regular(size: CGFloat,
                 color: Color = .white)  -> some View {
        self.font(.custom("SFProDisplay-Regular", size: size))
            .foregroundColor(color)
    }
}
