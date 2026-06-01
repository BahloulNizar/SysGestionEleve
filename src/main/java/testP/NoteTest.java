package testP;

import Metier.Eleve;
import Metier.Matiere;
import Metier.Note;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class NoteTest {

    @Test
    public void testNoteAssociations() {
        Eleve eleve = new Eleve();
        eleve.setNom("Benali");

        Matiere matiere = new Matiere();
        matiere.setLibelle("Mathematiques");

        Note note = new Note();
        note.setValeur(17.5f);
        note.setEleve(eleve);
        note.setMatiere(matiere);

        assertNotNull(note);
        assertEquals(17.5f, note.getValeur());

        assertNotNull(note.getEleve());
        assertEquals("Benali", note.getEleve().getNom());

        assertNotNull(note.getMatiere());
        assertEquals("Mathematiques", note.getMatiere().getLibelle());
    }
}