

void Sys_Follow_4_Alpha(int callFrom)
{

    SO_Follow_InitLevels();
    SO_Follow_Enforce_Condition_Evo_2();
    SO_Follow_BasicChangeLevel();



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
    
    
    //SO_Follow_Enforce_Condition_Evo();
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_O4_Y1_v03_11_original(int callFrom)
{
    Print("Sys_Follow_O4_Y1_v03_11_original");
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    SO_Follow_Enforce_Condition();
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
    }
    
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0) 
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
    }
	
    
    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_11_original");
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_11_original");
    }



    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void Sys_Follow_4_11(int callFrom)
{

    SO_Follow_InitLevels();
    SO_Follow_Enforce_Condition_Evo();
    SO_Follow_BasicChangeLevel();
    

    
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

    //SO_Follow_Enforce_Condition_Evo_2();

    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_12(int callFrom)
{

    SO_Follow_InitLevels();
    SO_Follow_BasicChangeLevel();
    SO_Follow_Enforce_Condition();



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
    
    
    //SO_Follow_Enforce_Condition_Evo();
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_13(int callFrom)
{

    SO_Follow_InitLevels();
    SO_Follow_Enforce_Condition();
    SO_Follow_BasicChangeLevel();


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


    //SO_Follow_New_Level();

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;

    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_121(int callFrom)
{

    SO_Follow_InitLevels_ev();
    SO_Follow_BasicChangeLevel_ev();
    SO_Follow_Enforce_Condition_ev();

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
    
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_122(int callFrom)
{

    SO_Follow_InitLevels_ev();
    SO_Follow_BasicChangeLevel_ev2();
    SO_Follow_Enforce_Condition_ev2();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_123(int callFrom)
{

    SO_Follow_InitLevels_ev();
    SO_Follow_BasicChangeLevel_ev2();
    SO_Follow_Enforce_Condition_ev2();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_EN_DISTANCE_CHOSEN = ESTRATEGIA_AJUSTE_DE_DISTANCIA;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_124(int callFrom)
{

    SO_Follow_GetMovies_v124();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}



void Sys_Follow_4_2(int callFrom)
{
    SO_Follow_InitLevels_Pro();
    SO_Follow_BasicChangeLevel_Pro();
    SO_Follow_Enforce_Condition_Pro();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

/*
void Sys_Follow_4_124(int callFrom)
{

    switch(callFrom) 
    {
        case 2:
        {

            SO_Follow_InitLevels_ev();
            SO_Follow_BasicChangeLevel_ev2();

        }
        break;                               
        case 3:
            SO_Follow_Enforce_Condition_ev2();
            break;                               
    }
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}
*/


void Sys_Follow_4_125(int callFrom)
{
    SO_Follow_InitLevels_ev();

    switch(callFrom) 
    {
        case 2:
            SO_Follow_BasicChangeLevel_ev2();
            break;                               
        case 3:
            SO_Follow_Enforce_Condition_ev2();
            break;                               
    }
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


void Sys_Follow_4_126(int callFrom)
{
    SO_Follow_Enforce_Condition_Forex();
    SO_Follow_InitLevels_Forex();
    SO_Follow_BasicChangeLevel_Forex();
    
    /*
    switch(callFrom) 
    {
        case 2:
            SO_Follow_BasicChangeLevel_Pro();
            Print("Sys_Follow_4_126 -> callFrom 2");
            break;                               
        case 3:
            SO_Follow_Enforce_Condition_Pro();
            Print("Sys_Follow_4_126 -> callFrom 3");
            break;                               
    }

    */
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}

void Sys_Follow_4_127(int callFrom)
{

    
    switch(callFrom) 
    {
        case 2:
            SO_Follow_PlaceOrders_v127();
            SO_Follow_Update_v127();
            Print("Sys_Follow_4_127 -> callFrom 2");
            break;                               
        case 3:
            SO_Follow_PlaceOrders_v127();
            Print("Sys_Follow_4_127 -> callFrom 3");
            break;                               
    }

    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}



void Sys_Follow_4_128(int callFrom)
{
    /*
    SO_Follow_InitLevels_ev();
    SO_Follow_BasicChangeLevel_ev2();
    SO_Follow_Enforce_Condition_ev2();
    */

    switch(callFrom) 
    {
        case 2:
            SO_Follow_InitLevels_ev();
            SO_Follow_BasicChangeLevel_ev2();
            SO_Follow_Enforce_Condition_ev2();
            break;                               
        case 3:
            SO_Follow_Enforce_Condition_ev2();
            Print("Sys_Follow_4_128 -> callFrom 3");
            break;                               
    }

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    //SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    SELECTED_EST_VOLUME_CHOSEN = ESTRATEGIA_AJUSTE_DE_VOLUME;
    
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}


