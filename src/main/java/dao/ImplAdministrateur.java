package dao;

import Metier.Administrateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;

public class ImplAdministrateur implements IAdministrateur {
    // Factory kat-b9a static machi mochkil
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionScolairePU");

    public ImplAdministrateur() {
        // Khawya m9as sghira
    }

    @Override
    public void addAdmin(Administrateur admin) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(admin);
            em.getTransaction().commit();
        } finally {
            em.close(); // dima n-sdou l-connection mlli n-salio
        }
    }

    @Override
    public Administrateur login(String email, String password) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Administrateur a WHERE a.email = :email AND a.motDePasse = :pw", Administrateur.class)
                    .setParameter("email", email)
                    .setParameter("pw", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close(); // dima n-sdou l-connection mlli n-salio
        }
    }
}