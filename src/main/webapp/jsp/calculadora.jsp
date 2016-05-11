<html>
<body>
	<h2>Calculadora</h2>
	<form>
		Operador 1: <input name="oper1">
		<br>
		Operação: <input name="op">
		<br>
		Operador 2: <input name="oper2">
		<br>
		<button>Calcular</button>
	</form>
<%
String oper1Str = request.getParameter("oper1");
String opStr = request.getParameter("op");
String oper2Str = request.getParameter("oper2");

int oper1 = oper1Str == null ? 0 : Integer.parseInt(oper1Str);
opStr = opStr == null ? "" : opStr;
int oper2 = oper2Str == null ? 0 : Integer.parseInt(oper2Str);

int resultado = 0;

if (opStr.equals("+")) {
	resultado = oper1 + oper2;
} else if (opStr.equals("-")) {
	resultado = oper1 - oper2;
}

out.print("Resultado: " + resultado);
%>
</body>
</html>
