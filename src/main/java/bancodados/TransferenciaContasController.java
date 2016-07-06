package bancodados;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/transferenciaContas")
public class TransferenciaContasController extends HttpServlet {
  private String valor(HttpServletRequest req, String param, String padrao) {
    String result = req.getParameter(param);
    if (result == null) {
      result = padrao;
    }
    return result;
  }

  private int toInt(HttpServletRequest req, String param, int padrao) {
    String valor = valor(req, param, "");
    return valor == "" ? padrao : Integer.parseInt(valor);
  }

  private double toDouble(HttpServletRequest req, String param, double padrao) {
    String valor = valor(req, param, "");
    return valor == "" ? padrao : Double.parseDouble(valor);
  }

  @Override
  protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try {
      String msg;
      String op = valor(req, "operacao", "");
      int origem = toInt(req, "origem", 0);
      int destino = toInt(req, "destino", 0);
      double valor = toDouble(req, "valor", 0);
      String nome = valor(req, "nome", "");
      if (op.equals("transferir")) {
        ContaDao.transferir(origem, destino, valor);
        msg = "Transferência realizada com sucesso.";
      } else if (op.equals("")) {
        msg = "";
      } else {
        throw new IllegalArgumentException("Operação \"" + op + "\" não suportada.");
      }
      
      req.setAttribute("msg", msg);

      req.getRequestDispatcher("TransferenciaContasView.jsp").forward(req, resp);
    } catch (Exception e) {
      e.printStackTrace(resp.getWriter());
    }
  }
}