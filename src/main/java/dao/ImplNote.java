package dao;

import Metier.Note;
import jakarta.persistence.*;
import java.util.List;
import java.util.Date;

public class ImplNote implements INote {
    private EntityManager em;

    public ImplNote() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionScolairePU");
        this.em = emf.createEntityManager();
    }

    @Override
    public void addNote(Note n) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (n.getDateSaisie() == null) {
                n.setDateSaisie(new Date());
            }
            em.persist(n);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void updateNote(Note n) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(n);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void deleteNote(int id) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.clear();
            Note n = em.find(Note.class, id);
            if (n != null) {
                em.remove(n);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public Note getNote(int id) {
        em.clear();
        return em.find(Note.class, id);
    }

    @Override
    public List<Note> getNotesByEleve(int eleveId) {
        em.clear();
        return em.createQuery("SELECT n FROM Note n WHERE n.eleve.id = :id", Note.class)
                .setParameter("id", eleveId)
                .getResultList();
    }

    @Override
    public List<Note> getNotesByMatiere(int matiereId) {
        em.clear();
        return em.createQuery("SELECT n FROM Note n WHERE n.matiere.id = :id", Note.class)
                .setParameter("id", matiereId)
                .getResultList();
    }

    @Override
    public List<Note> getAllNotes() {
        em.clear();
        return em.createQuery("SELECT n FROM Note n", Note.class).getResultList();
    }
}