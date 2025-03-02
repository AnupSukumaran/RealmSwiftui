/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import RealmSwift


struct IngredientRow: View {
  @State private var ingredientFormIsPresented = false
  
  @ObservedRealmObject var ingredient: Ingredient

  

  var buttonImage: String {
    ingredient.bought ? "circle.inset.filled" : "circle"
  }

  var body: some View {
    HStack {
      Button(action: openUpdateIngredient) {
        Text("\(ingredient.quantity)")
          .bold()
          .padding(.horizontal, 4)
        VStack(alignment: .leading) {
          Text(ingredient.title)
            .font(.headline)
          Text(ingredient.notes)
            .font(.subheadline)
        }
        .lineLimit(1)
      }
      .buttonStyle(.plain)
      .disabled(ingredient.bought)
      .sheet(isPresented: $ingredientFormIsPresented) {
        IngredientFormView(ingredient: ingredient)
      }
      Spacer()
      Button(action: toggleBought) {
        Image(systemName: buttonImage)
          .resizable()
          .frame(width: 24, height: 24)
      }
      .foregroundColor(ingredient.color)

    }
  }
}

// MARK: - Actions
extension IngredientRow {
  func openUpdateIngredient() {
    ingredientFormIsPresented.toggle()
  }

  func toggleBought() {
    $ingredient.bought.wrappedValue.toggle()
  }
}

struct IngredientRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IngredientRow(ingredient: IngredientMock.ingredientsMock[0])
      IngredientRow(ingredient: IngredientMock.boughtIngredientsMock[0])
    }
    .previewLayout(.sizeThatFits)
  }
}

extension Ingredient {
  var color: Color {
    colorOption.color
  }
}
