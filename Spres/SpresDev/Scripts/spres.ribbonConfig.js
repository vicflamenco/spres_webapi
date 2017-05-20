var ribbonConfig;
function createRibbonControl() {

    var url = getUrl("/api/Permissions")
    var permissionsDataManager = ej.DataManager({
        url: url,
        adaptor: new ej.WebApiAdaptor()
    });
    ej.WaitingPopup.showDefault();
    permissionsDataManager.executeQuery(ej.Query()).done(function (e) {

        ribbonConfig = {
            width: "99.8%",
            create: "createControl",
            allowResizing: true,
            applicationTab: { Type: ej.Ribbon.applicationTabType.menu, menuItemID: "ribbonmenu", menuSettings: { openOnClick: false, click: ribbonMenuClick } },
            tabs: []
        };

        var permissions = e.result;
        var permissionsString = JSON.stringify(permissions);
        sessionStorage.setItem("permissions", permissionsString);
        var InicioTabCreated = false;
        var maintenanceTabCreated = false;
        var groupParametersCreated = false;
        var authorizationGroupCreated = false;
        var budgetingButtonsCreated = false;
        var adjustmentTabCreated = false;
        var increasesGroupCreated = false;

        var analysisPermission = false;
        var exportValue = sessionStorage.getItem("export");
        for (var i = 0; i < permissions.length; i++) {

            var permission = permissions[i];

            switch (permission.Option) {

                case "Budgeting":

                    if (permission.View) {
                        $('#SheetsTab').show();
                        $('#CompanyControl').show();
                        $('#FiscalYearControl').show();
                        $('#CostCenterControl').show();
                        $('#CurrencyControl').show();
                        $('#designMonths').show();
                        $('#designColumns').show();
                        $('#designSummary').show();
                        if (groupParametersCreated == false) {
                            InicioTab.groups.push(groupParameters);
                            groupParametersCreated = true;
                        }
                        if (permission.Edit) {

                            if (!budgetingButtonsCreated) {
                                for (var j = 0; j < groupsBudgeting.length; j++) {
                                    InicioTab.groups.push(groupsBudgeting[j]);
                                }
                                budgetingButtonsCreated = true;
                            }

                            AuthorizationButtonGroup.content.push(RequestAuthorizationButton);
                            if (!authorizationGroupCreated) {
                                InicioTab.groups.push(AuthorizationButtonGroup);
                                authorizationGroupCreated = true;
                            }

                        }

                        if (InicioTabCreated == false) {
                            ribbonConfig.tabs.push(InicioTab);
                            ribbonConfig.tabs.push(ViewTab);

                            if (permission.Edit) {
                                if (adjustmentTabCreated == false) {
                                    if (increasesGroupCreated == false) {
                                        ribbonConfig.tabs.push(adjustmentsTab);
                                        adjustmentsTab.groups.push(adjustmentGroup);
                                        adjustmentsTab.groups.push(savingGroups);
                                        adjustmentsTab.groups.push(increasesGroup);
                                        increasesGroup.content[0].groups.push(increasesModifications);
                                        adjustmentTabCreated = true;
                                        increasesGroupCreated = true;
                                    } else {
                                        increasesGroup.content[0].groups.push(increasesModifications);
                                        increasesGroupCreated = true;
                                    }
                                } else {
                                    adjustmentsTab.groups.push(adjustmentGroup);
                                    adjustmentsTab.groups.push(savingGroups);
                                    adjustmentsTab.groups.push(increasesGroup);
                                    increasesGroup.content[0].groups.push(increasesModifications);
                                    adjustmentTabCreated = true;
                                }
                            }
                            
                            InicioTabCreated = true;
                        }
                    }
                    break;
                case "Consolidate":

                    if (!permission.View) {
                        $(".internalMenu li").eq(1).hide();
                        
                    }
                    if (!permission.Edit) {
                        $(".internalMenu li").eq(3).hide();
                    }

                    break;
                case "Reporting":

                    if (permission.View) {
                        $('#CompanyControl').show();
                        $('#FiscalYearControl').show();
                        $('#CostCenterControl').show();

                        if (groupParametersCreated == false) {
                            InicioTab.groups.push(groupParameters);
                            groupParametersCreated = true;
                        }

                        InicioTab.groups.push(reportButton);

                        if (InicioTabCreated == false) {
                            ribbonConfig.tabs.push(InicioTab);
                            InicioTabCreated = true;
                        }
                    } else {
                        $(".internalMenu li").eq(2).hide();
                    }
                    if (permission.Edit) {

                        $('#analysisParameter').show();
                        $('#analysisOption').show();                        
                       
                        ViewTab.groups[0].content[0].groups.push(analisysButton);
                        analysisPermission = true;
                    }

                    
                    break;
                case "Authorization":

                    if (permission.View) {
                        $('#CompanyControl').show();
                        $('#FiscalYearControl').show();
                        $('#CostCenterControl').show();

                        if (groupParametersCreated == false) {
                            InicioTab.groups.push(groupParameters);
                            groupParametersCreated = true;
                        }

                        AuthorizationButtonGroup.content.push(authorizationButtons[0]);
                        if (permission.Edit) {
                            AuthorizationButtonGroup.content.push(authorizationButtons[1]);
                        }

                        if (!authorizationGroupCreated) {
                            InicioTab.groups.push(AuthorizationButtonGroup);
                            authorizationGroupCreated = true;
                        }

                        if (InicioTabCreated == false) {
                            ribbonConfig.tabs.push(InicioTab);
                            InicioTabCreated = true;
                        }

                        if (adjustmentTabCreated == true) {
                            if ( increasesGroupCreated  == true) {
                                increasesGroup.content[0].groups.push(increaseRequestButton);
                            }
                            else {
                                adjustmentsTab.groups.push(increasesGroup);
                                increasesGroup.content[0].groups.push(increaseRequestButton);
                                increasesGroupCreated = true;
                            }

                        } else {
                            ribbonConfig.tabs.push(adjustmentsTab);
                            adjustmentsTab.groups.push(increasesGroup);
                            increasesGroup.content[0].groups.push(increaseRequestButton);
                            adjustmentTabCreated = true;
                            increasesGroupCreated = true;
                        }
                    }

                    break;
                case "Catalogs":
                    if (permission.View) {
                        maintenanceTab.groups.push(catalogsGroup);
                        if (maintenanceTabCreated == false) {
                            ribbonConfig.tabs.push(maintenanceTab);
                            maintenanceTabCreated = true;
                        }
                    }

                    break;

                case "Configuration":
                    if (permission.View) {
                        maintenanceTab.groups.push(configurationGroup);
                        if (maintenanceTabCreated == false) {
                            ribbonConfig.tabs.push(maintenanceTab);
                            maintenanceTabCreated = true;
                        }
                    }
                    break;
                case "Security":

                    if (permission.View) {
                        ribbonConfig.tabs.push(securityTab);
                    }
                    break;
                case "PeopleBudgeting":
                    
                    if (permission.Edit && !budgetingButtonsCreated) {
                        for (var j = 0; j < groupsBudgeting.length; j++) {
                            InicioTab.groups.push(groupsBudgeting[j]);
                        }
                        budgetingButtonsCreated = true;
                    }

                    if (!(permission.View && permission.AllCostCenters)) {
                        $(".internalMenu li").eq(0).hide();
                    }
                    break;

                default:
                    break;
            }

            
        }
        if (analysisPermission) {
            ribbonConfig.tabs.push(analysisTab);
            analysisTab.groups.push(groupParametersAnalisys);
            analysisTab.groups.push(filterTypeGroupAnalysis);
            analysisTab.groups.push(optionsChkAnalysis);
            analysisTab.groups.push(closeAnalysisButton);
            
        }
        
        $("#defaultRibbon").ejRibbon(ribbonConfig);

        var btnGenerar = $("#defaultRibbon_generate");

        if (btnGenerar.length) {
            btnGenerar = btnGenerar.data("ejButton");
            btnGenerar.disable();
        }
        
        $("#defaultRibbon").ejRibbon("hideTab", "ANÁLISIS");

    }).fail(function (jqXHR) {

        window.location = getUrl("/Home/Login");

    }).always(function () {
        ej.WaitingPopup.hideDefault();
    });
    
};

var InicioTab = {
    id: "home", text: "INICIO", groups: []
};

var groupParameters = {
                text: "Parámetros", alignType: ej.Ribbon.alignType.columns, content: [
                    {
                        groups: [
                            {
                                text: "Región",
                                contentID: "CompanyControl"
                            },
                            {
                                text: "Año fiscal",
                                contentID: "FiscalYearControl"
                            },
                            {
                                text: "Centro de costo",
                                contentID: "CostCenterControl"
                            }
                        ],
                        defaults: {
                            type: ej.Ribbon.type.custom,
                            width: 250,
                            height: 23,
                            cssClass: "Parameters"
                        }
                    }
                ]
}


var groupsBudgeting = [
        
        {
            text: "Paquetes", alignType: ej.Ribbon.alignType.columns, content: [{
                groups:
                    [
                    {
                        id: "addPackageButton",
                        text: "Agregar",
                        toolTip: "Agregar paquete",
                        cssClass: "CustomButton CenterButtonText",
                        buttonSettings: {
                            contentType: ej.ContentType.TextAndImage,
                            imagePosition: ej.ImagePosition.ImageTop,
                            prefixIcon: "glyphicon glyphicon-folder-close",
                            click: addNewPackageClick
                        }
                    }
                    ],
                defaults: {
                    type: ej.Ribbon.type.Button,
                    width: 60,
                    height: 70,
                    isBig: true
                }
            },
            {
                groups:
                    [
                    {
                        id: "deletePkg",
                        text: "Remover",
                        toolTip: "Remover paquete",
                        cssClass: "CustomButton CenterButtonText",
                        buttonSettings: {
                            contentType: ej.ContentType.TextAndImage,
                            imagePosition: ej.ImagePosition.ImageTop,
                            prefixIcon: "glyphicon glyphicon-remove-sign",
                            click: deletePackageClick
                        }
                    }
                    ],
                defaults: {
                    type: ej.Ribbon.type.Button,
                    width: 65,
                    height: 70,
                    isBig: true
                }
            }]
        }
        , {
            text: "Líneas", alignType: ej.Ribbon.alignType.columns, content: [{
                groups: [{
                    id: "new",
                    text: "Nueva",
                    toolTip: "Nueva línea",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        prefixIcon: "glyphicon glyphicon-asterisk",
                        click: "addLine"
                    }
                },
                {
                    id: "edit",
                    text: "Editar",
                    toolTip: "Editar línea",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        prefixIcon: "glyphicon glyphicon-pencil",
                        click: editLineButtonClick
                    }
                },

                {
                    id: "delete",
                    text: "Eliminar",
                    toolTip: "Eliminar línea",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        prefixIcon: "e-ribbon clearAll",
                        click: "deleteLineClick"
                    }
                }],
                defaults: {
                    type: ej.Ribbon.type.button,
                    width: 80,
                    isBig: false
                }
            },

            {
                groups:
                    [
                        {
                            id: "save",
                            text: "Guardar",
                            toolTip: "Guardar línea",
                            buttonSettings: {
                                contentType: ej.ContentType.TextAndImage,
                                prefixIcon: "glyphicon glyphicon-floppy-disk",
                                click: saveLineButtonClick
                            }
                        },
                        {
                            id: "cancel",
                            text: "Cancelar",
                            toolTip: "Cancelar edición",
                            buttonSettings: {
                                contentType: ej.ContentType.TextAndImage,
                                prefixIcon: "glyphicon glyphicon-floppy-remove",
                                click: cancelEditLineButtonClick
                            }
                        }
                    ],
                defaults: {
                    type: ej.Ribbon.type.Button,
                    width: 80
                }
            },

            {
                groups:
                    [
                    {
                        id: "generate",
                        text: "Generar",
                        toolTip: "Generar líneas",
                        cssClass: "CustomButton CenterButtonText",
                        buttonSettings: {
                            contentType: ej.ContentType.TextAndImage,
                            imagePosition: ej.ImagePosition.ImageTop,
                            prefixIcon: "glyphicon glyphicon-flash",
                            click: "generateEmployeeLines"
                        }
                    }
                    ],
                defaults: {
                    type: ej.Ribbon.type.Button,
                    width: 70,
                    height: 70
                }
            }


            ]
    }
];

var BudgetingTab = {
    id: "home", text: "INICIO", 
};

var ViewTab = {
    id: "view", text: "VISTA", groups: [
    {
        text: "Presupuestación", alignType: ej.Ribbon.alignType.rows, content: [
            {
                groups: [{
                    id: "Budget",
                    text: "Presupuestar",
                    toolTip: "Budget",
                    cssClass: "CustomButton CenterButtonText",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-piggy-bank",
                        click: "BudgetingView"
                    }
                },
                {
                    id: "Summary",
                    text: "Resumen",
                    toolTip: "Resumen",
                    cssClass: "CustomButton CenterButtonText",
                    width: 70,
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-list-alt",
                        click: "Summary"
                    }
                },
                ],
                defaults: {
                    type: ej.Ribbon.type.button,
                    width: 100,
                    height: 70
                }
            }
        ]
    },
    {
        text: "Moneda", alignType: ej.Ribbon.alignType.rows, content: [
            {
                groups: [
                    {
                        text: "Moneda",
                        contentID: "CurrencyControl"
                    }
                ],
                defaults: {
                    type: ej.Ribbon.type.custom,
                    width: 160,
                    height: 23,
                    cssClass: "Parameters"
                }
            }
        ]
    },
        {
            text: "Meses", alignType: ej.Ribbon.alignType.rows, content: [
                {
                    groups:
                    [
                        {
                            type: "custom",
                            contentID: "designMonths"
                        }
                    ]

                }
            ]
        },
        {
            text: "Columnas", alignType: ej.Ribbon.alignType.rows, content: [
                {
                    groups:
                    [
                        {
                            type: "custom",
                            contentID: "designColumns"
                        }
                    ]

                }
            ]
        },
        {
            text: "Resumen", alignType: ej.Ribbon.alignType.rows, content: [
                {
                    groups:
                    [
                        {
                            type: "custom",
                            contentID: "designSummary"
                        }
                    ]

                }
            ]
        }
    ]
};

var analisysButton = {
    
        id: "analysisbtn",
        text: "Análisis",
        toolTip: "Análisis",
        cssClass: "CustomButton CenterButtonText",
        width: 70,
        buttonSettings: {
            contentType: ej.ContentType.TextAndImage,
            imagePosition: ej.ImagePosition.ImageTop,
            prefixIcon: "glyphicon glyphicon-stats",
            click: "analysisButtonClick"
        }
};

function analysisButtonClick() {
    var ribbonObj = $("#defaultRibbon").data("ejRibbon");
    $("#defaultRibbon").ejRibbon("showTab", "ANÁLISIS");

    for (var i = 0; i < ribbonObj._tabContents.length; i++) {
        
        var txtTab = ribbonObj.getTabText(i);
        ribbonObj.hideTab(txtTab);
        
        for (var j = 0; j <= ribbonObj._tabContents.length; j++) {
            if (j == ribbonObj._tabContents.length) {
                $("#defaultRibbon").ejRibbon({
                    selectedItemIndex: j
                });
            }
        }
    }

    $.ajax({
        url: getUrl("/api/Analysis"),
        method: "DELETE"        
    }).done(function () {

        var paginachange = getUrl("/Reporting/_Container");
        $("#analysisView").show();
        $("#analysisView").load(paginachange);

        $("#summaryView").hide();
        $("#IncreasesRequestView").hide();
        $("#BudgetContainer").hide();

    }).fail(function (jqXHR, textStatus, errThrown) {
        alert("Ocurrió un error al intentar generar el paquete");
    }).always(function () {
        ej.WaitingPopup.hideDefault();
    });
}
var reportButton = {
    text: "Exportar", alignType: ej.Ribbon.alignType.columns, content: [
        {
            groups: [
                {
                    id: "report",
                    text: "Reporte",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Exportar reporte",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-tasks",
                        click: "exportCurrentViewReport"
                    }
                }
            ],
            defaults: {
                type: ej.Ribbon.type.Button,
                width: 60,
                height: 70,
                isBig: true
            }
        }
    ]
};

var exportGroup = {
    text: "Exportar", alignType: ej.Ribbon.alignType.columns,
    content: [{
        groups: [],
                    defaults: {
                        type: ej.Ribbon.type.Button,
                        width: 60,
                        height: 70,
                        isBig: true
                    }
    }]
};

var RequestAuthorizationButton =
{
    groups: [
        {
            id: "requestAuthorization",
            text: "Solicitar Autorización",
            cssClass: "CustomButton CenterButtonText",
            toolTip: "Solicitar autorización del presupuesto actual",
            buttonSettings: {
                contentType: ej.ContentType.TextAndImage,
                imagePosition: ej.ImagePosition.ImageTop,
                prefixIcon: "glyphicon glyphicon-edit",
                click: "requestAuthorization"
            }
        }
    ],
    defaults: {
        type: ej.Ribbon.type.Button,
        width: 100,
        height: 70,
        isBig: true
    }
};

var AuthorizationButtonGroup = {
    text: "Revisión", alignType: ej.Ribbon.alignType.columns, content: []
};

var authorizationButtons = [
    {
        groups: [
            {
                id: "authorizeBudget",
                text: "Autorizar",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Autorizar presupuesto",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-check",
                    click: "authorizeBudget"
                }
            }
        ],
        defaults: {
            type: ej.Ribbon.type.Button,
            width: 80,
            height: 70,
            isBig: true
        }
    },
    {
        groups: [
            {
                id: "enableBudgetChanges",
                text: "Habilitar cambios",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Habilitar cambios en el presupuesto",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-folder-open",
                    click: "enableBudgetChanges"
                }
            }
        ],
        defaults: {
            type: ej.Ribbon.type.Button,
            width: 80,
            height: 70,
            isBig: true
        }
    }
];

var maintenanceTab = {
    id: "maintenance", text: "MANTENIMIENTO",
    groups: []
};

var catalogsGroup = {
        text: "Catálogos", alignType: ej.Ribbon.alignType.columns, content: [{
            groups: [{
                id: "employees",
                text: "Empleados",
                toolTip: "Empleados",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    prefixIcon: "glyphicon glyphicon-user",
                    click: "EmployeesPopUp"
                },

            },
            {
                id: "positions",
                text: "Posiciones",
                toolTip: "Posiciones",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    prefixIcon: "glyphicon glyphicon-record",
                    click: "PositionPopUp"
                }
            }
            ],
            defaults: {
                type: ej.Ribbon.type.button,
                isBig: false,
                width: 125
            }
        },
        {
            groups: [
            {
                id: "benefits",
                text: "Beneficios",
                toolTip: "Beneficios",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    prefixIcon: "glyphicon glyphicon-heart",
                    click: "BenefitsPopUp"
                }
            },
            {
                id: "equipment",
                text: "Equipo",
                toolTip: "Equipo de protección",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    prefixIcon: "glyphicon glyphicon-briefcase",
                    click: "EquipmentsPopUp"
                },

            }
            ],
            defaults: {
                type: ej.Ribbon.type.button,
                width: 125,
                isBig: false
            }
        },
        {
            groups: [
            {
                id: "providers",
                text: "Proveedores",
                toolTip: "Proveedores",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    prefixIcon: "glyphicon glyphicon-shopping-cart",
                    click: "ProvidersPopUp"
                },
                alignLeft: true
            }],
            defaults: {
                type: ej.Ribbon.type.button,
                width: 125,
                isBig: false
            }
        }]
};


var costCenter = {

};

var configurationGroup = {
        text: "Configuración", alignType: ej.Ribbon.alignType.rows, content: [{
            groups: [{
                id: "programmings",
                text: "Periodos",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Periodos",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "e-ribbon e-datetimenew",

                    click: "ProgrammingsPopUp"
                }
            },
                {
                    id: "premises",
                    text: "Premisas",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Premisas",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-flag",
                        click: "PremisesPopUp"
                    }
                },
                {
                    id: "exchangerates",
                    text: "Tipos de cambio",
                    toolTip: "Tipos de cambio",
                    cssClass: "CustomButton CenterButtonText",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-usd",
                        click: "ExchangeRatesPopUp"
                    }
                },

                {
                id: "accounts",
                text: "Cuentas contables",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Cuentas contables",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-th-list",
                    click: "AccountsPopUp"
                }
            },
                {
                    id: "costCenter",
                    text: "Centros de costo",
                    cssClass: "CustomButton",
                    toolTip: "Centros de costos",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-sort-by-attributes",
                        click: "CostCenterPopUp"
                    }
                },
                {
                    id: "packages",
                    text: "Paquetes",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Paquetes",
                    buttonSettings: {
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-gift",
                        click: "PackagesPopUp"
                    }
                }
            ],
            defaults: {
                type: ej.Ribbon.type.button,
                width: 70,
                height: 70
            }
        }]
};

var securityTab = {
    id: "security", text: "SEGURIDAD", groups: [
    {
        text: "Seguridad", alignType: ej.Ribbon.alignType.rows, content: [{
            groups: [{
                id: "roles",
                text: "Roles",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Roles",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "e-ribbon e-datetimenew",
                    click: "RolesPop"
                }
            },
                {
                    id: "users",
                    text: "Usuarios",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Usuarios",
                    buttonSettings: {
                        width: 100,
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-user",
                        click: "UsersPop"
                    }
                },
                {
                    id: "options",
                    text: "Opciones",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Opciones",
                    buttonSettings: {
                        width: 100,
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-cog",
                        click: "OptionsPop"
                    }
                },
                {
                    id: "companyAuthorizers",
                    text: "Autorización",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Autorización de presupuestos",
                    buttonSettings: {
                        width: 100,
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-check",
                        click: "CompanyAuthorizersPop"
                    }
                },
                {
                    id: "events",
                    text: "Auditoría de eventos",
                    cssClass: "CustomButton CenterButtonText",
                    toolTip: "Auditoría de eventos",
                    buttonSettings: {
                        width: 100,
                        contentType: ej.ContentType.TextAndImage,
                        imagePosition: ej.ImagePosition.ImageTop,
                        prefixIcon: "glyphicon glyphicon-calendar",
                        click: "EventsPopUp"
                    }
                }
            ],
            defaults: {
                type: ej.Ribbon.type.button,
                width: 70,
                height: 70
}
        }]
}
    ]
};

var adjustmentsTab = {
    id: "adjustments", text: "AJUSTES", groups: []
};

var adjustmentGroup = {
    text: "Ajustes", alignType: ej.Ribbon.alignType.rows, content: [{
        groups: [
            {
                id: "accountAdjustment",
                text: "De cuenta contable",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Ajuste entre cuentas contables",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-random",
                    click: AccountAdjustmentPopup
                }
            },
            {
                id: "budgetingLineAdjustment",
                text: "De línea presupuestaria",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Ajuste de línea presupuestaria",
                buttonSettings: {
                    width: 120,
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-resize-horizontal",
                    click: BudgetingLineAdjustmentPopup
                }
            }
        ],
        defaults: {
            type: ej.Ribbon.type.button,
            width: 80,
            height: 70
        }
    }]
};

var savingGroups = {
    text: "Ahorros", alignType: ej.Ribbon.alignType.rows, content: [{
        groups: [
            {
                id: "savingsModifications",
                text: "Traslado",
                cssClass: "CustomButton CenterButtonText",
                toolTip: "Ahorros del mes anterior",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-piggy-bank",
                    click: SavingsModificationsPopup
                }
            }
        ],
        defaults: {
            type: ej.Ribbon.type.button,
            width: 80,
            height: 70
        }
    }]
};

var increasesGroup = {
    text: "Incrementos", alignType: ej.Ribbon.alignType.rows, content: [{
        groups: [],
        defaults: {
            type: ej.Ribbon.type.button,
            width: 60,
            height: 70
        }
    }]
};
var increasesModifications = {
    id: "increasesModifications",
    text: "Solicitar",
    cssClass: "CustomButton  CenterButtonText",
    toolTip: "Solicitar un incremento de presupuesto",
    buttonSettings: {
        width: 80,
        contentType: ej.ContentType.TextAndImage,
        imagePosition: ej.ImagePosition.ImageTop,
        prefixIcon: "glyphicon glyphicon-envelope",
        click: IncreasesModificationsPopup
    }
};

var increaseRequestButton = {
    id: "increasesRequest",
    text: "Solicitudes",
    cssClass: "CustomButton  CenterButtonText",
    toolTip: "ver solicitudes de incrementos",
    buttonSettings: {
        width: 80,
        contentType: ej.ContentType.TextAndImage,
        imagePosition: ej.ImagePosition.ImageTop,
        prefixIcon: "glyphicon glyphicon-log-in",
        click: IncreasesRequest
    }
};

var analysisTab = {
    id: "analysis", text: "ANÁLISIS", groups: []
};

var groupParametersAnalisys = {
    text: "Parámetros", alignType: ej.Ribbon.alignType.columns, content: [
        {
            groups: [
                {
                    text: "Tipo análisis",
                    contentID: "typeAnalysis"
                },
                {
                    text: "Año fiscal",
                    contentID: "fiscalYearAnalisys"
                },
                {
                    text: "Paquete",
                    contentID: "packageAnalisys"
                }
            ],
            defaults: {
                type: ej.Ribbon.type.custom,
                width: 250,
                height: 23,
                cssClass: "Parameters"
            }
        },
    {
        groups:
            [
            {
                id: "generateReport",
                text: "Generar",
                toolTip: "Generar reporte",
                cssClass: "CustomButton CenterButtonText",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-stats",
                    click: "generateReportClick"
                }
            }
            ],
        defaults: {
            type: ej.Ribbon.type.Button,
            width: 65,
            height: 70,
            isBig: true
        }
    }
    ]
};

var filterTypeGroupAnalysis = {
    text: "Filtros", alignType: ej.Ribbon.alignType.columns, content: [{
        groups:
            [
            {
                id: "costCenterFilterAnalysis",
                text: "Centro de costo",
                toolTip: "filto por centro de costo",
                cssClass: "CustomButton CenterButtonText",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-sort-by-attributes",
                    click: "CostCenterFilterAnalysis"
                }
            }
            ],
        defaults: {
            type: ej.Ribbon.type.Button,
            width: 60,
            height: 70,
            isBig: true
        }
    },
            {
                groups:
                    [
                    {
                        id: "accoutnsFilterAnalysis",
                        text: "Cuentas contables",
                        toolTip: "Remover paquete",
                        cssClass: "CustomButton CenterButtonText",
                        buttonSettings: {
                            contentType: ej.ContentType.TextAndImage,
                            imagePosition: ej.ImagePosition.ImageTop,
                            prefixIcon: "glyphicon glyphicon-list",
                            click: "AccountFilterAnalysis"
                        }
                    }
                    ],
                defaults: {
                    type: ej.Ribbon.type.Button,
                    width: 65,
                    height: 70,
                    isBig: true
                }
            }]

};

var optionsChkAnalysis = {
    
        text: "Opciones", alignType: ej.Ribbon.alignType.rows, content: [
            {
                groups:
                [
                    {
                        type: "custom",
                        contentID: "analysisOption"
                    }
                ]

            }
        ]
}

var closeAnalysisButton = {
    text: "Salir", alignType: ej.Ribbon.alignType.columns, content: [{
        groups:
            [
            {
                id: "closeAnalysisMode",
                text: "Salir modo análisis",
                toolTip: "Salir del modo análisis",
                cssClass: "CustomButton CenterButtonText",
                buttonSettings: {
                    contentType: ej.ContentType.TextAndImage,
                    imagePosition: ej.ImagePosition.ImageTop,
                    prefixIcon: "glyphicon glyphicon-eye-close",
                    click: "closeAnalysis"
                }
            }
            ],
        defaults: {
            type: ej.Ribbon.type.Button,
            width: 60,
            height: 70,
            isBig: true
        }
    }]

};

function closeAnalysis() {
    
    var ribbonObj = $("#defaultRibbon").data("ejRibbon");
    
    
    for (var i = 0; i < ribbonObj._tabContents.length; i++) {
        //ribbonObj.option({
        //    disabledItemIndex: [i]
        //});
        var txtTab = ribbonObj.getTabText(i);
        ribbonObj.showTab(txtTab);

        //for (var j = 0; j <= ribbonObj._tabContents.length; j++) {
        //    if (j == ribbonObj._tabContents.length) {
        //        var txtTabAnalysis = ribbonObj.getTabText(j);
        //        console.log(txtTabAnalysis);
        //        ribbonObj.hideTab(j);
        //    }
        //}

        //console.log(i);
    }
    ribbonObj.hideTab("ANÁLISIS");


    $("#analysisView").hide();

    $("#summaryView").show();
    $("#IncreasesRequestView").show();
    $("#BudgetContainer").show();
    
            
}