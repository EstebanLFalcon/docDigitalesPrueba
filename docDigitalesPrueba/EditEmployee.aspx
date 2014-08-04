<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="EditEmployee.aspx.cs" Inherits="docDigitalesPrueba.EditEmployee" %>
<asp:Content ID="ContentEditEmployeeHead" ContentPlaceHolderID="head" runat="server">
                    <script>
                        var selectedSucursal;
                        $(document).ready(function () {
                            if (window.location.search.split('?').length > 1) {
                                var params = window.location.search.split('?')[1].split('&');
                                var RFCEmpleado = decodeURIComponent(params[0].split('=')[1]);
                                $.ajax({
                                    type: "POST",
                                    url: "EditEmployee.aspx/GetEmpleado",
                                    data: "{rfc: '" + RFCEmpleado + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: OnSuccess,
                                    failure: function (response) {
                                        alert(response.d);
                                    }
                                });
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
                            }

                        });
                        function RetrievedNames(response) {
                            var nombreSucursales = response.d;
                            nombreSucursales = nombreSucursales.split("^");
                            nombreSucursales.forEach(function (campo) {
                                if (campo == "No se encontraron sucursales")
                                    $("#btnSubmit").attr("disabled", "");
                                $("#selectboxSucursales").append("<option val='"+campo+"'>" + campo + "</option>");

                            });
                            $("#selectboxSucursales").val(selectedSucursal)
                            //$("#selectboxSucursales").filter(function () { return $(this).text() == "sucursal de prueba"; }).prop('selected', true);
                        }
                        function OnSuccess(response) {
                            if (response.d != "No se encontro empleado.") {  
                                var valoresEmpleado = response.d;
                                valoresEmpleado = valoresEmpleado.split("^");
                                $("#txtboxNombreEmpleado").val(valoresEmpleado[0]);
                                $("#txtboxRFC").val(valoresEmpleado[1]);
                                $("#txtboxRFC").attr("disabled", "");
                                $("#txtboxPuesto").val(valoresEmpleado[2]);
                                $("#selectboxSucursales").val(valoresEmpleado[3]);
                                selectedSucursal = valoresEmpleado[3];
                            } else {
                                alert(response.d);
                            }
                        }
                        function submitEmployee() {
                            $("selectboxSucursales").prop("selectedIndex", 3);
                            var emptyTextBoxes = $('input.required:text').filter(function () { return this.value == ""; });
                            emptyTextBoxes.each(function () {
                                $(this).css("border-color", "red");
                            });
                            if (emptyTextBoxes.length == 0) {
                                $.ajax({
                                    type: "POST",
                                    url: "EditEmployee.aspx/UpdateEmployee",
                                    data: "{nombre_empleado:'" + $("#txtboxNombreEmpleado").val() + "',rfc:'" + $("#txtboxRFC").val() + "',puesto:'" + $("#txtboxPuesto").val() + "',nombre_sucursal:'" + $("#selectboxSucursales option:selected").text() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: OnSuccessSubmit,
                                    failure: function (response) {
                                        alert(response.d);
                                    }
                                });
                            } else {
                                alert("Porfavor ingrese los campos requeridos marcados en rojo.");
                            }
                        }
                        function OnSuccessSubmit(response) {
                            if (response.d == "Success") {
                                alert("Registro exitoso.");
                                window.location.href = "Home.aspx";
                            } else {
                                alert(response.d);
                            }
                        }
                       </script>
</asp:Content>
<asp:Content ID="ContentEditEmployeeBody" ContentPlaceHolderID="contentBody" runat="server">
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
