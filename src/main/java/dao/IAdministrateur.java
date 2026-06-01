package dao;

import Metier.Administrateur;

public interface IAdministrateur {
    void addAdmin(Administrateur admin);
    Administrateur login(String email, String password);
}