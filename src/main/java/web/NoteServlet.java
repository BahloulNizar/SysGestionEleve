package web;

import dao.*;
import Metier.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/notes")
public class NoteServlet extends HttpServlet {
    private INote noteDao;
    private IEleve eleveDao;
    private IMatiere matiereDao;

    @Override
    public void init() throws ServletException {
        noteDao = new ImplNote();
        eleveDao = new ImplEleve();
        matiereDao = new ImplMatiere();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Eleve> eleves = eleveDao.getListEleves();
        List<Matiere> matieres = matiereDao.getListMatieres();
        List<Note> notes = noteDao.getAllNotes();

        request.setAttribute("eleves", eleves);
        request.setAttribute("matieres", matieres);
        request.setAttribute("notes", notes);

        request.getRequestDispatcher("saisieNotes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEleve = Integer.parseInt(request.getParameter("eleveId"));
        int idMatiere = Integer.parseInt(request.getParameter("matiereId"));
        float valeur = Float.parseFloat(request.getParameter("valeur"));

        Note n = new Note();
        n.setValeur(valeur);
        n.setEleve(eleveDao.getEleve(idEleve));
        n.setMatiere(matiereDao.getMatiere(idMatiere));

        noteDao.addNote(n);

        response.sendRedirect("notes");
    }
}