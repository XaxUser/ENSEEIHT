package pack.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Candidat {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nom;
	private String prenom;
	private String date_naissance;
	private String universite;
	private String niveau_etude;
	private String formation;
	
	public Candidat() {
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return this.id ;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public String getNom() {
		return this.nom;
	}
	
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	
	public String getPrenom() {
		return this.prenom;
	}
	
	public void setDateNaissance(String date_naissance) {
		this.date_naissance = date_naissance;
	}
	
	public String getDateNaissance() {
		return this.date_naissance;
	}
	
	public void setUniversite(String universite) {
		this.universite = universite;
	}
	
	public String getUniversite() {
		return this.universite;
	}
	
	public void setNiveauEtude(String niveau_etude) {
		this.niveau_etude = niveau_etude;
	}
	
	public String getNiveauEtude() {
		return this.niveau_etude;
	}
	
	public void setFormation(String formation) {
		this.formation = formation;
	}
	
	public String getFormation() {
		return this.formation;
	}
	
	
}
