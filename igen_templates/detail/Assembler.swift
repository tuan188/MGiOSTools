import UIKit

protocol {{name}}Assembler {
    func resolve(navigationController: UINavigationController, {{model_variable}}: {{model_name}}) -> {{name}}ViewController
    func resolve(navigationController: UINavigationController, {{model_variable}}: {{model_name}}) -> {{name}}ViewModel
    func resolve(navigationController: UINavigationController) -> {{name}}NavigatorType
    func resolve() -> {{name}}UseCaseType
}

extension {{name}}Assembler {
    func resolve(navigationController: UINavigationController, {{model_variable}}: {{model_name}}) -> {{name}}ViewController {
        let vc = {{name}}ViewController.instantiate()
        let vm: {{name}}ViewModel = resolve(navigationController: navigationController, {{model_variable}}: {{model_variable}})
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController, {{model_variable}}: {{model_name}}) -> {{name}}ViewModel {
        return {{name}}ViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            {{model_variable}}: {{model_variable}}
        )
    }
}

extension {{name}}Assembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> {{name}}NavigatorType {
        return {{name}}Navigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> {{name}}UseCaseType {
        return {{name}}UseCase()
    }
}
