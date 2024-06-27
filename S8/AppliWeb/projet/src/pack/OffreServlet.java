package pack;

import java.io.IOException;
import java.util.Collection;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.entities.Offre;
import pack.facade.CompteFacade;

@WebServlet("/OffresServlet")
public class OffreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @EJB
    private CompteFacade compteFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Collection<Offre> offres = compteFacade.listerOffres();

        request.setAttribute("offres", offres);

        request.getRequestDispatcher("/offres.jsp").forward(request, response);
    }
}
