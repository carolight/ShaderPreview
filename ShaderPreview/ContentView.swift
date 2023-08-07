//
//  ContentView.swift
//  ShaderPreview
//
//  Created by Caroline on 8/8/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Image("sphere-normal")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .lighting()
  }
}

extension View {
  // The metal shader is a simple Lambertian model
  // with a overlaid rectangle of a color
  // This demonstrates sending a single value
  // and a structure
  func lighting() -> some View {
//    let lightPosition = Shader.Argument.float3(0.5, 0.3, 1.0)
    let function = ShaderFunction(library: .default, name: "lighting")
    var params = LightingParams()
    params.lightDirection = [1, 1, 0]
    params.newColor = [0, 1, 1, 1]

    let data = Shader.Argument.data(Data(
      bytes: &params,
      count: MemoryLayout<LightingParams>.stride))

    let shader = Shader(
      function: function,
      arguments: [.color(.red), data])
    return colorEffect(shader, isEnabled: true)
  }
}

#Preview {
    ContentView()
}
