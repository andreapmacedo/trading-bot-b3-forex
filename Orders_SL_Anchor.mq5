

void SL_OrderAnchor_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 101:  
            SL_STR_Anchor_101();
            break;
        case 201:  
            SL_STR_Anchor_201();
            break;

    }
}

void SL_STR_Anchor_101()
{
    Level_sl_long = Level_Buy; 
    Level_sl_short = Level_Sell;
}
void SL_STR_Anchor_201()
{
    Level_sl_long = Level_Buy; 
    Level_sl_short = Level_Sell;
}

//+------------------------------------------------------------------+
// Distância por sequência
//+------------------------------------------------------------------+

// void definirDistanciaDoLevel_cfg_10() 
// {
//     double adj_end_seq;
//     definirSequenciaMaximaDeEntradasEstabelecida(adj_end_seq);
    
//     if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)
//     {
//         double range;
//         if(sequenciaDeEntradaNivelInferior <= adj_end_seq)
//         {
//             range = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         else if(sequenciaDeEntradaNivelInferior > adj_end_seq)
//         {
//             range = adj_end_seq-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }

//         calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, range);
//     }
//     else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)   
//     {
//         double range;
//         if( sequenciaDeEntradaNivelSuperior <= adj_end_seq)
//         {
//             range = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         else if(sequenciaDeEntradaNivelSuperior > adj_end_seq)
//         {
//             range = adj_end_seq-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, range);
//     }
// }