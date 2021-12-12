





void Sys_Follow_7_1(int callFrom)
{

    double top_level;
    double bottom_level;
    double sell_vol = SELECTED_VOLUME_LONG;
    double buy_vol = SELECTED_VOLUME_LONG;

    double updated = 0;

    //Print("Sys_Follow_4_1 ",callFrom);
    if(callFrom != 3)
    {
        SetLevelRef(top_level, bottom_level);
        if(CheckChangeLevel(top_level, bottom_level) > 0)
        {
            SO_FOLLOW_LOCK = 0;
        }

    }
                
    
    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
               // SetLevelRef(top_level, bottom_level);
               // CheckChangeLevel(double top, double bottom)
                //setLevelAnchor(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break;                                          
            case 3:
                top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
                bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE; 
                setLevelAnchor(DYT_SYMBOL_LAST_DEAL_PRICE, DYT_SYMBOL_LAST_DEAL_PRICE);
                SO_FOLLOW_LOCK = 1;
                break; 
        }

        SetLevelDistance(top_level, bottom_level, ESTRATEGIA_AJUSTE_DE_DISTANCIA);
        Set_OrderVolume(sell_vol, buy_vol, ESTRATEGIA_AJUSTE_DE_VOLUME);

        SetAddChange(top_level, bottom_level);
        EN_BUY_MARKET_LEVEL = bottom_level;
        EN_SELL_MARKET_LEVEL = top_level;
        updated = 1;
    }
    //Set_Market_Order_Trigger(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME );
    Set_Market_Order_Limit(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME, updated);
    SO_Follow_6_TopDisplay(top_level, bottom_level);
}

void Sys_Follow_7_2(int callFrom)
{

    double top_level;
    double bottom_level;
    double sell_vol = SELECTED_VOLUME_LONG;
    double buy_vol = SELECTED_VOLUME_LONG;
    double updated = 0;


    if(callFrom != 3)
    {
        SetLevelRef(top_level, bottom_level);
        if(MyGetVolumePosition() >= SELECTED_LIMIT_POSITION_VOLUME
            || SELECTED_BUY_FIRST 
            || SELECTED_SELL_FIRST
            || DYT_SELL_FIRST 
            || DYT_BUY_FIRST
            )
            {
            if(CheckChangeLevel(top_level, bottom_level) > 0)
            {
                SO_FOLLOW_LOCK = 0;
            }
        }

    }



    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
                //SetLevelRef(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                //Print("Sys_Follow_6_2 +  callFrom ",callFrom);
                break;                                          
            case 3:
                top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
                bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE; 
                setLevelAnchor(DYT_SYMBOL_LAST_DEAL_PRICE, DYT_SYMBOL_LAST_DEAL_PRICE);
                SO_FOLLOW_LOCK = 1;
                break; 
            case 4:
                SO_FOLLOW_LOCK = 1;
                break;                 
        }
        
        
        SetLevelDistance(top_level, bottom_level, ESTRATEGIA_AJUSTE_DE_DISTANCIA);
        Print("top_level -  bottom_level:", top_level - bottom_level);


        Set_OrderVolume(sell_vol, buy_vol, ESTRATEGIA_AJUSTE_DE_VOLUME);
        SetAddChange(top_level, bottom_level); // trabalhar na função em que a estratégia de add possa ser modificada (chosen est add)


        EN_BUY_MARKET_LEVEL = bottom_level;
        EN_SELL_MARKET_LEVEL = top_level;
    
        updated = 1;
    }

    //Set_Market_Order_Trigger(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME );
    Set_Market_Order_Limit(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME, updated);
    SO_Follow_6_TopDisplay(top_level, bottom_level);

}


