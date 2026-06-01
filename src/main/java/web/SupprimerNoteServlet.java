package web;

import dao.INote;
import dao.ImplNote;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/supprimerNote")
public class SupprimerNoteServlet extends HttpServlet {
    private INote noteDao;

    @Override
    public void init() throws ServletException {
        noteDao = new ImplNote();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            noteDao.deleteNote(id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("notes");
    }
}