package dao;

import Metier.Releve;
import jakarta.persistence.*;
import java.util.List;

public class ImplReleve implements IReleve {
    private EntityManager em;

    public ImplReleve() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionScolairePU");
        this.em = emf.createEntityManager();
    }

    @Override
    public void addReleve(Releve r) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(r);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public Releve getReleve(int id) {
        em.clear();
        return em.find(Releve.class, id);
    }

    @Override
    public List<Releve> getAllReleves() {
        em.clear();
        return em.createQuery("SELECT r FROM Releve r", Releve.class).getResultList();
    }
}