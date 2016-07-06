<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="bancodados.Conta"%>
<html>

  <head>
    <title>Listar Contas</title>
  </head>

  <body>
    <h1><a href="listarContas">Listar Contas</a></h1>
    <table border="1">
      <tr>
        <th>Número</th>
        <th>Saldo</th>
      </tr>
      <%
      ArrayList<Conta> contas =
        (ArrayList<Conta>) request.getAttribute("contas");
      for (Conta conta : contas) {
      %>
      <tr>
        <td><%=conta.getNumero()%></td>
        <td><%=conta.getSaldo()%></td>
      </tr>
      <%
      }
      %>
    </table>
  </body>

</html>