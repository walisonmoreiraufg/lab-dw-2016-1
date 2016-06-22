<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="bancodados.Usuario"%>
<html>

  <head>
    <title>Usuário</title>
  </head>

  <body>
    <h1><a href="usuario">Usuário</a></h1>
    <form>
      <table>
        <tr>
          <td>Código</td>
          <td><input name="codigo"></td>
        </tr>
        <tr>
          <td>Nome:</td>
          <td><input name="nome"></td>
        </tr>
        <tr>
          <td>Login:</td>
          <td><input name="login"></td>
        </tr>
        <tr>
          <td>Senha:</td>
          <td><input type="password" name="senha"></td>
        </tr>
      </table>
      <button name="operacao" value="incluir">Incluir</button>
      <button name="operacao" value="excluir">Excluir</button>
      <button name="operacao" value="alterar">Alterar</button>
    </form>
    <b>${msg}</b>
    <hr>
    <table border="1">
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Login</th>
        <th>Ações</th>
      </tr>
      
      <%
      ArrayList<Usuario> usuarios =
        (ArrayList<Usuario>) request.getAttribute("usuarios");
      for (Usuario usuario : usuarios) {
      %>
      <tr>
        <td><%=usuario.getCodigo()%></td>
        <td><%=usuario.getNome()%></td>
        <td><%=usuario.getLogin()%></td>
        <td><a href="usuario?operacao=excluir&codigo=<%=usuario.getCodigo()%>">Excluir</a></td>
      </tr>
      <%}%>
    </table>
  </body>

</html>