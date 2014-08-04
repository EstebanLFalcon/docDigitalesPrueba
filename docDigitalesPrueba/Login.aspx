<%@ Page Title="" Language="C#" MasterPageFile="~/Base.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="docDigitalesPrueba.Login" %>
<asp:Content ID="ContentLoginHead" ContentPlaceHolderID="head" runat="server">
        <script>
            function validateUser() {
                var emptyTextBoxes = $('input:text').filter(function () { return this.value == ""; });
                emptyTextBoxes.each(function () {
                    $(this).css("border-color", "red");
                });
                
                if (emptyTextBoxes.length == 0) {
                    $.ajax({
                        type: "POST",
                        url: "/Login.aspx/validateLogin",
                        data: "{user: '" + $("#txtboxCorreo").val() + "',password:'" + $("#txtboxPassword").val() + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                } else {
                    $("#txtboxPassword").after("<p>Porfavor ingrese todos los valores.</p>");
                }
            }
            function OnSuccess(response) {
                if (response.d == "Success") {
                    window.location.href = "Home.aspx";
                } else {
                    alert(response.d);
                }
            }
</script>
</asp:Content>

<asp:Content ID="ContentLoginBody" ContentPlaceHolderID="contentBody" runat="server">
    <label>Correo:</label>
    <input id="txtboxCorreo" type="text" />
    <br />
    <label>Contraseña:</label>
    <input id="txtboxPassword" type="password" />
    <br />
    <button id="btnLogin" onclick="validateUser()">Log In</button>
    <a href="RegisterUser.aspx">Registro</a>

</asp:Content>
