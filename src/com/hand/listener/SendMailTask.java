package com.hand.listener;

import java.util.TimerTask;    

import javax.servlet.ServletContext;    

import com.hand.util.Const;
import com.hand.util.PageData;
import com.hand.util.Tools;
import com.hand.util.mail.SimpleMailSender;
    
/**  
 * 定时器   
 * @author 
 *  
 */  

public class SendMailTask extends TimerTask{    
    
	
    private static boolean isRunning = false;      
      
    private ServletContext context = null;      
      
    public SendMailTask() {    
        super();    
    }    
        
    public SendMailTask(ServletContext context) {      
        this.context = context;      
    }      
    @Override    
    public void run() {    
            
        if (!isRunning) {    
                 
            context.log("开始执行指定任务");  
            
			try {
				PageData pd = new PageData();  
				pd = ContextListener.pcService.countdep(pd);
				long xzdn = (long) pd.get("have");
				if(xzdn<5){
					String strEMAIL = Tools.readTxtFile(Const.EMAIL);
					String toEMAIL ="547964154@qq.com";
					String TITLE ="温馨提示";
					String CONTENT ="闲置pc数量不足，为"+xzdn+"台";
					String TYPE ="1";
					String strEM[] = strEMAIL.split(",fh,");
					SimpleMailSender.sendEmail(strEM[0], strEM[1], strEM[2], strEM[3], toEMAIL, TITLE, CONTENT, TYPE);			
					isRunning = false; 
		            context.log("指定任务执行结束");   
				}	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			 
        } else {      
            context.log("上一次任务执行还未结束");      
     }    
    }    
    
}  
