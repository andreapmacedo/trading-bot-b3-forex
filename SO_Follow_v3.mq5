


void Sys_Follow_4_v3_beta(int callFrom)
{

    SO_Follow_InitLevels();
    //SO_Follow_ChangeLevels_v2();
    //SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_v3();
    
    /*
    if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        SO_Follow_Enforce_Condition();
    }
    */
    SO_Follow_EN_Full_System();
    /*
    switch(SELECTED_EN_MODE) // Version
    {
        case 1:
            SO_Follow_EN_Full_Free(); 
            break;                                                          
        case 2:
            SO_Follow_EN_Full_Default(); 
            break;                               
        case 3:
            SO_Follow_EN_Full_Lock(); 
            break;                               
        default:
            SO_Follow_EN_Full_System(); 
            break;                                
    } 

    */           
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_v31_beta(int callFrom)
{

    SO_Follow_InitLevels();
    //SO_Follow_ChangeLevels_v2();
    //SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_v3();
    
    /*
    if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        SO_Follow_Enforce_Condition();
    }
    */
    SO_Follow_EN_Full_System();
    /*
    switch(SELECTED_EN_MODE) // Version
    {
        case 1:
            SO_Follow_EN_Full_Free(); 
            break;                                                          
        case 2:
            SO_Follow_EN_Full_Default(); 
            break;                               
        case 3:
            SO_Follow_EN_Full_Lock(); 
            break;                               
        default:
            SO_Follow_EN_Full_System(); 
            break;                                
    } 


    */           
    
    
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Percent;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_v32_beta(int callFrom)
{

    SO_Follow_InitLevels();
    //SO_Follow_ChangeLevels_v2();
    //SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_v3();
    
    /*
    if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        SO_Follow_Enforce_Condition();
    }
    */
    SO_Follow_EN_Full_System();
    /*
    switch(SELECTED_EN_MODE) // Version
    {
        case 1:
            SO_Follow_EN_Full_Free(); 
            break;                                                          
        case 2:
            SO_Follow_EN_Full_Default(); 
            break;                               
        case 3:
            SO_Follow_EN_Full_Lock(); 
            break;                               
        default:
            SO_Follow_EN_Full_System(); 
            break;                                
    } 

    */           
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_v33(int callFrom)
{

    SO_Follow_InitLevels();
    //SO_Follow_ChangeLevels_v2();
    //SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_v3();
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;        
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_v34(int callFrom)
{

    SO_Follow_InitLevels_V33();
    //SO_Follow_ChangeLevels_v2();
    //SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_v33();
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_v35(int callFrom)
{

    SO_Follow_PlaceOrders_v35();
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_v36(int callFrom)
{

    SO_Follow_PlaceOrders_v36();

    /*
    switch(callFrom) 
    {
        case 3:
            SO_Follow_Setter_36(1);
            break; 
        case 2:
            SO_Follow_PlaceOrders_v36();
            break;                                          
    }
    */
    


    
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_v37(int callFrom)
{

    SO_Follow_PlaceOrders_v37();

    /*
    switch(callFrom) 
    {
        case 3:
            SO_Follow_Setter_36(1);
            break; 
        case 2:
            SO_Follow_PlaceOrders_v36();
            break;                                          
    }
    */
    


    
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_v38(int callFrom)
{

    SO_Follow_PlaceOrders_v38();

    /*
    switch(callFrom) 
    {
        case 3:
            SO_Follow_Setter_36(1);
            break; 
        case 2:
            SO_Follow_PlaceOrders_v36();
            break;                                          
    }
    */
    
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;

               
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}