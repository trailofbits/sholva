package com.trailofbits.log4shell;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

class PoC {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(PoC.class);
        for(String arg : args) {
            System.out.println("Logging \"" + arg + "\"");
            logger.error(arg);
        }
    }
}
