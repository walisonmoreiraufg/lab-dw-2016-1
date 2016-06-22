package bancodados;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/usuario")
public class UsuarioController extends HttpServlet {
	private String valor(HttpServletRequest req, String param, String padrao) {
		String result = req.getParameter(param);
		if (result == null) {
			result = padrao;
		}
		return result;
	}

	private int toInt(HttpServletRequest req, String param, String padrao) {
		return Integer.parseInt(valor(req, param, padrao));
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String msg;
			String op = valor(req, "operacao", "");
			int codigo = toInt(req, "codigo", "0");
			String nome = valor(req, "nome", "");
			String login = valor(req, "login", "");
			String senha = valor(req, "senha", "");
			if (op.equals("incluir")) {
				UsuarioDao.inclui(codigo, nome, login, senha);
				msg = "Inclusão realizada com sucesso.";
			} else if (op.equals("alterar")) {
				UsuarioDao.alterar(codigo, nome, login, senha);
				msg = "Alteração realizada com sucesso.";
			} else if (op.equals("excluir")) {
				UsuarioDao.excluir(codigo);
				msg = "Exclusão realizada com sucesso.";
			} else if (op.equals("")) {
				msg = "";
			} else {
				throw new IllegalArgumentException("Operação \"" + op + "\" não suportada.");
			}
			req.setAttribute("msg", msg);
			req.setAttribute("usuarios", UsuarioDao.listar());
			
			req.getRequestDispatcher("UsuarioView.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace(resp.getWriter());
		}
	}
}
