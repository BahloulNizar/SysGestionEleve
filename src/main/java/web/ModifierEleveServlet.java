package web;

import dao.IClasse;
import dao.IEleve;
import dao.ImplClasse;
import dao.ImplEleve;
import Metier.Classe;
import Metier.Eleve;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/modifierEleve")
public class ModifierEleveServlet extends HttpServlet {

    private IEleve eleveDao;
    private IClasse classeDao;

    @Override
    public void init() throws ServletException {
        eleveDao = new ImplEleve();
        classeDao = new ImplClasse();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Eleve e = eleveDao.getEleve(id);
                List<Classe> listeClasses = classeDao.getAllClasses();

                request.setAttribute("eleve", e);
                request.setAttribute("classes", listeClasses);

                request.getRequestDispatcher("modifier-eleve.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            response.sendRedirect("listeEleves");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String matricule = request.getParameter("matricule");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            int idClasse = Integer.parseInt(request.getParameter("idClasse"));

            Eleve e = new Eleve();
            e.setId(id);
            e.setMatricule(matricule);
            e.setNom(nom);
            e.setPrenom(prenom);

            if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
                e.setDateNaissance(java.sql.Date.valueOf(dateNaissanceStr));
            }

            Classe c = classeDao.getClasse(idClasse);
            e.setClasse(c);

            eleveDao.updateEleve(e);

            response.sendRedirect("listeEleves");

        } catch (Exception ex) {
            ex.printStackTrace();
            String idErr = request.getParameter("id");
            response.sendRedirect("modifierEleve?id=" + idErr + "&error=true");
        }
    }
}