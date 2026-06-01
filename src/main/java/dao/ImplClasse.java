package dao;

import Metier.Classe;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import java.util.List;

public class ImplClasse implements IClasse {

    private EntityManager em = SingletonConnection.getEntityManager();

    @Override
    public void addClasse(Classe c) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(c);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public List<Classe> getAllClasses() {
        em.clear();
        return em.createQuery("SELECT c FROM Classe c LEFT JOIN FETCH c.filiere", Classe.class)
                .getResultList();
    }

    @Override
    public void deleteClasse(int id) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            Classe c = em.find(Classe.class, id);

            if (c != null) {
                em.createQuery("UPDATE Eleve e SET e.classe = NULL WHERE e.classe.id = :id")
                        .setParameter("id", id)
                        .executeUpdate();

                em.remove(c);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public Classe getClasse(int id) {
        em.clear();
        return em.find(Classe.class, id);
    }
}