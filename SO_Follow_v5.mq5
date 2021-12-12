
void Sys_Follow_5_1(int callFrom)
{

    double top_level;
    double bottom_level;
    //Print("Sys_Follow_5_3 ",callFrom);

    SetLevelRef(top_level, bottom_level);
    Sys_Follow_CheckChange(top_level, bottom_level);
    Sys_Follow_Enforce_Dev(top_level, bottom_level);

    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
            Sys_Follow_Set_Dev(top_level, bottom_level);
            Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break;                                          
            // case 3:
            //     Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
            //     SO_FOLLOW_LOCK = 1;
            //     break; 
            case 3:
                Sys_Follow_Set_Dev(top_level, bottom_level);
               // Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
                //Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
                SO_FOLLOW_LOCK = 1;
                break; 

        }				
        if(LONG_CONDITIONS || SHORT_CONDITIONS)
        {
            SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
            SELECTED_EST_EN_DISTANCE_CHOSEN = ESTRATEGIA_AJUSTE_DE_DISTANCIA;
            //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
            SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
            SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
            PlaceOrders(0);  
            
            TopDisplay(top_level,bottom_level);

        }
    }



}

void TopDisplay(double top_level, double bottom_level)
{
    spd = (string)(FINAL_EN_SHORT_VALUE - FINAL_EN_LONG_VALUE);
       
        Comment("top_level ->  "+ top_level,
                "\n FINAL_EN_SHORT_VALUE ->  " + FINAL_EN_SHORT_VALUE,
                "\n ------------------------------------",
                "\n bottom_level ->  " + bottom_level,
                "\n FINAL_EN_LONG_VALUE ->  " + FINAL_EN_LONG_VALUE,
                "\n SPD ->  " + spd
                );

}


void Sys_Follow_5_2(int callFrom)
{

    double top_level;
    double bottom_level;
    //Print("Sys_Follow_5_3 ",callFrom);

    SetLevelRef(top_level, bottom_level);
    //Sys_Follow_CheckChange(top_level, bottom_level);
    Sys_Follow_Enforce_Dev(top_level, bottom_level);

    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
            Sys_Follow_Set_Dev(top_level, bottom_level);
            Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break;                                          
            // case 3:
            //     Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
            //     SO_FOLLOW_LOCK = 1;
            //     break; 
            case 3:
                Sys_Follow_Set_Dev(top_level, bottom_level);
                //Sys_Follow_Pull_Push_Dev(top_level, bottom_level);
                //Sys_Follow_Set_3(DYT_SYMBOL_LAST_DEAL_PRICE);
                SO_FOLLOW_LOCK = 1;
                break; 

        }				
        if(LONG_CONDITIONS || SHORT_CONDITIONS)
        {
            SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
            SELECTED_EST_EN_DISTANCE_CHOSEN = ESTRATEGIA_AJUSTE_DE_DISTANCIA;
            //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
            SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
            SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
            PlaceOrders(0);  



            
            TopDisplay(top_level,bottom_level );


        }
    }
}


void Sys_Follow_CheckChange(double top, double bottom)
{
    if(bottom > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SO_FOLLOW_LOCK = 0;
    }
       
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(top < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SO_FOLLOW_LOCK = 0;
    }  
}
