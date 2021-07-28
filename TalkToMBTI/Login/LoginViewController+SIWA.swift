//
//  LoginViewController+SIWA.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/29.
//

import AWSMobileClient

extension LoginViewController {
  func setupProviderLoginView() {
      let authorizationButton = ASAuthorizationAppleIDButton()
      authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
      self.view.addSubview(authorizationButton)
      authorizationButton.center = self.view.center
  }
  
  @objc
  func handleAuthorizationAppleIDButtonPress() {
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      
      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
  }
  
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
  
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithAuthorization authorization: ASAuthorization) {
      guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
          let identityTokenData = appleIDCredential.identityToken else {
              print("No token available")
              return
      }

      guard let identityToken = String(data: identityTokenData, encoding: .utf8) else {
          print("Can't convert identity token data to string")
          return
      }

      AWSMobileClient.default().federatedSignIn(providerName: IdentityProvider.apple.rawValue,
                                                token: identityToken) { userState, error in
          if let error = error {
              print("Error in federatedSignIn: \(error)")
              return
          }

          guard let userState = userState else {
              print("userState unexpectedly nil")
              return
          }

          print("federatedSignIn successful: \(userState)")
      }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      // Handle error.
    print(error)
  }
  

}
