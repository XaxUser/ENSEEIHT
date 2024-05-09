// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: Equité,
 * implantation: avec un moniteur. */
public class LectRed_Equite implements LectRed
{

    private Lock lock;
    private Condition read;
    private Condition write;
    private int writers;
    private int readers;
    private int waitWriters;
    private int waitReaders;
    
    public LectRed_Equite () {
    	this.lock = new ReentrantLock();
    	this.read = lock.newCondition();
    	this.write = lock.newCondition();
        this.waitWriters = 0;
        this.waitReaders = 0;
    	this.writers = 0;
    	this.readers = 0;
    }

    @Override
    public void demanderLecture () throws InterruptedException {
        lock.lock ();
        if(waitWriters > 0 || waitReaders > 0 || writers > 0) {
            waitReaders++;
            read.await ();
            waitReaders--;
        }
        readers ++;
        read.signal ();
    	lock.unlock ();
    }

    
    @Override
    public void terminerLecture  () throws InterruptedException {
        lock.lock ();
        readers --;
        if(readers == 0) {
            if(waitWriters > 0) {
                write.signal ();
            } else {
                read.signal ();
            }
        }
        this.lock.unlock ();
    }


    @Override
    public void demanderEcriture () throws InterruptedException {
    	lock.lock ();
    	if(readers > 0 || writers > 0) {
            waitReaders++;
    	    read.await ();
            waitReaders--;
    	    if(readers > 0) {
                waitWriters++;
    	        write.await ();
                waitWriters--;
    	    }
    	}
    	this.writers ++;
    	this.lock.unlock ();
    }

    
    @Override
    public void terminerEcriture () throws InterruptedException {
        this.lock.lock ();
    	this.writers --;
        this.read.signal ();
        this.lock.unlock ();
    }

    public String nomStrategie() {
        return "Stratégie: Equité.";
    }
}
