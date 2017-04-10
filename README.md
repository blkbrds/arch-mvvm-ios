- [Theory](#theory)
- [Use cases](#use-cases)
  * [ViewController ViewModel](#viewcontroller-viewmodel)
    + [Declaration](#declaration)
    + [Business logic](#business-logic)
    + [Data Binding](#data-binding)
    + [API call](#api-call)
  * [Cell ViewModel](#cell-viewmodel)
    + [Declaration](#declaration-1)
    + [Business logic](#business-logic-1)
    + [Data Binding](#data-binding-1)
- [Demo](#demo)

# Theory

MVVM is a specialization of the [Presentation Model](https://msdn.microsoft.com/en-us/library/ff921080.aspx) (or Application Model) for Microsoft's Silverlight and WPF. The main ideas behind this UI architectural pattern are:
- The view part is the only one that depends on the GUI framework. This means that for iOS, the view controller is part of the view.
- The view can only talk to the view model. Never to the model.
- The view model holds the state of the view. This state is offered to the view via view model properties. These properties contain not only the value of the labels, but also other view related information like if the save button is enabled or the color for a rating view. But the information of the state must be UI framework independent. So in the case of iOS, the property for the color should be an enum, for example, instead of a UIColor.
- The view model also provides methods that will take care of the UI actions. This actions will talk to the model, but they never change the state of the view that is data related directly. Instead, it talks to the model and asks for the required changes.
- The model should be *autonomous*, i.e. you should be able to use the same code for the model for a command line application and a UI interface. It will take care of all the business logic.
- The model doesn't know about the view model. So changes to the view model are propagated through an observation mechanism. For iOS and a model with plain NSObject subclasses or even Core Data, KVO can be used for that (also for Swift).
- Once the view model knows about changes in the model, it should update the state that it holds (if you use value types, then it should create an updated one and replace it).
- The view model doesn't know about the view. In its original conception it uses data binding, that not available for iOS. So changes in the view model are propagated through an observation mechanism. You can also use KVO here, or as you mention in the question, a simple delegation pattern, even better if combined with Swift property observers, will do. Some people prefer reactive frameworks, like RxSwift, ReactiveCocoa, or even Swift Bond.

The benifits:
- Better separation of concerns.
- UI independence: easier migration to other UIs.
- Better testability because of the separation of concerns and the decoupled nature of the code.

# Interactor

![](images/interactor.png)

# What's would be tested?

- Model
    - API
        - request params
        - response
    - DB
        - mapping
        - defined fetch
- ViewModel
    - output for controller
    - logic
- View
    - data binding
    - action handler

When ViewModel provide a list of sub-ViewModel, it needs conform to Provider protocol:
- `numberOfSections() -> Int`
- `numberOfItemsInSection(_ section: Int) -> Int`
- `itemAtIndexPath(_ indexPath: IndexPath) -> Item`

# Use cases

## ViewController ViewModel

- ### Declaration

    ```swift
    final class LoginViewModel: MVVM.ViewModel {
        var mail = ""
        var pass = ""

        // Init with a model or not
        init(user: User?) {
            guard let user = user else { return }
            mail = user.mail
        }
    }
    ```

- ### Business logic

    ```swift
    func validate() -> Validation {
        let comps = mail.components(separatedBy: "@")
        guard comps.count == 2,
            let name = comps.first, name.len >= 6,
            let domain = comps.last, domain.len >= 5
        else {
            return .failure(key: "mail", msg: "'mail' too short")
        }
        guard pass.len >= 6 else { return .failure(key: "pass", msg: "'pass' too short") }
        return .success
    }
    ```

- ### Data Binding

    ```swift
    ```

- ### API call

    ```swift
    enum LoginResult {
        case success
        case failure(error: Error)
    }

    func login(_ completion: @escaping (LoginResult) -> Void) {
        let validation = validate()
        guard validation.passed else {
            let info: [String: Any] = [
                NSLocalizedDescriptionKey: validation.description
            ]
            let error = NSError(domain: "", code: -1, userInfo: info)
            completion(.failure(error: error))
            return
        }
        let ws = API.User(id: 0)
        let params = API.User.LoginParams(mail: mail, pass: pass)
        ws.login(params: params) { (result) in
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    ```

## Cell ViewModel

**Notice:** Cell ViewModel has no API call. Because all events must be forwarded to Controller through delegation.

- ### Declaration

    ```swift
    final class RepoCellViewModel: MVVM.ViewModel {
        var name = ""
        var slug = ""

        init(repo: Repo?) {
            guard let repo = repo else { return }
            name = repo.name
            slug = repo.slug
        }
    }
    ```

- ### Business logic

    ```swift
    ```

- ### Data Binding

    ```swift
    ```

# Demo

[![codecov](https://codecov.io/gh/AsianTechInc/AT-MVVM-iOS/branch/master/graph/badge.svg)](https://codecov.io/gh/AsianTechInc/AT-MVVM-iOS)

This application implements [GitHub API](https://developer.github.com/v3)

**Setup Development Environment**

- `./scripts/install` - this script will install
    - [Homebrew](https://github.com/Homebrew/brew) & necessary formulas
    - [rbenv](https://github.com/rbenv/rbenv) & necessary gems
    - [CocoaPods](https://cocoapods.org/) & project's dependences
    > Please use command `bundle exec pod install` instead of `pod install` to update `Pods`.

**Coding Convension**

Based on [The Official raywenderlich.com Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).
