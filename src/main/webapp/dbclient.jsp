<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%-- 1.0.0 --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%!String val(javax.servlet.http.HttpServletRequest request, String param) {
  return val(request, param, "");
}%>
<%!String val(javax.servlet.http.HttpServletRequest request, String param, String defaultValue) {
  String value = request.getParameter(param);
  return value == null || value.trim().equals("") ? defaultValue : value;
}%>
<%
request.setCharacterEncoding("utf-8");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DB Client</title>
<link rel="shortcut icon" href="https://raw.githubusercontent.com/websys-co/jsp-db-client/master/src/main/webapp/favicon.ico">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<style>
body {
  padding-top: 15px;
}
</style>
<!--[if lt IE 9]>
  <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <form name="frm" method="post" accept-charset="utf-8">
        <input type="hidden" name="op" value="run">
        <div class="col-sm-12">
          <div class="panel panel-info">
            <div class="panel-heading">DB Client</div>
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-4">
                  <div class="form-group">
                    <%String url = val(request, "url");%>
                    <input type="text" name="url" class="form-control input-sm" placeholder="URL JDBC" title="Exemplo: jdbc:derby:db;create=true" value="<%=url%>">
                  </div>
                </div>
                <div class="col-sm-3">
                  <div class="form-group">
                    <%String user = val(request, "user");%>
                    <input type="text" name="user" class="form-control input-sm" placeholder="Usuário" value="<%=user%>">
                  </div>
                </div>
                <div class="col-sm-3">
                  <div class="form-group">
                    <%String password = val(request, "password");%>
                    <input type="password" name="password" class="form-control input-sm" placeholder="Senha" value="<%=password%>">
                  </div>
                </div>
                <div class="col-sm-2">
                  <div class="form-group">
                    <%String max = val(request, "max", "100");%>
                    <input type="text" name="max" class="form-control input-sm" placeholder="# Máx. registros" title="Quantidade máxima de registros" value="<%=max%>">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12">
                  <div class="form-group">
                    <%String sql = val(request, "sql");%>
                    <textarea name="sql" class="form-control" rows="8" placeholder="SQL"><%=sql%></textarea>
                  </div>
                  <button type="submit" class="btn btn-primary pull-right">Executar</button>
                </div>
              </div>
            </div>
          </div>
<%
String op = val(request, "op");
if (op.equals("run")) {
  Connection conn = null;
  try {
    conn = DriverManager.getConnection(url, user, password);
    Statement stmt = conn.createStatement();
    boolean isResultSet = stmt.execute(sql);
    if (isResultSet) {
      ResultSet rs = stmt.getResultSet();
      if (rs.next()) {
%>
          <div class="panel panel-success" id="resultPanel">
            <div class="panel-heading">Sucesso</div>
            <table class="table table-condensed">
              <thead>
                <tr>
<%
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
          String columnName = rsmd.getColumnName(i);
%>
                  <th><%=columnName%></th>
<%
        }
%>
                </tr>
              </thead>
              <tbody>
<%
        int maxRegs = Integer.parseInt(max);
        int numRegs = 1;
        do {
%>
                <tr>
<%
          for (int i = 1; i <= columnCount; i++) {
            String value = rs.getString(i);            
%>
                  <td><%=value%></td>
<%
          }
%>
                </tr>
<%
        } while(++numRegs <= maxRegs && rs.next());
%>
              </tbody>
            </table>
          </div>
<%
      } else {
%>
          <div class="panel panel-success" id="resultPanel">
            <div class="panel-heading">Sucesso</div>
            <div class="panel-body">
              <p>Nenhum registro foi encontrado.</p>
            </div>
          </div>
<%
      }
    } else {
      int updateCount = stmt.getUpdateCount();
%>
          <div class="panel panel-success" id="resultPanel">
            <div class="panel-heading">Sucesso</div>
            <div class="panel-body">
              <p>O SQL foi executado com sucesso: <mark><%=updateCount%> registro(s) alterado(s).</mark></p>
            </div>
          </div>
<%
    }
  } catch (Throwable e) {
%>
          <div class="panel panel-danger" id="resultPanel">
            <div class="panel-heading">Erro</div>
            <div class="panel-body">
              <p>A execução do SQL falhou: <mark><%=e.getClass().getName() + " - " + e.getMessage()%></mark></p>
            </div>
          </div>
<%
  } finally {
    if (conn != null) {
      try {
        conn.close();
      } catch (Throwable e) {
        //Não há o que fazer.        
      }
    }
  }
%>
          <script>
            function scroll() {
              var resultPanel = $("#resultPanel");
              if (resultPanel.length) {
                $("html, body").animate({
                  scrollTop: resultPanel.offset().top
                }, 600);
              }
            }
          </script>
<%
} else {
%>
          <script>
            function scroll() {
            }
          </script>
<%
}
%>
        </div>
      </form>
    </div>
  </div>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <script>
    $(document).ready(function () {
      setTimeout(scroll, 300);
    });
  </script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
  <script>
      /*!
       * IE10 viewport hack for Surface/desktop Windows 8 bug
       * Copyright 2014 Twitter, Inc.
       * Licensed under the Creative Commons Attribution 3.0 Unported License. For
       * details, see http://creativecommons.org/licenses/by/3.0/.
       */

      // See the Getting Started docs for more information:
      // http://getbootstrap.com/getting-started/#support-ie10-width
      (function() {
        'use strict';
        if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
          var msViewportStyle = document.createElement('style')
          msViewportStyle.appendChild(document.createTextNode('@-ms-viewport{width:auto!important}'))
          document.querySelector('head').appendChild(msViewportStyle)
        }
      })();
  </script>
</body>
</html>