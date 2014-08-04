<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="RegisterEmployee.aspx.cs" Inherits="docDigitalesPrueba.RegisterEmployee" %>
<asp:Content ID="ContentEmployeeHead" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "RegisterEmployee.aspx/GetNombreSucursales",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: RetrievedNames,
                failure: function (response) {
                    alert(response.d);
                }
            });
        });
        function RetrievedNames(response) {
                var nombreSucursales = response.d;
                nombreSucursales = nombreSucursales.split("^");
                nombreSucursales.forEach(function (campo) {
                    if (campo == "No se encontraron sucursales")
                        $("#btnSubmit").attr("disabled", "");
                    $("#selectboxSucursales").append("<option value =" + campo + ">" + campo + "</option>");
                });

                //window.location.href = "Home.aspx";

        }
        function submitEmployee() {
            var emptyTextBoxes = $('input.required:text').filter(function () { return this.value == ""; });
            emptyTextBoxes.each(function () {
                $(this).css("border-color", "red");
            });
            if (emptyTextBoxes.length == 0) {
                $.ajax({
                    type: "POST",
                    url: "RegisterEmployee.aspx/InsertEmployee",
                    data: "{nombre_empleado:'" + $("#txtboxNombreEmpleado").val() + "',rfc:'" + $("#txtboxRFC").val() + "',puesto:'" + $("#txtboxPuesto").val() + "',nombre_sucursal:'" + $("#selectboxSucursales option:selected" ).text() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            } else {
                alert("Porfavor ingrese los campos requeridos marcados en rojo.");
            }
        }
        function OnSuccess(response) {
            if (response.d == "Success") {
                alert("Registro exitoso.");
                window.location.href = "Home.aspx";
            } else {
                alert(response.d);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="ContentEmployeeBody" ContentPlaceHolderID="contentBody" runat="server">
    <label>Sucursal</label>
    <select id="selectboxSucursales">
    </select>
    <br />
    <label>Nombre</label>
    <input type="text" id="txtboxNombreEmpleado" class="required"/>
    <br />
    <label>RFC</label>
    <input type="text" id="txtboxRFC" class="required"/>
    <br />
    <label>Puesto</label>
    <input type="text" id="txtboxPuesto" />
    <br />
    <button id="btnSubmit" onclick="submitEmployee()">Submit</button>
    <a href="Home.aspx">Regresar</a>
</asp:Content>
