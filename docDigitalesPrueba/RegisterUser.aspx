<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="RegisterUser.aspx.cs" Inherits="docDigitalesPrueba.RegisterUser" %>
<asp:Content ID="ContentRegisterUserHead" ContentPlaceHolderID="head" runat="server">
        <script>
            function validateSubmit() {
                var emptyTextBoxes = $('input.required').filter(function () { return this.value == ""; });
                emptyTextBoxes.each(function () {
                    $(this).css("border-color", "red");
                });

                if (emptyTextBoxes.length == 0) {
                    if ($("#txtboxPassword").val() != $("#txtboxCPassword").val()) {
                        $("#txtboxCPassword").after("<p>Contraseñas no coinciden.</p>");
                    } else {
                        $.ajax({
                            type: "POST",
                            url: "RegisterUser.aspx/submitUser",
                            data: "{email: '" + $("#txtboxCorreo").val() + "',nombre_usuario:'" + $("#txtboxNombreUsuario").val() + "',nombre_empresa:'"+$("#txtboxNombreEmpresa").val()+"',password:'"+$("#txtboxPassword").val()+"',rfc:'"+$("#txtboxRFC").val()+"'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccess,
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    }
                } else {
                    alert("Porfavor ingrese todos los campos requeridos marcados en rojo.");
                }
            }
            function OnSuccess(response) {
                if (response.d == "Success") {
                    alert("Registro exitoso.");
                    window.location.href = "Login.aspx";
                } else {
                    alert(response.d);
                }
            }
</script>
</asp:Content>
<asp:Content ID="ContentRegisterUserBody" ContentPlaceHolderID="contentBody" runat="server">
    
    <label>Nombre Completo:</label>
    <input id="txtboxNombreUsuario" type="text" class="required" />
    <br />
    <label>Correo:</label>
    <input id="txtboxCorreo" type="text" class="required" />
    <br />
    <label>RFC:</label>
    <input id="txtboxRFC" type="text" class="required"/>
    <br />
    <label>Nombre de la empresa:</label>
    <input id="txtboxNombreEmpresa" type="text" class="required"/>
    <br />
    <label>Contraseña</label>
    <input id="txtboxPassword" type="password" class="required"/>
    <br />
    <label>Confirmar Contraseña:</label>
    <input id="txtboxCPassword" type="password" class="required"/>
    <br />
    <button id="btnSubmit" onclick="validateSubmit()">Submit</button>
    <a href="Login.aspx">Regresar</a>
</asp:Content>
