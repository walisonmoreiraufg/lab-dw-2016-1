package bancodados;

public class Conta {

  private Integer numero;
  private Double saldo;

	public Conta() {
	}

	public Integer getNumero() {
    return numero;
  }

  public void setNumero(Integer numero) {
    this.numero = numero;
  }

  public Double getSaldo() {
    return saldo;
  }

  public void setSaldo(Double saldo) {
    this.saldo = saldo;
  }

  public Conta(Integer numero, Double saldo) {
		this.numero = numero;
		this.saldo = saldo;
	}
}
