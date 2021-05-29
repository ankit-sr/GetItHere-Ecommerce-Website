
package com.mycompany.reseller.helper;


public class Desc {
    
    public static String descShort(String desc)
    {
        String[] st =  desc.split(" ");
        if(st.length>10)
        {
            String result = "";
            for(int  i=0;i<10;i++)
            {
                result = result + st[i] + " ";
            }
            return (result+"...");
        }
        else{
            return (desc + "...");
        }
    }
    
}
