package dao;

import Metier.Matiere;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ImplMatiere implements IMatiere {
    private EntityManager em;

    public ImplMatiere() {
        this.em = SingletonConnection.getEntityManager();
    }

    @Override
    public void addMatiere(Matiere m) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(m);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public List<Matiere> getListMatieres() {
        em.clear();
        return em.createQuery("select m from Matiere m", Matiere.class).getResultList();
    }

    @Override
    public Matiere getMatiere(int id) {
        em.clear();
        return em.find(Matiere.class, id);
    }

    @Override
    public void updateMatiere(Matiere m) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(m);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMatiere(int id) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Matiere m = em.find(Matiere.class, id);
            if (m != null) {
                em.remove(m);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }
}