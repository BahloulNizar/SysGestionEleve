package dao;

import Metier.Matiere;
import java.util.List;

public interface IMatiere {
    void addMatiere(Matiere m);
    List<Matiere> getListMatieres();
    Matiere getMatiere(int id);

    void updateMatiere(Matiere m);
    void deleteMatiere(int id);
}