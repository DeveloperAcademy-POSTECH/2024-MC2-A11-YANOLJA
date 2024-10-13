//
//  WebContent.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebContent: UIViewRepresentable {
  public var url: String
  @Binding var isLoading: Bool  // 로딩 상태를 외부에서 바인딩
  
  public init(url: String, isLoading: Binding<Bool>) {
    self.url = url
    self._isLoading = isLoading
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string: self.url) else { return WKWebView() }
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator  // 델리게이트 설정
    webView.load(URLRequest(url: url))
    return webView
  }
  
  public func updateUIView(_ uiView: WKWebView, context: Context) {
    // 추가적인 업데이트가 필요하다면 여기에 구현
  }
  
  // Coordinator 클래스 정의
  public class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebContent
    
    init(_ parent: WebContent) {
      self.parent = parent
    }
    
    // 페이지 로딩 시작 시 호출
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = true
      }
    }
    
    // 페이지 로딩 완료 시 호출
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
    
    // 페이지 로딩 실패 시 호출
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
      print("웹 페이지 로딩 실패: \(error.localizedDescription)")
    }
  }
}
