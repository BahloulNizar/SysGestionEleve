package test;

import dao.*;
import Metier.*;
import java.util.Scanner;
import java.util.List;
import java.util.Date;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        IAdministrateur adminDao = new ImplAdministrateur();
        IEleve eleveDao = new ImplEleve();
        IClasse classeDao = new ImplClasse();
        IMatiere matiereDao = new ImplMatiere();
        INote noteDao = new ImplNote();

        if (adminDao.login("admin@test.com", "123") == null) {
            Administrateur defaultAdmin = new Administrateur();
            defaultAdmin.setNom("Directeur");
            defaultAdmin.setEmail("admin@test.com");
            defaultAdmin.setMotDePasse("123");
            adminDao.addAdmin(defaultAdmin);
        }

        System.out.println("========= SYSTEME DE GESTION SCOLAIRE =========");
        System.out.print("Email : ");
        String email = scanner.nextLine();
        System.out.print("Mot de passe : ");
        String pass = scanner.nextLine();

        Administrateur session = adminDao.login(email, pass);

        if (session != null) {
            System.out.println("\n✅ Connexion réussie ! Bonjour " + session.getNom());
            int choix = 0;
            do {
                System.out.println("\n--- MENU PRINCIPAL ---");
                System.out.println("1. Ajouter une Classe");
                System.out.println("2. Ajouter un Eleve");
                System.out.println("3. Lister les Eleves");
                System.out.println("4. Modifier un Eleve");
                System.out.println("5. Supprimer un Eleve");
                System.out.println("6. Ajouter une Matiere");
                System.out.println("7. Saisir une Note");
                System.out.println("8. Résultats (Moyennes & Classement)");
                System.out.println("9. Quitter");
                System.out.print("Votre choix : ");

                try {
                    choix = scanner.nextInt();
                    scanner.nextLine();
                } catch (Exception e) {
                    System.out.println("⚠️ Veuillez saisir un nombre.");
                    scanner.nextLine();
                    continue;
                }

                switch (choix) {
                    case 1:
                        System.out.print("Nom de la classe : "); String nomC = scanner.nextLine();
                        Classe cl = new Classe();
                        cl.setNom(nomC);
                        classeDao.addClasse(cl);
                        System.out.println("✅ Classe ajoutée !");
                        break;

                    case 2:
                        System.out.print("Nom : "); String nomE = scanner.nextLine();
                        System.out.print("Prenom : "); String prenomE = scanner.nextLine();
                        System.out.print("Matricule : "); String mat = scanner.nextLine();
                        System.out.print("Date Naissance (YYYY-MM-DD) : "); String dStr = scanner.nextLine();

                        List<Classe> cls = classeDao.getAllClasses();
                        if(cls == null || cls.isEmpty()) {
                            System.out.println("⚠️ Créez une classe d'abord !");
                            break;
                        }
                        for(Classe c : cls) System.out.println(c.getId() + " - " + c.getNom());
                        System.out.print("ID Classe : "); int idC = scanner.nextInt();

                        Eleve el = new Eleve();
                        el.setNom(nomE); el.setPrenom(prenomE); el.setMatricule(mat);
                        el.setDateNaissance(java.sql.Date.valueOf(dStr));
                        el.setClasse(classeDao.getClasse(idC));
                        eleveDao.addEleve(el);
                        System.out.println("✅ Eleve ajouté !");
                        break;

                    case 3:
                        List<Eleve> liste = eleveDao.getListEleves();
                        if(liste == null || liste.isEmpty()) {
                            System.out.println("Aucun élève trouvé.");
                        } else {
                            System.out.printf("\n%-3s | %-10s | %-20s | %-12s | %-10s\n", "ID", "MATRICULE", "NOM & PRENOM", "DATE NAISS.", "CLASSE");
                            for (Eleve e : liste) {
                                String cn = (e.getClasse()!=null)? e.getClasse().getNom() : "Non affecté";
                                System.out.printf("%-3d | %-10s | %-20s | %-12s | %-10s\n", e.getId(), e.getMatricule(), e.getNom()+" "+e.getPrenom(), e.getDateNaissance(), cn);
                            }
                        }
                        break;

                    case 4:
                        System.out.print("ID de l'élève à modifier : "); int idMod = scanner.nextInt();
                        scanner.nextLine();
                        Eleve eMod = eleveDao.getEleve(idMod);
                        if(eMod != null) {
                            System.out.print("Nouveau Nom ("+eMod.getNom()+") : "); eMod.setNom(scanner.nextLine());
                            System.out.print("Nouveau Prenom ("+eMod.getPrenom()+") : "); eMod.setPrenom(scanner.nextLine());
                            eleveDao.updateEleve(eMod);
                            System.out.println("✅ Modification réussie !");
                        } else {
                            System.out.println("❌ Élève introuvable.");
                        }
                        break;

                    case 5:
                        System.out.print("ID de l'élève à supprimer : "); int idSup = scanner.nextInt();
                        scanner.nextLine();
                        System.out.print("Confirmer la suppression (O/N) ? ");
                        if(scanner.nextLine().equalsIgnoreCase("O")) {
                            eleveDao.deleteEleve(idSup);
                            System.out.println("✅ Élève supprimé !");
                        }
                        break;

                    case 6:
                        System.out.print("Libellé : "); String lib = scanner.nextLine();
                        System.out.print("Coefficient : "); float coef = scanner.nextFloat();
                        Matiere m = new Matiere();
                        m.setLibelle(lib); m.setCoefficient(coef);
                        matiereDao.addMatiere(m);
                        System.out.println("✅ Matière ajoutée !");
                        break;

                    case 7:
                        System.out.print("ID Eleve : "); int idE = scanner.nextInt();
                        List<Matiere> mats = matiereDao.getListMatieres();
                        for(Matiere ma : mats) System.out.println(ma.getId() + " - " + ma.getLibelle());
                        System.out.print("ID Matiere : "); int idM = scanner.nextInt();
                        System.out.print("Note : "); float valN = scanner.nextFloat();

                        Note n = new Note();
                        n.setValeur(valN); n.setDateSaisie(new Date());
                        n.setEleve(eleveDao.getEleve(idE));
                        n.setMatiere(matiereDao.getMatiere(idM));
                        noteDao.addNote(n);
                        System.out.println("✅ Note enregistrée !");
                        break;

                    case 8:
                        List<Eleve> elevesList = eleveDao.getListEleves();
                        System.out.println("\n--- RESULTATS & CLASSEMENT ---");
                        for (Eleve e : elevesList) {
                            List<Note> sesNotes = noteDao.getNotesByEleve(e.getId());
                            float som = 0, tCoef = 0;
                            for(Note nt : sesNotes) {
                                som += (nt.getValeur() * nt.getMatiere().getCoefficient());
                                tCoef += nt.getMatiere().getCoefficient();
                            }
                            float moy = (tCoef > 0) ? (som/tCoef) : 0;
                            String st = (moy < 10) ? "⚠️ En difficulté" : (moy >= 16) ? "🌟 Excellent" : "✅ Passable";
                            System.out.println(e.getNom() + " " + e.getPrenom() + " | Moyenne: " + String.format("%.2f", moy) + " | " + st);
                        }
                        break;
                }
            } while (choix != 9);
        } else {
            System.out.println("❌ Email ou Mot de passe incorrect.");
        }
        scanner.close();
    }
}