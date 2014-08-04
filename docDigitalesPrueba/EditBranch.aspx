<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="EditBranch.aspx.cs" Inherits="docDigitalesPrueba.EditBranch" %>
<asp:Content ID="ContentEditBranchHead" ContentPlaceHolderID="head" runat="server">
            <script>
                var nombreAnterior;
                $(document).ready(function () {
                    if (window.location.search.split('?').length > 1) {
                        var params = window.location.search.split('?')[1].split('&');
                        var nombreSucursal = decodeURIComponent(params[0].split('=')[1]);
                        nombreSucursal = nombreSucursal.replace("Editar", "");
                        nombreAnterior = nombreSucursal;
                        $.ajax({
                            type: "POST",
                            url: "EditBranch.aspx/GetSucursal",
                            data: "{nombre_sucursal: '" + nombreSucursal + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccess,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                        $.ajax({
                            type: "POST",
                            url: "EditBranch.aspx/GetEmpleadosSucursal",
                            data: "{nombre_sucursal: '" + nombreSucursal + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccessEmpleados,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    }
                });
                function OnSuccessEmpleados(response) {
                    var valorEmpleados = response.d;
                    valorEmpleados = valorEmpleados.split("^");
                    $("#tablaEmpleados").find('tbody').append($('<tr>'));
                    valorEmpleados.forEach(function (campo) {
                        if (campo == "*") {
                            $("#tablaEmpleados").find('tr:last')
                            .append($('<th>').append($('<button class="edit">Editar</button>')));
                            $("#tablaEmpleados tbody").append($('<tr>'));
                        } else if (campo != "") {
                            $("#tablaEmpleados").find('tr:last')
                                .append($('<th>').text(campo));
                        }
                    });
                    $(".edit").bind("click", editarEmpleado);
                }
                function editarEmpleado() {
                    var par = $(this).parent().parent(); //tr
                    var RFCEmpleado = par.find(':nth-child(2)').text();
                    var url = "EditEmployee.aspx?Empleado=" + encodeURIComponent(RFCEmpleado);
                    window.location.href = url;
                }
                function OnSuccess(response) {
                    if (response.d != "No se encontro sucursal.") {
                        var valoresSucursal = response.d;
                        valoresSucursal = valoresSucursal.split("^");
                        $("#txtboxNombreSucursal").val(valoresSucursal[0]);
                        $("#txtboxCalle").val(valoresSucursal[1]);
                        $("#txtboxColonia").val(valoresSucursal[2]);
                        $("#txtboxNumExt").val(valoresSucursal[3]);
                        $("#txtboxNumInt").val(valoresSucursal[4]);
                        $("#txtboxCP").val(valoresSucursal[5]);
                        $("#txtboxCiudad").val(valoresSucursal[6]);
                        $("#txtboxPais").val(valoresSucursal[7]);
                    } else {
                        alert(response.d);
                    }
                }
                function updateBranch() {
                    var countWrongNumeric = 0;
                    var intRegex = new RegExp(/[0-9]+([ ]+)?$/);
                    var emptyTextBoxes = $('input.required:text').filter(function () { return this.value == ""; });
                    emptyTextBoxes.each(function () {
                        $(this).css("border-color", "red");
                    });
                    var numericTextBoxes = $("input[name='numeric']");
                    numericTextBoxes.each(function () {
                        if (!$(this).val().match(intRegex)) {
                            countWrongNumeric++;
                            $(this).css("border-color", "red");
                        }
                        else {
                            if (countWrongNumeric > 0)
                                countWrongNumeric--;
                            $(this).css("border-color", "");
                        }
                    });
                    if (emptyTextBoxes.length == 0 && countWrongNumeric == 0) {
                        $.ajax({
                            type: "POST",
                            url: "EditBranch.aspx/UpdateBranch",
                            data: "{nombre_sucursal:'" + $("#txtboxNombreSucursal").val() + "',calle:'" + $("#txtboxCalle").val() + "',colonia:'" + $("#txtboxColonia").val() + "',numero_ext:'" + $("#txtboxNumExt").val() + "',numero_int:'" + $("#txtboxNumInt").val() + "',cp:'" + $("#txtboxCP").val() + "',ciudad:'" + $("#txtboxCiudad").val() + "',pais:'" + $("#txtboxPais").val() + "',nombreAnterior:'"+nombreAnterior+"'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccessUpdate,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    } else {
                        alert("Porfavor ingrese los campos requeridos marcados en rojo.");
                        //$("#txtboxPais").after("<p>Porfavor ingrese todos los valores requeridos.</p>");
                    }
                }
                function OnSuccessUpdate(response) {
                    if (response.d == "Success") {
                        alert("Registro exitoso.");
                        window.location.href = "Home.aspx";
                    } else {
                        alert(response.d);
                    }
                }
               </script>
</asp:Content>
<asp:Content ID="ContentEditBranchBody" ContentPlaceHolderID="contentBody" runat="server">
    <table id="tablaEmpleados">
        <thead>
        <tr>
            <th>Nombre del Empleado</th>
            <th>RFC</th>
            <th>Puesto</th>
        </tr>
            </thead>
        <tbody>
        </tbody>
    </table>
    <br />
     <label>Nombre de la sucursal:</label>
    <input id="txtboxNombreSucursal" type="text" class="required"/>
    <br />
    <label>Calle:</label>
    <input id="txtboxCalle" type="text" />
    <br />
    <label>Colonia:</label>
    <input id="txtboxColonia" type="text" />
    <br />
    <label>Numero Exterior</label>
    <input id="txtboxNumExt" type="text" name="numeric" />
    <br />
    <label>Numero Interior:</label>
    <input id="txtboxNumInt" type="text" name="numeric"/>
    <br />
    <label>Codigo Postal:</label>
    <input id="txtboxCP" type="text" name="numeric" />
    <br />
    <label>Ciudad:</label>
    <input id="txtboxCiudad" type="text"  />
    <br />
    <label>Pais:</label>
    <input id="txtboxPais" type="text" />
    <br />
    <button id="btnSubmit" onclick="updateBranch()">Submit</button>
    <a href="Home.aspx">Regresar</a>
</asp:Content>
