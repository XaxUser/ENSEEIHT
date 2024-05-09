// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioRedacteur implements LectRed
{

    private Lock lock;
    private Condition pasAcces;

    private int nbLecteursEnCours;
    private int redacteurs;
    private boolean redactionEnCours;

    public LectRed_PrioRedacteur() {
        this.lock = new ReentrantLock();
        this.pasAcces = lock.newCondition();
        this.nbLecteursEnCours = 0;
        this.redacteurs = 0;
        this.redactionEnCours = false;
    }

    @Override
    public void demanderLecture() throws InterruptedException {
        lock.lock();
        try {
            while (redactionEnCours || redacteurs>0) {
                pasAcces.await();
            }
            nbLecteursEnCours++;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void terminerLecture() throws InterruptedException {
        lock.lock();
        try {
            nbLecteursEnCours--;
            if (nbLecteursEnCours == 0) {
                pasAcces.signal();
            }
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void demanderEcriture() throws InterruptedException {
        lock.lock();
        try {
            redacteurs++;
            while (nbLecteursEnCours > 0 || redactionEnCours) {
                pasAcces.await();
            }         
            redactionEnCours = true;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void terminerEcriture() throws InterruptedException {
        lock.lock();
        try {
            redactionEnCours = false;
            redacteurs--;
            pasAcces.signalAll();
        } finally {
            lock.unlock();
        }
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
