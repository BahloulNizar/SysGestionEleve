package web;

import dao.IMatiere;
import dao.ImplMatiere;
import Metier.Matiere;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/matieres")
public class MatiereServlet extends HttpServlet {

    private IMatiere matiereDao;

    @Override
    public void init() throws ServletException {
        matiereDao = new ImplMatiere();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Matiere> matieres = matiereDao.getListMatieres();
        request.setAttribute("matieres", matieres);
        request.getRequestDispatcher("matieres.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nomMatiere = request.getParameter("nom");
        String coeffStr = request.getParameter("coefficient");

        try {
            if (nomMatiere != null && coeffStr != null) {
                Matiere m = new Matiere();
                m.setLibelle(nomMatiere);
                m.setCoefficient(Double.parseDouble(coeffStr));
                matiereDao.addMatiere(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("matieres");
    }
}