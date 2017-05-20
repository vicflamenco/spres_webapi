<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="SpresDev.Views.Reporting.Report" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>


<!DOCTYPE html>
<html>
<head>
    <title>        
    </title>
    <style>
        html, body{
            width:100%;
            height:100%;            
            margin:0;
        }

        #Viewer {
            width: 100%;
            height: 100%;
            display: table !important;
        }
        #frmReport {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <form runat="server" id="frmReport">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="Viewer" runat="server" ProcessingMode="Remote" Width="100%" Height="100%" ShowParameterPrompts="false">
        </rsweb:ReportViewer>
    </form>

</body>
</html>


