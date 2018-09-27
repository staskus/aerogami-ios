module.exports = function (plop) {
    // create your generators here
    plop.setGenerator('feature', {
        description: 'creates a basic feature structure',
        prompts: [{
            type: 'input',
            name: 'name',
            message: 'What\'s the Feature Name (including spaces) ? (Ex: Travel Feed)'
        }],
        actions: [
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Configurator.swift',
                templateFile: 'templates/plop/Feature/Configurator.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Models.swift',
                templateFile: 'templates/plop/Feature/Models.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Interactor.swift',
                templateFile: 'templates/plop/Feature/Interactor.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Presenter.swift',
                templateFile: 'templates/plop/Feature/Presenter.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}ViewController.swift',
                templateFile: 'templates/plop/Feature/ViewController.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Router.swift',
                templateFile: 'templates/plop/Feature/Router.swift.hbs'
            },
            {
                type: 'add',
                path: 'TravelFeatureKit/Features/{{name}}/{{properCase name}}Assembly.swift',
                templateFile: 'templates/plop/Feature/Assembly.swift.hbs'
            }
        ]
    });
};
