// contra a tendência na zona de transição
void SetSisSettings_03()
{
    switch(TRADE_STATUS_SYSTEM_03_CHOSEN)
    {
        case 1:
            SisSettings_03_ch0001();
            break;
        case 2:
            SisSettings_03_ch0002();
            break;
        default:
            break;
    }

}
void SisSettings_03_ch0001()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    
    if(pos_status == 0) // comprado
    {
        // if(sequenciaDeEntradaNivelInferior > 0)
            Sell_Vol = SELECTED_VOLUME_SHORT * 2;
        //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
        
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        //BottomChange = 0;

    }
    // else // vendido
    // {
    //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }

    if(pos_status == 1) // vendido
    {
        //  if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;
        
        //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //BuyVolChange  += SELECTED_VOLUME_LONG;
        // TopChange += 50;
    }
    // else
    // {
    //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
}
void SisSettings_03_ch0002()
{
    // double temp_vol;
    // definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro

    if(pos_status == 0) // comprado
    {
        SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        // if(sequenciaDeEntradaNivelInferior > 0)
            Sell_Vol = SELECTED_VOLUME_SHORT * 2;
        //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
        
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        //BottomChange = 0;

    }
    // else // vendido
    // {
    //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
    if(pos_status == 1) // vendido
    {
        SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        //  if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;
        
        //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //BuyVolChange  += SELECTED_VOLUME_LONG;
        // TopChange += 50;
    }
    // else
    // {
    //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
}
