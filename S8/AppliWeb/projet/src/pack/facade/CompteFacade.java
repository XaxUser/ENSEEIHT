package pack.facade;

import pack.entities.Compte;
import pack.entities.Entreprise;
import pack.entities.Offre;

import java.util.Collection;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Stateless
public class CompteFacade {
    @PersistenceContext
    private EntityManager em;
    
    
	@PostConstruct
	public void init() {
	    Compte compte = new Compte();
	    compte.setUsername("exampleUser");
	    compte.setPassword("examplePassword");
	    compte.setEmail("example@example.com");
	    em.persist(compte);
	    
	    
	    Compte compte2 = new Compte();
	    compte.setUsername("exampleUser");
	    compte.setPassword("pool");
	    compte.setEmail("exemple@exemple.com");
	    em.persist(compte2);

	    Entreprise entreprise = new Entreprise();
	    entreprise.setNom("Example Company");
	    entreprise.setCompte(compte);
	    em.persist(entreprise);

	    Offre offre1 = new Offre();
	    offre1.setTitre("Offre 1");
	    offre1.setDomaine("Informatique");
	    offre1.setLieu("Paris");
	    offre1.setDuree("6 mois");
	    offre1.setPoste("Développeur");
	    offre1.setDescriptif("Développement d'applications web.");
	    offre1.setRemuneration("3000€");
	    offre1.setEntreprise(entreprise);
	    em.persist(offre1);

	    Offre offre2 = new Offre();
	    offre2.setTitre("Offre 2");
	    offre2.setDomaine("Marketing");
	    offre2.setLieu("Lyon");
	    offre2.setDuree("3 mois");
	    offre2.setPoste("Assistant Marketing");
	    offre2.setDescriptif("Aide au développement de la stratégie marketing.");
	    offre2.setRemuneration("2000€");
	    offre2.setEntreprise(entreprise);
	    em.persist(offre2);
	    
	    Offre offre3 = new Offre();
	    offre3.setTitre("Offre 3");
	    offre3.setDomaine("Finance");
	    offre3.setLieu("Marseille");
	    offre3.setDuree("12 mois");
	    offre3.setPoste("Analyste Financier");
	    offre3.setDescriptif("Analyse des performances financières.");
	    offre3.setRemuneration("3500€");
	    offre3.setEntreprise(entreprise);
	    em.persist(offre3);
	}

    public void createCompte(Compte compte) {
        em.persist(compte);
    }
    
    public void createEntreprise(Entreprise entreprise) {
        em.persist(entreprise);
    }
    
    public void createOffre(Offre offre) {
        em.persist(offre);
    }
    

    public Compte findCompteById(Long id) {
        return em.find(Compte.class, id);
    }

    public Collection<Compte> findAllComptes() {
        return em.createQuery("from Compte", Compte.class).getResultList();
    }

    public void updateCompte(Compte compte) {
        em.merge(compte);
    }

    public void deleteCompte(Long id) {
        Compte compte = em.find(Compte.class, id);
        if (compte != null) {
            em.remove(compte);
        }
    }
    
    public Collection<Offre> listerOffres() {
    	TypedQuery<Offre> query = em.createQuery(
    		    "SELECT o FROM Offre o", Offre.class);

    		return query.getResultList();

    }
    

    public Entreprise findEntrepriseByCompte(Compte compte) {
        TypedQuery<Entreprise> query = em.createQuery(
            "SELECT c FROM Entreprise c WHERE c.compte = :compte", Entreprise.class);
        query.setParameter("compte", compte);
        
        try {
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    

    public Compte findByUsernameAndPassword(String username, String password) {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c WHERE c.username = :username AND c.password = :password", Compte.class);
        query.setParameter("username", username);
        query.setParameter("password", password);
        
        try {
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    
    public Compte findByEmailAndPassword(String email, String password) {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c WHERE c.email = :email AND c.password = :password", Compte.class);
        query.setParameter("email", email);
        query.setParameter("password", password);
        
        try {
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

	public Offre findOffreById(int id) {	
		return em.find(Offre.class, id);	
	}

	public void postulerOffre(Compte etudiant, Offre offre) {
	    if (!em.contains(etudiant)) {
	        etudiant = em.merge(etudiant);
	    }
	    if (!em.contains(offre)) {
	        offre = em.merge(offre);
	    }

	    etudiant.getOffresPostulees().add(offre);

	    em.merge(etudiant);
	}
	
	public Compte findCompteWithOffres(Long compteId) {
	    TypedQuery<Compte> query = em.createQuery(
	        "SELECT c FROM Compte c LEFT JOIN FETCH c.offresPostulees WHERE c.id = :id", Compte.class);
	    query.setParameter("id", compteId);
	    return query.getSingleResult();
	}
	
	
	


	
	
	
}
