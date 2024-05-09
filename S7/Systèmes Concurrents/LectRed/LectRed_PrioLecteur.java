// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux lecteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioLecteur implements LectRed
{

    private Lock lock;
    private Condition pasAcces;

    private int lecteurs;
    private int redacteurs;
    private boolean lectureEnCours;
    

    public LectRed_PrioLecteur() {
        this.lock = new ReentrantLock();
        this.pasAcces = lock.newCondition();
        this.lecteurs = 0;
        this.redacteurs = 0;
        this.lectureEnCours = false;
    }

    @Override
    public void demanderEcriture() throws InterruptedException {
        lock.lock();
        try {
            while (lectureEnCours || lecteurs>0 || redacteurs>0) {
                pasAcces.await();
            }
            redacteurs++;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void terminerEcriture() throws InterruptedException {
        lock.lock();
        try {
            redacteurs--;
            if (redacteurs == 0) {
                pasAcces.signal();
            }
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void demanderLecture() throws InterruptedException {
        lock.lock();
        try {
            lecteurs++;
            while (redacteurs>0) {
                pasAcces.await();
            }         
            lectureEnCours = true;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void terminerLecture() throws InterruptedException {
        lock.lock();
        try {
            lectureEnCours = false;
            lecteurs--;
            pasAcces.signalAll();
        } finally {
            lock.unlock();
        }
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
