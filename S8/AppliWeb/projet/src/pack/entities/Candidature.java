package pack.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Candidature {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	public Candidature() {
			
	}
		
		
	public void setId(int id) {
		this.id = id;
	}
		
	public int getId() {
		return this.id ;
	}	
	
}

