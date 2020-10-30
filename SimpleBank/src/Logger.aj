import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import com.bank.Bank;

/*public aspect Logger {

    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    
}*/


public aspect Logger {

    File file = new File("log.txt");
    
    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    
    pointcut transaction() : call(* money*(..) );
    after(): transaction(){
    	Calendar cal = Calendar.getInstance();
    	int hor = cal.get(Calendar.HOUR_OF_DAY);
        int min = cal.get(Calendar.MINUTE);
        int seg = cal.get(Calendar.SECOND);
        try {
        	FileWriter fw = new FileWriter(file,true);
        	String hora = " Hora: "+ String.valueOf(hor)+":"+String.valueOf(min)+":"+String.valueOf(seg);
        	String tipo = "";
        	if(thisJoinPointStaticPart.getSignature().getName().equals("moneyMakeTransaction")) {
        		tipo = "Realizar Transaccion";
        	}else if (thisJoinPointStaticPart.getSignature().getName().equals("moneyWithdrawal")) {
        		tipo = "Retirar Dinero";
				
			}
        		
        	fw.write("Transaccion: "+ tipo+ hora+"\n");
        	System.out.println("Transaccion: "+ tipo+ hora);
        	fw.close();
        }catch (IOException e) {
        	System.out.println("Error: "+e);
			// TODO: handle exception
		}
       
        
    	
    }
    
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    
   
}