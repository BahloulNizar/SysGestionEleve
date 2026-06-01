package dao;

import Metier.Filiere;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ImplFiliere implements IFiliere {
    private EntityManager em = SingletonConnection.getEntityManager();

    @Override
    public void ajouterFiliere(Filiere f) {
        EntityTransaction tx = em.getTransaction();
        tx.begin();
        em.persist(f);
        tx.commit();
    }

    @Override
    public List<Filiere> listerFilieres() {
        return em.createQuery("SELECT f FROM Filiere f", Filiere.class).getResultList();
    }

    @Override
    public void supprimerFiliere(int id) {
        Filiere f = em.find(Filiere.class, id);
        if (f != null) {
            EntityTransaction tx = em.getTransaction();
            tx.begin();
            em.remove(f);
            tx.commit();
        }
    }

    @Override
    public Filiere getFiliere(int id) {
        return em.find(Filiere.class, id);
    }
}