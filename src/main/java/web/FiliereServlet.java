package web;

import Metier.Filiere;
import dao.IFiliere;
import dao.ImplFiliere;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "filiereServlet", urlPatterns = {"/filieres", "/ajouterFiliere", "/supprimerFiliere"})
public class FiliereServlet extends HttpServlet {
    private IFiliere metier = new ImplFiliere();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.equals("/filieres")) {
            List<Filiere> filieres = metier.listerFilieres();
            request.setAttribute("filieres", filieres);
            request.getRequestDispatcher("filieres.jsp").forward(request, response);
        }
        else if (path.equals("/supprimerFiliere")) {
            int id = Integer.parseInt(request.getParameter("id"));
            metier.supprimerFiliere(id);
            response.sendRedirect("filieres");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String code = request.getParameter("code");

        Filiere f = new Filiere();
        f.setNom(nom);
        f.setCode(code);

        metier.ajouterFiliere(f);
        response.sendRedirect("filieres");
    }
}