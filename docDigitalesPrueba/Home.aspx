<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="docDigitalesPrueba.Home" %>
<asp:Content ID="ContentHomeHead" ContentPlaceHolderID="head" runat="server">
        <script>
            $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Home.aspx/SelectSucursales",
                        //data: "{estado: 'P'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                });

                function OnSuccess(response) {
                    var sucursales = response.d;
                    sucursales = sucursales.split("^");
                    $("#tablaSucursales").find('tbody').append($('<tr>'));
                    sucursales.forEach(function (campo) {
                        if (campo == "*") {
                            $("#tablaSucursales").find('tr:last')
                            .append($('<th>').append($('<button class="edit">Editar</button>')));
                            $("#tablaSucursales tbody").append($('<tr>'));
                        } else if (campo != "") {
                            $("#tablaSucursales").find('tr:last')
                                .append($('<th>').text(campo));
                        }
                    });
                    $(".edit").bind("click", editarSucursal);
                }
                function editarSucursal() {
                    var par = $(this).parent().parent(); //tr
                    var nombreSucursal = par.find(':nth-child(1)').text();
                    var url = "EditBranch.aspx?branch=" + encodeURIComponent(nombreSucursal);
                    window.location.href = url;
                }

        </script>
</asp:Content>
<asp:Content ID="ContentHomeBody" ContentPlaceHolderID="contentBody" runat="server">
        <table id="tablaSucursales">
        <thead>
        <tr>
            <th>Nombre Sucursal</th>
            <th>Numero de Empleados</th>
        </tr>
            </thead>
        <tbody>
        </tbody>
    </table>
    <br />
    <a href="RegisterBranch.aspx">Registrar Sucursal</a>
    <a href="RegisterEmployee.aspx">Registrar Empleado</a>
</asp:Content>
