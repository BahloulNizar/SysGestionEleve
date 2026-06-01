package web;

import dao.IEleve;
import dao.ImplEleve;
import Metier.Eleve;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/test-eleves")
public class TestServlet extends HttpServlet {

    private IEleve eleveDao = new ImplEleve();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Eleve> eleves = eleveDao.getListEleves();

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Test MySQL</title></head><body>");
        out.println("<h1>Liste des élèves (Depuis MySQL via Servlet)</h1>");

        if (eleves.isEmpty()) {
            out.println("<p>⚠️ La base de données est vide. Ajoute des élèves via le Main !</p>");
        } else {
            out.println("<ul>");
            for(Eleve e : eleves) {
                out.println("<li>" + e.getNom() + " " + e.getPrenom() + " (Matricule: " + e.getMatricule() + ")</li>");
            }
            out.println("</ul>");
        }

        out.println("</body></html>");
    }
}