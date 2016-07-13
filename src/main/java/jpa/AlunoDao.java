package jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

public class AlunoDao {

  private static EntityManagerFactory emf =
      Persistence.createEntityManagerFactory("gestao-academica");

  public static void inclui(String matricula, String nome) {
    //Obter "conexão".
    EntityManager em = emf.createEntityManager();
    em.getTransaction().begin();
    Aluno aluno = new Aluno(matricula, nome);
    //Grava o objeto no banco de dados.
    em.persist(aluno);
    em.getTransaction().commit();
    em.close();
	}

	public static void alterar(String matricula, String nome) {
	}

	public static void excluir(String matricula) {
	}

	public static List<Aluno> listar() {
	  EntityManager em = emf.createEntityManager();
    String jpql = "from Aluno";
    TypedQuery<Aluno> query =
      em.createQuery(jpql, Aluno.class);
    List<Aluno> result = query.getResultList();
    em.close();
    return result;
	}
}
