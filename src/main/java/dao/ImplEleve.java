package dao;

import Metier.Eleve;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class ImplEleve implements IEleve {

    private EntityManager em;

    public ImplEleve() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionScolairePU");
        em = emf.createEntityManager();
    }

    @Override
    public void addEleve(Eleve e) {
        try {
            em.getTransaction().begin();
            em.persist(e);
            em.getTransaction().commit();
            em.clear();
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void deleteEleve(int id) {
        try {
            Eleve e = em.find(Eleve.class, id);
            if (e != null) {
                em.getTransaction().begin();
                em.remove(e);
                em.getTransaction().commit();
                em.clear();
            }
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public Eleve getEleve(int id) {
        Eleve e = em.find(Eleve.class, id);
        if (e != null) {
            em.refresh(e);
        }
        return e;
    }

    @Override
    public List<Eleve> getListEleves() {
        em.clear();
        return em.createQuery("select e from Eleve e", Eleve.class).getResultList();
    }

    @Override
    public void updateEleve(Eleve e) {
        try {
            em.getTransaction().begin();
            em.merge(e);
            em.getTransaction().commit();
            em.clear();
        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void modifyEleve(Eleve e) {
        updateEleve(e);
    }
}