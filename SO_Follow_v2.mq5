


void Sys_Follow_4_21(int callFrom)
{
    
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double top_level;
    double bottom_level;

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));


    //if(last_deal > 0)
    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;
        Comment("Último Negócio " + last_deal);          
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        
        top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        /*
        if(DYT_SYMBOL_LAST_DEAL_PRICE > SERVER_SYMBOL_ASK)
        {
            top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
            Comment("Último Trade " + DYT_SYMBOL_LAST_DEAL_PRICE);
        }
        else
        {
            top_level = SERVER_SYMBOL_ASK;
            Comment("SERVER_SYMBOL_ASK ->  "+ SERVER_SYMBOL_ASK);
        }
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE < SERVER_SYMBOL_BID)
        {
            bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
            Comment("Último Trade " + DYT_SYMBOL_LAST_DEAL_PRICE);
        }
        else
        {
            bottom_level = SERVER_SYMBOL_BID;
            Comment("SERVER_SYMBOL_BID ->  "+ SERVER_SYMBOL_BID);
        }  
        */      
    }
    else
    {
        /*
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;
         */
         
        top_level = SERVER_SYMBOL_BID;
        bottom_level = SERVER_SYMBOL_ASK;         
        Comment("SERVER_SYMBOL_ASK ->  "+ SERVER_SYMBOL_ASK,
                "\n SERVER_SYMBOL_BID ->  " + SERVER_SYMBOL_BID
                );
                     
    }
        
    switch(callFrom) 
    {
        case 2:
            Sys_Follow_Set_Dev(top_level, bottom_level);
            Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
            Sys_Follow_Enforce_Dev(top_level, bottom_level);
            break;                                          
        case 3:
            Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
            break; 
        case 4:
            Sys_Follow_Enforce_Dev(SERVER_SYMBOL_BID, SERVER_SYMBOL_ASK);
            Comment("SERVER_SYMBOL_ASK 4 ->  "+ SERVER_SYMBOL_ASK,
                    "\n SERVER_SYMBOL_BID 4 ->  " + SERVER_SYMBOL_BID
                    );
            break; 

    }
    
    
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = ESTRATEGIA_AJUSTE_DE_DISTANCIA;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}





void Sys_Follow_4_23(int callFrom)
{

    

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double top_level;
    double bottom_level;


    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));


    //if(last_deal > 0)
    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;
        Comment("Último Negócio " + last_deal);               
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        
        top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
            Comment("Último Trade " + DYT_SYMBOL_LAST_DEAL_PRICE);
        /*
        if(DYT_SYMBOL_LAST_DEAL_PRICE > SERVER_SYMBOL_ASK)
        {
            top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        }
        else
        {
            top_level = SERVER_SYMBOL_ASK;
            Comment("SERVER_SYMBOL_ASK ->  "+ SERVER_SYMBOL_ASK);
        }
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE < SERVER_SYMBOL_BID)
        {
            bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
            Comment("Último Trade " + DYT_SYMBOL_LAST_DEAL_PRICE);
        }
        else
        {
            bottom_level = SERVER_SYMBOL_BID;
            Comment("SERVER_SYMBOL_BID ->  "+ SERVER_SYMBOL_BID);
        }  
        */      
    }
    else
    {
        /*
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;
         */
         
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;           
         Comment("SERVER_SYMBOL_ASK ->  "+ SERVER_SYMBOL_ASK,
                  "\n SERVER_SYMBOL_BID ->  " + SERVER_SYMBOL_BID
                  );        
    }


    switch(callFrom) 
    {
        case 2:
            Sys_Follow_Set_Dev(top_level, bottom_level);
            Sys_Follow_Enforce_Dev(top_level, bottom_level);
            if(MyGetVolumePosition() >= SELECTED_LIMIT_POSITION_VOLUME)
                Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
            break;                                          
        case 3:
            Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
            break; 
        case 4:
            Sys_Follow_Enforce_Dev(SERVER_SYMBOL_BID, SERVER_SYMBOL_ASK);
            Comment("SERVER_SYMBOL_ASK 4 ->  "+ SERVER_SYMBOL_ASK,
                    "\n SERVER_SYMBOL_BID 4 ->  " + SERVER_SYMBOL_BID
                    );
            break; 
    }
    
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = ESTRATEGIA_AJUSTE_DE_DISTANCIA;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_Set_3(double last)
{

    if(last > 0)
    {
        SetTopLevel(last);
        SetBottomLevel(last); 
    }


}


void Sys_Follow_Set_Dev(double top, double bottom)
{
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        SetTopLevel(top);
    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        SetBottomLevel(bottom); 
    }

}

void Sys_Follow_Pull_Push_Dev(double top, double bottom)
{
    if(bottom > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SetTopLevel(top);
    }
       
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(top < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SetBottomLevel(bottom); // empurra o bottom
    }  
}


void Sys_Follow_Enforce_Dev(double top, double bottom)
{
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            SetTopLevel(top);
            SO_FOLLOW_LOCK = 0;
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SetBottomLevel(bottom);
            SO_FOLLOW_LOCK = 0;
        } 
    }

}



void SetBottomLevel(double level)
{

    if(level > 0)
    {
    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_BOTTOM_LEVEL = level;
    TEMP_EN_SHORT_VALUE = level;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SetBottomLevel");
   // changeBottom = true;
    }
    else
    {
        Print("SetBottomLevel -> erro 0");
    }
}
void SetTopLevel(double level)
{
    if(level > 0)
    {

    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_TOP_LEVEL = level;
    TEMP_EN_LONG_VALUE = level;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SetTopLevel");
   // changeTop =  true;
    }
    else
    {
        Print("SetTopLevel -> erro 0");
    }

}
