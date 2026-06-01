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

@WebServlet("/modifierMatiere")
public class ModifierMatiereServlet extends HttpServlet {

    private IMatiere matiereDao;

    @Override
    public void init() throws ServletException {
        matiereDao = new ImplMatiere();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Matiere m = matiereDao.getMatiere(id);
                request.setAttribute("matiere", m);

                request.getRequestDispatcher("modifier-matiere.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("matieres");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nom = request.getParameter("nom");
            double coeff = Double.parseDouble(request.getParameter("coefficient"));

            Matiere m = new Matiere();
            m.setId(id);
            m.setLibelle(nom);
            m.setCoefficient(coeff);

            matiereDao.updateMatiere(m);

            response.sendRedirect("matieres");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("matieres?error=true");
        }
    }
}