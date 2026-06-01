package dao;

import java.util.List;
import Metier.Classe;

public interface IClasse {
    void addClasse(Classe c);
    List<Classe> getAllClasses();
    Classe getClasse(int id);
    void deleteClasse(int id);
}