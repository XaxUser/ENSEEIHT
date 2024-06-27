 package pack;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.entities.Entreprise;
import pack.entities.Offre;
import pack.facade.CompteFacade;

@WebServlet("/CreationOffreServlet")
public class CreationOffre extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade offreFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/creationoffre.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String titre = request.getParameter("titre");
        String domaine = request.getParameter("domaine");
        String lieu = request.getParameter("lieu");
        String duree = request.getParameter("duree");
        String poste = request.getParameter("poste");
        String descriptif = request.getParameter("descriptif");
        String remuneration = request.getParameter("remuneration");

        Entreprise entreprise = (Entreprise) request.getSession().getAttribute("entreprise");

        if (entreprise == null) {
            response.sendRedirect("ConnexionEntrepriseServlet");
            return;
        }

        Offre offre = new Offre();
        offre.setTitre(titre);
        offre.setDomaine(domaine);
        offre.setLieu(lieu);
        offre.setDuree(duree);
        offre.setPoste(poste);
        offre.setDescriptif(descriptif);
        offre.setRemuneration(remuneration);
        offre.setEntreprise(entreprise);

        offreFacade.createOffre(offre);

        response.sendRedirect("CreationOffreServlet");
    }
}
