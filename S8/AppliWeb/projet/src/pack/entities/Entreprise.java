package pack.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Entreprise implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String secteurActivite;
    
    @OneToOne
    private Compte compte;

    @OneToMany(mappedBy = "entreprise", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Offre> offresPostulees;

    public Entreprise() {
    }

    public Entreprise(String nom, String secteurActivite) {
        this.nom = nom;
        this.secteurActivite = secteurActivite;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public void setCompte(Compte compte) {
        this.compte = compte;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getSecteurActivite() {
        return secteurActivite;
    }

    public void setSecteurActivite(String secteurActivite) {
        this.secteurActivite = secteurActivite;
    }

    public List<Offre> getOffresPostulees() {
        return offresPostulees;
    }

    public void setOffresPostulees(List<Offre> offresPostulees) {
        this.offresPostulees = offresPostulees;
    }

    @Override
    public String toString() {
        return "Entreprise{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", secteurActivite='" + secteurActivite + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Entreprise that = (Entreprise) o;

        return id != null ? id.equals(that.id) : that.id == null;
    }

    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}
