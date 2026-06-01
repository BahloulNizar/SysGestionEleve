package web;

import dao.IClasse;
import dao.ImplClasse;
import dao.IFiliere;
import dao.ImplFiliere;
import Metier.Classe;
import Metier.Filiere;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "cs", urlPatterns = {"/classes", "/ajouterClasse", "/supprimerClasse"})
public class ClassesServlet extends HttpServlet {
    private IClasse classeDao = new ImplClasse();
    private IFiliere filiereDao = new ImplFiliere();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.equals("/classes")) {
            List<Classe> listeClasses = classeDao.getAllClasses();
            List<Filiere> listeFilieres = filiereDao.listerFilieres();

            request.setAttribute("classes", listeClasses);
            request.setAttribute("filieres", listeFilieres);

            request.getRequestDispatcher("classes.jsp").forward(request, response);
        }
        else if (path.equals("/supprimerClasse")) {
            int id = Integer.parseInt(request.getParameter("id"));
            classeDao.deleteClasse(id);
            response.sendRedirect("classes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getServletPath().equals("/ajouterClasse")) {
            String nom = request.getParameter("nom");
            int idFiliere = Integer.parseInt(request.getParameter("idFiliere"));

            Filiere f = filiereDao.getFiliere(idFiliere);

            Classe c = new Classe();
            c.setNom(nom);
            c.setFiliere(f);

            classeDao.addClasse(c);

            response.sendRedirect("classes");
        }
    }
}