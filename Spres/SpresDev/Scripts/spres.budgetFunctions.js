var editingContext = {};

function generateReportClick() {

    var analysisType = $("#analysisTypeList").ejDropDownList("instance").getSelectedValue();
    var fiscalYear = $("#fiscalYearAnalysisList").ejDropDownList("instance").getSelectedValue();
    var packageId = $("#packageAnalisysList").ejDropDownList("instance").getSelectedValue();

    if (analysisType != "" && fiscalYear != "") {

        if (analysisType != "0" && packageId == "") {

            alert("Seleccione un paquete");

        }
        if (sessionStorage.filteredCostCenters && sessionStorage.filteredCostCenters.length == 0) {
            alert("Debe seleccionar al menos un centro de costos en la sección de filtros");
        }
        if (sessionStorage.filteredAccounts && sessionStorage.filteredAccounts.length == 0) {
            alert("Debe seleccionar al menos una cuenta contable en la sección de filtros");
        }
        else {
            var lineDetailsBool = true;
            var collapseGroupedData = true;
            var showAlert = true;
            $("#chkGroupData").prop("checked") ? collapseGroupedData = true : collapseGroupedData = false;
            $("#chkIncludeDetailLines").prop("checked") ? IncludeLineDetails = true : IncludeLineDetails = false;
            $("#chkShowAlert").prop("checked") ? showAlert = true : showAlert = false;
            

            var obj = {
                ReportPath: getAnalysisType(analysisType),
                FiscalYear: fiscalYear,
                Package: (analysisType == "0") ? null : packageId,
                CostCenters: sessionStorage.filteredCostCenters ? sessionStorage.filteredCostCenters.split(",") : undefined,
                Accounts: sessionStorage.filteredAccounts ? sessionStorage.filteredAccounts.split(",") : undefined,
                IncludeLineDetails: IncludeLineDetails,
                CollapseGroupedData: collapseGroupedData,
                HideNonBudgeted: showAlert
            }

            ej.WaitingPopup.showDefault();
            $.ajax({
                url: getUrl("/api/Analysis"),
                method: "POST",
                data: obj               
            }).done(function () {
                
                var paginachange = getUrl("/Reporting/_Container");
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
    } else {
        alert("Seleccione un tipo de reporte y un año fiscal");
    }

    

};

function getAnalysisType(value) {
    switch (value) {
        case "0": return "/SpresReports/ReportPackages";
        case "1": return "/SpresReports/ReportAccounts";
        case "2": return "/SpresReports/ReportCostCenters";
        default: return "";
    }
};

function IncreasesModificationsPopup() {

    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();
    var lineId = sessionStorage.lineId;

    if (companyId && fiscalYear && costCenterId) {

        if (lineId) {
            var url = getUrl("/Home/IncreasesModifications");

            var increasesModificationsDialog = $("#increasesModificationsDialog").data("ejDialog");
            if (increasesModificationsDialog != undefined) {
                increasesModificationsDialog.destroy();
            }
            increasesModificationsDialog = $("#increasesModificationsDialog").ejDialog({
                enableModal: true,
                enableResize: false,
                contentType: "ajax",
                showOnInit: false,
                allowDraggable: true,
                isResponsive: false,
                actionButtons: [],
                width: 800,
                height: 560

            }).data("ejDialog");

            increasesModificationsDialog.option({
                contentUrl: url,
                title: "Incrementos de presupuesto"
            });
            increasesModificationsDialog.open();

        } else {
            alert("Seleccione una cuenta contable");
        }

    } else {
        alert("Seleccione una región, un año fiscal y un centro de costo");
    }
};

function SavingsModificationsPopup() {
    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();
    var lineId = sessionStorage.lineId;

    if (companyId && fiscalYear && costCenterId) {

        if (lineId) {
            var url = getUrl("/Home/SavingsTransfer");

            var savingsTransferDialog = $("#savingsTransferDialog").data("ejDialog");
            if (savingsTransferDialog != undefined) {
                savingsTransferDialog.destroy();
            }
            savingsTransferDialog = $("#savingsTransferDialog").ejDialog({
                enableModal: true,
                enableResize: false,
                contentType: "ajax",
                showOnInit: false,
                allowDraggable: true,
                isResponsive: false,
                actionButtons: [],
                width: 550,
                height: 470

            }).data("ejDialog");

            savingsTransferDialog.option({
                contentUrl: url,
                title: "Traslado de ahorros"
            });
            savingsTransferDialog.open();

        } else {
            alert("Seleccione una cuenta contable origen");
        }

    } else {
        alert("Seleccione una región, un año fiscal y un centro de costo");
    }
};

function AccountAdjustmentPopup() {

    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();
    var lineId = sessionStorage.lineId;

    if (companyId && fiscalYear && costCenterId) {

        if (lineId) {
            var url = getUrl("/Home/AccountAdjustment");

            var accountAdjustmentDialog = $("#accountAdjustmentDialog").data("ejDialog");
            if (accountAdjustmentDialog != undefined)
            {
                accountAdjustmentDialog.destroy();
            }
            accountAdjustmentDialog = $("#accountAdjustmentDialog").ejDialog({
                enableModal: true,
                enableResize: false,
                contentType: "ajax",
                showOnInit: false,
                allowDraggable: true,
                isResponsive: false,
                actionButtons: [],
                width: 550,
                height: 470

            }).data("ejDialog");

            accountAdjustmentDialog.option({
                contentUrl: url,
                title: "Ajuste presupuestario entre cuentas contables"
            });
            accountAdjustmentDialog.open();

        } else {
            alert("Seleccione una cuenta contable origen");
        }
        
    } else {
        alert("Seleccione una región, un año fiscal y un centro de costo");
    }
};

function BudgetingLineAdjustmentPopup() {
    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();
    var subLineId = sessionStorage.subLineId;

    if (companyId && fiscalYear && costCenterId) {

        if (subLineId) {
            var url = getUrl("/Home/BudgetingLineAdjustment");

            var budgetingLineAdjustmentDialog = $("#budgetingLineAdjustmentDialog").data("ejDialog");
            if (budgetingLineAdjustmentDialog != undefined) {
                budgetingLineAdjustmentDialog.destroy();
            }
            budgetingLineAdjustmentDialog = $("#budgetingLineAdjustmentDialog").ejDialog({
                enableModal: true,
                enableResize: false,
                contentType: "ajax",
                showOnInit: false,
                allowDraggable: true,
                isResponsive: false,
                actionButtons: [],
                width: 600,
                height: 560

            }).data("ejDialog");

            budgetingLineAdjustmentDialog.option({
                contentUrl: url,
                title: "Ajuste presupuestario de línea de presupuestación"
            });
            budgetingLineAdjustmentDialog.open();

        } else {
            alert("Seleccione una línea presupuestaria");
        }

    } else {
        alert("Seleccione una región, un año fiscal y un centro de costo");
    }
};

function EmployeesPopUp() {

    var url = getUrl("/Configuration/Employees");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Catálogo de empleados",
        width: 1150,
        height: 500
    });
    dialog.open();
};

function PositionPopUp() {

    var url = getUrl("/Configuration/Positions");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Catálogo de posiciones",
        width: 700,
        height: 500
    });
    dialog.open();

};

function PackagesPopUp() {

    var url = getUrl("/Configuration/Packages");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Catálogo de paquetes",
        width: 700,
        height: 570
    });
    dialog.open();

};

function BenefitsPopUp() {
    var url = getUrl("/Configuration/Benefits");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Catálogo de beneficios",
        width: 700,
        height: 500
    });
    dialog.open();

};

function EquipmentsPopUp() {
    var url = getUrl("/Configuration/Equipments");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Catálogo de equipo de protección individual",
        width: 700,
        height: 500
    });
    dialog.open();
};

function ProvidersPopUp() {
    var url = getUrl("/Configuration/Providers");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Catálogo de proveedores",
        width: 700,
        height: 500
    });
    dialog.open();
};
//popups listas
function AccountsPopUp() {
    var url = getUrl("/Configuration/Accounts");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Listados de cuentas contables",
        width: 800,
        height: 500
    });
    dialog.open();

};

function CostCenterPopUp() {
    var url = getUrl("/Configuration/CostCenters");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Listados de centros de costo",
        width: 750,
        height: 525
    });
    dialog.open();
};

//popups configuración

function ProgrammingsPopUp() {
    var url = getUrl("/Configuration/Programmings");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Configuración de períodos de ingreso y ajuste de presupuesto",
        width: 700,
        height: 450
    });
    dialog.open();

};

function PremisesPopUp() {
    var url = getUrl("/Configuration/Premises");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Configuración de premisas",
        width: 700,
        height: 520
    });
    dialog.open();
};

//Popups seguridad

function CompanyAuthorizersPop() {
    var url = getUrl("/Security/CompanyAuthorizers");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Autorización de Presupuestos",
        width: 600,
        height: 500
    });
    dialog.open();
};

function RolesPop() {
    var url = getUrl("/Security/Roles");
    clearDialogContent(url);
    dialog.option({        
        title: "Administración de roles",
        width: 700,
        height: 500
    });
    dialog.option({ contentUrl: url });
    dialog.open();
};

function UsersPop() {
    var url = getUrl("/Security/Users");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Administración de usuarios",
        width: 800,
        height: 520
    });
    dialog.open();
};

function OptionsPop() {
    var url = getUrl("/Security/Options");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Administración de opciones",
        width: 700,
        height: 500
    });
    dialog.open();
};

function EventsPopUp() {

    var url = getUrl("/Security/Events");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Auditoría de eventos",
        width: 700,
        height: 500
    });
    dialog.open();

};


function ExchangeRatesPopUp() {
    var url = getUrl("/Configuration/ExchangeRates");
    clearDialogContent(url);
    dialog.option({
        contentUrl: url,
        title: "Mantenimiento de tipos de cambios",
        width: 700,
        height: 500
    });
    dialog.open();
};

function Summary() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var costCenter = getCostCenterId();
    var currency = getCurrencyId();

    if (fiscal && company && costCenter && currency) {
        ej.WaitingPopup.showDefault();
        toggleView(false);
        var paginachange = getUrl("/Home/_Summary");
        var summary = $("#summaryView");
        var IncreasesRequestView = $("#IncreasesRequestView");
        IncreasesRequestView.hide();
        IncreasesRequestView.empty();
        summary.empty();
        summary.load(paginachange);
        summary.show();
        $("#SheetsTab").hide();
        $('#expSummary').show();
        $('#exp').hide();

        $("#BudgetContainer").hide();
        $("#analysisView").hide();

    } else {
        alert("Seleccione año fiscal, región y centro de costos");
    }
    sessionStorage.setItem("currentView", "Summary");
};

function BudgetingView() {
    toggleView(true);
    var summary = $("#summaryView");
    var IncreasesRequestView = $("#IncreasesRequestView");
    IncreasesRequestView.hide();
    IncreasesRequestView.empty();
    $('#SheetsTab').show();
    $("#BudgetContainer").show();

    $("#analysisView").hide();
    $("#summaryView").hide();
    $("#IncreasesRequestView").hide();
    
    $('#expSummary').hide();
    $('#exp').show();
    summary.hide();
    summary.empty();
    sessionStorage.setItem("currentView", "Budgeting");
};


function IncreasesRequest() {

    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();

    if (companyId && fiscalYear && costCenterId) {

        ej.WaitingPopup.showDefault();
        $.ajax({
            url: getUrl("/api/Forecasts/IncreasedPackages/" + fiscalYear + "/" + companyId + "/" + costCenterId),
            method: "GET"
        }).done(function (packages) {

            console.log(packages);

            if (packages.length > 0) {
                
        toggleView(false);
        var paginachange = getUrl("/Home/_IncreasesRequest");
        var summary = $("#summaryView");
        var IncreasesRequestView = $("#IncreasesRequestView");
        sessionStorage.setItem("companyIncrease", companyId);
        sessionStorage.setItem("fiscalYearIncrease", fiscalYear);
        sessionStorage.setItem("costCenterIncrease", costCenterId);
                sessionStorage.setItem("increasedPackages", JSON.stringify(packages));
        $("#SheetsTab").hide();
        $('#expSummary').hide();
        $('#exp').hide();
        summary.hide();
        summary.empty();
                IncreasesRequestView.load(paginachange);
        IncreasesRequestView.show();
                
            } else {

                

                alert("No se encontró ninguna solicitud de incremento en para el presupuesto del centro de costo seleccionado");
            }

        }).fail(function (jqXHR, textStatus, errThrown) {

            if (jqXHR.status == 400 && jqXHR.responseJSON && jqXHR.responseJSON.Message) {
                alert(jqXHR.responseJSON.Message);
            } else {
                alert("Ocurrió un error interno al intentar cargar la información de las solicitudes de incrementos");
            }

        }).always(function () {
            ej.WaitingPopup.hideDefault();
        });
    }
    else {
        alert("Seleccione año fiscal, región y centro de costos");
    }

};

function addNewPackageClick() {
    if (typeof createBudgetSheet != "undefined") createBudgetSheet();
};

function deletePackageClick() {
    if (typeof removeBudgetSheet != "undefined") removeBudgetSheet();
};

function changeCurrency(args) {

    var count = args.model.dataSource.length;
    changeCurrencyStatusLabel(args.text);
    if (count > 1) {
        if (args.model.selectedItemIndex > 0) {
            toggleBudgeting(false);
            alert("Las modificaciones han sido deshabilitadas. Si desea presupuestar, utilice la moneda local (" + args.model.dataSource[0].Name + ")");
        } else {
            toggleBudgeting(true);
        }
    }
    loadBudgetSheets();

    if (sessionStorage.currentView == "Summary"){
        Summary();
    }
};

function toggleAddPackageTabButton(enable) {
    if (enable) {
        sheetsTabObj.option("enabledItemIndex", [0]);
    } else {
        sheetsTabObj.option("disabledItemIndex", [0]);
    }
}

function toggleBudgetButtons(enableButtons, budgetStatus) {
    var buttons = [
        "defaultRibbon_addPackageButton",
        "defaultRibbon_deletePkg",
        "defaultRibbon_new",
        "defaultRibbon_delete"
    ];

    toggleAddPackageTabButton(enableButtons);

    if (enableButtons || (!enableButtons && budgetStatus == 3)) {
        // Si estoy habilitando los botones o si el presupuesto está autorizado y estoy deshabilitando los botones
        buttons.push("defaultRibbon_edit");
        buttons.push("defaultRibbon_save");
        buttons.push("defaultRibbon_cancel");
    }
    
    for (var i = 0; i < buttons.length; i++) {
        var button = $("#" + buttons[i]);
        if (button.length) {
            var obj = button.data("ejButton");
            if (enableButtons) {
                obj.enable();
            } else {
                obj.disable();
            }
        }
    }
    var generateButton = $("#defaultRibbon_generate");
    if (generateButton.length) {
        generateButton.data("ejButton").disable();
    }
};

function toggleBudgeting(enable) {
    var buttons = [
        "defaultRibbon_addPackageButton",
        "defaultRibbon_deletePkg",
        "defaultRibbon_new",
        "defaultRibbon_edit",
        "defaultRibbon_delete",
        "defaultRibbon_save",
        "defaultRibbon_cancel",
        "defaultRibbon_authorizeBudget",
        "defaultRibbon_enableBudgetChanges"
    ];

    for (var i = 0; i < buttons.length; i++) {
        var button = $("#" + buttons[i]);
        if (button.length) {
            var obj = button.data("ejButton");
            if (enable) {
                obj.enable();
            } else {
                obj.disable();
            }
        }
    }
    var generateButton = $("#defaultRibbon_generate");
    if (generateButton.length){
        generateButton.data("ejButton").disable();
    }
};

function toggleView(enable) {
    var buttons = [
        "defaultRibbon_addPackageButton",
        "defaultRibbon_deletePkg",
        "defaultRibbon_new",
        "defaultRibbon_edit",
        "defaultRibbon_delete",
        "defaultRibbon_save",
        "defaultRibbon_cancel",
        "defaultRibbon_authorizeBudget",
        "defaultRibbon_enableBudgetChanges"
    ];

    for (var i = 0; i < buttons.length; i++) {
        var button = $("#" + buttons[i]);
        if (button.length) {
            var obj = button.data("ejButton");
            if (enable) {
                obj.enable();
            } else {
                obj.disable();
            }
        }
    }
        
    var generateButton = $("#defaultRibbon_generate");
    if (generateButton.length) {
        generateButton.data("ejButton").disable();
    }

    $(".chkMeses").each(function () {
        if (enable) {
            $(this).removeAttr("disabled");
        } else {
            $(this).attr("disabled", true);
    }
    });

    $(".chkColumnas").each(function () {
        if (enable) {
            $(this).removeAttr("disabled");
        } else {
            $(this).attr("disabled", true);
        }
    });

    $(".chkResumen").each(function () {
        if (enable) {
            $(this).removeAttr("disabled");
        } else {
            $(this).attr("disabled", true);
        }
    });
};

function showColumn(columnName, gridId) {
    
    $(".e-content > .e-grid").each(function () {

        var gridObj = $(this).data("ejGrid");
        if (gridObj != undefined) {

            var column = gridObj.getColumnByField(columnName);

            if (column) {
                gridObj.showColumns(columnName);
            }
        }
    });
    
};

function hideColumn(columnName, gridId) {

    $(".e-content > .e-grid").each(function () {

        var gridObj = $(this).data("ejGrid");
        var column = gridObj.getColumnByField(columnName);

        if (column && column.visible) {
            gridObj.hideColumns(columnName);
        }

    });
};

function requestAuthorization() {

    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();

    if (companyId && fiscalYear && costCenterId) {

        var budgetDialog = $("#requestAuthorizationDialog").data("ejDialog");

        if (budgetDialog != undefined)
            budgetDialog.destroy();

        var url = getUrl("/Home/_RequestAuthorization");

        budgetDialog = $("#requestAuthorizationDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: [],
            width: 600,
            heigh: 400

        }).data("ejDialog");

        budgetDialog.option({
            contentUrl: url,
            title: "Solicitar autorización"
        });

        budgetDialog.open();
    } else {
        alert("Debe seleccionar región, año fiscal y centro de costo.");
    }
};

function authorizeBudget() {

    var companyId = getCompanyId();
    var fiscalYear = getFiscalYear();
    var costCenterId = getCostCenterId();

    if (companyId && fiscalYear && costCenterId) {

        var budgetDialog = $("#authorizeBudgetDialog").data("ejDialog");

        if (budgetDialog != undefined)
            budgetDialog.destroy();
        var url = getUrl("/Home/_AuthorizeBudget");
        budgetDialog = $("#authorizeBudgetDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: [],
            width: 600,
            heigh: 400

        }).data("ejDialog");

        budgetDialog.option({
            contentUrl: url,
            title: "Autorizar presupuesto"
        });

        budgetDialog.open();
    } else {
        alert('Debe seleccionar región, año fiscal y centro de costo.');
    }
};

function enableBudgetChanges() {
    var companyId = getCompanyId(); var fiscalYear = getFiscalYear(); var costCenterId = getCostCenterId();
    if (companyId && fiscalYear && costCenterId) {

        var budgetDialog = $("#enableBudgetChangesDialog").data("ejDialog");

        if (budgetDialog != undefined)
            budgetDialog.destroy();
        var url = getUrl("/Home/_EnableBudgetChanges");
        budgetDialog = $("#enableBudgetChangesDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: []
        }).data("ejDialog");
        budgetDialog.option({
            contentUrl: url,
            title: "Habilitar cambios en el Presupuesto"
        });
        budgetDialog.open();
    } else alert('Debe seleccionar región, año fiscal y centro de costo.');
};

function exportConsolidatedBudget() {
    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var currency = getCurrencyId();

    if (fiscal && company && currency) {

        var url = "/api/export?fiscal=" + fiscal + "&company=" + company + "&toCurrencyId=" + currency;
        var popup = window.open(getUrl(url), "_blank");
    } else {
        alert("Seleccione año fiscal y región");
    }
};

function exportCurrentViewReport() {

    var currentView = sessionStorage.getItem("currentView");

    if (currentView == "Summary") {
        exportSummary();
    }
    else {
        exportReport();
    }
};

function exportReport() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var costCenter = getCostCenterId();
    var currency = getCurrencyId();

    if (fiscal && company && costCenter && currency) {

        var url = "/api/export?fiscal=" + fiscal + "&company=" + company + "&costCenter=" + costCenter + "&toCurrencyId=" + currency;
        var popup = window.open(getUrl(url), "_blank");
    } else {
        alert("Seleccione año fiscal, región y centro de costos");
    }
};

function exportHistoricalReport() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var costCenter = getCostCenterId();
    var currency = getCurrencyId();

    if (fiscal && company && costCenter && currency) {


        var exportHistoricalReportDialog = $("#exportHistoricalReportDialog").data("ejDialog");
        if (exportHistoricalReportDialog) exportHistoricalReportDialog.destroy();

        var url = getUrl("/Home/_ExportHistoricalReport");
        exportHistoricalReportDialog = $("#exportHistoricalReportDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: [],
            contentUrl: url,
            width: "500",
            height: "280",
            title: "Exportar reporte histórico"
        }).data("ejDialog");

        exportHistoricalReportDialog.open();

    } else {

        alert("Seleccione año fiscal, región y centro de costos");
    }

};

function importFile() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var currency = getCurrencyId();

    if (fiscal && company && currency) {

        sessionStorage.setItem("fiscalYearImport", fiscal);
        sessionStorage.setItem("companyImport", company);

        var url = getUrl("/Home/_ImportFile");

        var importFileDialog = $("#importFileDialog").data("ejDialog");

        if (importFileDialog != undefined)
            importFileDialog.destroy();
        
        importFileDialog = $("#importFileDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: [],
            width: 450,
            height: 430

        }).data("ejDialog");

        importFileDialog.option({
            contentUrl: url,
            title: "Importar archivo"
        });
        importFileDialog.open();

    } else {
        alert("Seleccione año fiscal y región");
    }
};

function exportAOP() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var currency = getCurrencyId();

    if (fiscal && company && currency) {
        var url = "/api/Export/AOP/" + fiscal + "/" + company + "/" + currency;
        var popup = window.open(getUrl(url), "_blank");
    } else {
        alert("Seleccione año fiscal y región");
    }
};

function exportSummary() {

    var fiscal = getFiscalYear();
    var company = getCompanyId();
    var costCenter = getCostCenterId();
    var currency = getCurrencyId();

    var url = "/api/Export/Summary/" + fiscal + "/" + company + "/" + costCenter + "/" + currency;

    if (fiscal && company && costCenter) {
        url = getUrl(url);
        var popup = window.open(url, "_blank");
    } else {
        alert("Seleccione año fiscal, región y centro de costos");
    }
};

function editLineButtonClick() {

    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (programmingIsActive == "false") {
        alert("El período de presupuestación no está activo, por lo que no se pueden realizar modificaciones.");
    } else if (selectedSheetAllowsEditing() == "false") {
        alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");
    } else {

        var selected = $("tr[aria-selected='true']").first();

        var isAuthorized = sessionStorage.BudgetIsAuthorized;

        if (isAuthorized == "true") {
            alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
        } else if (selected.length >= 0 && sessionStorage.subLineId != undefined) {
            $(".e-grid").each(function () {
                var gridObj = $(this).data("ejGrid");
                var index = gridObj.getIndexByRow($(selected));
                if (index >= 0) {
                    var expenseType = gridObj.getSelectedRecords()[0].ExpenseType;
                    switch (expenseType) {
                        case 0:
                            gridObj.startEdit(selected);
                            sessionStorage.budgetingAction = "edit";
                            break;
                        case 1:
                            gridObj.startEdit(selected);
                            sessionStorage.budgetingAction = "edit";
                            break;
                        case 2:
                            openEditPremiseLineDialog();
                            break;
                        default: break;
                    }
                }
            });
        } else {
            alert("Seleccione una línea de presupuestación");
        }
    }
};

function saveLineButtonClick() {

    var action = sessionStorage.budgetingAction;

    if (action == "add" || action == "edit") {
        var isAuthorized = sessionStorage.BudgetIsAuthorized;

        if (isAuthorized == "true") {
            alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
        } else if (selectedSheetAllowsEditing() == "false") {

            alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");

        } else {
            $(".e-grid").each(function () { $(this).data("ejGrid").endEdit(); });
                sessionStorage.removeItem("budgetingAction");
        }
    } else {
        alert("Actualmente no se está agregando o editando una línea de presupuestación");
    }
};

function cancelEditLineButtonClick() {
    
    var action = sessionStorage.budgetingAction;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    if (action == "add" || action == "edit") {
        var isAuthorized = sessionStorage.BudgetIsAuthorized;

        if (isAuthorized == "true") {
            alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
        } else if (selectedSheetAllowsEditing() == "false") {

            alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");

        } else {
                sessionStorage.removeItem("budgetingAction");
                // cancelar edición
        }
    } else {
        alert("Actualmente no se está agregando o editando una línea de presupuestación");
    }
};

function deleteLineClick() {

    saveSheetsTabSelectedItemIndex();

    var subLineId = sessionStorage.subLineId;
    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (programmingIsActive == "false") {
        alert("El período de presupuestación no está activo, por lo que no se pueden realizar modificaciones.");
    } else if (selectedSheetAllowsEditing() == "false") {

        alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");

    } else if (subLineId != null && subLineId != 'undefined') {
        var deleteLineDialog = $("#deleteLineDialog").data("ejDialog");
        if (deleteLineDialog) deleteLineDialog.destroy();

        var url = getUrl("/Home/_DeleteLine");
        deleteLineDialog = $("#deleteLineDialog").ejDialog({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            showOnInit: false,
            allowDraggable: true,
            isResponsive: false,
            actionButtons: [],
            contentUrl: url,
            title: "Eliminar línea"
        }).data("ejDialog");

        deleteLineDialog.open();
    }
    else {
        alert('Seleccione una línea de presupuestación');
    }
};

function createBudgetSheet() {

    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (programmingIsActive == "false") {
        alert("El período de presupuestación no está activo, por lo que no se pueden realizar modificaciones.");
    } else {

        var companyId = getCompanyId();
        var fiscalYear = getFiscalYear();
        var costCenterId = getCostCenterId();

        if (companyId && fiscalYear && costCenterId) {

            var budgetDialog = $("#budgetDialog").data("ejDialog");
            if (budgetDialog) budgetDialog.destroy();
            var url = getUrl("/Home/_AddPackage");
            budgetDialog = $("#budgetDialog").ejDialog({
                enableModal: true,
                enableResize: false,
                contentType: "ajax",
                showOnInit: false,
                allowDraggable: true,
                isResponsive: false,
                actionButtons: []
            }).data("ejDialog");
            budgetDialog.option({
                contentUrl: url,
                title: "Agregar paquete"
            });
            budgetDialog.open();

        } else {
            alert('Debe seleccionar región, año fiscal y centro de costo para poder agregar un paquete');
        }
    }
};

function addLine() {

    var lineId = sessionStorage.lineId;
    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    var selected = $("tr[aria-selected='true']").first();
    
    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (programmingIsActive == "false") {
        alert("El período de presupuestación no está activo, por lo que no se pueden realizar modificaciones.");
    } else if (selectedSheetAllowsEditing() == "false") {
    
        alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");

    } else if (selected.length > 0 && lineId != undefined) {

        $(".e-grid").each(function () {

            var gridObj = $(this).data("ejGrid");
            var index = gridObj.getIndexByRow($(selected));

            if (index >= 0) {

                var selectedRecord = gridObj.getSelectedRecords()[0];
                switch (selectedRecord.ExpenseType) {
                    case 0:
                        sessionStorage.budgetingAction = "add";
                        var nextGrid = selected.next("tr").find(".e-grid").data("ejGrid");
                        nextGrid.addRecord();
                        break;
                    case 1:
                        sessionStorage.budgetingAction = "add";
                        var nextGrid = selected.next("tr").find(".e-grid").data("ejGrid");
                        nextGrid.addRecord();
                        break;
                    case 2:
                        var parentLineId = gridObj.getSelectedRecords()[0].Id;
                        openPremiseDialog(parentLineId);
                        break;
                    default:
                        break;
                }
            }
        });
    } else {
        alert("Seleccione una cuenta contable");
    }
};

function openEditPremiseLineDialog() {

    var editPremiseDialog = $("#editPremiseDialog").data("ejDialog");

    if (editPremiseDialog)
        editPremiseDialog.destroy();
    var url = getUrl("/Home/_EditPremiseLine");
    editPremiseDialog = $("#editPremiseDialog").ejDialog({
        enableModal: true,
        enableResize: false,
        contentType: "ajax",
        showOnInit: false,
        allowDraggable: true,
        isResponsive: false,
        actionButtons: [],
        contentUrl: url,
        title: "Presupuestación por premisa",
        width: 700
    }).data("ejDialog");

    editPremiseDialog.open();
};

function openPremiseDialog(parentLineId) {

    var premiseDialog = $("#premiseDialog").data("ejDialog");
    if (premiseDialog) premiseDialog.destroy();
    var url = getUrl("/configuration/_expensedetail?&parentLineId=" + parentLineId + "&company=" + getCompanyId() + "&year=" + getFiscalYear() + "&cost=" + getCostCenterId());
    premiseDialog = $("#premiseDialog").ejDialog({
        enableModal: true,
        enableResize: false,
        contentType: "ajax",
        showOnInit: false,
        allowDraggable: true,
        isResponsive: false,
        width: 550,
        height: 250
    }).data("ejDialog");

    premiseDialog.option({
        contentUrl: url,
        title: "Crear nueva línea por premisa",
    });

    premiseDialog.open();
};

function removeBudgetSheet() {

    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    var programmingIsActive = sessionStorage.ProgrammingIsActive;

    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (programmingIsActive == "false") {
        alert("El período de presupuestación no está activo, por lo que no se pueden realizar modificaciones.");
    } else {

        var count = sheetsTabObj.getItemsCount();
        var selected = sheetsTabObj.model.selectedItemIndex;

        if (count > 1) {
        var sheetId = sessionStorage.sheetId;
            if (!sheetId || selected == 0) {
            alert("Debe seleccionar el paquete que desea eliminar");
        }
            else {
                var urlDeletePackages = getUrl("/api/BudgetSheets/" + sheetId);
            if (confirm("¿Está seguro que desea remover el paquete generado para este centro de costo?")) {
                $.ajax(urlDeletePackages, { type: "DELETE" }).done(function () {
                    var gridId = "#grid_" + sheetId;
                    $(gridId).ejGrid("instance").destroy();
                    var sheets = $("#SheetsTab").ejTab("instance");
                    sheets.removeItem(sheets.selectedItemIndex());

                    if (sheets.getItemsCount() == 1) {
                        getBudgetIsAuthorized();
                    }
                })
                .fail(function (args) {
                    alert("No se pudo remover el paquete. Intente nuevamente.");
                });
            }
            }
        } else {
            alert("Aún no existen paquetes creados para el presupuesto de este centro de costos.");
        }
    }
};

function generateEmployeeLines() {

    var lineId = sessionStorage.lineId;
    var isAuthorized = sessionStorage.BudgetIsAuthorized;
    
    if (isAuthorized == "true") {
        alert("El presupuesto del centro de costo seleccionado ya fue autorizado y no admite modificaciones.");
    } else if (selectedSheetAllowsEditing() == "false") {

        alert("No posee permisos suficientes para poder editar la hoja de " + getSheetDisplayName() + ".");

    } else if (lineId != null && lineId != undefined) {
        var urlApi = getUrl("/api/BudgetLines/IsFreeLine/" + lineId);
        $.get(urlApi).done(function (data) {
            if (data) {
                alert('Las líneas de la cuenta contable seleccionada deben ingresarse manualmente.');
            }
            else {
                var generateLinesDialog = $("#generateLinesConfirmationDialog").data("ejDialog");
                if (generateLinesDialog) generateLinesDialog.destroy();
                generateLinesDialog = $("#generateLinesConfirmationDialog").ejDialog({
                    enableModal: true,
                    contentType: "ajax",
                    showOnInit: false,
                    enableResize: false,
                    allowDraggable: true,
                    isResponsive: false,
                    width: 600,
                    height: 305
                }).data("ejDialog");
                var url = getUrl("/Home/_GenerateLinesConfirmation");
                generateLinesDialog.option({
                    contentUrl: url,
                    title: "Generar líneas"
                });
                generateLinesDialog.open();
            }
        }).fail(function (jXHR, textStatus, errThrown) {
            if (jXHR.status == 401) {
                window.location = getUrl("/Home/Login");
            } else {
                console.log(jXHR);
            }
        });
    }
    else
        alert('Seleccione una cuenta contable.');
};

function getActiveGridId() {

    var id = sessionStorage.sheetId;

    if (sheetsTabObj != undefined && id != undefined) {
        return "#grid_" + id;
    } else {
        return undefined;
    }
};

var sheetsTabObj;

$(function () {

    sheetsTabObj = $('#SheetsTab').ejTab({
        itemActive: tabItemActive,
        itemAdd: tabItemAdd,
        create: tabItemCreate,
        beforeActive: tabItemBeforeActive,
        selectedItemIndex: 0,
        showRoundedCorner: true
    }).data("ejTab");

    var budgetingPermission = findUserPermission("Budgeting");
    var peopleBudgetingPermission = findUserPermission("PeopleBudgeting");

    if (budgetingPermission != null && peopleBudgetingPermission != null) {
        if (!budgetingPermission.Edit && !peopleBudgetingPermission.Edit) {
            toggleAddPackageTabButton(false);
        }
    }

    $(".chkMeses").change(function () {

        var gridId = getActiveGridId();
        if (gridId != undefined) {
        var mes = $(this);
        var checked = this.checked;
        var attr = mes.attr("id");
        var monthId = attr.substring(6, attr.length);
        var monthName = getMonthName(monthId);

        $(".chkColumnas:checked").each(function () {
            var columna = $(this);
            var attr = columna.attr("id");
            var columnName = attr.substring(3, attr.length);
            var fieldName = monthName + "_" + columnName;
            if (checked)
                    showColumn(fieldName, gridId);
            else
                    hideColumn(fieldName, gridId);
        });
        }
    });

    $(".chkColumnas").change(function () {

        var gridId = getActiveGridId();

        if (gridId != undefined) {
            var columna = $(this);
            var checked = this.checked;
            var attr = columna.attr("id");
            var columnName = attr.substring(3, attr.length);

            $(".chkMeses:checked").each(function () {
                var mes = $(this);
                var attr = mes.attr("id");
                var monthId = attr.substring(6, attr.length);
                var monthName = getMonthName(monthId);
                var fieldName = monthName + "_" + columnName;
                if (checked)
                        showColumn(fieldName, gridId);
                else
                        hideColumn(fieldName, gridId);
            });
        }
    });

    $(".chkResumen").change(function () {
        var gridId = getActiveGridId();

        if (gridId != undefined) {
            var checked = this.checked;
            var summaryColumns = [
                "Summary_YearTotal",
                "Summary_PreviousYear",
                "Summary_DifferenceTotal",
                "Summary_DifferencePercentage"
            ];
            for (var i = 0; i < summaryColumns.length; i++) {
                if (checked) {
                    showColumn(summaryColumns[i], gridId);
                } else {
                    hideColumn(summaryColumns[i], gridId);
                }
            }
        }
    });

    $.validator.addMethod("minLength", function (value, element, params) {
        return element.value.length >= params[0] && element.value.length <= params[1];
    }, "La descripción debe contener entre 5 y 100 caracteres.");
});

function getMonthName(monthId) {
    switch (monthId) {
        case "1": return "January";
        case "2": return "February";
        case "3": return "March";
        case "4": return "April";
        case "5": return "May";
        case "6": return "June";
        case "7": return "July";
        case "8": return "August";
        case "9": return "September";
        case "10": return "October";
        case "11": return "November";
        case "12": return "December";
        default: return "";
    }
};

function saveSheetsTabSelectedItemIndex() {
    var sheetIndex = $('#SheetsTab').ejTab('instance').selectedItemIndex();
    var strTabId = $($("#SheetsTab").find("li").get(sheetIndex)).find("a").attr("href");
    sessionStorage.sheetId = strTabId.substr(5, strTabId.length - 5);
};

function clearBudgetSheets() {
    while (sheetsTabObj.getItemsCount() > 1) sheetsTabObj.removeItem(1);
};

function selectedSheetAllowsEditing() {
    var tabId = "#tab_" + sessionStorage.sheetId;
    return $(tabId).attr("allowEditing");
};

function getSheetDisplayName() {
    var sheetId = sessionStorage.sheetId;
    var item = $("a[href='#tab_" + sheetId + "']");
    return item.text();
};

function loadBudgetSheets(selectLastTab) {

    var selectedIndex = sheetsTabObj.option("selectedItemIndex");

    var companyId = getCompanyId(); var fiscalYear = getFiscalYear(); var costCenterId = getCostCenterId();

    if (companyId && fiscalYear && costCenterId) {
        var url = getUrl("/api/BudgetSheets/" + costCenterId + "/" + fiscalYear + "/" + companyId);
        var sheetsDataManager = ej.DataManager({
            url: url,
            adaptor: new ej.WebApiAdaptor()
        });
        ej.WaitingPopup.showDefault();
        sheetsDataManager.executeQuery(ej.Query()).done(function (data) {

            clearBudgetSheets();

            for (var i = 0; i < data.result.length; i++) {

                var id = "#tab_" + data.result[i].Id
                sheetsTabObj.addItem(id, data.result[i].Package.Name);
                var tabItem = $(id);
                tabItem.attr("AllowEditing", data.result[i].AllowEditing);
            }

            if (selectLastTab) {
                sheetsTabObj.option("selectedItemIndex", sheetsTabObj.getItemsCount() - 1);
            }
            
            if (selectedIndex >= 0 && sheetsTabObj.getItemsCount() - 1 >= selectedIndex) {
                sheetsTabObj.option("selectedItemIndex", selectedIndex);
            }
        }).fail(function (jqXHR, textStatus, errThrown) {

            console.log(jqXHR);
            alert("Ocurrió un error al intentar cargar las hojas del presupuesto");

        }).always(function () {
            ej.WaitingPopup.hideDefault();
        });
    }
};

function tabItemActive(args) {

    sessionStorage.removeItem("lineId");
    sessionStorage.removeItem("subLineId");

    var strTabId = $(args.activeHeader).children("a").attr("href");
    var sheetId = strTabId.substr(5, strTabId.length - 5);

    if (sheetId != '0') {
        loadGrid(sheetId);
        saveSheetsTabSelectedItemIndex();
    }
    else {
        $(args.activeHeader).children("a").unbind("click");
        $(args.activeHeader).children("a").click(createBudgetSheet);
    }
};

function tabItemAdd(args) {
    var strTabId = $(args.activeHeader).children("a").attr("href");
};

function tabItemCreate(args) {
    var strTabId = $(args.activeHeader).children("a").attr("href");
};

function tabItemBeforeActive(args) {
    var strTabId = $(args.activeHeader).children("a").attr("href");
    if (strTabId == "#tab_0") {
        var tabs = $("#SheetsTab").ejTab("instance");
        tabs.option("selectedItemIndex", args.prevActiveIndex);
    }
};

function unselectAllRows() {

    sessionStorage.removeItem('lineId');
    sessionStorage.removeItem('subLineId');

    $('.e-grid').each(function () {
        $(this).ejGrid('instance').clearSelection();
    });
};

function loadGrid(sheetId) {

    var tabId = "#tab_" + sheetId;
    var gridId = "#grid_" + sheetId;

    var length = $(gridId).length;

    if (length == 0) {

        var html = $("<div>").attr("id", gridId.replace("#", ""));
        $(tabId).html(html);
        $(tabId).css("padding", "0px");

        var currency = getCurrencyId();
        if (currency) {

            var url = "/api/BudgetLines?sheetId=" + sheetId + "&costCenterId=" + getCostCenterId() + "&toCurrencyId=" + currency;

            var dataManager = ej.DataManager({
                url: getUrl(url),
                adaptor: new ej.WebApiAdaptor()
            });

            ej.WaitingPopup.showDefault();
            dataManager.executeQuery(ej.Query()).done(function (data) {

                var dataModel = data.result;

                subChildGrid = {
                    dataSource: dataModel.SubChildrenLines,
                    queryString: "LevelTwoId",
                    allowPaging: false,
                    columns: columns,
                    showStackedHeader: true,
                    stackedHeaderRows: stackedHeader,
                    allowSelection: true,
                    rowSelecting: unselectAllRows,
                    rowSelected: function (args) {
                        sessionStorage.subLineId = args.data.Id;
                        var generateButton = $("#defaultRibbon_generate");
                        if(generateButton.length){
                            generateButton.data("ejButton").disable();
                        }
                        
                    },
                    allowScrolling: false,
                    commonWidth: 60,
                    editSettings: { allowEditOnDblClick: false, allowEditing: true, allowAdding: true, allowDeleting: false },
                    recordDoubleClick: subChildGridRecordDoubleClick,
                    actionBegin: subChildGridActionBegin,
                    actionComplete: subChildGridActionComplete,
                    actionFailure: subChildGridActionFailure
                };

                principalChild = {
                    dataSource: dataModel.ChildrenLines,
                    queryString: "LevelOneId",
                    allowPaging: false,
                    columns: columns,
                    showStackedHeader: true,
                    stackedHeaderRows: stackedHeader,
                    allowSelection: true,
                    allowScrolling: false,
                    commonWidth: 60,
                    rowSelecting: unselectAllRows,
                    rowSelected: principalChildRowSelected,
                    childGrid: subChildGrid
                };

                $(gridId).ejGrid({
                    dataSource: dataModel.ParentLines,
                    childGrid: principalChild,
                    allowPaging: false,
                    columns: columns,
                    showStackedHeader: true,
                    stackedHeaderRows: stackedHeader,
                    allowSelection: false,
                    commonWidth: 60,
                    allowScrolling: true,
                    isResponsive: false,
                    rowSelected: function (args) {
                        $("#defaultRibbon_generate").data("ejButton").disable();
                    }
                });

                $(".chkMeses:unchecked").each(function () {

                    var mes = $(this);
                    var attr = mes.attr("id");
                    var monthId = attr.substring(6, attr.length);
                    var monthName = getMonthName(monthId);

                    $(".chkColumnas").each(function () {
                        var columna = $(this);
                        var attr = columna.attr("id");
                        var columnName = attr.substring(3, attr.length);
                        var fieldName = monthName + "_" + columnName;
                        hideColumn(fieldName, gridId);
                    });
                });

                $(".chkColumnas:unchecked").each(function () {
                    var columna = $(this);
                    var attr = columna.attr("id");
                    var columnName = attr.substring(3, attr.length);

                    $(".chkMeses").each(function () {
                        var mes = $(this);
                        var attr = mes.attr("id");
                        var monthId = attr.substring(6, attr.length);
                        var monthName = getMonthName(monthId);
                        var fieldName = monthName + "_" + columnName;
                        hideColumn(fieldName, gridId);
                    });
                });
            }).always(function () {
                ej.WaitingPopup.hideDefault();
            });
        } else {
            alert("Seleccione una Moneda en la pestaña VISTA");
        }
    }
};

function principalChildRowSelected(args) {

    if (args.prevRow)
        args.prevRow.removeClass("CurrentRow");

    if (!args.row.hasClass("e-detailrowvisible"))
        args.row.closest(".e-grid").ejGrid("instance").expandCollapse(args.row.first());

    args.row.addClass("CurrentRow");
    sessionStorage.lineId = args.data.Id;
    sessionStorage.lineDescription = args.data.Description;

    var isTracked = sessionStorage.IsTracked;

    var button = $("#defaultRibbon_generate").data("ejButton");

    if (args.data.ExpenseType == 1 && isTracked == "false") {
        button.enable();
    } else {
        button.disable();
    }

};

function subChildGridRecordDoubleClick(args) {
    var lineId = args.data.Id;
};

function subChildGridActionBegin(args) {

    switch (args.requestType) {
        case "add":
            sessionStorage.requestType = args.requestType;
            break;
        case "beginedit":
            sessionStorage.requestType = args.requestType;
            break;
        case "save":
            editingContext.newData = args.data;
            editingContext.originalModel = args.model;
            editingContext.originalDataSource = args.model.dataSource;
            subChildGridSave(args);
            break;
        default:
            break;
    }
};

function subChildGridActionComplete(args) {
    editingContext.newModel = args.model;
    editingContext.newDataSource = args.model.dataSource;
    editingContext.currentGrid = args.target;
}

function subChildGridActionFailure(args) {

}

function ribbonMenuClick(args) {

    switch (args.text) {
        case "Salir":
            sessionStorage.clear();
            ej.WaitingPopup.showDefault();            
            window.location = getUrl("/");
            break;
        case "AOP":
            exportAOP();
            break;
        case "Consolidado":
            exportConsolidatedBudget();
            break;
        case "Histórico":
            exportHistoricalReport();
            break;
        case "Importar":
            importFile();
            break;
    }
};

function subChildGridSave(args) {

    args.data.PremiseId = args.model.parentDetails.parentRowData.PremiseId;
    args.data.AccountId = args.model.parentDetails.parentRowData.AccountId;
    args.data.ExpenseType = args.model.parentDetails.parentRowData.ExpenseType;

    args.data.January_Target = args.data.January_Quantity * args.data.January_UnitCost;
    args.data.February_Target = args.data.February_Quantity * args.data.February_UnitCost;
    args.data.March_Target = args.data.March_Quantity * args.data.March_UnitCost;
    args.data.April_Target = args.data.April_Quantity * args.data.April_UnitCost;
    args.data.May_Target = args.data.May_Quantity * args.data.May_UnitCost;
    args.data.June_Target = args.data.June_Quantity * args.data.June_UnitCost;
    args.data.July_Target = args.data.July_Quantity * args.data.July_UnitCost;
    args.data.August_Target = args.data.August_Quantity * args.data.August_UnitCost;
    args.data.September_Target = args.data.September_Quantity * args.data.September_UnitCost;
    args.data.October_Target = args.data.October_Quantity * args.data.October_UnitCost;
    args.data.November_Target = args.data.November_Quantity * args.data.November_UnitCost;
    args.data.December_Target = args.data.December_Quantity * args.data.December_UnitCost;
    args.data.Summary_YearTotal = args.data.January_Target + args.data.February_Target + args.data.March_Target + args.data.April_Target
                            + args.data.May_Target + args.data.June_Target + args.data.July_Target + args.data.August_Target
                            + args.data.September_Target + args.data.October_Target + args.data.November_Target + args.data.December_Target;

    var dataItem = args.data;

    var model = {

        Id: dataItem.Id,
        ParentId: args.model.parentDetails.parentRowData.Id,
        LevelOneId: 0,
        LevelTwoId: args.model.parentDetails.parentRowData.Id,
        AccountId: args.model.parentDetails.parentRowData.AccountId,
        Description: dataItem.Description,
        ExpenseType: args.model.parentDetails.parentRowData.ExpenseType,

        January_Quantity: dataItem.January_Quantity,
        January_UnitCost: dataItem.January_UnitCost,
        January_Target: dataItem.January_Target,
        January_Forecast: dataItem.January_Forecast,
        January_Real: dataItem.January_Real,

        February_Quantity: dataItem.February_Quantity,
        February_UnitCost: dataItem.February_UnitCost,
        February_Target: dataItem.February_Target,
        February_Forecast: dataItem.February_Forecast,
        February_Real: dataItem.February_Real,

        March_Quantity: dataItem.March_Quantity,
        March_UnitCost: dataItem.March_UnitCost,
        March_Target: dataItem.March_Target,
        March_Forecast: dataItem.March_Forecast,
        March_Real: dataItem.March_Real,

        April_Quantity: dataItem.April_Quantity,
        April_UnitCost: dataItem.April_UnitCost,
        April_Target: dataItem.April_Target,
        April_Forecast: dataItem.April_Forecast,
        April_Real: dataItem.April_Real,

        May_Quantity: dataItem.May_Quantity,
        May_UnitCost: dataItem.May_UnitCost,
        May_Target: dataItem.May_Target,
        May_Forecast: dataItem.May_Forecast,
        May_Real: dataItem.May_Real,

        June_Quantity: dataItem.June_Quantity,
        June_UnitCost: dataItem.June_UnitCost,
        June_Target: dataItem.June_Target,
        June_Forecast: dataItem.June_Forecast,
        June_Real: dataItem.June_Real,

        July_Quantity: dataItem.July_Quantity,
        July_UnitCost: dataItem.July_UnitCost,
        July_Target: dataItem.July_Target,
        July_Forecast: dataItem.July_Forecast,
        July_Real: dataItem.July_Real,

        August_Quantity: dataItem.August_Quantity,
        August_UnitCost: dataItem.August_UnitCost,
        August_Target: dataItem.August_Target,
        August_Forecast: dataItem.August_Forecast,
        August_Real: dataItem.August_Real,

        September_Quantity: dataItem.September_Quantity,
        September_UnitCost: dataItem.September_UnitCost,
        September_Target: dataItem.September_Target,
        September_Forecast: dataItem.September_Forecast,
        September_Real: dataItem.September_Real,

        October_Quantity: dataItem.October_Quantity,
        October_UnitCost: dataItem.October_UnitCost,
        October_Target: dataItem.October_Target,
        October_Forecast: dataItem.October_Forecast,
        October_Real: dataItem.October_Real,

        November_Quantity: dataItem.November_Quantity,
        November_UnitCost: dataItem.November_UnitCost,
        November_Target: dataItem.November_Target,
        November_Forecast: dataItem.November_Forecast,
        November_Real: dataItem.November_Real,

        December_Quantity: dataItem.December_Quantity,
        December_UnitCost: dataItem.December_UnitCost,
        December_Target: dataItem.December_Target,
        December_Forecast: dataItem.December_Forecast,
        December_Real: dataItem.December_Real
    };

    var reqType = sessionStorage.requestType;

    ej.WaitingPopup.showDefault();

    if (reqType == "add") {

        var urlPost = getUrl("/api/BudgetLines/PostLine");
        $.post(urlPost, model)
        .done(function (data) {

            /*HERE*/
            editingContext.computedData = data;
            var newDataItem = editingContext.newModel.dataSource.shift();
            for (var prop in data[0]) {                
                if (newDataItem[prop]) {
                    newDataItem[prop] = data[0][prop];
                }
            }
            editingContext.newModel.dataSource.push(newDataItem);

            var parentDataItem = editingContext.newModel.parentDetails.parentRowData;
            for (var prop in data[1]) {
                if (parentDataItem[prop]) {
                    parentDataItem[prop] = data[1][prop];
                }
            }

            var childGrid = $("#" + editingContext.currentGrid.id).data("ejGrid");
            childGrid.dataSource(editingContext.newModel.dataSource);            

            var parentGrid = $("#" + editingContext.newModel.parentDetails.parentID).data("ejGrid");
            parentGrid.updateRecord("Id", data[1]);

            var granfatherGrid = $("#" + editingContext.newModel.parentDetails.parentID).parent().closest(".e-grid").data("ejGrid");
            granfatherGrid.updateRecord("Id", data[2]);

        }).fail(function (xhr, textStatus, errorThrown) {
            console.log(xhr.responseText);
        }).always(function () {
            ej.WaitingPopup.hideDefault();
        });

    } else if (reqType == "beginedit") {

        var urlPut = getUrl("/api/BudgetLines/PutLine");
        $.ajax({
            method: "PUT",
            url: urlPut,
            data: model
        }).done(function (data) {

            


        }).fail(function (jHXR, textStatus, err) {
            console.log(jHXR.responseText);
        }).always(function () {
            ej.WaitingPopup.hideDefault();
        });

    }
};

function updateGridValues(data) {

    var gridId = "#grid_" + sessionStorage.sheetId;
    var gridObj = $(gridId).data("ejGrid");
};

var stackedHeader =
[
    {
        stackedHeaderColumns:
        [
            { headerText: "Enero", column: "January_Quantity,January_UnitCost,January_Target,January_Real,January_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Febrero", column: "February_Quantity,February_UnitCost,February_Target,February_Real,February_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Marzo", column: "March_Quantity,March_UnitCost,March_Target,March_Real,March_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Abril", column: "April_Quantity,April_UnitCost,April_Target,April_Real,April_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Mayo", column: "May_Quantity,May_UnitCost,May_Target,May_Real,May_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Junio", column: "June_Quantity,June_UnitCost,June_Target,June_Real,June_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Julio", column: "July_Quantity,July_UnitCost,July_Target,July_Real,July_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Agosto", column: "August_Quantity,August_UnitCost,August_Target,August_Real,August_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Septiembre", column: "September_Quantity,September_UnitCost,September_Target,September_Real,September_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Octubre", column: "October_Quantity,October_UnitCost,October_Target,October_Real,October_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Noviembre", column: "November_Quantity,November_UnitCost,November_Target,November_Real,November_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Diciembre", column: "December_Quantity,December_UnitCost,December_Target,December_Real,December_Forecast", textAlign: ej.TextAlign.Center }
            , { headerText: "Resumen", column: "Summary_YearTotal,Summary_PreviousYear,Summary_DifferenceTotal,Summary_DifferencePercentage", textAlign: ej.TextAlign.Center }
        ]
    }
];

var columns = [
    { cssClass: "RowHeader", field: "Id", customAttributes: { "data-month": "" }, headerText: "Id", visible: false, isPrimaryKey: true },
    { cssClass: "RowHeader", field: "AccountId", customAttributes: { "data-month": "" }, headerText: "AccountId", visible: false },
    { cssClass: "RowHeader", field: "ParentId", customAttributes: { "data-month": "" }, headerText: "ParentId", visible: false },
    { cssClass: "RowHeader", field: "PremiseId", customAttributes: { "data-month": "" }, headerText: "PremiseId", visible: false },
    { cssClass: "RowHeader Description", field: "Description", customAttributes: { "data-month": "Description" }, headerText: "Descripción", width: 300, validationRules: { required: true } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Enero" }, field: "January_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Enero" }, field: "January_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Enero" }, field: "January_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Enero" }, field: "January_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Enero" }, field: "January_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Febrero" }, field: "February_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Febrero" }, field: "February_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Febrero" }, field: "February_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Febrero" }, field: "February_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Febrero" }, field: "February_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Marzo" }, field: "March_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Marzo" }, field: "March_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Marzo" }, field: "March_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Marzo" }, field: "March_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Marzo" }, field: "March_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Abril" }, field: "April_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Abril" }, field: "April_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Abril" }, field: "April_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Abril" }, field: "April_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Abril" }, field: "April_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Mayo" }, field: "May_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Mayo" }, field: "May_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Mayo" }, field: "May_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Mayo" }, field: "May_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Mayo" }, field: "May_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Junio" }, field: "June_Quantity", headerText: "Cantidad",  textAlign: ej.TextAlign.Center, validationRules: { number: true } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Junio" }, field: "June_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Junio" }, field: "June_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Junio" }, field: "June_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Junio" }, field: "June_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Julio" }, field: "July_Quantity", headerText: "Cantidad",  textAlign: ej.TextAlign.Center, validationRules: { number: true } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Julio" }, field: "July_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Julio" }, field: "July_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Julio" }, field: "July_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Julio" }, field: "July_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Agosto" }, field: "August_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Agosto" }, field: "August_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Agosto" }, field: "August_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Agosto" }, field: "August_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Agosto" }, field: "August_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Septiembre" }, field: "September_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Septiembre" }, field: "September_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Septiembre" }, field: "September_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Septiembre" }, field: "September_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Septiembre" }, field: "September_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Octubre" }, field: "October_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Octubre" }, field: "October_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Octubre" }, field: "October_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Octubre" }, field: "October_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Octubre" }, field: "October_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Noviembre" }, field: "November_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Noviembre" }, field: "November_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Noviembre" }, field: "November_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Noviembre" }, field: "November_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Noviembre" }, field: "November_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Diciembre" }, field: "December_Quantity", headerText: "Cantidad", textAlign: ej.TextAlign.Center, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 0, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Diciembre" }, field: "December_UnitCost", headerText: "C. U.", format: "{0:n2}", textAlign: ej.TextAlign.Right, validationRules: { number: true }, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Diciembre" }, field: "December_Target", headerText: "Meta", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Diciembre" }, field: "December_Real", headerText: "Real", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "Diciembre" }, field: "December_Forecast", headerText: "Forecast", format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false, editType: ej.Grid.EditingType.Numeric, editParams: { decimalPlaces: 2, showSpinButton: false } },

    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "" }, field: "Summary_YearTotal", headerText: 'Presente', format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "" }, field: "Summary_PreviousYear", headerText: 'Anterior', format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "" }, field: "Summary_DifferenceTotal", headerText: 'Dif', format: "{0:n2}", textAlign: ej.TextAlign.Right, allowEditing: false },
    { cssClass: "Value", defaultValue: "0", customAttributes: { "data-month": "" }, field: "Summary_DifferencePercentage", headerText: 'Dif %', format: "{0:P}", textAlign: ej.TextAlign.Right, allowEditing: false }
];

function reloadIncrease() {

};

//botones de pestaña análisis
function CostCenterFilterAnalysis() {
    
    var url = getUrl("/Reporting/FilteredCostCenterView");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Filtro de centros de costo",
        width: 700,
        height: 500
    });
    dialog.open();
};

function AccountFilterAnalysis() {

    var url = getUrl("/Reporting/FilteredAccountView");
    clearDialogContent(url);

    dialog.option({
        contentUrl: url,
        title: "Filtro de cuentas contables",
        width: 700,
        height: 500
    });
    dialog.open();
    
};

