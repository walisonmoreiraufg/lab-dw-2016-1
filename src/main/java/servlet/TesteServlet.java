package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(value="/teste")
public class TesteServlet extends HttpServlet{

	@Override
	protected void service(
			HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		resp
			.getOutputStream()
			.print("<html>"
				+ "<head>"
				+ "<title>"
				+ "Teste de Servlet"
				+ "</title>"
				+ "</head>"
				+ "<body>"
				+ "<h1>Teste de Servlet</h1>"
				+ "</body>");
		
	}
}
