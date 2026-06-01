package web;

import dao.IEleve;
import dao.ImplEleve;
import dao.IClasse;
import dao.ImplClasse;
import Metier.Eleve;
import Metier.Classe;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/listeEleves")
public class EleveServlet extends HttpServlet {

    private IEleve eleveDao;
    private IClasse classeDao;

    @Override
    public void init() throws ServletException {
        eleveDao = new ImplEleve();
        classeDao = new ImplClasse();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminSession") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Eleve> liste = eleveDao.getListEleves();
        request.setAttribute("eleves", liste);

        List<Classe> listeClasses = classeDao.getAllClasses();
        request.setAttribute("classes", listeClasses);

        request.getRequestDispatcher("listeEleves.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}