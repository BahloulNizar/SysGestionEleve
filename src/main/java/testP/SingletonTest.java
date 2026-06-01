package testP;

import dao.SingletonConnection;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class SingletonTest {

    @Test
    public void testSingletonInstanceUnique() {
        EntityManager em1 = SingletonConnection.getEntityManager();
        EntityManager em2 = SingletonConnection.getEntityManager();

        assertNotNull(em1, "L'EntityManager ne doit pas être null");
        assertSame(em1, em2, "Le pattern Singleton a échoué : Les deux instances sont différentes !");

        System.out.println("✅ Test réussi : Le Singleton fonctionne parfaitement !");
    }
}