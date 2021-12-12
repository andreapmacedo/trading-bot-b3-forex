

// contra a tendência
void SetSisSettings_02()
{
    switch(TRADE_STATUS_SYSTEM_02_CHOSEN)
    {
        case 1:
            SisSettings_02_ch0001();
            break;
        case 2:
            SisSettings_02_ch0002();
            break;
        default:
            break;
    }

}

void SisSettings_02_ch0001()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {
        SetTopMagneticMovie(); // (est 2x)
        //if(sequenciaDeEntradaNivelInferior > 1)
            Sell_Vol = SELECTED_VOLUME_SHORT * 3;
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        
        // stop
        // if(temp_vol > 2)
        // {
        //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
        //     {
        //         //Level_Sell = Freeze_Central_Bottom; 
                
        //         Level_Sell = SERVER_SYMBOL_ASK; 
        //         Sell_Vol = SELECTED_VOLUME_SHORT ;
        //     }
        // }

    }

    if(pos_status == 1) // vendido
    {
        //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //  if(sequenciaDeEntradaNivelSuperior > 1)
        SetBottomMagneticMovie(); // (est 2x)
        Buy_Vol = SELECTED_VOLUME_LONG * 3;

        // stop
        // if(temp_vol > 2)
        // {
        //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
        //     {
                
        //         //Level_Buy = Freeze_Central_Top;  
                
        //         Level_Buy = SERVER_SYMBOL_BID; 
        //         Buy_Vol = SELECTED_VOLUME_LONG ;
        //     }
        // }

        //BuyVolChange  += SELECTED_VOLUME_LONG;
        //Buy_Vol  = temp_vol; // exemplo de possibilidade
        //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
    }
}
void SisSettings_02_ch0002()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(sequenciaDeEntradaNivelInferior > 1) // sequência
        {
            Sell_Vol = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
        SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(sequenciaDeEntradaNivelSuperior > 1)
        {
            Buy_Vol = SELECTED_VOLUME_LONG * 3;
        }
    }
}
void SisSettings_02_ch0003()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        // SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(sequenciaDeEntradaNivelInferior > 1) // sequência
        {
            Sell_Vol = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
        // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(sequenciaDeEntradaNivelSuperior > 1)
        {
            Buy_Vol = SELECTED_VOLUME_LONG * 3;
        }
    }
}
void SisSettings_02_ch0004()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        //SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
       // BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(sequenciaDeEntradaNivelInferior > 1) // sequência
        {
            Sell_Vol = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
       // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
       // TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(sequenciaDeEntradaNivelSuperior > 1)
        {
            Buy_Vol = SELECTED_VOLUME_LONG * 3;
        }
    }
}

void SisSettings_02_ch0005()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        //SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
       // BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(sequenciaDeEntradaNivelInferior > 1) // sequência
        {
            Sell_Vol = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
       // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
       // TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(sequenciaDeEntradaNivelSuperior > 1)
        {
            Buy_Vol = SELECTED_VOLUME_LONG * 3;
        }
    }
}