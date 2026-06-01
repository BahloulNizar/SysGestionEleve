package web;

import dao.IEleve;
import dao.INote;
import dao.IReleve;
import dao.ImplEleve;
import dao.ImplNote;
import dao.ImplReleve;
import Metier.Eleve;
import Metier.Note;
import Metier.Releve;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Date;

@WebServlet("/releveNotes")
public class ReleveServlet extends HttpServlet {
    private INote noteDao;
    private IEleve eleveDao;
    private IReleve releveDao;

    @Override
    public void init() throws ServletException {
        noteDao = new ImplNote();
        eleveDao = new ImplEleve();
        releveDao = new ImplReleve();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int idEleve = Integer.parseInt(idParam);
                Eleve eleve = eleveDao.getEleve(idEleve);

                if (eleve != null) {
                    List<Note> notes = noteDao.getNotesByEleve(idEleve);

                    Releve historique = new Releve();
                    historique.setEleve(eleve);
                    historique.setDateGeneration(new Date());
                    historique.setContenuPDF(null);

                    releveDao.addReleve(historique);

                    request.setAttribute("eleve", eleve);
                    request.setAttribute("notes", notes);
                    request.getRequestDispatcher("/releveNotes.jsp").forward(request, response);
                } else {
                    response.sendRedirect("listeEleves");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("listeEleves");
            }
        } else {
            response.sendRedirect("listeEleves");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}