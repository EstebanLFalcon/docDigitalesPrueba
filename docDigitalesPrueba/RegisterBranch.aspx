<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="RegisterBranch.aspx.cs" Inherits="docDigitalesPrueba.RegisterBranch" %>
<asp:Content ID="ContentBranchHead" ContentPlaceHolderID="head" runat="server">
            <script>
                function submitBranch() {
                    var countWrongNumeric = 0;
                    var intRegex = new RegExp(/[0-9]+$/);
                    var emptyTextBoxes = $('input.required:text').filter(function () { return this.value == ""; });
                    emptyTextBoxes.each(function () {
                        $(this).css("border-color", "red");
                    });
                    var numericTextBoxes = $("input[name='numeric']");
                    numericTextBoxes.each(function () {
                        if($(this).val() != "")
                        if (!$(this).val().match(intRegex)){
                            countWrongNumeric++;
                            $(this).css("border-color", "red");
                            $(this).after("<p>Este campo debe ser numerico.</p>");
                        }
                        else {
                            if (countWrongNumeric > 0)
                                countWrongNumeric--;
                            $(this).css("border-color", "");
                            $(this).next().remove();
                        }
                    });
                    if (emptyTextBoxes.length == 0 && countWrongNumeric == 0) {
                        $.ajax({
                            type: "POST",
                            url: "RegisterBranch.aspx/InsertBranch",
                            data: "{nombre_sucursal:'" + $("#txtboxNombreSucursal").val() + "',calle:'" + $("#txtboxCalle").val() + "',colonia:'" + $("#txtboxColonia").val() + "',numero_ext:'" + $("#txtboxNumExt").val() + "',numero_int:'" + $("#txtboxNumInt").val() + "',cp:'" + $("#txtboxCP").val() + "',ciudad:'" + $("#txtboxCiudad").val() + "',pais:'" + $("#txtboxPais").val() + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccess,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    } else {
                        alert("Porfavor ingrese todos los campos requeridos marcados en rojo.");
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
<asp:Content ID="ContentBranchBody" ContentPlaceHolderID="contentBody" runat="server">
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
    <button id="btnSubmit" onclick="submitBranch()">Submit</button>
    <a href="Home.aspx">Regresar</a>
</asp:Content>
