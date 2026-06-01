package testP;

import Metier.Classe;
import Metier.Eleve;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class EleveTest {

    @Test
    public void testEleveCreation() {
        Eleve eleve = new Eleve();
        eleve.setNom("Alaoui");
        eleve.setPrenom("Fatima");
        eleve.setMatricule("E12345");

        assertNotNull(eleve);
        assertEquals("Alaoui", eleve.getNom());
        assertEquals("Fatima", eleve.getPrenom());
        assertEquals("E12345", eleve.getMatricule());
    }

    @Test
    public void testEleveClasseAssociation() {
        Classe classe = new Classe();
        classe.setNom("Terminale S");

        Eleve eleve = new Eleve();
        eleve.setNom("Benali");
        eleve.setClasse(classe);

        assertNotNull(eleve.getClasse());
        assertEquals("Terminale S", eleve.getClasse().getNom());
    }
}