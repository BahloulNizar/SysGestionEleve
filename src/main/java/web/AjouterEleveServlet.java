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
import java.sql.Date;
import java.util.List;

@WebServlet("/ajouterEleve")
public class AjouterEleveServlet extends HttpServlet {
    private IEleve eleveDao;
    private IClasse classeDao;

    @Override
    public void init() throws ServletException {
        eleveDao = new ImplEleve();
        classeDao = new ImplClasse();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Classe> classes = classeDao.getAllClasses();
        request.setAttribute("classes", classes);

        request.getRequestDispatcher("ajouter-eleve.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String matricule = request.getParameter("matricule");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String dateNaisStr = request.getParameter("dateNaissance");
            int idC = Integer.parseInt(request.getParameter("idClasse"));

            Eleve e = new Eleve();
            e.setMatricule(matricule);
            e.setNom(nom);
            e.setPrenom(prenom);

            if (dateNaisStr != null && !dateNaisStr.isEmpty()) {
                e.setDateNaissance(Date.valueOf(dateNaisStr));
            }

            Classe c = classeDao.getClasse(idC);
            e.setClasse(c);

            eleveDao.addEleve(e);

            response.sendRedirect("listeEleves");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("ajouterEleve?error=true");
        }
    }
}