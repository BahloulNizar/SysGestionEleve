package dao;

import Metier.Administrateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;

public class ImplAdministrateur implements IAdministrateur {
    private EntityManager em;

    public ImplAdministrateur() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionScolairePU");
        em = emf.createEntityManager();
    }

    @Override
    public void addAdmin(Administrateur admin) {
        em.getTransaction().begin();
        em.persist(admin);
        em.getTransaction().commit();
    }

    @Override
    public Administrateur login(String email, String password) {
        try {
            return em.createQuery("SELECT a FROM Administrateur a WHERE a.email = :email AND a.motDePasse = :pw", Administrateur.class)
                    .setParameter("email", email)
                    .setParameter("pw", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}