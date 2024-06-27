package pack;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.entities.Compte;
import pack.entities.Offre;
import pack.facade.CompteFacade;

@WebServlet("/PostulerOffreServlet")
public class PostulerOffreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade compteFacade;
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/offresConnexion.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int offreId = Integer.parseInt(request.getParameter("offreId"));

        Offre offre = compteFacade.findOffreById(offreId);

        Compte etudiant = (Compte) request.getSession().getAttribute("compte");

        Compte etudiantAvecOffres = compteFacade.findCompteWithOffres(etudiant.getId());

        compteFacade.postulerOffre(etudiantAvecOffres, offre);

        request.getSession().setAttribute("compte", etudiantAvecOffres);

        response.sendRedirect(request.getContextPath() + "/accueil.jsp");
    }
}
